From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] stash: --keep option just saves
Date: Thu, 12 Feb 2009 06:25:14 +0900
Message-ID: <20090212062514.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 22:27:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXMc6-00040u-5O
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 22:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360AbZBKVZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 16:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757353AbZBKVZy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 16:25:54 -0500
Received: from karen.lavabit.com ([72.249.41.33]:37081 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756954AbZBKVZy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 16:25:54 -0500
Received: from h.earth.lavabit.com (h.earth.lavabit.com [192.168.111.17])
	by karen.lavabit.com (Postfix) with ESMTP id 6404F11BACB;
	Wed, 11 Feb 2009 15:25:53 -0600 (CST)
Received: from 8583.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 1QPUYPRUTUQ9; Wed, 11 Feb 2009 15:25:53 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=KDXPJJiF6sXc4BhCrhGiZvjwqAB07v73qY2vMZpucmJvmVt7N3sawlBP1vy+XhWAeOJoraVtmpviuCjYi3ulYsoSEmjg0Wb3TH9UdqojcozTE6J6h9SBhiN5E10C+JaWapENbU8RMAT0zAYA6QXIsAF6ibrp/lElJ909k2BUee8=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109533>

The "save" subcommand usually removes the changes it stashed from the
index and the work tree. Existing --keep-index option however keeps the
changes to the index. This new option keeps the changes made to both the
index and the work tree.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/git-stash.txt |    7 +++++--
 git-stash.sh                |   35 +++++++++++++++++++++++++++++------
 t/t3903-stash.sh            |   22 ++++++++++++++++++++++
 3 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 051f94d..ddd68ef 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git stash' (show | drop | pop ) [<stash>]
 'git stash' apply [--index] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--keep-index] [<message>]]
+'git stash' [save [--keep | --keep-index] [<message>]]
 'git stash' clear
 'git stash' create
 
@@ -41,13 +41,16 @@ is also possible).
 OPTIONS
 -------
 
-save [--keep-index] [<message>]::
+save [--keep | --keep-index] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  This is the default action when no
 	subcommand is given. The <message> part is optional and gives
 	the description along with the stashed state.
 +
+If the `--keep` option is used, `git reset --hard` is omitted and your
+changes to the index and the work tree will be kept.
++
 If the `--keep-index` option is used, all changes already added to the
 index are left intact.
 
diff --git a/git-stash.sh b/git-stash.sh
index b9ace99..0d5efaa 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -6,7 +6,7 @@ USAGE="list [<options>]
    or: $dashless (show | drop | pop ) [<stash>]
    or: $dashless apply [--index] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--keep-index] [<message>]]
+   or: $dashless [save [--keep | --keep-index] [<message>]]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -93,12 +93,31 @@ create_stash () {
 }
 
 save_stash () {
+	keep=
 	keep_index=
-	case "$1" in
-	--keep-index)
-		keep_index=t
+	while test $# != 0
+	do
+		case "$1" in
+		--keep-index)
+			keep_index=t
+			;;
+		--keep)
+			keep=t
+			;;
+		--)
+			shift
+			break
+			;;
+		*)
+			break
+			;;
+		esac
 		shift
-	esac
+	done
+	if test "$keep$keep_index" = tt
+	then
+		die "Cannot use --keep and --keep-index at the same time"
+	fi
 
 	stash_msg="$*"
 
@@ -120,8 +139,12 @@ save_stash () {
 		die "Cannot save the current status"
 	printf 'Saved working directory and index state "%s"\n' "$stash_msg"
 
-	git reset --hard
+	if test -n "$keep"
+	then
+		return
+	fi
 
+	git reset --hard
 	if test -n "$keep_index" && test -n $i_tree
 	then
 		git read-tree --reset -u $i_tree
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7484cbe..90f0902 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -177,4 +177,26 @@ test_expect_success 'stash branch' '
 	test 0 = $(git stash list | wc -l)
 '
 
+test_expect_success 'stash --keep-index' '
+	git stash clear &&
+	echo modified > file &&
+	git add file &&
+	echo changed > file &&
+	git stash save --keep-index test &&
+	git diff --exit-code &&
+	test modified = "$(cat file)" &&
+	git diff stash^ stash | grep "^+changed"
+'
+
+test_expect_success 'stash --keep' '
+	git stash clear &&
+	echo modified > file &&
+	git add file &&
+	echo changed > file &&
+	git stash save --keep test &&
+	test changed = "$(cat file)" &&
+	git diff --exit-code stash &&
+	test modified = "$(git show :file)"
+'
+
 test_done
-- 
1.6.2.rc0

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
