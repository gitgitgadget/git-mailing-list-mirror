From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/5] commit: make ignore_non_trailer() non static
Date: Fri, 07 Nov 2014 19:50:50 +0100
Message-ID: <20141107185053.16854.5866.chriscool@tuxfamily.org>
References: <20141107184148.16854.63825.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Nov 07 19:51:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmodJ-0006PK-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 19:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbaKGSva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 13:51:30 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:64135 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057AbaKGSv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 13:51:29 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id C48E29E;
	Fri,  7 Nov 2014 19:51:27 +0100 (CET)
X-git-sha1: 2676ea71cd36e4be4d0d20ddb7bf1eef5e3f0222 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20141107184148.16854.63825.chriscool@tuxfamily.org>
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
