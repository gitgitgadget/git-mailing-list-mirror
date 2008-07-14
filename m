From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/6] archive: unify file attribute handling
Date: Mon, 14 Jul 2008 21:22:29 +0200
Message-ID: <487BA775.5090700@lsrfire.ath.cx>
References: <487B92FC.5030103@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:36:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITqC-0000zW-TR
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbYGNTfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbYGNTfJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:35:09 -0400
Received: from india601.server4you.de ([85.25.151.105]:45934 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbYGNTfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:35:08 -0400
X-Greylist: delayed 649 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jul 2008 15:35:08 EDT
Received: from [10.0.1.200] (p57B7FF09.dip.t-dialin.net [87.183.255.9])
	by india601.server4you.de (Postfix) with ESMTPSA id 1F2602F81F7;
	Mon, 14 Jul 2008 21:24:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <487B92FC.5030103@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88455>

Now that all file attribute handling for git archive has moved to archive.c,
we can unexport sha1_file_to_archive() and is_archive_path_ignored() even
disappears.

Add setup_archive_check(), modelled after similar functions used in the code
of other commands that support multiple file attributes.

Also remove convert_to_archive(), as it's only remaining function with
attribute handling gone was to call format_subst() if commit was not NULL,
which is now checked in sha1_file_to_archive().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c |   63 ++++++++++++++++++++++--------------------------------------
 archive.h |    3 --
 2 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/archive.c b/archive.c
index 58de55e..b8b45ba 100644
--- a/archive.c
+++ b/archive.c
@@ -36,34 +36,9 @@ static void format_subst(const struct commit *commit,
 	free(to_free);
 }
 
-static int convert_to_archive(const char *path,
-                              const void *src, size_t len,
-                              struct strbuf *buf,
-                              const struct commit *commit)
-{
-	static struct git_attr *attr_export_subst;
-	struct git_attr_check check[1];
-
-	if (!commit)
-		return 0;
-
-	if (!attr_export_subst)
-		attr_export_subst = git_attr("export-subst", 12);
-
-	check[0].attr = attr_export_subst;
-	if (git_checkattr(path, ARRAY_SIZE(check), check))
-		return 0;
-	if (!ATTR_TRUE(check[0].value))
-		return 0;
-
-	format_subst(commit, src, len, buf);
-	return 1;
-}
-
-void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
-                           unsigned int mode, enum object_type *type,
-                           unsigned long *sizep,
-                           const struct commit *commit)
+static void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
+		unsigned int mode, enum object_type *type,
+		unsigned long *sizep, const struct commit *commit)
 {
 	void *buffer;
 
@@ -75,7 +50,8 @@ void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
 		strbuf_init(&buf, 0);
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
 		convert_to_working_tree(path, buf.buf, buf.len, &buf);
-		convert_to_archive(path, buf.buf, buf.len, &buf, commit);
+		if (commit)
+			format_subst(commit, buf.buf, buf.len, &buf);
 		buffer = strbuf_detach(&buf, &size);
 		*sizep = size;
 	}
@@ -83,18 +59,17 @@ void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
 	return buffer;
 }
 
-int is_archive_path_ignored(const char *path)
+static void setup_archive_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_export_ignore;
-	struct git_attr_check check[1];
+	static struct git_attr *attr_export_subst;
 
-	if (!attr_export_ignore)
+	if (!attr_export_ignore) {
 		attr_export_ignore = git_attr("export-ignore", 13);
-
+		attr_export_subst = git_attr("export-subst", 12);
+	}
 	check[0].attr = attr_export_ignore;
-	if (git_checkattr(path, ARRAY_SIZE(check), check))
-		return 0;
-	return ATTR_TRUE(check[0].value);
+	check[1].attr = attr_export_subst;
 }
 
 struct archiver_context {
@@ -110,6 +85,9 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct archiver_context *c = context;
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
+	struct git_attr_check check[2];
+	const char *path_without_prefix;
+	int convert = 0;
 	int err;
 	enum object_type type;
 	unsigned long size;
@@ -119,9 +97,14 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	strbuf_grow(&path, PATH_MAX);
 	strbuf_add(&path, base, baselen);
 	strbuf_addstr(&path, filename);
+	path_without_prefix = path.buf + args->baselen;
 
-	if (is_archive_path_ignored(path.buf + args->baselen))
-		return 0;
+	setup_archive_check(check);
+	if (!git_checkattr(path_without_prefix, ARRAY_SIZE(check), check)) {
+		if (ATTR_TRUE(check[0].value))
+			return 0;
+		convert = ATTR_TRUE(check[1].value);
+	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		strbuf_addch(&path, '/');
@@ -133,8 +116,8 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		return READ_TREE_RECURSIVE;
 	}
 
-	buffer = sha1_file_to_archive(path.buf + args->baselen, sha1, mode,
-			&type, &size, args->commit);
+	buffer = sha1_file_to_archive(path_without_prefix, sha1, mode,
+			&type, &size, convert ? args->commit : NULL);
 	if (!buffer)
 		return error("cannot read %s", sha1_to_hex(sha1));
 	if (args->verbose)
diff --git a/archive.h b/archive.h
index 4e44549..88ee3be 100644
--- a/archive.h
+++ b/archive.h
@@ -43,9 +43,6 @@ extern int write_tar_archive(struct archiver_args *);
 extern int write_zip_archive(struct archiver_args *);
 extern void *parse_extra_zip_args(int argc, const char **argv);
 
-extern void *sha1_file_to_archive(const char *path, const unsigned char *sha1, unsigned int mode, enum object_type *type, unsigned long *size, const struct commit *commit);
-extern int is_archive_path_ignored(const char *path);
-
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
 
 #endif	/* ARCHIVE_H */
-- 
1.5.6.2.212.g08b51
