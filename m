From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] git-init: don't base core.filemode on the ability to chmod.
Date: Thu, 4 Oct 2007 01:19:41 +0200
Message-ID: <20071003231941.GA20800@admingilde.org>
References: <20071003105501.GD7085@admingilde.org> <470388DC.4040504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 01:19:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdDVO-0003Vp-Qb
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 01:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbXJCXTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 19:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbXJCXTn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 19:19:43 -0400
Received: from mail.admingilde.org ([213.95.32.147]:44710 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbXJCXTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 19:19:42 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.63 #1)
	id 1IdDVF-0005T0-Bn
	for git@vger.kernel.org; Thu, 04 Oct 2007 01:19:41 +0200
Content-Disposition: inline
In-Reply-To: <470388DC.4040504@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59908>

At least on Linux the vfat file system honors chmod calls but does not
store them permanently (as there is no on-disk format for it).
So the filemode test which tries to chmod a file thinks that the file system
does support file modes which will result in problems later after the
file system got remounted.

Now we check both that new files are created without the executable bit
and that we can actually modify it with chmod.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---  8<  ---
 builtin-init-db.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

On Wed, Oct 03, 2007 at 02:19:40PM +0200, Johannes Sixt wrote:
> On Windows, we don't get an executable bit at all. Better use both 
> heuristics, i.e. set core.filemode false if either one diagnoses an 
> unreliable x-bit.

this should work better for Windows.
Previously I sent it only to Johannes and forgot to Cc the list.


diff --git a/builtin-init-db.c b/builtin-init-db.c
index 763fa55..1d92916 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -247,7 +247,10 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	filemode = TEST_FILEMODE;
 	if (TEST_FILEMODE && !lstat(path, &st1)) {
 		struct stat st2;
-		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
+		/* test that new files are not created with X bit */
+		filemode = !(st1.st_mode & S_IXUSR);
+		/* test that we can modify the X bit */
+		filemode &= (!chmod(path, st1.st_mode ^ S_IXUSR) &&
 				!lstat(path, &st2) &&
 				st1.st_mode != st2.st_mode);
 	}
-- 
1.5.3.3.8.g367dc7

-- 
Martin Waitz
