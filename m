From: Max Kirillov <max@max630.net>
Subject: [PATCH v4 1/2] submodule refactor: use git_path_submodule() in add_submodule_odb()
Date: Wed, 18 Mar 2015 23:10:51 +0200
Message-ID: <1426713052-19171-2-git-send-email-max@max630.net>
References: <1426713052-19171-1-git-send-email-max@max630.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:19:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLN0-0004xn-Ir
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbbCRVTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:19:13 -0400
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:52307
	"EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754880AbbCRVTM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 17:19:12 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2015 17:19:12 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-07.prod.phx3.secureserver.net with 
	id 59Bw1q00T5B68XE019C3Tc; Wed, 18 Mar 2015 14:12:05 -0700
X-Mailer: git-send-email 2.1.1.391.g7a54a76
In-Reply-To: <1426713052-19171-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265761>

Signed-off-by: Max Kirillov <max@max630.net>
---
 submodule.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/submodule.c b/submodule.c
index 34094f5..4aad3d4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -122,43 +122,35 @@ void stage_updated_gitmodules(void)
 
 static int add_submodule_odb(const char *path)
 {
-	struct strbuf objects_directory = STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
+	const char* objects_directory;
 	int ret = 0;
-	const char *git_dir;
 
-	strbuf_addf(&objects_directory, "%s/.git", path);
-	git_dir = read_gitfile(objects_directory.buf);
-	if (git_dir) {
-		strbuf_reset(&objects_directory);
-		strbuf_addstr(&objects_directory, git_dir);
-	}
-	strbuf_addstr(&objects_directory, "/objects/");
-	if (!is_directory(objects_directory.buf)) {
+	objects_directory = git_path_submodule(path, "objects/");
+	if (!is_directory(objects_directory)) {
 		ret = -1;
 		goto done;
 	}
+
 	/* avoid adding it twice */
 	for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
-		if (alt_odb->name - alt_odb->base == objects_directory.len &&
-				!strncmp(alt_odb->base, objects_directory.buf,
-					objects_directory.len))
+		if (alt_odb->name - alt_odb->base == strlen(objects_directory) &&
+				!strcmp(alt_odb->base, objects_directory))
 			goto done;
 
-	alt_odb = xmalloc(objects_directory.len + 42 + sizeof(*alt_odb));
+	alt_odb = xmalloc(strlen(objects_directory) + 42 + sizeof(*alt_odb));
 	alt_odb->next = alt_odb_list;
-	strcpy(alt_odb->base, objects_directory.buf);
-	alt_odb->name = alt_odb->base + objects_directory.len;
+	strcpy(alt_odb->base, objects_directory);
+	alt_odb->name = alt_odb->base + strlen(objects_directory);
 	alt_odb->name[2] = '/';
 	alt_odb->name[40] = '\0';
 	alt_odb->name[41] = '\0';
 	alt_odb_list = alt_odb;
 
 	/* add possible alternates from the submodule */
-	read_info_alternates(objects_directory.buf, 0);
+	read_info_alternates(objects_directory, 0);
 	prepare_alt_odb();
 done:
-	strbuf_release(&objects_directory);
 	return ret;
 }
 
-- 
2.1.1.391.g7a54a76
