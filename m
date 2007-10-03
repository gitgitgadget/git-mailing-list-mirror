From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] git-init: don't base core.filemode on the ability to chmod.
Date: Wed, 3 Oct 2007 12:55:01 +0200
Message-ID: <20071003105501.GD7085@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 13:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id2hn-0001aH-0G
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 13:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbXJCLrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 07:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753638AbXJCLrr
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 07:47:47 -0400
Received: from mail.admingilde.org ([213.95.32.147]:40057 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbXJCLrq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 07:47:46 -0400
X-Greylist: delayed 3164 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Oct 2007 07:47:46 EDT
Received: from martin by mail.admingilde.org with local  (Exim 4.63 #1)
	id 1Id1sb-0007YA-LP
	for git@vger.kernel.org; Wed, 03 Oct 2007 12:55:01 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59828>

At least on Linux the vfat file system honors chmod calls but does not
store them permanently (as there is no on-disk format for it).
So the filemode test which tries to chmod a file thinks that the file
system does support file modes.  This will result in problems when the
file system gets mounted for the next time and all the executable bits
are back.

A more reliable test for file systems without filemode support is to
simply check if new files are created with the executable bit set.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 builtin-init-db.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)


NOTE: this is only tested on Linux with ext3 and vfat file systems.
I do not know enough about the behaviour of other systems so there
may be regressions.


diff --git a/builtin-init-db.c b/builtin-init-db.c
index 763fa55..fbccacb 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -246,10 +246,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	/* Check filemode trustability */
 	filemode = TEST_FILEMODE;
 	if (TEST_FILEMODE && !lstat(path, &st1)) {
-		struct stat st2;
-		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
-				!lstat(path, &st2) &&
-				st1.st_mode != st2.st_mode);
+		filemode = !(st1.st_mode & S_IXUSR);
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-- 
1.5.3.3.8.g367dc7


-- 
Martin Waitz
