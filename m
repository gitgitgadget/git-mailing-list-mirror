From: Antony Male <antony.male@gmail.com>
Subject: [PATCH] Submodules always use a relative path to gitdir
Date: Thu, 29 Dec 2011 21:00:26 +0000
Message-ID: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
Cc: gitster@pobox.com, iveqy@iveqy.com,
	Antony Male <antony.male@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 29 22:11:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgNFp-0005f7-4r
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 22:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab1L2VLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 16:11:08 -0500
Received: from li299-15.members.linode.com ([178.79.161.15]:35441 "EHLO
	antonymale.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab1L2VLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 16:11:07 -0500
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Dec 2011 16:11:06 EST
Received: by antonymale.co.uk (Postfix, from userid 1000)
	id 62D0CA801F; Thu, 29 Dec 2011 21:00:31 +0000 (GMT)
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187785>

This fixes a problem where moving a git repository with checked-out
submodules would cause a fatal error when commands such as 'git
submodule update' were run.

Git submoule clone uses git clone --separate-git-dir to checkout a
submodule's git repository into <supermodule>/.git/modules, if this
folder does not already exist. git clone --separate-git-dir was
designed for a scenario where the git repository stays in one location
and the working copy can be moved. Therefore the .git file in the
working copy uses an absolute path to specify the location of the
repository.

In the submodules scenario, neither the git repository nor the working
copy will be moved relative to each other. However, the supermodule may
be moved, which moves both the submodule's git repository and its
working copy. This means that the submodule's .git file no longer
points to its repository, causing the error.

Previously, if git submodule clone was called when the submodule's git
repository already existed in <supermodule>/.git/modules, it would
simply re-create the submodule's .git file, using a relative path.
This patch uses the above mechanism to re-write the .git file after git
clone --separate-git-dir is run, replacing the absolute path with a
relative one.

An alternative patch would teach git-clone an option to control whether
an absolute or relative path is used when --separate-git-dir is passed.

Signed-off-by: Antony Male <antony.male@gmail.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3adab93..18eb5ff 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -159,7 +159,6 @@ module_clone()
 	if test -d "$gitdir"
 	then
 		mkdir -p "$path"
-		echo "gitdir: $rel_gitdir" >"$path/.git"
 		rm -f "$gitdir/index"
 	else
 		mkdir -p "$gitdir_base"
@@ -171,6 +170,7 @@ module_clone()
 		fi ||
 		die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
 	fi
+	echo "gitdir: $rel_gitdir" >"$path/.git"
 }
 
 #
-- 
1.7.8
