From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/5] git-merge: add support for branch.<name>.mergeoptions
Date: Sat, 22 Sep 2007 02:33:04 +0200
Message-ID: <1190421186-21784-4-git-send-email-hjemli@gmail.com>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
 <1190421186-21784-2-git-send-email-hjemli@gmail.com>
 <1190421186-21784-3-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 02:34:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYswf-00017n-8n
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbXIVAde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573AbXIVAdd
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:33:33 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:46848 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420AbXIVAdd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:33:33 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l8M0WYsQ018896;
	Sat, 22 Sep 2007 02:32:35 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.2.82.g75c8d
In-Reply-To: <1190421186-21784-3-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58906>

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
 git-merge.sh                |   16 +++++++++++
 t/t7600-merge.sh            |   63 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 0 deletions(-)

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
index a3ef676..39a24ac 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -168,9 +168,25 @@ parse_option () {
 	args_left="$#"
 }
 
+parse_config () {
+	while test "$#" != "0"
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
+branch=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
+mergeopts=$(git config "branch.$branch.mergeoptions")
+parse_config $mergeopts
+
 while parse_option "$@"
 do
 	while test $args_left -lt $#
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9e58636..e99b5d9 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -314,4 +314,67 @@ test_expect_success 'merge c1 with c2 and c3 (squash)' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2 (no-commit in config)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--no-commit" &&
+	git merge c2 &&
+	if test "$c1" != "$(git rev-parse HEAD)"
+	then
+		echo "[OOPS] HEAD changed"
+		false
+	fi &&
+	if ! cmp -s file result.1-5
+	then
+		echo "[OOPS] merge result is wrong"
+		false
+	fi &&
+	if test "$c2" != "$(cat .git/MERGE_HEAD)"
+	then
+		echo "[OOPS] MERGE_HEAD is wrong"
+		false
+	fi
+'
+
+test_expect_success 'merge c1 with c2 (squash in config)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--squash" &&
+	git merge c2 &&
+	if test "$c1" != "$(git rev-parse HEAD)"
+	then
+		echo "[OOPS] new commit created"
+		false
+	fi &&
+	if ! cmp -s file result.1-5
+	then
+		echo "[OOPS] merge result is wrong"
+		false
+	fi &&
+	if test -f .git/MERGE_HEAD
+	then
+		echo "[OOPS] MERGE_HEAD exists"
+		false
+	fi
+'
+
+test_expect_success 'override config option -n' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "-n" &&
+	git merge --summary c2 >diffstat.txt &&
+	if ! grep -e "^ file | \+2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was not generated"
+	fi
+'
+
+test_expect_success 'override config option --summary' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--summary" &&
+	git merge -n c2 >diffstat.txt &&
+	if grep -e "^ file | \+2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was generated"
+		false
+	fi
+'
+
 test_done
-- 
1.5.3.2.82.g75c8d
