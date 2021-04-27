Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96668C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6386861139
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbhD0VTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:39 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:41828 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239299AbhD0VTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:25 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 4A49780597;
        Tue, 27 Apr 2021 17:18:41 -0400 (EDT)
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
Subject: [PATCH v3 25/30] subtree: have $indent actually affect indentation
Date:   Tue, 27 Apr 2021 15:17:43 -0600
Message-Id: <20210427211748.2607474-26-lukeshu@lukeshu.com>
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

Currently, the $indent variable is just used to track how deeply we're
nested, and the debug log is indented by things like

   debug "  foo"

That is: The indentation-level is hard-coded.  It used to be that the
code couldn't recurse, so the indentation level could be known
statically, so it made sense to just hard-code it in the
output. However, since 315a84f9aa ("subtree: use commits before rejoins
for splits", 2018-09-28), it can now recurse, and the debug log is
misleading.

So fix that.  Indent according to $indent.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh | 42 +++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 53a1a025f5..768fa7b6b6 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -55,11 +55,13 @@ arg_split_annotate=
 arg_addmerge_squash=
 arg_addmerge_message=
 
+indent=0
+
 # Usage: debug [MSG...]
 debug () {
 	if test -n "$arg_debug"
 	then
-		printf "%s\n" "$*" >&2
+		printf "%$(($indent * 2))s%s\n" '' "$*" >&2
 	fi
 }
 
@@ -251,17 +253,17 @@ cache_miss () {
 	done
 }
 
-# Usage: check_parents PARENTS_EXPR INDENT
+# Usage: check_parents PARENTS_EXPR
 check_parents () {
-	assert test $# = 2
+	assert test $# = 1
 	missed=$(cache_miss "$1") || exit $?
-	local indent=$(($2 + 1))
+	local indent=$(($indent + 1))
 	for miss in $missed
 	do
 		if ! test -r "$cachedir/notree/$miss"
 		then
-			debug "  incorrect order: $miss"
-			process_split_commit "$miss" "" "$indent"
+			debug "incorrect order: $miss"
+			process_split_commit "$miss" ""
 		fi
 	done
 }
@@ -314,6 +316,8 @@ try_remove_previous () {
 find_latest_squash () {
 	assert test $# = 1
 	debug "Looking for latest squash ($dir)..."
+	local indent=$(($indent + 1))
+
 	dir="$1"
 	sq=
 	main=
@@ -360,6 +364,8 @@ find_latest_squash () {
 find_existing_splits () {
 	assert test $# = 2
 	debug "Looking for prior splits..."
+	local indent=$(($indent + 1))
+
 	dir="$1"
 	rev="$2"
 	main=
@@ -385,7 +391,7 @@ find_existing_splits () {
 			die "could not rev-parse split hash $b from commit $sq"
 			;;
 		END)
-			debug "  Main is: '$main'"
+			debug "Main is: '$main'"
 			if test -z "$main" -a -n "$sub"
 			then
 				# squash commits refer to a subtree
@@ -668,12 +674,11 @@ ensure_valid_ref_format () {
 		die "'$1' does not look like a ref"
 }
 
-# Usage: process_split_commit REV PARENTS INDENT
+# Usage: process_split_commit REV PARENTS
 process_split_commit () {
-	assert test $# = 3
+	assert test $# = 2
 	local rev="$1"
 	local parents="$2"
-	local indent=$3
 
 	if test $indent -eq 0
 	then
@@ -688,20 +693,21 @@ process_split_commit () {
 	progress "$revcount/$revmax ($createcount) [$extracount]"
 
 	debug "Processing commit: $rev"
+	local indent=$(($indent + 1))
 	exists=$(cache_get "$rev") || exit $?
 	if test -n "$exists"
 	then
-		debug "  prior: $exists"
+		debug "prior: $exists"
 		return
 	fi
 	createcount=$(($createcount + 1))
-	debug "  parents: $parents"
-	check_parents "$parents" "$indent"
+	debug "parents: $parents"
+	check_parents "$parents"
 	newparents=$(cache_get $parents) || exit $?
-	debug "  newparents: $newparents"
+	debug "newparents: $newparents"
 
 	tree=$(subtree_for_commit "$rev" "$dir") || exit $?
-	debug "  tree is: $tree"
+	debug "tree is: $tree"
 
 	# ugly.  is there no better way to tell if this is a subtree
 	# vs. a mainline commit?  Does it matter?
@@ -716,7 +722,7 @@ process_split_commit () {
 	fi
 
 	newrev=$(copy_or_skip "$rev" "$tree" "$newparents") || exit $?
-	debug "  newrev is: $newrev"
+	debug "newrev is: $newrev"
 	cache_set "$rev" "$newrev"
 	cache_set latest_new "$newrev"
 	cache_set latest_old "$rev"
@@ -820,7 +826,7 @@ cmd_split () {
 		do
 			# the 'onto' history is already just the subdir, so
 			# any parent we find there can be used verbatim
-			debug "  cache: $rev"
+			debug "cache: $rev"
 			cache_set "$rev" "$rev"
 		done || exit $?
 	fi
@@ -838,7 +844,7 @@ cmd_split () {
 	eval "$grl" |
 	while read rev parents
 	do
-		process_split_commit "$rev" "$parents" 0
+		process_split_commit "$rev" "$parents"
 	done || exit $?
 
 	latest_new=$(cache_get latest_new) || exit $?
-- 
2.31.1

