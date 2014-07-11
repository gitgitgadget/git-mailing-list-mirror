From: David Turner <dturner@twopensource.com>
Subject: [PATCH 4/4 v6] cache-tree: Write updated cache-tree after commit
Date: Thu, 10 Jul 2014 17:31:26 -0700
Message-ID: <1405038686-1138-4-git-send-email-dturner@twitter.com>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 02:32:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Oky-0002oR-UF
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 02:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbaGKAcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 20:32:01 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:50279 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaGKAb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 20:31:57 -0400
Received: by mail-qa0-f50.google.com with SMTP id m5so306000qaj.9
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 17:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yQcZshjqzM2dC1/JWvGbdVKaV856Ai+vGi8Fc1tCOss=;
        b=F/CAU7e/M5JepFGUFo4vOmk5V444DT/rWLZXJVSo0AiK7F4wDIeeYTmnygbThsBA1X
         yugvYRikD968lBoNyVMrXFkyTkN3wLztYAc6LVakFDnk7LfCo6XaJXfYNUmcFW5Wmdym
         AZKE6AAR+1TW5So3f+rAsL0DmpS+OKipmpGVvYKH2M86EXGsnQYYT1RyA29jxewoMaAw
         3pLXAA+8HR+002YcXbDkytcisK7Ef49HcwfLf6X4Shf/K1Rbo1s6XAdQWg08r3lj1/VL
         K7otY4+Y5co8YJn8gfp3ujPR7mn1Qy1LmeXxCEB+j/QXoIVm4P//aQDYDU6fwdOcHqow
         X34g==
X-Gm-Message-State: ALoCoQlCxKdpxKwu6Q8h1eo0vXnbNDbHnK311NWDnfATFiSpdVa+G74nEKGiGUEB+U5m81XZsoqK
X-Received: by 10.229.44.65 with SMTP id z1mr82938294qce.7.1405038717151;
        Thu, 10 Jul 2014 17:31:57 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id s62sm752254qga.28.2014.07.10.17.31.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jul 2014 17:31:56 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1405038686-1138-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253245>

During the commit process, update the cache-tree. Write this updated
cache-tree so that it's ready for subsequent commands.

Add test code which demonstrates that git commit now writes the cache
tree.  Make all tests test the entire cache-tree, not just the root
level.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/commit.c      |  9 +++++-
 t/t0090-cache-tree.sh | 87 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 81 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..99c9054 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -342,6 +342,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 
 		discard_cache();
 		read_cache_from(index_lock.filename);
+		if (update_main_cache_tree(WRITE_TREE_SILENT) >= 0)
+			write_cache(fd, active_cache, active_nr);
 
 		commit_style = COMMIT_NORMAL;
 		return index_lock.filename;
