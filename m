From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] post-update hook: update working copy
Date: Fri,  2 Nov 2007 13:45:04 +1300
Message-ID: <1193964304-10847-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 01:45:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InkfH-0004yp-3s
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 01:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbXKBApU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 20:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbXKBApU
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 20:45:20 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:49118 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbXKBApT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 20:45:19 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1Inken-0001Ww-8H; Fri, 02 Nov 2007 13:45:05 +1300
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id 125982C4E9; Fri,  2 Nov 2007 13:45:05 +1300 (NZDT)
X-Mailer: git-send-email 1.5.3.2.3.g2f2dcc-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63044>

Now that git-stash is available, it is not so unsafe to push to a
non-bare repository, but care needs to be taken to preserve any dirty
working copy or index state.  This hook script does that, using
git-stash.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 templates/hooks--post-update |   76 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 73 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 templates/hooks--post-update

diff --git a/templates/hooks--post-update b/templates/hooks--post-update
old mode 100644
new mode 100755
index bcba893..352a432
--- a/templates/hooks--post-update
+++ b/templates/hooks--post-update
@@ -1,8 +1,78 @@
 #!/bin/sh
 #
-# An example hook script to prepare a packed repository for use over
-# dumb transports.
+# This hook does two things:
+#
+#  1. update the "info" files that allow the list of references to be
+#     queries over dumb transports such as http
+#
+#  2. if this repository looks like it is a non-bare repository, and
+#     the checked-out branch is pushed to, then update the working copy.
+#     This makes "push" function somewhat similarly to darcs and bzr.
 #
 # To enable this hook, make this file executable by "chmod +x post-update".
 
-exec git-update-server-info
+git-update-server-info
+
+is_bare=$(git-config --get --bool core.bare)
+
+if [ -z "$is_bare" ]
+then
+	# for compatibility's sake, guess
+	git_dir_full=$(cd $GIT_DIR; pwd)
+	case $git_dir_full in */.git) is_bare=false;; *) is_bare=true;; esac
+fi
+
+update_wc() {
+	ref=$1
+	echo "Push to checked out branch $ref" >&2
+	if (cd $GIT_WORK_TREE; git-diff-files -q --exit-code >/dev/null)
+	then
+		wc_dirty=0
+	else
+		echo "W:unstaged changes found in working copy" >&2
+		wc_dirty=1
+		desc="working copy"
+	fi
+	if git diff-index HEAD@{1} >/dev/null
+	then
+		index_dirty=0
+	else
+		echo "W:uncommitted, staged changes found" >&2
+		index_dirty=1
+		if [ -n "$desc" ]
+		then
+			desc="$desc and index"
+		else
+			desc="index"
+		fi
+	fi
+	if [ "$wc_dirty" -ne 0 -o "$index_dirty" -ne 0 ]
+	then
+		new=$(git rev-parse HEAD)
+		git-update-ref --no-deref HEAD HEAD@{1}
+		echo "W:stashing dirty $desc - see git-stash(1)" >&2
+		(cd $GIT_WORK_TREE
+		git stash save "dirty $desc before update to $new")
+		git-symbolic-ref HEAD "$ref"
+	fi
+
+	# eye candy - show the WC updates :)
+	echo "Updating working copy" >&2
+	(cd $GIT_WORK_TREE
+	git-diff-index -R --name-status HEAD >&2
+	git-reset --hard HEAD)
+}
+
+if [ "$is_bare" = "false" ]
+then
+	active_branch=`git-symbolic-ref HEAD`
+	export GIT_DIR=$(cd $GIT_DIR; pwd)
+	GIT_WORK_TREE=${GIT_WORK_TREE-..}
+	for ref
+	do
+		if [ "$ref" = "$active_branch" ]
+		then
+			update_wc $ref
+		fi
+	done
+fi
-- 
1.5.3.2.3.g2f2dcc-dirty
