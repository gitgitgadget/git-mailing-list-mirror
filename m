From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/5] commit: make ignore_non_trailer() non static
Date: Sun, 09 Nov 2014 10:23:41 +0100
Message-ID: <20141109092344.4864.789.chriscool@tuxfamily.org>
References: <20141109092313.4864.54933.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 10:29:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnOoW-00082O-AH
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 10:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbaKIJ32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 04:29:28 -0500
Received: from [194.158.98.15] ([194.158.98.15]:60663 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751553AbaKIJ1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 04:27:38 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 29D136D;
	Sun,  9 Nov 2014 10:27:17 +0100 (CET)
X-git-sha1: a1765bd2a9e5f47729956d97c43bab822d825b91 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20141109092313.4864.54933.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/commit.c | 46 ----------------------------------------------
 commit.c         | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 commit.h         |  3 +++
 3 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e3c60dd..cda74e9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -677,52 +677,6 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	comment_line_char = *p;
 }
 
-/*
- * Inspect sb and determine the true "end" of the log message, in
- * order to find where to put a new Signed-off-by: line.  Ignored are
- * trailing comment lines and blank lines, and also the traditional
- * "Conflicts:" block that is not commented out, so that we can use
- * "git commit -s --amend" on an existing commit that forgot to remove
- * it.
- *
- * Returns the number of bytes from the tail to ignore, to be fed as
- * the second parameter to append_signoff().
- */
-static int ignore_non_trailer(struct strbuf *sb)
-{
-	int boc = 0;
-	int bol = 0;
-	int in_old_conflicts_block = 0;
-
-	while (bol < sb->len) {
-		char *next_line;
-
-		if (!(next_line = memchr(sb->buf + bol, '\n', sb->len - bol)))
-			next_line = sb->buf + sb->len;
-		else
-			next_line++;
-
-		if (sb->buf[bol] == comment_line_char || sb->buf[bol] == '\n') {
-			/* is this the first of the run of comments? */
-			if (!boc)
-				boc = bol;
-			/* otherwise, it is just continuing */
-		} else if (starts_with(sb->buf + bol, "Conflicts:\n")) {
-			in_old_conflicts_block = 1;
-			if (!boc)
-				boc = bol;
-		} else if (in_old_conflicts_block && sb->buf[bol] == '\t') {
-			; /* a pathname in the conflicts block */
-		} else if (boc) {
-			/* the previous was not trailing comment */
-			boc = 0;
-			in_old_conflicts_block = 0;
-		}
-		bol = next_line - sb->buf;
-	}
-	return boc ? sb->len - boc : 0;
-}
-
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
diff --git a/commit.c b/commit.c
index 19cf8f9..a54cb9a 100644
--- a/commit.c
+++ b/commit.c
@@ -1640,3 +1640,49 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
 	}
 	return NULL;
 }
+
+/*
+ * Inspect sb and determine the true "end" of the log message, in
+ * order to find where to put a new Signed-off-by: line.  Ignored are
+ * trailing comment lines and blank lines, and also the traditional
+ * "Conflicts:" block that is not commented out, so that we can use
+ * "git commit -s --amend" on an existing commit that forgot to remove
+ * it.
+ *
+ * Returns the number of bytes from the tail to ignore, to be fed as
+ * the second parameter to append_signoff().
+ */
+int ignore_non_trailer(struct strbuf *sb)
+{
+	int boc = 0;
+	int bol = 0;
+	int in_old_conflicts_block = 0;
+
+	while (bol < sb->len) {
+		char *next_line;
+
+		if (!(next_line = memchr(sb->buf + bol, '\n', sb->len - bol)))
+			next_line = sb->buf + sb->len;
+		else
+			next_line++;
+
+		if (sb->buf[bol] == comment_line_char || sb->buf[bol] == '\n') {
+			/* is this the first of the run of comments? */
+			if (!boc)
+				boc = bol;
+			/* otherwise, it is just continuing */
+		} else if (starts_with(sb->buf + bol, "Conflicts:\n")) {
+			in_old_conflicts_block = 1;
+			if (!boc)
+				boc = bol;
+		} else if (in_old_conflicts_block && sb->buf[bol] == '\t') {
+			; /* a pathname in the conflicts block */
+		} else if (boc) {
+			/* the previous was not trailing comment */
+			boc = 0;
+			in_old_conflicts_block = 0;
+		}
+		bol = next_line - sb->buf;
+	}
+	return boc ? sb->len - boc : 0;
+}
diff --git a/commit.h b/commit.h
index bc68ccb..cd35ac1 100644
--- a/commit.h
+++ b/commit.h
@@ -337,6 +337,9 @@ extern void free_commit_extra_headers(struct commit_extra_header *extra);
 extern const char *find_commit_header(const char *msg, const char *key,
 				      size_t *out_len);
 
+/* Find the end of the log message, the right place for a new trailer. */
+extern int ignore_non_trailer(struct strbuf *sb);
+
 typedef void (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 				 void *cb_data);
 
-- 
2.1.2.555.gfbecd99
