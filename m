Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2FDC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94476613B2
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbhDZRtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbhDZRsl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:48:41 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF2C061760
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:47:56 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 0BD2780593;
        Mon, 26 Apr 2021 13:47:55 -0400 (EDT)
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
Subject: [PATCH v2 23/30] subtree: add comments and sanity checks
Date:   Mon, 26 Apr 2021 11:45:18 -0600
Message-Id: <20210426174525.3937858-24-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174525.3937858-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <20210426174525.3937858-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

For each function in subtree, add a usage comment saying what the
arguments are, and add an `assert` checking the number of arguments.

In figuring out each thing's arguments in order to write those comments
and assertions, it turns out that find_existing_splits is written as if
it takes multiple 'revs', but it is in fact only ever passed a single
'rev':

	unrevs="$(find_existing_splits "$dir" "$rev")" || exit $?

So go ahead and codify that by documenting and asserting that it takes
exactly two arguments, one dir and one rev.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - Expand on the the commit message.
 - Fix capitalization in one of the comments.

 contrib/subtree/git-subtree.sh | 64 ++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7fbd8481ed..441571c85a 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -55,6 +55,7 @@ arg_split_annotate=
 arg_addmerge_squash=
 arg_addmerge_message=
 
+# Usage: debug [MSG...]
 debug () {
 	if test -n "$arg_debug"
 	then
@@ -62,6 +63,7 @@ debug () {
 	fi
 }
 
+# Usage: progress [MSG...]
 progress () {
 	if test -z "$GIT_QUIET"
 	then
@@ -69,6 +71,7 @@ progress () {
 	fi
 }
 
+# Usage: assert CMD...
 assert () {
 	if ! "$@"
 	then
@@ -192,7 +195,9 @@ main () {
 	"cmd_$arg_command" "$@"
 }
 
+# Usage: cache_setup
 cache_setup () {
+	assert test $# = 0
 	cachedir="$GIT_DIR/subtree-cache/$$"
 	rm -rf "$cachedir" ||
 		die "Can't delete old cachedir: $cachedir"
@@ -203,6 +208,7 @@ cache_setup () {
 	debug "Using cachedir: $cachedir" >&2
 }
 
+# Usage: cache_get [REVS...]
 cache_get () {
 	for oldrev in "$@"
 	do
@@ -214,6 +220,7 @@ cache_get () {
 	done
 }
 
+# Usage: cache_miss [REVS...]
 cache_miss () {
 	for oldrev in "$@"
 	do
@@ -224,7 +231,9 @@ cache_miss () {
 	done
 }
 
+# Usage: check_parents PARENTS_EXPR INDENT
 check_parents () {
+	assert test $# = 2
 	missed=$(cache_miss "$1") || exit $?
 	local indent=$(($2 + 1))
 	for miss in $missed
@@ -237,11 +246,15 @@ check_parents () {
 	done
 }
 
+# Usage: set_notree REV
 set_notree () {
+	assert test $# = 1
 	echo "1" > "$cachedir/notree/$1"
 }
 
+# Usage: cache_set OLDREV NEWREV
 cache_set () {
+	assert test $# = 2
 	oldrev="$1"
 	newrev="$2"
 	if test "$oldrev" != "latest_old" &&
@@ -253,7 +266,9 @@ cache_set () {
 	echo "$newrev" >"$cachedir/$oldrev"
 }
 
+# Usage: rev_exists REV
 rev_exists () {
+	assert test $# = 1
 	if git rev-parse "$1" >/dev/null 2>&1
 	then
 		return 0
@@ -262,17 +277,22 @@ rev_exists () {
 	fi
 }
 
-# if a commit doesn't have a parent, this might not work.  But we only want
+# Usage: try_remove_previous REV
+#
+# If a commit doesn't have a parent, this might not work.  But we only want
 # to remove the parent from the rev-list, and since it doesn't exist, it won't
 # be there anyway, so do nothing in that case.
 try_remove_previous () {
+	assert test $# = 1
 	if rev_exists "$1^"
 	then
 		echo "^$1^"
 	fi
 }
 
+# Usage: find_latest_squash DIR
 find_latest_squash () {
+	assert test $# = 1
 	debug "Looking for latest squash ($dir)..."
 	dir="$1"
 	sq=
@@ -316,10 +336,12 @@ find_latest_squash () {
 	done || exit $?
 }
 
+# Usage: find_existing_splits DIR REV
 find_existing_splits () {
+	assert test $# = 2
 	debug "Looking for prior splits..."
 	dir="$1"
-	revs="$2"
+	rev="$2"
 	main=
 	sub=
 	local grep_format="^git-subtree-dir: $dir/*\$"
@@ -328,7 +350,7 @@ find_existing_splits () {
 		grep_format="^Add '$dir/' from commit '"
 	fi
 	git log --grep="$grep_format" \
-		--no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
+		--no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' "$rev" |
 	while read a b junk
 	do
 		case "$a" in
@@ -365,7 +387,9 @@ find_existing_splits () {
 	done || exit $?
 }
 
+# Usage: copy_commit REV TREE FLAGS_STR
 copy_commit () {
+	assert test $# = 3
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
@@ -391,7 +415,9 @@ copy_commit () {
 	) || die "Can't copy commit $1"
 }
 
+# Usage: add_msg DIR LATEST_OLD LATEST_NEW
 add_msg () {
+	assert test $# = 3
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
@@ -410,7 +436,9 @@ add_msg () {
 	EOF
 }
 
+# Usage: add_squashed_msg REV DIR
 add_squashed_msg () {
+	assert test $# = 2
 	if test -n "$arg_addmerge_message"
 	then
 		echo "$arg_addmerge_message"
@@ -419,7 +447,9 @@ add_squashed_msg () {
 	fi
 }
 
+# Usage: rejoin_msg DIR LATEST_OLD LATEST_NEW
 rejoin_msg () {
+	assert test $# = 3
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
@@ -438,7 +468,9 @@ rejoin_msg () {
 	EOF
 }
 
+# Usage: squash_msg DIR OLD_SUBTREE_COMMIT NEW_SUBTREE_COMMIT
 squash_msg () {
+	assert test $# = 3
 	dir="$1"
 	oldsub="$2"
 	newsub="$3"
@@ -460,12 +492,16 @@ squash_msg () {
 	echo "git-subtree-split: $newsub"
 }
 
+# Usage: toptree_for_commit COMMIT
 toptree_for_commit () {
+	assert test $# = 1
 	commit="$1"
 	git rev-parse --verify "$commit^{tree}" || exit $?
 }
 
+# Usage: subtree_for_commit COMMIT DIR
 subtree_for_commit () {
+	assert test $# = 2
 	commit="$1"
 	dir="$2"
 	git ls-tree "$commit" -- "$dir" |
@@ -479,7 +515,9 @@ subtree_for_commit () {
 	done || exit $?
 }
 
+# Usage: tree_changed TREE [PARENTS...]
 tree_changed () {
+	assert test $# -gt 0
 	tree=$1
 	shift
 	if test $# -ne 1
@@ -496,7 +534,9 @@ tree_changed () {
 	fi
 }
 
+# Usage: new_squash_commit OLD_SQUASHED_COMMIT OLD_NONSQUASHED_COMMIT NEW_NONSQUASHED_COMMIT
 new_squash_commit () {
+	assert test $# = 3
 	old="$1"
 	oldsub="$2"
 	newsub="$3"
@@ -511,7 +551,9 @@ new_squash_commit () {
 	fi
 }
 
+# Usage: copy_or_skip REV TREE NEWPARENTS
 copy_or_skip () {
+	assert test $# = 3
 	rev="$1"
 	tree="$2"
 	newparents="$3"
@@ -586,7 +628,9 @@ copy_or_skip () {
 	fi
 }
 
+# Usage: ensure_clean
 ensure_clean () {
+	assert test $# = 0
 	if ! git diff-index HEAD --exit-code --quiet 2>&1
 	then
 		die "Working tree has modifications.  Cannot add."
@@ -597,12 +641,16 @@ ensure_clean () {
 	fi
 }
 
+# Usage: ensure_valid_ref_format REF
 ensure_valid_ref_format () {
+	assert test $# = 1
 	git check-ref-format "refs/heads/$1" ||
 		die "'$1' does not look like a ref"
 }
 
+# Usage: process_split_commit REV PARENTS INDENT
 process_split_commit () {
+	assert test $# = 3
 	local rev="$1"
 	local parents="$2"
 	local indent=$3
@@ -654,6 +702,8 @@ process_split_commit () {
 	cache_set latest_old "$rev"
 }
 
+# Usage: cmd_add REV
+#    Or: cmd_add REPOSITORY REF
 cmd_add () {
 
 	ensure_clean
@@ -681,7 +731,9 @@ cmd_add () {
 	fi
 }
 
+# Usage: cmd_add_repository REPOSITORY REFSPEC
 cmd_add_repository () {
+	assert test $# = 2
 	echo "git fetch" "$@"
 	repository=$1
 	refspec=$2
@@ -689,9 +741,11 @@ cmd_add_repository () {
 	cmd_add_commit FETCH_HEAD
 }
 
+# Usage: cmd_add_commit REV
 cmd_add_commit () {
 	# The rev has already been validated by cmd_add(), we just
 	# need to normalize it.
+	assert test $# = 1
 	rev=$(git rev-parse --verify "$1^{commit}") || exit $?
 
 	debug "Adding $dir as '$rev'..."
@@ -722,6 +776,7 @@ cmd_add_commit () {
 	say >&2 "Added dir '$dir'"
 }
 
+# Usage: cmd_split [REV]
 cmd_split () {
 	if test $# -eq 0
 	then
@@ -801,6 +856,7 @@ cmd_split () {
 	exit 0
 }
 
+# Usage: cmd_merge REV
 cmd_merge () {
 	test $# -eq 1 ||
 		die "You must provide exactly one revision.  Got: '$*'"
@@ -837,6 +893,7 @@ cmd_merge () {
 	fi
 }
 
+# Usage: cmd_pull REPOSITORY REMOTEREF
 cmd_pull () {
 	if test $# -ne 2
 	then
@@ -848,6 +905,7 @@ cmd_pull () {
 	cmd_merge FETCH_HEAD
 }
 
+# Usage: cmd_push REPOSITORY REMOTEREF
 cmd_push () {
 	if test $# -ne 2
 	then
-- 
2.31.1

