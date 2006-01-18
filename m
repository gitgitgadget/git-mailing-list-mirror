From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Wed, 18 Jan 2006 00:53:32 -0800
Message-ID: <7vmzhtzzlf.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 09:53:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ez94T-00014v-Hb
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 09:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWARIxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 03:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWARIxe
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 03:53:34 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:19098 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030203AbWARIxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 03:53:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118085109.CHE17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 03:51:09 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0601170325y60094b4w693ac37490c67410@mail.gmail.com>
	(Alex Riesen's message of "Tue, 17 Jan 2006 12:25:37 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14813>

Sorry, but the previous patch turns out to be bogus as well.
'touch' did not affect the timestamp of the symbolic link but
ended up creating a file pointed by it, and since we (hopefully)
correctly do lstat() not stat(), it did not have any good
effect.  Here is an replacement.

-- >8 --
Subject: [PATCH] t4011: "sleep 1" sleeps too little on cygwin

This test depended on "sleep 1" not to return until the next
second boundary, to get a dirty index entry.  An initial fix was
provided by Alex Riesen using a bashism $SECONDS, but make it a
bit more portable, and also work around a potential problem on a
filesystem with coarser-than-a-second timestamp granularity,
this patch fixes it a bit differently.

The test is checking if we correctly notice the stat changes,
and the timestamp is not the only thing we have in the stat part
of the index.  This commit fixes the problem by leaving the
original symlink we create on the filesystem, so that it keeps
the inode number used for the original symlink in use, and then
create a second one which should get a different inode number.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 t/t4011-diff-symlink.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

5f6849e7b60bc4908bf10a7946fd93d4aaaf9c35
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index e3ebf38..f0e3491 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -48,7 +48,7 @@ EOF
 
 test_expect_success \
     'diff removed symlink' \
-    'rm frotz &&
+    'mv frotz nitfol &&
     git-diff-index -M -p $tree > current &&
     compare_diff_patch current expected'
 
@@ -58,8 +58,7 @@ EOF
 
 test_expect_success \
     'diff identical, but newly created symlink' \
-    'sleep 1 &&
-    ln -s xyzzy frotz &&
+    'ln -s xyzzy frotz &&
     git-diff-index -M -p $tree > current &&
     compare_diff_patch current expected'
 
-- 
1.1.3.gce7b
