Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005FDC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CFF6113B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbhDWTny (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:54 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:35334 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243930AbhDWTni (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:38 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 6EDE980594;
        Fri, 23 Apr 2021 15:43:01 -0400 (EDT)
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
Subject: [PATCH 23/30] subtree: add comments and sanity checks
Date:   Fri, 23 Apr 2021 13:42:23 -0600
Message-Id: <20210423194230.1388945-24-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh | 62 ++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 04dfaf443e..ddfa74c3bf 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -41,6 +41,7 @@ arg_split_annotate=
 arg_addmerge_squash=
 arg_addmerge_message=
 
+# Usage: debug [MSG...]
 debug () {
 	if test -n "$arg_debug"
 	then
@@ -48,6 +49,7 @@ debug () {
 	fi
 }
 
+# Usage: progress [MSG...]
 progress () {
 	if test -z "$GIT_QUIET"
 	then
@@ -55,6 +57,7 @@ progress () {
 	fi
 }
 
+# Usage: assert CMD...
 assert () {
 	if ! "$@"
 	then
@@ -178,7 +181,9 @@ main () {
 	"cmd_$arg_command" "$@"
 }
 
+# Usage: cache_setup
 cache_setup () {
+	assert test $# = 0
 	cachedir="$GIT_DIR/subtree-cache/$$"
 	rm -rf "$cachedir" ||
 		die "Can't delete old cachedir: $cachedir"
@@ -189,6 +194,7 @@ cache_setup () {
 	debug "Using cachedir: $cachedir" >&2
 }
 
+# Usage: cache_get [REVS...]
 cache_get () {
 	for oldrev in "$@"
 	do
@@ -200,6 +206,7 @@ cache_get () {
 	done
 }
 
+# Usage: cache_miss [REVS...]
 cache_miss () {
 	for oldrev in "$@"
 	do
@@ -210,7 +217,9 @@ cache_miss () {
 	done
 }
 
+# Usage: check_parents PARENTS_EXPR INDENT
 check_parents () {
+	assert test $# = 2
 	missed=$(cache_miss "$1") || exit $?
 	local indent=$(($2 + 1))
 	for miss in $missed
@@ -223,11 +232,15 @@ check_parents () {
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
@@ -239,7 +252,9 @@ cache_set () {
 	echo "$newrev" >"$cachedir/$oldrev"
 }
 
+# Usage: rev_exists REV
 rev_exists () {
+	assert test $# = 1
 	if git rev-parse "$1" >/dev/null 2>&1
 	then
 		return 0
@@ -248,17 +263,22 @@ rev_exists () {
 	fi
 }
 
+# Usage: try_remove_previous REV
+#
 # if a commit doesn't have a parent, this might not work.  But we only want
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
@@ -302,10 +322,12 @@ find_latest_squash () {
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
@@ -314,7 +336,7 @@ find_existing_splits () {
 		grep_format="^Add '$dir/' from commit '"
 	fi
 	git log --grep="$grep_format" \
-		--no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
+		--no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' "$rev" |
 	while read a b junk
 	do
 		case "$a" in
@@ -351,7 +373,9 @@ find_existing_splits () {
 	done || exit $?
 }
 
+# Usage: copy_commit REV TREE FLAGS_STR
 copy_commit () {
+	assert test $# = 3
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
@@ -377,7 +401,9 @@ copy_commit () {
 	) || die "Can't copy commit $1"
 }
 
+# Usage: add_msg DIR LATEST_OLD LATEST_NEW
 add_msg () {
+	assert test $# = 3
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
@@ -396,7 +422,9 @@ add_msg () {
 	EOF
 }
 
+# Usage: add_squashed_msg REV DIR
 add_squashed_msg () {
+	assert test $# = 2
 	if test -n "$arg_addmerge_message"
 	then
 		echo "$arg_addmerge_message"
@@ -405,7 +433,9 @@ add_squashed_msg () {
 	fi
 }
 
+# Usage: rejoin_msg DIR LATEST_OLD LATEST_NEW
 rejoin_msg () {
+	assert test $# = 3
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
@@ -424,7 +454,9 @@ rejoin_msg () {
 	EOF
 }
 
+# Usage: squash_msg DIR OLD_SUBTREE_COMMIT NEW_SUBTREE_COMMIT
 squash_msg () {
+	assert test $# = 3
 	dir="$1"
 	oldsub="$2"
 	newsub="$3"
@@ -446,12 +478,16 @@ squash_msg () {
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
@@ -465,7 +501,9 @@ subtree_for_commit () {
 	done || exit $?
 }
 
+# Usage: tree_changed TREE [PARENTS...]
 tree_changed () {
+	assert test $# -gt 0
 	tree=$1
 	shift
 	if test $# -ne 1
@@ -482,7 +520,9 @@ tree_changed () {
 	fi
 }
 
+# Usage: new_squash_commit OLD_SQUASHED_COMMIT OLD_NONSQUASHED_COMMIT NEW_NONSQUASHED_COMMIT
 new_squash_commit () {
+	assert test $# = 3
 	old="$1"
 	oldsub="$2"
 	newsub="$3"
@@ -497,7 +537,9 @@ new_squash_commit () {
 	fi
 }
 
+# Usage: copy_or_skip REV TREE NEWPARENTS
 copy_or_skip () {
+	assert test $# = 3
 	rev="$1"
 	tree="$2"
 	newparents="$3"
@@ -572,7 +614,9 @@ copy_or_skip () {
 	fi
 }
 
+# Usage: ensure_clean
 ensure_clean () {
+	assert test $# = 0
 	if ! git diff-index HEAD --exit-code --quiet 2>&1
 	then
 		die "Working tree has modifications.  Cannot add."
@@ -583,12 +627,16 @@ ensure_clean () {
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
@@ -640,6 +688,8 @@ process_split_commit () {
 	cache_set latest_old "$rev"
 }
 
+# Usage: cmd_add REV
+#    Or: cmd_add REPOSITORY REF
 cmd_add () {
 
 	ensure_clean
@@ -667,7 +717,9 @@ cmd_add () {
 	fi
 }
 
+# Usage: cmd_add_repository REPOSITORY REFSPEC
 cmd_add_repository () {
+	assert test $# = 2
 	echo "git fetch" "$@"
 	repository=$1
 	refspec=$2
@@ -675,9 +727,11 @@ cmd_add_repository () {
 	cmd_add_commit FETCH_HEAD
 }
 
+# Usage: cmd_add_commit REV
 cmd_add_commit () {
 	# The rev has already been validated by cmd_add(), we just
 	# need to normalize it.
+	assert test $# = 1
 	rev=$(git rev-parse --verify "$1^{commit}") || exit $?
 
 	debug "Adding $dir as '$rev'..."
@@ -708,6 +762,7 @@ cmd_add_commit () {
 	say >&2 "Added dir '$dir'"
 }
 
+# Usage: cmd_split [REV]
 cmd_split () {
 	if test $# -eq 0
 	then
@@ -787,6 +842,7 @@ cmd_split () {
 	exit 0
 }
 
+# Usage: cmd_merge REV
 cmd_merge () {
 	test $# -eq 1 ||
 		die "You must provide exactly one revision.  Got: '$*'"
@@ -823,6 +879,7 @@ cmd_merge () {
 	fi
 }
 
+# Usage: cmd_pull REPOSITORY REMOTEREF
 cmd_pull () {
 	if test $# -ne 2
 	then
@@ -834,6 +891,7 @@ cmd_pull () {
 	cmd_merge FETCH_HEAD
 }
 
+# Usage: cmd_push REPOSITORY REMOTEREF
 cmd_push () {
 	if test $# -ne 2
 	then
-- 
2.31.1

