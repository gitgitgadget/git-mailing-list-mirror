Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71855203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbcGVTOn (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:14:43 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:63739 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbcGVTOm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:14:42 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rx0hH2J1Cz5tlG;
	Fri, 22 Jul 2016 21:14:39 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id BE64B52DC;
	Fri, 22 Jul 2016 21:14:38 +0200 (CEST)
To:	Stefan Beller <sbeller@google.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
From:	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] git-submodule: forward exit code of git-submodule--helper
 more faithfully
Message-ID: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org>
Date:	Fri, 22 Jul 2016 21:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

git-submodule--helper is invoked as the upstream of a pipe in several
places. Usually, the failure of a program in this position is not
detected by the shell. For this reason, the code inserts a token in the
output stream when git-submodule--helper fails that is detected
downstream, where the shell script is quit with exit code 1.

There happens to be a bug in git-submodule--helper that leads to a
segmentation fault. The test suite triggers the crash in several places,
all of which are protected by 'test_must_fail'. But due to the inspecific
exit code 1, the crash remains undiagnosed.

Extend the failure protocol such that git-submodule--helper's exit code
is passed downstream (only in the case of failure). This enables the
downstream to use it as its own exit code, and 'test_must_fail' to
identify the segmentation fault as an unexpected failure.

The bug itself is fixed in the next commit.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
When you run ./t7400-submodule-basic.sh -v, you will notice this output:

fatal: destination path '/home/jsixt/Src/git/git/t/trash directory.t7400-submodule-basic/init' already exists and is not an empty directory.
fatal: clone of './.subrepo' into submodule path '/home/jsixt/Src/git/git/t/trash directory.t7400-submodule-basic/init' failed
Failed to clone 'init'. Retry scheduled
fatal: destination path '/home/jsixt/Src/git/git/t/trash directory.t7400-submodule-basic/init' already exists and is not an empty directory.
fatal: clone of './.subrepo' into submodule path '/home/jsixt/Src/git/git/t/trash directory.t7400-submodule-basic/init' failed
/home/jsixt/Src/git/git/git-submodule: line 494: 21757 Segmentation fault      git submodule--helper update-clone ${GIT_QUIET:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} ${prefix:+--recursive-prefix "$prefix"} ${update:+--update "$update"} ${reference:+--reference "$reference"} ${depth:+--depth "$depth"} ${recommend_shallow:+"$recommend_shallow"} ${jobs:+$jobs} "$@"
ok 32 - update should fail when path is used by a file

Note the segmentation fault. This mini-series addresses the issue.

Noticed on Windows because it "visualizes" segfaults even for
command line programs.

 git-submodule.sh            | 22 +++++++++++-----------
 t/t5815-submodule-protos.sh |  4 ++--
 t/t7400-submodule-basic.sh  |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4ec7546..0a0e12d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -49,7 +49,7 @@ die_if_unmatched ()
 {
 	if test "$1" = "#unmatched"
 	then
-		exit 1
+		exit ${2:-1}
 	fi
 }
 
@@ -312,11 +312,11 @@ cmd_foreach()
 
 	{
 		git submodule--helper list --prefix "$wt_prefix" ||
-		echo "#unmatched"
+		echo "#unmatched" $?
 	} |
 	while read mode sha1 stage sm_path
 	do
-		die_if_unmatched "$mode"
+		die_if_unmatched "$mode" "$sha1"
 		if test -e "$sm_path"/.git
 		then
 			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
@@ -423,11 +423,11 @@ cmd_deinit()
 
 	{
 		git submodule--helper list --prefix "$wt_prefix" "$@" ||
-		echo "#unmatched"
+		echo "#unmatched" $?
 	} |
 	while read mode sha1 stage sm_path
 	do
-		die_if_unmatched "$mode"
+		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path") || exit
 
 		displaypath=$(git submodule--helper relative-path "$sm_path" "$wt_prefix")
@@ -581,12 +581,12 @@ cmd_update()
 		${depth:+--depth "$depth"} \
 		${recommend_shallow:+"$recommend_shallow"} \
 		${jobs:+$jobs} \
-		"$@" || echo "#unmatched"
+		"$@" || echo "#unmatched" $?
 	} | {
 	err=
 	while read mode sha1 stage just_cloned sm_path
 	do
-		die_if_unmatched "$mode"
+		die_if_unmatched "$mode" "$sha1"
 
 		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
@@ -994,11 +994,11 @@ cmd_status()
 
 	{
 		git submodule--helper list --prefix "$wt_prefix" "$@" ||
-		echo "#unmatched"
+		echo "#unmatched" $?
 	} |
 	while read mode sha1 stage sm_path
 	do
-		die_if_unmatched "$mode"
+		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
@@ -1075,11 +1075,11 @@ cmd_sync()
 	cd_to_toplevel
 	{
 		git submodule--helper list --prefix "$wt_prefix" "$@" ||
-		echo "#unmatched"
+		echo "#unmatched" $?
 	} |
 	while read mode sha1 stage sm_path
 	do
-		die_if_unmatched "$mode"
+		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
index 06f55a1..112cf40 100755
--- a/t/t5815-submodule-protos.sh
+++ b/t/t5815-submodule-protos.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup repository with submodules' '
 	git commit -m "add submodules"
 '
 
-test_expect_success 'clone with recurse-submodules fails' '
+test_expect_failure 'clone with recurse-submodules fails' '
 	test_must_fail git clone --recurse-submodules . dst
 '
 
@@ -32,7 +32,7 @@ test_expect_success 'update of ssh allowed' '
 	git -C dst submodule update ssh-module
 '
 
-test_expect_success 'update of ext not allowed' '
+test_expect_failure 'update of ext not allowed' '
 	test_must_fail git -C dst submodule update ext-module
 '
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b77cce8..7c8b90b 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -352,7 +352,7 @@ test_expect_success 'sync should fail with unknown submodule' '
 	test_failure_with_unknown_submodule sync
 '
 
-test_expect_success 'update should fail when path is used by a file' '
+test_expect_failure 'update should fail when path is used by a file' '
 	echo hello >expect &&
 
 	echo "hello" >init &&
@@ -361,7 +361,7 @@ test_expect_success 'update should fail when path is used by a file' '
 	test_cmp expect init
 '
 
-test_expect_success 'update should fail when path is used by a nonempty directory' '
+test_expect_failure 'update should fail when path is used by a nonempty directory' '
 	echo hello >expect &&
 
 	rm -fr init &&
-- 
2.9.0.443.ga8520ad
