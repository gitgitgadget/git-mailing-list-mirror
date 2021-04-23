Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E42C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B46D6113B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244016AbhDWTn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbhDWTnl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:41 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3719C06175F
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:43:03 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 4BAB580597;
        Fri, 23 Apr 2021 15:43:03 -0400 (EDT)
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
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 25/30] subtree: have $indent actually affect indentation
Date:   Fri, 23 Apr 2021 13:42:25 -0600
Message-Id: <20210423194230.1388945-26-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
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
index 62cf54928e..54e904516b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -41,11 +41,13 @@ arg_split_annotate=
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
 
@@ -222,17 +224,17 @@ cache_miss () {
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
@@ -285,6 +287,8 @@ try_remove_previous () {
 find_latest_squash () {
 	assert test $# = 1
 	debug "Looking for latest squash ($dir)..."
+	local indent=$(($indent + 1))
+
 	dir="$1"
 	sq=
 	main=
@@ -331,6 +335,8 @@ find_latest_squash () {
 find_existing_splits () {
 	assert test $# = 2
 	debug "Looking for prior splits..."
+	local indent=$(($indent + 1))
+
 	dir="$1"
 	rev="$2"
 	main=
@@ -356,7 +362,7 @@ find_existing_splits () {
 			die "could not rev-parse split hash $b from commit $sq"
 			;;
 		END)
-			debug "  Main is: '$main'"
+			debug "Main is: '$main'"
 			if test -z "$main" -a -n "$sub"
 			then
 				# squash commits refer to a subtree
@@ -639,12 +645,11 @@ ensure_valid_ref_format () {
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
@@ -659,20 +664,21 @@ process_split_commit () {
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
@@ -687,7 +693,7 @@ process_split_commit () {
 	fi
 
 	newrev=$(copy_or_skip "$rev" "$tree" "$newparents") || exit $?
-	debug "  newrev is: $newrev"
+	debug "newrev is: $newrev"
 	cache_set "$rev" "$newrev"
 	cache_set latest_new "$newrev"
 	cache_set latest_old "$rev"
@@ -791,7 +797,7 @@ cmd_split () {
 		do
 			# the 'onto' history is already just the subdir, so
 			# any parent we find there can be used verbatim
-			debug "  cache: $rev"
+			debug "cache: $rev"
 			cache_set "$rev" "$rev"
 		done || exit $?
 	fi
@@ -809,7 +815,7 @@ cmd_split () {
 	eval "$grl" |
 	while read rev parents
 	do
-		process_split_commit "$rev" "$parents" 0
+		process_split_commit "$rev" "$parents"
 	done || exit $?
 
 	latest_new=$(cache_get latest_new) || exit $?
-- 
2.31.1

