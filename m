From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 4/6] git-merge: add support for branch.<name>.mergeoptions
Date: Mon, 24 Sep 2007 00:51:43 +0200
Message-ID: <1190587905-700-5-git-send-email-hjemli@gmail.com>
References: <1190587905-700-1-git-send-email-hjemli@gmail.com>
 <1190587905-700-2-git-send-email-hjemli@gmail.com>
 <1190587905-700-3-git-send-email-hjemli@gmail.com>
 <1190587905-700-4-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 00:52:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaJ0-0002CH-HO
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 00:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755288AbXIWWvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 18:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755014AbXIWWvo
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 18:51:44 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:42837 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755144AbXIWWvo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 18:51:44 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id l8NMp91P023085;
	Mon, 24 Sep 2007 00:51:11 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190587905-700-4-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58998>

This enables per branch configuration of merge options. Currently, the most
useful options to specify per branch are --squash, --summary/--no-summary
and possibly --strategy, but all options are supported.

Note: Options containing whitespace will _not_ be handled correctly. Luckily,
the only option which can include whitespace is --message and it doesn't
make much sense to give that option a default value.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/config.txt    |    6 ++++
 Documentation/git-merge.txt |    4 +++
 git-merge.sh                |   21 ++++++++++++++++
 t/t7600-merge.sh            |   54 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 015910f..d3c25f3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -337,6 +337,12 @@ branch.<name>.merge::
 	branch.<name>.merge to the desired branch, and use the special setting
 	`.` (a period) for branch.<name>.remote.
 
+branch.<name>.mergeoptions::
+	Sets default options for merging into branch <name>. The syntax and
+	supported options are equal to that of gitlink:git-merge[1], but
+	option values containing whitespace characters are currently not
+	supported.
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f or -n.  Defaults
 	to false.
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 144bc16..b1771a1 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -58,6 +58,10 @@ merge.verbosity::
 	above outputs debugging information.  The default is level 2.
 	Can be overriden by 'GIT_MERGE_VERBOSITY' environment variable.
 
+branch.<name>.mergeoptions::
+	Sets default options for merging into branch <name>. The syntax and
+	supported options are equal to that of git-merge, but option values
+	containing whitespace characters are currently not supported.
 
 HOW MERGE WORKS
 ---------------
diff --git a/git-merge.sh b/git-merge.sh
index 68b3503..e95d4a7 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -168,9 +168,30 @@ parse_option () {
 	args_left="$#"
 }
 
+parse_config () {
+	while test $# -gt 0
+	do
+		parse_option "$@" || usage
+		while test $args_left -lt $#
+		do
+			shift
+		done
+	done
+}
+
 case "$#" in 0) usage ;; esac
 
 have_message=
+
+if branch=$(git-symbolic-ref -q HEAD)
+then
+	mergeopts=$(git config "branch.${branch#refs/heads/}.mergeoptions")
+	if test -n "$mergeopts"
+	then
+		parse_config $mergeopts
+	fi
+fi
+
 while parse_option "$@"
 do
 	while test $args_left -lt $#
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index dec6ea2..110974c 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -341,4 +341,58 @@ test_expect_success 'merge c1 with c2 and c3 (squash)' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2 (no-commit in config)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--no-commit" &&
+	git merge c2 &&
+	verify_merge file result.1-5 &&
+	verify_head $c1 &&
+	verify_mergeheads $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (squash in config)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--squash" &&
+	git merge c2 &&
+	verify_merge file result.1-5 &&
+	verify_head $c1 &&
+	verify_no_mergehead &&
+	verify_diff squash.1-5 .git/SQUASH_MSG "[OOPS] bad squash message"
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'override config option -n' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "-n" &&
+	test_tick &&
+	git merge --summary c2 >diffstat.txt &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2 &&
+	if ! grep -e "^ file | \+2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was not generated"
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'override config option --summary' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--summary" &&
+	test_tick &&
+	git merge -n c2 >diffstat.txt &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2 &&
+	if grep -e "^ file | \+2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was generated"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.5.3.2.82.g75c8d
