Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1FD32079E
	for <e@80x24.org>; Sun, 15 Jan 2017 14:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbdAOOZl (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 09:25:41 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35234 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdAOOZk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 09:25:40 -0500
Received: by mail-wm0-f68.google.com with SMTP id d140so7871486wmd.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 06:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ntRIZGw9z40VYbNM4h97faNX5irpAhU3YFnk2ilL3NI=;
        b=aVZ9X7BqenE7zvh9shLV/QqikARJ2Rbl96p3uPtUncDJTxlUky+hUJhHew8BP7M3AF
         UF0qqx5X4s1aKjDxy+yRBZ8+YzXRbRyJeqyqDP7bIbIjZcd+KooUnRiFeFaQcmyQedgX
         VljQeRI9hyYmaLZ6UuCsT1tU4iQKzdhnuHBaFsGAc+MqEWTsnc5iKVGYeClZXWqoYhOx
         xVkC4DZeZ1ibbVVkr0nM8+qKhO+yAbFIIdvYWPKEo9eV9QooqWHrbfVA2qd67lvWsBs5
         CH/vzajQT3WJD4kVwfZqheqq5nEnGj5skzmIQ3Se2LeVT6+5qjN+KAqiAbM8qmsKNzVa
         Cw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ntRIZGw9z40VYbNM4h97faNX5irpAhU3YFnk2ilL3NI=;
        b=QijgIIMD99tu1CVNz24QKkQEOvFeJUgxARethmFzRXUddhvzuW0TNhpMsMuGgMUumd
         EzO7Mx3iLX3D796l9GHLntbjZTss+AEfCW5p6xHPRxuuUme0cp3kLQSC1pVx6VCPXN6G
         7RTjG5/JzajYhVTlrJ24lNGoB1slg1YIa2/r7s5rig7LIUAXWy5E32utyfNfp5XsgD9t
         q89XhLR72K9PiO02CLlIycYQpOxc40b7j9S5lWW32+zgUZgPh1MmZLHocpSJiYeYlazH
         IqN16HR2fQwnrcEwWJHeMedQ3RBtNABYEcIIseOnEG6w3eZ5ix59UQ90Eg2NWVg9cdSv
         KPYg==
X-Gm-Message-State: AIkVDXLX7CluQ4TCaytlyn4NFWcj+qS2oJMRNQ7kx4IIVOQAvMwXI5zlyweKgF1BCGB5tw==
X-Received: by 10.28.39.196 with SMTP id n187mr8388918wmn.114.1484490338538;
        Sun, 15 Jan 2017 06:25:38 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id g197sm21330056wmd.15.2017.01.15.06.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jan 2017 06:25:37 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     kes-kes@yandex.ru, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC] stash: support filename argument
Date:   Sun, 15 Jan 2017 14:25:42 +0000
Message-Id: <20170115142542.11999-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.258.ge05806da9e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on a repository, it's often helpful to stash the changes
of a single or multiple files, and leave others alone.  Unfortunately
git currently offers no such option.  git stash -p can be used to work
around this, but it's often impractical when there are a lot of changes
over multiple files.

Add a --file option to git stash save, which allows for stashing a
single file.  Specifying the --file argument multiple times allows
stashing more than one file at a time.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Marked as RFC and without documentation updates to first get a feeling
for the user interface, and whether people are interested in this
change.

Ideally I wanted the the user interface to look like something like:
git stash save -- [<filename1,...>], but unfortunately that's already
taken up by the stash message.  So to preserve backward compatibility
I used the new --file argument.

 git-stash.sh     | 45 +++++++++++++++++++++++++++++++++++++--------
 t/t3903-stash.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 10c284d1aa..0ef1b5b56e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -41,7 +41,7 @@ no_changes () {
 untracked_files () {
 	excl_opt=--exclude-standard
 	test "$untracked" = "all" && excl_opt=
-	git ls-files -o -z $excl_opt
+	git ls-files -o -z $excl_opt -- $1
 }
 
 clear_stash () {
@@ -56,6 +56,23 @@ clear_stash () {
 }
 
 create_stash () {
+	files=
+	while test $# != 0
+	do
+		case "$1" in
+		--)
+			shift
+			break
+			;;
+		--files)
+			;;
+		*)
+			files="$1 $files"
+			;;
+		esac
+		shift
+	done
+
 	stash_msg="$1"
 	untracked="$2"
 
@@ -92,7 +109,7 @@ create_stash () {
 		# Untracked files are stored by themselves in a parentless commit, for
 		# ease of unpacking later.
 		u_commit=$(
-			untracked_files | (
+			untracked_files $files | (
 				GIT_INDEX_FILE="$TMPindex" &&
 				export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
@@ -115,7 +132,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff-index --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff-index --name-only -z HEAD -- $files >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
@@ -129,7 +146,7 @@ create_stash () {
 
 		# find out what the user wants
 		GIT_INDEX_FILE="$TMP-index" \
-			git add--interactive --patch=stash -- &&
+			git add--interactive --patch=stash -- $files &&
 
 		# state of the working tree
 		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
@@ -193,6 +210,7 @@ save_stash () {
 	keep_index=
 	patch_mode=
 	untracked=
+	files=
 	while test $# != 0
 	do
 		case "$1" in
@@ -216,6 +234,10 @@ save_stash () {
 		-a|--all)
 			untracked=all
 			;;
+		--file)
+			shift
+			files="$files $1"
+			;;
 		--help)
 			show_help
 			;;
@@ -262,18 +284,25 @@ save_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash "$stash_msg" $untracked
+	create_stash --files $files -- "$stash_msg" "$untracked"
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
 
 	if test -z "$patch_mode"
 	then
-		git reset --hard ${GIT_QUIET:+-q}
+		if test -n "$files"
+		then
+			git reset -- $files
+			git checkout HEAD -- $(git ls-files --modified -- $files)
+			git clean --force --quiet -- $(git ls-files --others -- $files)
+		else
+			git reset --hard ${GIT_QUIET:+-q}
+		fi
 		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
 		if test -n "$untracked"
 		then
-			git clean --force --quiet -d $CLEAN_X_OPTION
+			git clean --force --quiet -d $CLEAN_X_OPTION -- $files
 		fi
 
 		if test "$keep_index" = "t" && test -n "$i_tree"
@@ -627,7 +656,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$*" && echo "$w_commit"
+	create_stash -- "$*" && echo "$w_commit"
 	;;
 store)
 	shift
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2de3e18ce6..42bfca873b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -775,4 +775,31 @@ test_expect_success 'stash is not confused by partial renames' '
 	test_path_is_missing file
 '
 
+test_expect_success 'stash --file <filename> stashes and restores the file' '
+	>foo &&
+	>bar &&
+	git add foo bar &&
+	git stash save --file foo &&
+	test_path_is_file bar &&
+	test_path_is_missing foo &&
+	git stash pop &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
+test_expect_success 'stash with multiple filename arguments' '
+	>foo &&
+	>bar &&
+	>extra &&
+	git add foo bar &&
+	git stash save --file foo --file bar &&
+	test_path_is_missing bar &&
+	test_path_is_missing foo &&
+	test_path_is_file extra &&
+	git stash pop &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	test_path_is_file extra
+'
+
 test_done
-- 
2.11.0.258.ge05806da9e.dirty

