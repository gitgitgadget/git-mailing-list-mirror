From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] commit encoding: store it in commit header rather than
 mucking with NUL
Date: Sun, 24 Dec 2006 16:44:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612241643440.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612241505290.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Dec 24 16:45:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyVXB-0004gX-NU
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 16:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbWLXPox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 10:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbWLXPox
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 10:44:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:40723 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752113AbWLXPow (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 10:44:52 -0500
Received: (qmail invoked by alias); 24 Dec 2006 15:44:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 24 Dec 2006 16:44:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0612241505290.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35368>


It also fixes a segmentation fault when iconv does not know the
encoding (defaulting to no conversion).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sun, 24 Dec 2006, Johannes Schindelin wrote:

	> I don't like the convention to add the encoding after a trailing 
	> NUL. I'd rather have it as an "encoding blabl" header like the 
	> author and committer headers.

	This is a patch implementing that, on top of pu.

 builtin-commit-tree.c |   20 ++++++-------
 commit.c              |   70 ++++++++++++++++++++----------------------------
 2 files changed, 38 insertions(+), 52 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 9aff980..33c29f7 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -92,6 +92,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	char comment[1000];
 	char *buffer;
 	unsigned int size;
+	int encoding_is_utf8;
 
 	setup_ident();
 	git_config(git_default_config);
@@ -117,6 +118,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			parents++;
 	}
 
+	encoding_is_utf8 = !strcmp(git_commit_encoding, "utf-8");
+
 	init_buffer(&buffer, &size);
 	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
 
@@ -130,7 +133,11 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 
 	/* Person/date information */
 	add_buffer(&buffer, &size, "author %s\n", git_author_info(1));
-	add_buffer(&buffer, &size, "committer %s\n\n", git_committer_info(1));
+	add_buffer(&buffer, &size, "committer %s\n", git_committer_info(1));
+	if (!encoding_is_utf8)
+		add_buffer(&buffer, &size,
+				"encoding %s\n", git_commit_encoding);
+	add_buffer(&buffer, &size, "\n");
 
 	/* And add the comment */
 	while (fgets(comment, sizeof(comment), stdin) != NULL)
@@ -138,16 +145,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 
 	/* And check the encoding */
 	buffer[size] = '\0';
-	if (strcmp(git_commit_encoding, "utf-8")) {
-		/*
-		 * Add trailing section: this is safe because
-		 * add_buffer always allocates one byte more.
-		 */
-		size++;
-		add_buffer(&buffer, &size,
-			   "encoding %s\n", git_commit_encoding);
-	}
-	else if (!is_utf8(buffer))
+	if (encoding_is_utf8 && !is_utf8(buffer))
 		fprintf(stderr, commit_utf8_warn);
 
 	if (!write_sha1_file(buffer, size, commit_type, commit_sha1)) {
diff --git a/commit.c b/commit.c
index 58c4ecb..3132323 100644
--- a/commit.c
+++ b/commit.c
@@ -598,56 +598,43 @@ static int add_merge_info(enum cmit_fmt fmt, char *buf, const struct commit *com
 	return offset;
 }
 
-const char *commit_trailer(const struct commit *commit)
+static char *get_header(const struct commit *commit, const char *key)
 {
-	unsigned long size, len;
-	char type[10];
+	int key_len = strlen(key);
+	const char *line = commit->buffer;
 
-	if (sha1_object_info(commit->object.sha1, type, &size))
-		return NULL;
-	len = strlen(commit->buffer);
-	if (len == size)
-		return NULL;
-	return commit->buffer + len + 1;
-}
-
-char *find_commit_trailer(const struct commit *commit, const char *key)
-{
-	const char *trailer = commit_trailer(commit);
-	int keylen = strlen(key);
-	if (!trailer)
-		return NULL;
-	while (*trailer) {
-		const char *eol = strchr(trailer, '\n');
-		if (!eol)
-			eol = trailer + strlen(trailer);
-		if (!strncmp(trailer, key, keylen) && trailer[keylen] == ' ') {
-			int valsz = eol - trailer - keylen;
-			char *val = xmalloc(valsz + 1);
-			memcpy(val, trailer + keylen + 1, valsz);
-			val[valsz] = '\0';
-			if (val[valsz-1] == '\n')
-				val[valsz-1] = '\0';
-			return val;
+	for (;;) {
+		const char *eol = strchr(line, '\n'), *next;
+
+		if (line == eol)
+			return NULL;
+		if (!eol) {
+			eol = line + strlen(line);
+			next = NULL;
+		} else
+			next = eol + 1;
+		if (!strncmp(line, key, key_len) && line[key_len] == ' ') {
+			int len = eol - line - key_len;
+			char *ret = xmalloc(len);
+			memcpy(ret, line + key_len + 1, len - 1);
+			ret[len - 1] = '\0';
+			return ret;
 		}
-		if (!eol)
-			break;
-		trailer = eol + 1;
+		line = next;
 	}
-	return NULL;
 }
 
 static char *logmsg_to_utf8(const struct commit *commit)
 {
-	char *encoding = find_commit_trailer(commit, "encoding");
+	char *encoding = get_header(commit, "encoding");
 	char *out;
 
 	if (!encoding)
-		return commit->buffer;
+		return NULL;
 	out = reencode_string(commit->buffer, "utf-8", encoding);
 	free(encoding);
 	if (!out)
-		return commit->buffer;
+		return NULL;
 	return out;
 }
 
@@ -662,11 +649,12 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit
 	int parents_shown = 0;
 	const char *msg = commit->buffer;
 	int plain_non_ascii = 0;
-	int msg_reencoded = 0;
+	char *reencoded = NULL;
 
 	if (strcmp(git_commit_encoding, "utf-8") && i18n_log_to_utf8) {
-		msg = logmsg_to_utf8(commit);
-		msg_reencoded = 1;
+		reencoded = logmsg_to_utf8(commit);
+		if (reencoded)
+			msg = reencoded;
 	}
 
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
@@ -816,8 +804,8 @@ unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit
 		buf[offset++] = '\n';
 	buf[offset] = '\0';
 
-	if (msg_reencoded)
-		free((char*)msg);
+	if (reencoded)
+		free(reencoded);
 	return offset;
 }
 
-- 
1.4.4.3.g0001f-dirty
