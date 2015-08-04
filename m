From: Max Kirillov <max@max630.net>
Subject: [PATCH v7 1/2] submodule refactor: use git_path_submodule() in add_submodule_odb()
Date: Wed,  5 Aug 2015 01:05:24 +0300
Message-ID: <1438725925-3689-2-git-send-email-max@max630.net>
References: <1438725067-3295-1-git-send-email-max@max630.net>
 <1438725925-3689-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 00:05:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMkLA-0006sl-9y
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 00:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbbHDWFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 18:05:40 -0400
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:53461
	"EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752411AbbHDWFk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 18:05:40 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-09.prod.phx3.secureserver.net with 
	id 0m5X1r01S5B68XE01m5eLv; Tue, 04 Aug 2015 15:05:40 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1438725925-3689-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275341>

Functions which directly operate submodule's object database do not handle the
case when the submodule is linked worktree (which are introduced in
c7b3a3d2fe). Instead of fixing the path calculation use already existing
git_path_submodule() function without changing overall behavior. Then it will
be possible to modify only that function whenever we need to change real
location of submodule's repository content.

Signed-off-by: Max Kirillov <max@max630.net>
---
 submodule.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/submodule.c b/submodule.c
index 15e90d1..70d18ec 100644
--- a/submodule.c
+++ b/submodule.c
@@ -122,43 +122,35 @@ void stage_updated_gitmodules(void)
 
 static int add_submodule_odb(const char *path)
 {
-	struct strbuf objects_directory = STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
+	const char *objects_directory;
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
2.3.4.2801.g3d0809b
