From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git submodule summary: add --files option
Date: Thu, 13 Aug 2009 21:32:50 +0200
Message-ID: <4A846A62.7010306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org, hjemli@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 13 21:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbg2k-0002zU-Aw
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbZHMTcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbZHMTcv
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:32:51 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:57256 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbZHMTcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:32:51 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 393FE10C9797B;
	Thu, 13 Aug 2009 21:32:51 +0200 (CEST)
Received: from [80.128.97.229] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Mbg2d-00032K-00; Thu, 13 Aug 2009 21:32:51 +0200
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/Vb8XnO0PRJYwwcG1PeuHDuI0lqBE3MDNQ8jbS
	d1tLgQyst1EuB8n3fv8h4uT2HkKv9V7eZBv3VaeKevhcSIrEDI
	pvcqhtzYUP87oN78JVSw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125857>

git submodule summary is providing similar functionality for submodules as
git diff-index does for a git project (including the meaning of --cached).
But the analogon to git diff-files is missing, so add a --files option to
summarize the differences between the index of the super project and the
last commit checked out in the working tree of the submodule.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-submodule.txt |   13 +++++++++++--
 git-submodule.sh                |   19 ++++++++++++++++---
 t/t7401-submodule-summary.sh    |   22 ++++++++++++++++++++++
 3 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 7dd73ae..145802a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
 	      [--reference <repository>] [--merge] [--] [<path>...]
-'git submodule' [--quiet] summary [--cached] [--summary-limit <n>] [commit] [--] [<path>...]
+'git submodule' [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach <command>
 'git submodule' [--quiet] sync [--] [<path>...]

@@ -127,7 +127,11 @@ summary::
 	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
 	in the submodule between the given super project commit and the
-	index or working tree (switched by --cached) are shown.
+	index or working tree (switched by --cached) are shown. If the option
+	--files is given, show the series of commits in the submodule between
+	the index of super project the and the working tree of the submodule
+	(this option doesn't allow to use the --cached option or to provide an
+	explicit commit).

 foreach::
 	Evaluates an arbitrary shell command in each checked out submodule.
@@ -169,6 +173,11 @@ OPTIONS
 	commands typically use the commit found in the submodule HEAD, but
 	with this option, the commit stored in the index is used instead.

+--files::
+	This option is only valid for the summary command. This command
+	compares the commit in the index with that in the submodule HEAD
+	when this option is used.
+
 -n::
 --summary-limit::
 	This option is only valid for the summary command.
diff --git a/git-submodule.sh b/git-submodule.sh
index ebed711..9bdd6ea 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,7 +4,7 @@
 #
 # Copyright (c) 2007 Lars Hjemli

-USAGE="[--quiet] [--cached] \
+USAGE="[--quiet] [--cached|--files] \
 [add [-b branch] <repo> <path>]|[status|init|update [-i|--init] [-N|--no-fetch] [--rebase|--merge]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
@@ -16,6 +16,7 @@ command=
 branch=
 reference=
 cached=
+files=
 nofetch=
 update=

@@ -460,6 +461,7 @@ set_name_rev () {
 cmd_summary() {
 	summary_limit=-1
 	for_status=
+	diff_cmd=diff-index

 	# parse $args after "submodule ... summary".
 	while test $# -ne 0
@@ -468,6 +470,9 @@ cmd_summary() {
 		--cached)
 			cached="$1"
 			;;
+		--files)
+			files="$1"
+			;;
 		--for-status)
 			for_status="$1"
 			;;
@@ -504,9 +509,17 @@ cmd_summary() {
 		head=HEAD
 	fi

+	if [ -n "$files" ]
+	then
+		test -n "$cached" &&
+		die "--cached cannot be used with --files"
+		diff_cmd=diff-files
+		head=
+	fi
+
 	cd_to_toplevel
 	# Get modified modules cared by user
-	modules=$(git diff-index $cached --raw $head -- "$@" |
+	modules=$(git $diff_cmd $cached --raw $head -- "$@" |
 		egrep '^:([0-7]* )?160000' |
 		while read mod_src mod_dst sha1_src sha1_dst status name
 		do
@@ -520,7 +533,7 @@ cmd_summary() {

 	test -z "$modules" && return

-	git diff-index $cached --raw $head -- $modules |
+	git $diff_cmd $cached --raw $head -- $modules |
 	egrep '^:([0-7]* )?160000' |
 	cut -c2- |
 	while read mod_src mod_dst sha1_src sha1_dst status name
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 6149829..6cc16c3 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -56,6 +56,15 @@ test_expect_success 'modified submodule(forward)' "
 EOF
 "

+test_expect_success 'modified submodule(forward), --files' "
+	git submodule summary --files >actual &&
+	diff actual - <<-EOF
+* sm1 $head1...$head2 (1):
+  > Add foo3
+
+EOF
+"
+
 commit_file sm1 &&
 cd sm1 &&
 git reset --hard HEAD~2 >/dev/null &&
@@ -114,6 +123,15 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' "
 EOF
 "

+test_expect_success 'typechanged submodule(submodule->blob), --files' "
+    git submodule summary --files >actual &&
+    diff actual - <<-EOF
+* sm1 $head5(blob)->$head4(submodule) (3):
+  > Add foo5
+
+EOF
+"
+
 rm -rf sm1 &&
 git checkout-index sm1
 test_expect_success 'typechanged submodule(submodule->blob)' "
@@ -205,4 +223,8 @@ test_expect_success '--for-status' "
 EOF
 "

+test_expect_success 'fail when using --files together with --cached' "
+    test_must_fail git submodule summary --files --cached
+"
+
 test_done
-- 
1.6.4.114.gefd1
