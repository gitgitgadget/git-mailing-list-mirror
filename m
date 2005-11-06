From: Yaacov Akiba Slama <ya@slamail.org>
Subject: [PATCH]: Add git help command. A good patch this time, I hope
Date: Sun, 6 Nov 2005 12:39:17 +0200
Message-ID: <11312735573649-git-send-email-ya@slamail.org>
References: <436D276F.7010302@slamail.org>
Reply-To: Yaacov Akiba Slama <ya@slamail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Yaacov Akiba Slama <yaslama@laptop2.localdomain>
X-From: git-owner@vger.kernel.org Sun Nov 06 11:57:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYiAz-0003NQ-3D
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 11:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVKFKyx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 05:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVKFKyw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 05:54:52 -0500
Received: from [195.140.142.33] ([195.140.142.33]:9876 "EHLO c1-033.cyaris.net")
	by vger.kernel.org with ESMTP id S932353AbVKFKyv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 05:54:51 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EYiAd-000778-Qk; Sun, 06 Nov 2005 11:54:50 +0100
Received: from [127.0.0.1] (helo=laptop2)
	by localhost.localdomain with smtp (Exim 4.54)
	id 1EYhvh-0004OK-CI; Sun, 06 Nov 2005 12:39:17 +0200
In-Reply-To: <436D276F.7010302@slamail.org>
X-Mailer: git-send-email
To: Yaacov Akiba Slama <ya@slamail.org>
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  git help COMMAND will call "man COMMAND" if there is a
	manpage. If there is no manpage for the command, a simple help will be
	shown. Signed-off-by: Yaacov Akiba Slama <yaslama@laptop2.localdomain>
	--- [...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11205>

git help COMMAND will call "man COMMAND" if there is a manpage.
If there is no manpage for the command, a simple help will be shown.

Signed-off-by: Yaacov Akiba Slama <yaslama@laptop2.localdomain>

---

 .gitignore  |    1 +
 Makefile    |    2 +-
 git-help.sh |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git.sh      |   49 +---------------------------------------
 4 files changed, 76 insertions(+), 49 deletions(-)
 create mode 100755 git-help.sh

applies-to: 5af1b5b93257ecfe993bb24975bf596faa342758
e45c839c235cfd3d60cf611f420742bebdd0fe20
diff --git a/.gitignore b/.gitignore
index 3edf6b4..a412a09 100644
--- a/.gitignore
+++ b/.gitignore
@@ -34,6 +34,7 @@ git-format-patch
 git-fsck-objects
 git-get-tar-commit-id
 git-grep
+git-help
 git-hash-object
 git-http-fetch
 git-index-pack
diff --git a/Makefile b/Makefile
index 6c01dc2..fc42049 100644
--- a/Makefile
+++ b/Makefile
@@ -81,7 +81,7 @@ SCRIPT_SH = \
 	git-add.sh git-bisect.sh git-branch.sh git-checkout.sh \
 	git-cherry.sh git-clone.sh git-commit.sh \
 	git-count-objects.sh git-diff.sh git-fetch.sh \
-	git-format-patch.sh git-log.sh git-ls-remote.sh \
+	git-format-patch.sh git-help.sh git-log.sh git-ls-remote.sh \
 	git-merge-one-file.sh git-octopus.sh git-parse-remote.sh \
 	git-prune.sh git-pull.sh git-push.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
diff --git a/git-help.sh b/git-help.sh
new file mode 100755
index 0000000..a415f0c
--- /dev/null
+++ b/git-help.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+cmd=
+path=$(dirname "$0")
+case "$#" in
+0)	;;
+*)	cmd="$1"
+	shift
+
+        man -w -W git-$cmd &> /dev/null && man git-$cmd && exit 0
+esac
+
+case "$cmd" in
+	help)
+	cmd=""
+	;;
+esac
+
+if [ -n "$cmd" ]; then
+    echo "git command '$cmd' not found."
+    echo
+fi
+
+echo "Usage: git COMMAND [OPTIONS] [TARGET]"
+echo "Type 'git help COMMAND' for help on a specific command."
+echo
+
+echo "git commands are:"
+
+fmt <<\EOF | sed -e 's/^/    /'
+add
+apply
+archimport
+bisect
+branch
+checkout
+cherry
+clone
+commit
+count-objects
+cvsimport
+diff
+fetch
+format-patch
+fsck-objects
+get-tar-commit-id
+help
+init-db
+log
+ls-remote
+octopus
+pack-objects
+parse-remote
+patch-id
+prune
+pull
+push
+rebase
+relink
+rename
+repack
+request-pull
+reset
+resolve
+revert
+send-email
+shortlog
+show-branch
+status
+tag
+verify-tag
+whatchanged
+EOF
diff --git a/git.sh b/git.sh
index 94940ae..995df00 100755
--- a/git.sh
+++ b/git.sh
@@ -25,52 +25,5 @@ case "$#" in
 	;;
 esac
 
-echo "Usage: git COMMAND [OPTIONS] [TARGET]"
-if [ -n "$cmd" ]; then
-    echo "git command '$cmd' not found."
-fi
-echo "git commands are:"
+exec "$path/git-help" "$cmd"
 
-fmt <<\EOF | sed -e 's/^/    /'
-add
-apply
-archimport
-bisect
-branch
-checkout
-cherry
-clone
-commit
-count-objects
-cvsimport
-diff
-fetch
-format-patch
-fsck-objects
-get-tar-commit-id
-init-db
-log
-ls-remote
-octopus
-pack-objects
-parse-remote
-patch-id
-prune
-pull
-push
-rebase
-relink
-rename
-repack
-request-pull
-reset
-resolve
-revert
-send-email
-shortlog
-show-branch
-status
-tag
-verify-tag
-whatchanged
-EOF
---
0.99.9.GIT
