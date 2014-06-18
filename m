From: Jeff King <peff@peff.net>
Subject: [PATCH 1/7] commit: provide a function to find a header in a buffer
Date: Wed, 18 Jun 2014 16:27:37 -0400
Message-ID: <20140618202737.GA23896@sigill.intra.peff.net>
References: <20140618201944.GA23238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:27:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMSN-00057o-Et
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbaFRU1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:27:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:46999 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752864AbaFRU1j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:27:39 -0400
Received: (qmail 537 invoked by uid 102); 18 Jun 2014 20:27:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 15:27:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 16:27:37 -0400
Content-Disposition: inline
In-Reply-To: <20140618201944.GA23238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252056>

Usually when we parse a commit, we read it line by line and
handle each header in a single pass (e.g., in parse_commit
and parse_commit_header).  Sometimes, however, we only care
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
for, or it doesn't (and in the latter case, the caller can
complain).

Signed-off-by: Jeff King <peff@peff.net>
---
As noted in the comments below, I punted on extracting
multi-line headers like mergetag, because this function only
returns a pointer. It might make sense to wrap it with a
function to pull out a copy of the header, with continuation
lines connected to each other (that's almost what the static
get_header does, but I didn't make it public exactly because
it doesn't handle continuation lines).

That might be a more natural interface than
read_commit_extra_header_lines, which pulls out all headers
except ones that are specifically excluded. I haven't looked
closely enough. But in either case, that could easily come
on top of this.

 commit.c | 23 +++++++++++++++++++++++
 commit.h | 11 +++++++++++
 pretty.c | 33 ++++++---------------------------
 3 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/commit.c b/commit.c
index 11106fb..d04b525 100644
--- a/commit.c
+++ b/commit.c
@@ -1652,3 +1652,26 @@ void print_commit_list(struct commit_list *list,
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
+		const char *eol = strchrnul(line, '\n'), *next;
+
+		if (line == eol)
+			return NULL;
+		next = *eol ? eol + 1 : NULL;
+
+		if (eol - line > key_len &&
+		    !strncmp(line, key, key_len) &&
+		    line[key_len] == ' ') {
+			*out_len = eol - line - key_len - 1;
+			return line + key_len + 1;
+		}
+		line = next;
+	}
+	return NULL;
+}
diff --git a/commit.h b/commit.h
index 61559a9..7c766e9 100644
--- a/commit.h
+++ b/commit.h
@@ -312,6 +312,17 @@ extern struct commit_extra_header *read_commit_extra_headers(struct commit *, co
 
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
 struct merge_remote_desc {
 	struct object *obj; /* the named object, could be a tag */
 	const char *name;
diff --git a/pretty.c b/pretty.c
index cc5b45d..6081750 100644
--- a/pretty.c
+++ b/pretty.c
@@ -548,31 +548,11 @@ static void add_merge_info(const struct pretty_print_context *pp,
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
@@ -618,11 +598,10 @@ const char *logmsg_reencode(const struct commit *commit,
 
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
2.0.0.566.gfe3e6b2
