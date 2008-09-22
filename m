From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] builtin-prune.c: prune temporary packs in <object_dir>/pack
 directory
Date: Mon, 22 Sep 2008 18:34:26 -0500
Message-ID: <KKSursEoVthEbqc_O82_QIafgU9zgb4bQYP7w6x9ulU85L2Nixe_9g@cipher.nrlssc.navy.mil>
References: <1222104021-28277-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 23 01:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhuwU-0003z8-7i
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 01:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbYIVXeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 19:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbYIVXeh
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 19:34:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56932 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbYIVXeg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 19:34:36 -0400
Received: by mail.nrlssc.navy.mil id m8MNYQ3A025142; Mon, 22 Sep 2008 18:34:27 -0500
In-Reply-To: <1222104021-28277-1-git-send-email-pasky@suse.cz>
X-OriginalArrivalTime: 22 Sep 2008 23:34:26.0792 (UTC) FILETIME=[C07B4680:01C91D0B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96516>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---

Re: [PATCH] Do not perform cross-directory renames when creating packs

I think something like this should be applied on top.

-brandon


 builtin-prune.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index c767a0a..fc8be45 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -13,7 +13,7 @@ static const char * const prune_usage[] = {
 static int show_only;
 static unsigned long expire;
 
-static int prune_tmp_object(char *path, const char *filename)
+static int prune_tmp_object(const char *path, const char *filename)
 {
 	const char *fullpath = mkpath("%s/%s", path, filename);
 	if (expire) {
@@ -113,21 +113,19 @@ static void prune_object_dir(const char *path)
  * files begining with "tmp_") accumulating in the
  * object directory.
  */
-static void remove_temporary_files(void)
+static void remove_temporary_files(const char *path)
 {
 	DIR *dir;
 	struct dirent *de;
-	char* dirname=get_object_directory();
 
-	dir = opendir(dirname);
+	dir = opendir(path);
 	if (!dir) {
-		fprintf(stderr, "Unable to open object directory %s\n",
-			dirname);
+		fprintf(stderr, "Unable to open directory %s\n", path);
 		return;
 	}
 	while ((de = readdir(dir)) != NULL)
 		if (!prefixcmp(de->d_name, "tmp_"))
-			prune_tmp_object(dirname, de->d_name);
+			prune_tmp_object(path, de->d_name);
 	closedir(dir);
 }
 
@@ -141,6 +139,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 			 "expire objects older than <time>"),
 		OPT_END()
 	};
+	char *s;
 
 	save_commit_buffer = 0;
 	init_revisions(&revs, prefix);
@@ -163,6 +162,9 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	prune_object_dir(get_object_directory());
 
 	prune_packed_objects(show_only);
-	remove_temporary_files();
+	remove_temporary_files(get_object_directory());
+	s = xstrdup(mkpath("%s/pack", get_object_directory()));
+	remove_temporary_files(s);
+	free(s);
 	return 0;
 }
-- 
1.6.0.1.244.gdc19
