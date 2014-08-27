From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/6] commit: provide a function to find a header in a
 buffer
Date: Wed, 27 Aug 2014 03:56:01 -0400
Message-ID: <20140827075600.GA26384@peff.net>
References: <20140827075503.GA19521@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 09:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMY5Q-0001nV-RX
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 09:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbaH0H4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 03:56:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:59882 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751617AbaH0H4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 03:56:03 -0400
Received: (qmail 14587 invoked by uid 102); 27 Aug 2014 07:56:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 02:56:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 03:56:01 -0400
Content-Disposition: inline
In-Reply-To: <20140827075503.GA19521@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255983>

Usually when we parse a commit, we read it line by line and
handle each individual line (e.g., parse_commit and
parse_commit_header).  Sometimes, however, we only care
about extracting a single header. Code in this situation is
stuck doing an ad-hoc parse of the commit buffer.

Let's provide a reusable function to locate a header within
the commit.  The code is modeled after pretty.c's
get_header, which is used to extract the encoding.

Since some callers may not have the "struct commit" to go
along with the buffer, we drop that parameter.  The only
thing lost is a warning for truncated commits, but that's
OK.  This shouldn't happen in practice, and even if it does,
there's no particular reason that this function needs to
complain about it. It either finds the header it was asked
for, or it doesn't (and in the latter case, the caller will
typically complain).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 22 ++++++++++++++++++++++
 commit.h | 11 +++++++++++
 pretty.c | 33 ++++++---------------------------
 3 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/commit.c b/commit.c
index ae7f2b1..b6ffd62 100644
--- a/commit.c
+++ b/commit.c
@@ -1660,3 +1660,25 @@ void print_commit_list(struct commit_list *list,
 		printf(format, sha1_to_hex(list->item->object.sha1));
 	}
 }
+
+const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
+{
+	int key_len = strlen(key);
+	const char *line = msg;
+
+	while (line) {
+		const char *eol = strchrnul(line, '\n');
+
+		if (line == eol)
+			return NULL;
+
+		if (eol - line > key_len &&
+		    !strncmp(line, key, key_len) &&
+		    line[key_len] == ' ') {
+			*out_len = eol - line - key_len - 1;
+			return line + key_len + 1;
+		}
+		line = *eol ? eol + 1 : NULL;
+	}
+	return NULL;
+}
diff --git a/commit.h b/commit.h
index a8cbf52..12f4fe1 100644
--- a/commit.h
+++ b/commit.h
@@ -313,6 +313,17 @@ extern struct commit_extra_header *read_commit_extra_headers(struct commit *, co
 
 extern void free_commit_extra_headers(struct commit_extra_header *extra);
 
+/*
+ * Search the commit object contents given by "msg" for the header "key".
+ * Returns a pointer to the start of the header contents, or NULL. The length
+ * of the header, up to the first newline, is returned via out_len.
+ *
+ * Note that some headers (like mergetag) may be multi-line. It is the caller's
+ * responsibility to parse further in this case!
+ */
+extern const char *find_commit_header(const char *msg, const char *key,
+				      size_t *out_len);
+
 typedef void (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 				 void *cb_data);
 
diff --git a/pretty.c b/pretty.c
index 3a1da6f..3a70557 100644
--- a/pretty.c
+++ b/pretty.c
@@ -547,31 +547,11 @@ static void add_merge_info(const struct pretty_print_context *pp,
 	strbuf_addch(sb, '\n');
 }
 
-static char *get_header(const struct commit *commit, const char *msg,
-			const char *key)
+static char *get_header(const char *msg, const char *key)
 {
-	int key_len = strlen(key);
-	const char *line = msg;
-
-	while (line) {
-		const char *eol = strchrnul(line, '\n'), *next;
-
-		if (line == eol)
-			return NULL;
-		if (!*eol) {
-			warning("malformed commit (header is missing newline): %s",
-				sha1_to_hex(commit->object.sha1));
-			next = NULL;
-		} else
-			next = eol + 1;
-		if (eol - line > key_len &&
-		    !strncmp(line, key, key_len) &&
-		    line[key_len] == ' ') {
-			return xmemdupz(line + key_len + 1, eol - line - key_len - 1);
-		}
-		line = next;
-	}
-	return NULL;
+	size_t len;
+	const char *v = find_commit_header(msg, key, &len);
+	return v ? xmemdupz(v, len) : NULL;
 }
 
 static char *replace_encoding_header(char *buf, const char *encoding)
@@ -617,11 +597,10 @@ const char *logmsg_reencode(const struct commit *commit,
 
 	if (!output_encoding || !*output_encoding) {
 		if (commit_encoding)
-			*commit_encoding =
-				get_header(commit, msg, "encoding");
+			*commit_encoding = get_header(msg, "encoding");
 		return msg;
 	}
-	encoding = get_header(commit, msg, "encoding");
+	encoding = get_header(msg, "encoding");
 	if (commit_encoding)
 		*commit_encoding = encoding;
 	use_encoding = encoding ? encoding : utf8;
-- 
2.1.0.346.ga0367b9