@@ -383,8 +385,12 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	if (!only && !pathspec.nr) {
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
-		if (active_cache_changed) {
+		if (active_cache_changed
+		    || !cache_tree_fully_valid(active_cache_tree)) {
 			update_main_cache_tree(WRITE_TREE_SILENT);
+			active_cache_changed = 1;
+		}
+		if (active_cache_changed) {
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
 				die(_("unable to write new_index file"));
@@ -435,6 +441,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	fd = hold_locked_index(&index_lock, 1);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
+	update_main_cache_tree(WRITE_TREE_SILENT);
 	if (write_cache(fd, active_cache, active_nr) ||
 	    close_lock_file(&index_lock))
 		die(_("unable to write new_index file"));
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 3a3342e..db7a8d0 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -8,7 +8,7 @@ cache-tree extension.
  . ./test-lib.sh
 
 cmp_cache_tree () {
-	test-dump-cache-tree >actual &&
+	test-dump-cache-tree | sed -e '/#(ref)/d' >actual &&
 	sed "s/$_x40/SHA/" <actual >filtered &&
 	test_cmp "$1" filtered
 }
@@ -16,8 +16,34 @@ cmp_cache_tree () {
 # We don't bother with actually checking the SHA1:
 # test-dump-cache-tree already verifies that all existing data is
 # correct.
-test_shallow_cache_tree () {
-	printf "SHA  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >expect &&
+generate_expected_cache_tree_rec () {
+	dir="$1${1:+/}" &&
+	parent="$2" &&
+	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
+	# We want to count only foo because it's the only direct child
+	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
+	subtree_count=$(echo "$subtrees"|awk '$1 {++c} END {print c}') &&
+	entries=$(git ls-files|wc -l) &&
+	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
+	for subtree in $subtrees
+	do
+	    cd "$subtree"
+	    generate_expected_cache_tree_rec "$dir$subtree" "$dir" || return 1
+	    cd ..
+	done &&
+	dir=$parent
+}
+
+generate_expected_cache_tree () {
+    cwd=$(pwd)
+    generate_expected_cache_tree_rec
+    ret="$?"
+    cd "$cwd"
+    return $ret
+}
+
+test_cache_tree () {
+	generate_expected_cache_tree >expect &&
 	cmp_cache_tree expect
 }
 
@@ -33,14 +59,14 @@ test_no_cache_tree () {
 	cmp_cache_tree expect
 }
 
-test_expect_failure 'initial commit has cache-tree' '
+test_expect_success 'initial commit has cache-tree' '
 	test_commit foo &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'read-tree HEAD establishes cache-tree' '
 	git read-tree HEAD &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'git-add invalidates cache-tree' '
@@ -58,6 +84,18 @@ test_expect_success 'git-add in subdir invalidates cache-tree' '
 	test_invalid_cache_tree
 '
 
+cat >before <<\EOF
+SHA  (3 entries, 2 subtrees)
+SHA dir1/ (1 entries, 0 subtrees)
+SHA dir2/ (1 entries, 0 subtrees)
+EOF
+
+cat >expect <<\EOF
+invalid                                   (2 subtrees)
+invalid                                  dir1/ (0 subtrees)
+SHA dir2/ (1 entries, 0 subtrees)
+EOF
+
 test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
 	git tag no-children &&
 	test_when_finished "git reset --hard no-children; git read-tree HEAD" &&
@@ -65,8 +103,10 @@ test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
 	test_commit dir1/a &&
 	test_commit dir2/b &&
 	echo "I changed this file" >dir1/a &&
+	cmp_cache_tree before &&
+	echo "I changed this file" >dir1/a &&
 	git add dir1/a &&
-	test_invalid_cache_tree dir1/
+	cmp_cache_tree expect
 '
 
 test_expect_success 'update-index invalidates cache-tree' '
@@ -79,7 +119,7 @@ test_expect_success 'update-index invalidates cache-tree' '
 test_expect_success 'write-tree establishes cache-tree' '
 	test-scrap-cache-tree &&
 	git write-tree &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'test-scrap-cache-tree works' '
@@ -90,37 +130,56 @@ test_expect_success 'test-scrap-cache-tree works' '
 
 test_expect_success 'second commit has cache-tree' '
 	test_commit bar &&
-	test_shallow_cache_tree
+	test_cache_tree
+'
+
+test_expect_success 'commit in child dir has cache-tree' '
+	mkdir dir &&
+	>dir/child.t &&
+	git add dir/child.t &&
+	git commit -m dir/child.t &&
+	test_cache_tree
 '
 
 test_expect_success 'reset --hard gives cache-tree' '
 	test-scrap-cache-tree &&
 	git reset --hard &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'reset --hard without index gives cache-tree' '
 	rm -f .git/index &&
 	git reset --hard &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'checkout gives cache-tree' '
 	git tag current &&
 	git checkout HEAD^ &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'checkout -b gives cache-tree' '
 	git checkout current &&
 	git checkout -b prev HEAD^ &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'checkout -B gives cache-tree' '
 	git checkout current &&
 	git checkout -B prev HEAD^ &&
-	test_shallow_cache_tree
+	test_cache_tree
+'
+
+test_expect_success 'partial commit gives cache-tree' '
+	git checkout -b partial no-children &&
+	test_commit one &&
+	test_commit two &&
+	echo "some change" >one.t &&
+	git add one.t &&
+	echo "some other change" >two.t &&
+	git commit two.t -m partial &&
+	test_cache_tree
 '
 
 test_done
-- 
2.0.0.390.gcb682f8
