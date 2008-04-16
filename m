From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 3/7] git-submodule: Fall back on .gitmodules if info not found in $GIT_DIR/config
Date: Wed, 16 Apr 2008 22:19:33 +0800
Message-ID: <1208355577-8734-4-git-send-email-pkufranky@gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 16:30:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm8VL-00050Q-3D
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 16:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbYDPOUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 10:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756935AbYDPOTp
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 10:19:45 -0400
Received: from mail.qikoo.org ([60.28.205.235]:52421 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752755AbYDPOTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 10:19:42 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 2046A470B0; Wed, 16 Apr 2008 22:19:37 +0800 (CST)
X-Mailer: git-send-email 1.5.5.70.gd68a
In-Reply-To: <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79705>

Originally, the submodule workflow enforces 'git init' in the beginning
which copies submodule config info from .gitmodules to $GIT_DIR/config.
Then all subcommands except 'init' and 'add' fetch submodule info from
$GIT_DIR/config and .gitmodules can be discarded.

However, there may be inconsistence between .git/config and .gitmodules
when always using 'git init' at first. If upstream .gitmodules changes,
it is not easy to sync the changes to $GIT_DIR/config.

Running 'git init' again may not help much in this case.  Since .git/config
has a whole copy of .gitmodules, the user has no easy way to know which
entries should follow the upstream changes and which entires shouldn't.

Actually, .gitmodules which formly only acted as info hints can and should
play a more important and essential role.

As an analogy to .gitignore and .git/info/excludes which are for colleagues'
and individual wishes separately, .gitmodules is for common requirements and
$GIT_DIR/config is for special requirements.

This patch implements a fall back strategy to satisfy both common and
special requirements as follows.

$GIT_DIR/config only keeps submodule info different from .gitmodules.
And the info from $GIT_DIR/config take higher precedence. The code first
consults $GIT_DIR/config and then fall back on in-tree .gitmodules file.

With this patch, init subcommand becomes not forcefull and less meaningful.
And now it is just a tool to help users copy info to $GIT_DIR/config
(and may modify it later) only when they need.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh           |    9 ++++-----
 t/t7400-submodule-basic.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d3ae1e4..2276f6b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -98,7 +98,8 @@ module_name()
 }
 
 module_url() {
-	git config submodule.$1.url
+	git config submodule.$1.url ||
+	GIT_CONFIG=.gitmodules git config submodule.$1.url
 }
 
 module_info() {
@@ -256,12 +257,10 @@ cmd_init()
 	while read sha1 path name url
 	do
 		test -n "$name" || exit
-		# Skip already registered paths
-		test -z "$url" || continue
-
-		url=$(GIT_CONFIG=.gitmodules git config submodule."$name".url)
 		test -z "$url" &&
 		die "No url found for submodule path '$path' in .gitmodules"
+		# Skip already registered paths
+		test -z "$(git config submodule.$name.url)" || continue
 
 		url=$(absolute_url "$url")
 		git config submodule."$name".url "$url" ||
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e5d59b8..8b35ff8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -174,6 +174,35 @@ test_expect_success 'status should be "up-to-date" after update' '
 	git-submodule status | grep "^ $rev1"
 '
 
+test_expect_success 'status should be "modified" after submodule reset --hard HEAD@{1}' '
+	cd init &&
+	git reset --hard HEAD@{1}
+	rev2=$(git rev-parse HEAD) &&
+	cd .. &&
+	if test -z "$rev2"
+	then
+		echo "[OOPS] submodule git rev-parse returned nothing"
+		false
+	fi &&
+	git-submodule status | grep "^+$rev2"
+'
+
+test_expect_success 'update should checkout rev1 with falling back' '
+	git-config --unset submodule.example.url &&
+	GIT_CONFIG=.gitmodules git config submodule.example.url .subrepo &&
+	git-submodule update init &&
+	head=$(cd init && git rev-parse HEAD) &&
+	if test -z "$head"
+	then
+		echo "[OOPS] submodule git rev-parse returned nothing"
+		false
+	elif test "$head" != "$rev1"
+	then
+		echo "[OOPS] init did not checkout correct head"
+		false
+	fi
+'
+
 test_expect_success 'checkout superproject with subproject already present' '
 	git-checkout initial &&
 	git-checkout master
-- 
1.5.5.70.gd68a
