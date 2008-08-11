From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Adjust for the new way of enabling the default post-update
	hook
Date: Tue, 12 Aug 2008 00:34:46 +0200
Message-ID: <20080811223446.8342.37008.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 12 00:43:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSg7A-00077E-KV
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 00:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbYHKWm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 18:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbYHKWm2
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 18:42:28 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:58855 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752357AbYHKWm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 18:42:27 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Aug 2008 18:42:26 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id E6B1F2ACA47;
	Tue, 12 Aug 2008 00:34:46 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92015>

The post-update hook, which is required to be enabled in order for
the repository to be accessible over HTTP, is not enabled by
chmod a+x anymore, but instead by dropping the .sample suffix.

This patch emphasizes this change in the release notes (since
I believe this is rather noticeable backwards-incompatible change).
It also adjusts the documentation which still described the old way
and fixes t/t5540-http-push.sh, which was broken for 1.5 month
but apparently noone ever runs this test.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/RelNotes-1.6.0.txt   |    4 ++++
 Documentation/gitcore-tutorial.txt |   15 ++++++++-------
 Documentation/user-manual.txt      |    2 +-
 t/t5540-http-push.sh               |    2 +-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/RelNotes-1.6.0.txt b/Documentation/RelNotes-1.6.0.txt
index 8afb5b2..ad19122 100644
--- a/Documentation/RelNotes-1.6.0.txt
+++ b/Documentation/RelNotes-1.6.0.txt
@@ -28,6 +28,10 @@ introduced in v1.5.2 and v1.4.4.5.  If you want to keep your repositories
 backwards compatible past these versions, set repack.useDeltaBaseOffset
 to false or pack.indexVersion to 1, respectively.
 
+The standard way of making repositories friendly to dumb protocols
+(i.e. HTTP) changed: instead of making hooks/post-update executable,
+hooks/post-update.sample is to be moved to hooks/post-update.
+
 GIT_CONFIG, which was only documented as affecting "git config", but
 actually affected all git commands, now only affects "git config".
 GIT_LOCAL_CONFIG, also only documented as affecting "git config" and
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 49179b0..a417e59 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1366,8 +1366,9 @@ your login shell is 'bash', only `.bashrc` is read and not
 
 [NOTE]
 If you plan to publish this repository to be accessed over http,
-you should do `chmod +x my-git.git/hooks/post-update` at this
-point.  This makes sure that every time you push into this
+you should do `mv my-git.git/hooks/post-update.sample
+my-git.git/hooks/post-update` at this point.
+This makes sure that every time you push into this
 repository, `git update-server-info` is run.
 
 Your "public repository" is now ready to accept your changes.
@@ -1486,11 +1487,11 @@ A recommended workflow for a "project lead" goes like this:
 If other people are pulling from your repository over dumb
 transport protocols (HTTP), you need to keep this repository
 'dumb transport friendly'.  After `git init`,
-`$GIT_DIR/hooks/post-update` copied from the standard templates
-would contain a call to 'git-update-server-info' but the
-`post-update` hook itself is disabled by default -- enable it
-with `chmod +x post-update`.  This makes sure 'git-update-server-info'
-keeps the necessary files up-to-date.
+`$GIT_DIR/hooks/post-update.sample` copied from the standard templates
+would contain a call to 'git-update-server-info'
+but you need to manually enable the hook with
+`mv post-update.sample post-update`.  This makes sure
+'git-update-server-info' keeps the necessary files up-to-date.
 
 3. Push into the public repository from your primary
    repository.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e999211..08d1310 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1890,7 +1890,7 @@ adjustments to give web clients some extra information they need:
 $ mv proj.git /home/you/public_html/proj.git
 $ cd proj.git
 $ git --bare update-server-info
-$ chmod a+x hooks/post-update
+$ mv hooks/post-update.sample hooks/post-update
 -------------------------------------------------
 
 (For an explanation of the last two lines, see
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index f8c17cd..b0d242e 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -41,7 +41,7 @@ test_expect_success 'setup remote repository' '
 	git clone --bare test_repo test_repo.git &&
 	cd test_repo.git &&
 	git --bare update-server-info &&
-	chmod +x hooks/post-update &&
+	mv hooks/post-update.sample hooks/post-update &&
 	cd - &&
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
 '
