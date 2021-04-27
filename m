Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D4C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15D7613F3
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhD0VTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbhD0VTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:16 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE530C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 14:18:32 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id DDE8B80597;
        Tue, 27 Apr 2021 17:18:30 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v3 13/30] subtree: more consistent error propagation
Date:   Tue, 27 Apr 2021 15:17:31 -0600
Message-Id: <20210427211748.2607474-14-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427211748.2607474-1-lukeshu@lukeshu.com>
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Ensure that every $(subshell) that calls a function (as opposed to an
external executable) is followed by `|| exit $?`.  Similarly, ensure that
every `cmd | while read; do ... done` loop is followed by `|| exit $?`.

Both of those constructs mean that it can miss `die` calls, and keep
running when it shouldn't.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index d1ed7f9a6c..9ca498f81c 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -243,7 +243,7 @@ cache_miss () {
 }
 
 check_parents () {
-	missed=$(cache_miss "$1")
+	missed=$(cache_miss "$1") || exit $?
 	local indent=$(($2 + 1))
 	for miss in $missed
 	do
@@ -345,7 +345,7 @@ find_latest_squash () {
 			sub=
 			;;
 		esac
-	done
+	done || exit $?
 }
 
 find_existing_splits () {
@@ -394,7 +394,7 @@ find_existing_splits () {
 			sub=
 			;;
 		esac
-	done
+	done || exit $?
 }
 
 copy_commit () {
@@ -508,7 +508,7 @@ subtree_for_commit () {
 		test "$type" = "commit" && continue  # ignore submodules
 		echo $tree
 		break
-	done
+	done || exit $?
 }
 
 tree_changed () {
@@ -518,7 +518,7 @@ tree_changed () {
 	then
 		return 0   # weird parents, consider it changed
 	else
-		ptree=$(toptree_for_commit $1)
+		ptree=$(toptree_for_commit $1) || exit $?
 		if test "$ptree" != "$tree"
 		then
 			return 0   # changed
@@ -652,7 +652,7 @@ process_split_commit () {
 	progress "$revcount/$revmax ($createcount) [$extracount]"
 
 	debug "Processing commit: $rev"
-	exists=$(cache_get "$rev")
+	exists=$(cache_get "$rev") || exit $?
 	if test -n "$exists"
 	then
 		debug "  prior: $exists"
@@ -661,10 +661,10 @@ process_split_commit () {
 	createcount=$(($createcount + 1))
 	debug "  parents: $parents"
 	check_parents "$parents" "$indent"
-	newparents=$(cache_get $parents)
+	newparents=$(cache_get $parents) || exit $?
 	debug "  newparents: $newparents"
 
-	tree=$(subtree_for_commit "$rev" "$dir")
+	tree=$(subtree_for_commit "$rev" "$dir") || exit $?
 	debug "  tree is: $tree"
 
 	# ugly.  is there no better way to tell if this is a subtree
@@ -750,7 +750,7 @@ cmd_add_commit () {
 		commit=$(add_squashed_msg "$rev" "$dir" |
 			git commit-tree "$tree" $headp -p "$rev") || exit $?
 	else
-		revp=$(peel_committish "$rev") &&
+		revp=$(peel_committish "$rev") || exit $?
 		commit=$(add_msg "$dir" $headrev "$rev" |
 			git commit-tree "$tree" $headp -p "$revp") || exit $?
 	fi
@@ -773,10 +773,10 @@ cmd_split () {
 			# any parent we find there can be used verbatim
 			debug "  cache: $rev"
 			cache_set "$rev" "$rev"
-		done
+		done || exit $?
 	fi
 
-	unrevs="$(find_existing_splits "$dir" "$revs")"
+	unrevs="$(find_existing_splits "$dir" "$revs")" || exit $?
 
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
@@ -792,7 +792,7 @@ cmd_split () {
 		process_split_commit "$rev" "$parents" 0
 	done || exit $?
 
-	latest_new=$(cache_get latest_new)
+	latest_new=$(cache_get latest_new) || exit $?
 	if test -z "$latest_new"
 	then
 		die "No new revisions were found"
@@ -801,7 +801,7 @@ cmd_split () {
 	if test -n "$rejoin"
 	then
 		debug "Merging split branch into HEAD..."
-		latest_old=$(cache_get latest_old)
+		latest_old=$(cache_get latest_old) || exit $?
 		git merge -s ours \
 			--allow-unrelated-histories \
 			-m "$(rejoin_msg "$dir" "$latest_old" "$latest_new")" \
@@ -834,7 +834,7 @@ cmd_merge () {
 
 	if test -n "$squash"
 	then
-		first_split="$(find_latest_squash "$dir")"
+		first_split="$(find_latest_squash "$dir")" || exit $?
 		if test -z "$first_split"
 		then
 			die "Can't squash-merge: '$dir' was never added."
-- 
2.31.1

