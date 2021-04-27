Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937AEC43461
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E638613F6
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbhD0VTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:37 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:41750 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239164AbhD0VTW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:22 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id D02E280599;
        Tue, 27 Apr 2021 17:18:37 -0400 (EDT)
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
Subject: [PATCH v3 21/30] subtree: parse revs in individual cmd_ functions
Date:   Tue, 27 Apr 2021 15:17:39 -0600
Message-Id: <20210427211748.2607474-22-lukeshu@lukeshu.com>
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

The main argument parser goes ahead and tries to parse revs to make
things simpler for the sub-command implementations.  But, it includes
enough special cases for different sub-commands.  And it's difficult
having having to think about "is this info coming from an argument, or a
global variable?".  So the main argument parser's effort to make things
"simpler" ends up just making it more confusing and complicated.

Begone with the 'revs' global variable; parse 'rev=$(...)' as needed in
individual 'cmd_*' functions.

Begone with the 'default' global variable.  Its would-be value is
knowable just from which function we're in.

Begone with the 'ensure_single_rev' function.  Its functionality can be
achieved by passing '--verify' to 'git rev-parse'.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh | 62 +++++++++++++---------------------
 1 file changed, 24 insertions(+), 38 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index ee7fda3672..0df8d1b7d4 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -76,13 +76,6 @@ assert () {
 	fi
 }
 
-ensure_single_rev () {
-	if test $# -ne 1
-	then
-		die "You must provide exactly one revision.  Got: '$*'"
-	fi
-}
-
 main () {
 	if test $# -eq 0
 	then
@@ -164,11 +157,8 @@ main () {
 	shift
 
 	case "$arg_command" in
-	add|merge|pull)
-		default=
-		;;
-	split|push)
-		default="--default HEAD"
+	add|merge|pull|split|push)
+		:
 		;;
 	*)
 		die "Unknown command '$arg_command'"
@@ -193,22 +183,8 @@ main () {
 
 	dir="$(dirname "$arg_prefix/.")"
 
-	if test "$arg_command" != "pull" &&
-			test "$arg_command" != "add" &&
-			test "$arg_command" != "push"
-	then
-		revs=$(git rev-parse $default --revs-only "$@") || exit $?
-		dirs=$(git rev-parse --no-revs --no-flags "$@") || exit $?
-		ensure_single_rev $revs
-		if test -n "$dirs"
-		then
-			die "Error: Use --prefix instead of bare filenames."
-		fi
-	fi
-
 	debug "command: {$arg_command}"
 	debug "quiet: {$GIT_QUIET}"
-	debug "revs: {$revs}"
 	debug "dir: {$dir}"
 	debug "opts: {$*}"
 	debug
@@ -714,14 +690,13 @@ cmd_add_repository () {
 	repository=$1
 	refspec=$2
 	git fetch "$@" || exit $?
-	revs=FETCH_HEAD
-	set -- $revs
-	cmd_add_commit "$@"
+	cmd_add_commit FETCH_HEAD
 }
 
 cmd_add_commit () {
-	rev=$(git rev-parse $default --revs-only "$@") || exit $?
-	ensure_single_rev $rev
+	# The rev has already been validated by cmd_add(), we just
+	# need to normalize it.
+	rev=$(git rev-parse --verify "$1^{commit}") || exit $?
 
 	debug "Adding $dir as '$rev'..."
 	git read-tree --prefix="$dir" $rev || exit $?
@@ -752,6 +727,17 @@ cmd_add_commit () {
 }
 
 cmd_split () {
+	if test $# -eq 0
+	then
+		rev=$(git rev-parse HEAD)
+	elif test $# -eq 1
+	then
+		rev=$(git rev-parse -q --verify "$1^{commit}") ||
+			die "'$1' does not refer to a commit"
+	else
+		die "You must provide exactly one revision.  Got: '$*'"
+	fi
+
 	debug "Splitting $dir..."
 	cache_setup || exit $?
 
@@ -768,12 +754,12 @@ cmd_split () {
 		done || exit $?
 	fi
 
-	unrevs="$(find_existing_splits "$dir" "$revs")" || exit $?
+	unrevs="$(find_existing_splits "$dir" "$rev")" || exit $?
 
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
 	# (and rev-list --follow doesn't seem to solve this)
-	grl='git rev-list --topo-order --reverse --parents $revs $unrevs'
+	grl='git rev-list --topo-order --reverse --parents $rev $unrevs'
 	revmax=$(eval "$grl" | wc -l)
 	revcount=0
 	createcount=0
@@ -820,8 +806,10 @@ cmd_split () {
 }
 
 cmd_merge () {
-	rev=$(git rev-parse $default --revs-only "$@") || exit $?
-	ensure_single_rev $rev
+	test $# -eq 1 ||
+		die "You must provide exactly one revision.  Got: '$*'"
+	rev=$(git rev-parse -q --verify "$1^{commit}") ||
+		die "'$1' does not refer to a commit"
 	ensure_clean
 
 	if test -n "$arg_addmerge_squash"
@@ -861,9 +849,7 @@ cmd_pull () {
 	ensure_clean
 	ensure_valid_ref_format "$2"
 	git fetch "$@" || exit $?
-	revs=FETCH_HEAD
-	set -- $revs
-	cmd_merge "$@"
+	cmd_merge FETCH_HEAD
 }
 
 cmd_push () {
-- 
2.31.1

