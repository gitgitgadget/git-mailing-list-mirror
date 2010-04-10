From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH v2 1/9] Generate unique ID for submodules created using "git submodule add"
Date: Sat, 10 Apr 2010 19:23:42 +0100
Message-ID: <1270923830-11830-2-git-send-email-peter@pcc.me.uk>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 20:24:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fMN-0007O3-Vh
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab0DJSYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:24:15 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:37789 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041Ab0DJSXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:23:54 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLV-0006qO-8t; Sat, 10 Apr 2010 19:23:53 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLU-000369-8U; Sat, 10 Apr 2010 19:23:52 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144567>

This patch causes "git submodule add" to generate a unique ID for
the submodule which is used as its name.  The ID is formed by
concatenating the basename of the submodule path, a dash ("-")
character and the 7-character truncated SHA1 hash of the pid, date
and initial path.

The purpose of this patch is to avoid name conflicts which may arise
due to the ability to rename submodules.

The justification for truncating the SHA1 to 7 characters is that a
submodule naming clash is a highly infrequent event (as compared to
a file naming clash) so we can minimise the ugliness of generated
submodule names by using a smaller number of characters.

The justification for including the submodule path basename is that we
should include some component of the submodule path in the submodule
name to make it possible to identify a particular submodule by its
name.  At the same time we should be conscious of the fact that the
submodule path may change.  Including the entire submodule path in
the submodule name is likely to confuse users if the path changes.
The basename is the component of the path which is least likely
to change, which is a factor in favour of its inclusion in the
submodule name.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 Documentation/git-submodule.txt |    8 +++++++-
 git-submodule.sh                |   31 +++++++++++++++++++++++++++++--
 t/t7403-submodule-sync.sh       |    2 +-
 t/t7406-submodule-update.sh     |    6 +++---
 t/t7407-submodule-foreach.sh    |   14 +++++++-------
 5 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2502531..1bf78b6 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git submodule' [--quiet] add [-b branch]
-	      [--reference <repository>] [--] <repository> [<path>]
+	      [--reference <repository>] [-n <name>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
@@ -199,6 +199,12 @@ OPTIONS
 	(the default). This limit only applies to modified submodules. The
 	size is always limited to 1 for added/deleted/typechanged submodules.
 
+-n <name>::
+--name <name>::
+	This option is only valid for the add command.
+	Name of the new submodule.  By default, a unique identifier
+	is generated.
+
 -N::
 --no-fetch::
 	This option is only valid for the update command.
diff --git a/git-submodule.sh b/git-submodule.sh
index 187461c..de29f3a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -114,6 +114,23 @@ module_clone()
 }
 
 #
+# Generate a unique identifier.  Used to name a submodule.
+#
+gen_uid()
+{
+	path="$1"
+
+	pathbase=$(basename "$path")
+	echo -n "$pathbase"-
+
+	(
+	 echo "$path"
+	 echo $$
+	 date
+	) | git hash-object --stdin | cut -c1-7
+}
+
+#
 # Add a new submodule to the working tree, .gitmodules and the index
 #
 # $@ = repo path
@@ -131,6 +148,11 @@ cmd_add()
 			branch=$2
 			shift
 			;;
+		-n | --name)
+			case "$2" in '') usage ;; esac
+			name=$2
+			shift
+			;;
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
@@ -235,8 +257,13 @@ cmd_add()
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
 
-	git config -f .gitmodules submodule."$path".path "$path" &&
-	git config -f .gitmodules submodule."$path".url "$repo" &&
+	if test -z "$name"
+	then
+		name=$(gen_uid "$path")
+	fi
+
+	git config -f .gitmodules submodule."$name".path "$path" &&
+	git config -f .gitmodules submodule."$name".url "$repo" &&
 	git add .gitmodules ||
 	die "Failed to register submodule '$path'"
 }
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 7538756..f2c66f8 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 	git clone . super &&
 	git clone super submodule &&
 	(cd super &&
-	 git submodule add ../submodule submodule &&
+	 git submodule add -n submodule ../submodule submodule &&
 	 test_tick &&
 	 git commit -m "submodule"
 	) &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1382a8e..5bcac8f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -31,7 +31,7 @@ test_expect_success 'setup a submodule tree' '
 	git clone super rebasing &&
 	git clone super merging &&
 	(cd super &&
-	 git submodule add ../submodule submodule &&
+	 git submodule add -n submodule ../submodule submodule &&
 	 test_tick &&
 	 git commit -m "submodule" &&
 	 git submodule init submodule
@@ -49,12 +49,12 @@ test_expect_success 'setup a submodule tree' '
 	 git commit -m "submodule update"
 	) &&
 	(cd super &&
-	 git submodule add ../rebasing rebasing &&
+	 git submodule add -n rebasing ../rebasing rebasing &&
 	 test_tick &&
 	 git commit -m "rebasing"
 	) &&
 	(cd super &&
-	 git submodule add ../merging merging &&
+	 git submodule add -n merging ../merging merging &&
 	 test_tick &&
 	 git commit -m "rebasing"
 	)
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 2a52775..a0390dd 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -21,9 +21,9 @@ test_expect_success 'setup a submodule tree' '
 	git clone super submodule &&
 	(
 		cd super &&
-		git submodule add ../submodule sub1 &&
-		git submodule add ../submodule sub2 &&
-		git submodule add ../submodule sub3 &&
+		git submodule add -n sub1 ../submodule sub1 &&
+		git submodule add -n sub2 ../submodule sub2 &&
+		git submodule add -n sub3 ../submodule sub3 &&
 		git config -f .gitmodules --rename-section \
 			submodule.sub1 submodule.foo1 &&
 		git config -f .gitmodules --rename-section \
@@ -82,28 +82,28 @@ test_expect_success 'setup nested submodules' '
 	git clone submodule nested3 &&
 	(
 		cd nested3 &&
-		git submodule add ../submodule submodule &&
+		git submodule add -n submodule ../submodule submodule &&
 		test_tick &&
 		git commit -m "submodule" &&
 		git submodule init submodule
 	) &&
 	(
 		cd nested2 &&
-		git submodule add ../nested3 nested3 &&
+		git submodule add -n nested3 ../nested3 nested3 &&
 		test_tick &&
 		git commit -m "nested3" &&
 		git submodule init nested3
 	) &&
 	(
 		cd nested1 &&
-		git submodule add ../nested2 nested2 &&
+		git submodule add -n nested2 ../nested2 nested2 &&
 		test_tick &&
 		git commit -m "nested2" &&
 		git submodule init nested2
 	) &&
 	(
 		cd super &&
-		git submodule add ../nested1 nested1 &&
+		git submodule add -n nested1 ../nested1 nested1 &&
 		test_tick &&
 		git commit -m "nested1" &&
 		git submodule init nested1
-- 
1.6.5
