Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C60C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 22:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF4020748
	for <git@archiver.kernel.org>; Thu, 21 May 2020 22:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbgEUWhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 18:37:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:54052 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgEUWhg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 18:37:36 -0400
Received: (qmail 15923 invoked by uid 109); 21 May 2020 22:37:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 May 2020 22:37:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2235 invoked by uid 111); 21 May 2020 22:37:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 May 2020 18:37:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 May 2020 18:37:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/4] lib-submodule-update: pass OVERWRITING_FAIL
Message-ID: <20200521223734.GA1545675@coredump.intra.peff.net>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <cover.1590019226.git.liu.denton@gmail.com>
 <48598e3f9859dc525ec878cd7f3eaadee8bb61b1.1590019226.git.liu.denton@gmail.com>
 <20200521182928.GA1308647@coredump.intra.peff.net>
 <xmqq8shlro12.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8shlro12.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 02:11:53PM -0700, Junio C Hamano wrote:

> > A more complete patch is below, which is enough to get t5572 passing. I
> > think it would need the other test_submodule_switch() function updated,
> > and other scripts would need to adapt to the 2-arg style.
> 
> below where?

Oops.

---
 t/lib-submodule-update.sh | 46 ++++++++++++++++++++++++++++++----------------
 t/t5572-pull-submodule.sh | 31 ++++---------------------------
 2 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 64fc6487dd..34da02b7fa 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -310,7 +310,8 @@ test_submodule_content () {
 # Internal function; use test_submodule_switch() or
 # test_submodule_forced_switch() instead.
 test_submodule_switch_common() {
-	command="$1"
+	prep="$1"
+	command="$2"
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
 	if test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
@@ -326,7 +327,8 @@ test_submodule_switch_common() {
 		(
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			$command add_sub1 &&
+			$prep add_sub1 &&
+			$command &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -341,7 +343,8 @@ test_submodule_switch_common() {
 			cd submodule_update &&
 			mkdir sub1 &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			$command add_sub1 &&
+			$prep add_sub1 &&
+			$command &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -356,7 +359,8 @@ test_submodule_switch_common() {
 		(
 			cd submodule_update &&
 			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
-			$command replace_file_with_sub1 &&
+			$prep replace_file_with_sub1 &&
+			$command &&
 			test_superproject_content origin/replace_file_with_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -380,7 +384,8 @@ test_submodule_switch_common() {
 		(
 			cd submodule_update &&
 			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
-			$command replace_directory_with_sub1 &&
+			$prep replace_directory_with_sub1 &&
+			$command &&
 			test_superproject_content origin/replace_directory_with_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -402,7 +407,8 @@ test_submodule_switch_common() {
 		(
 			cd submodule_update &&
 			git branch -t remove_sub1 origin/remove_sub1 &&
-			$command remove_sub1 &&
+			$prep remove_sub1 &&
+			$command &&
 			test_superproject_content origin/remove_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -415,7 +421,8 @@ test_submodule_switch_common() {
 			cd submodule_update &&
 			git branch -t remove_sub1 origin/remove_sub1 &&
 			replace_gitfile_with_git_dir sub1 &&
-			$command remove_sub1 &&
+			$prep remove_sub1 &&
+			$command &&
 			test_superproject_content origin/remove_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -443,7 +450,8 @@ test_submodule_switch_common() {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			test_must_fail $command replace_sub1_with_directory &&
+			$prep replace_sub1_with_directory &&
+			test_must_fail $command &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -456,7 +464,8 @@ test_submodule_switch_common() {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_directory &&
+			$prep replace_sub1_with_directory &&
+			test_must_fail $command &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -470,7 +479,8 @@ test_submodule_switch_common() {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			test_must_fail $command replace_sub1_with_file &&
+			$prep replace_sub1_with_file &&
+			test_must_fail $command &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -484,7 +494,8 @@ test_submodule_switch_common() {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_file &&
+			$prep replace_sub1_with_file &&
+			test_must_fail $command &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -508,7 +519,8 @@ test_submodule_switch_common() {
 		(
 			cd submodule_update &&
 			git branch -t modify_sub1 origin/modify_sub1 &&
-			$command modify_sub1 &&
+			$prep modify_sub1 &&
+			$command &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/add_sub1 &&
 			git submodule update &&
@@ -523,7 +535,8 @@ test_submodule_switch_common() {
 		(
 			cd submodule_update &&
 			git branch -t invalid_sub1 origin/invalid_sub1 &&
-			$command invalid_sub1 &&
+			$prep invalid_sub1 &&
+			$command &&
 			test_superproject_content origin/invalid_sub1 &&
 			test_submodule_content sub1 origin/add_sub1 &&
 			test_must_fail git submodule update &&
@@ -538,7 +551,8 @@ test_submodule_switch_common() {
 		(
 			cd submodule_update &&
 			git branch -t valid_sub1 origin/valid_sub1 &&
-			$command valid_sub1 &&
+			$prep valid_sub1 &&
+			$command &&
 			test_superproject_content origin/valid_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -568,8 +582,8 @@ test_submodule_switch_common() {
 # }
 # test_submodule_switch "my_func"
 test_submodule_switch () {
-	command="$1"
-	test_submodule_switch_common "$command"
+	command="$2"
+	test_submodule_switch_common "$@"
 
 	# An empty directory does not prevent the creation of a submodule of
 	# the same name, but a file does.
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index f916729a12..e3ae7c89f1 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -11,36 +11,13 @@ reset_branch_to_HEAD () {
 	git branch --set-upstream-to="origin/$1" "$1"
 }
 
-git_pull () {
-	reset_branch_to_HEAD "$1" &&
-	git pull
-}
-
 # pulls without conflicts
-test_submodule_switch "git_pull"
-
-git_pull_ff () {
-	reset_branch_to_HEAD "$1" &&
-	git pull --ff
-}
-
-test_submodule_switch "git_pull_ff"
-
-git_pull_ff_only () {
-	reset_branch_to_HEAD "$1" &&
-	git pull --ff-only
-}
-
-test_submodule_switch "git_pull_ff_only"
-
-git_pull_noff () {
-	reset_branch_to_HEAD "$1" &&
-	git pull --no-ff
-}
-
+test_submodule_switch "reset_branch_to_HEAD" "git pull"
+test_submodule_switch "reset_branch_to_HEAD" "git pull -ff"
+test_submodule_switch "reset_branch_to_HEAD" "git pull --ff-only"
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch "git_pull_noff"
+test_submodule_switch "reset_branch_to_HEAD" "git pull --no-ff"
 
 test_expect_success 'pull --recurse-submodule setup' '
 	test_create_repo child &&
