From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 04/14] Rename path_excluded() to is_path_excluded()
Date: Thu, 20 Sep 2012 20:46:13 +0100
Message-ID: <1348170383-15751-5-git-send-email-git@adamspiers.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:47:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmiH-0000f4-M1
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab2ITTqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:46:46 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46179 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab2ITTq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:28 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id D3F742E5E8;
	Thu, 20 Sep 2012 20:46:27 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206079>

Start adopting clearer names for exclude functions.  This 'is_*'
naming pattern for functions returning booleans was agreed here:

http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=204924

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/add.c      | 2 +-
 builtin/ls-files.c | 2 +-
 dir.c              | 4 ++--
 dir.h              | 2 +-
 unpack-trees.c     | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e664100..075312a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -454,7 +454,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			    && !file_exists(pathspec[i])) {
 				if (ignore_missing) {
 					int dtype = DT_UNKNOWN;
-					if (path_excluded(&check, pathspec[i], -1, &dtype))
+					if (is_path_excluded(&check, pathspec[i], -1, &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
 					die(_("pathspec '%s' did not match any files"),
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b5434af..d226456 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -203,7 +203,7 @@ static void show_ru_info(void)
 static int ce_excluded(struct path_exclude_check *check, struct cache_entry *ce)
 {
 	int dtype = ce_to_dtype(ce);
-	return path_excluded(check, ce->name, ce_namelen(ce), &dtype);
+	return is_path_excluded(check, ce->name, ce_namelen(ce), &dtype);
 }
 
 static void show_files(struct dir_struct *dir)
diff --git a/dir.c b/dir.c
index 91e57d9..dad1582 100644
--- a/dir.c
+++ b/dir.c
@@ -627,8 +627,8 @@ void path_exclude_check_clear(struct path_exclude_check *check)
  * A path to a directory known to be excluded is left in check->path to
  * optimize for repeated checks for files in the same excluded directory.
  */
-int path_excluded(struct path_exclude_check *check,
-		  const char *name, int namelen, int *dtype)
+int is_path_excluded(struct path_exclude_check *check,
+		     const char *name, int namelen, int *dtype)
 {
 	int i;
 	struct strbuf *path = &check->path;
diff --git a/dir.h b/dir.h
index 549a187..41a5e32 100644
--- a/dir.h
+++ b/dir.h
@@ -113,7 +113,7 @@ struct path_exclude_check {
 };
 extern void path_exclude_check_init(struct path_exclude_check *, struct dir_struct *);
 extern void path_exclude_check_clear(struct path_exclude_check *);
-extern int path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
+extern int is_path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
 
 
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
diff --git a/unpack-trees.c b/unpack-trees.c
index 6d96366..724f69b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1373,7 +1373,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    path_excluded(o->path_exclude_check, name, -1, &dtype))
+	    is_path_excluded(o->path_exclude_check, name, -1, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
-- 
1.7.12.147.g6d168f4
