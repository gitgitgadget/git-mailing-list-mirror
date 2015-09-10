From: Max Kirillov <max@max630.net>
Subject: [PATCH v8 1/2] submodule refactor: use git_pathdup_submodule() in add_submodule_odb()
Date: Fri, 11 Sep 2015 00:57:10 +0300
Message-ID: <1441922231-18270-2-git-send-email-max@max630.net>
References: <1441922231-18270-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 00:05:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za9xa-0007IL-EG
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 00:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbbIJWEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 18:04:48 -0400
Received: from p3plsmtpa07-02.prod.phx3.secureserver.net ([173.201.192.231]:37497
	"EHLO p3plsmtpa07-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbbIJWEr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 18:04:47 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2015 18:04:45 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-02.prod.phx3.secureserver.net with 
	id FZxT1r00H5B68XE01Zxdwk; Thu, 10 Sep 2015 14:57:39 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1441922231-18270-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277643>

Functions which directly operate submodule's object database do not handle the
case when the submodule is linked worktree (which are introduced in
c7b3a3d2fe). Instead of fixing the path calculation use already existing
git_pathdup_submodule() function without changing overall behavior. Then it
will be possible to modify only that function whenever we need to change real
location of submodule's repository content.

Signed-off-by: Max Kirillov <max@max630.net>
---
 submodule.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/submodule.c b/submodule.c
index 245ed4d..7340069 100644
--- a/submodule.c
+++ b/submodule.c
@@ -119,43 +119,37 @@ void stage_updated_gitmodules(void)
 
 static int add_submodule_odb(const char *path)
 {
-	struct strbuf objects_directory = STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
+	char *objects_directory;
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
+	objects_directory = git_pathdup_submodule(path, "objects/");
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
+	free(objects_directory);
+
 	return ret;
 }
 
-- 
2.3.4.2801.g3d0809b
