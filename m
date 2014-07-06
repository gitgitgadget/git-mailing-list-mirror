From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 4/4] cache-tree: Write updated cache-tree after commit
Date: Sat,  5 Jul 2014 21:06:59 -0700
Message-ID: <1404619619-4774-4-git-send-email-dturner@twitter.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 06:07:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3djs-0005RB-RK
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 06:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbaGFEHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 00:07:35 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35057 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbaGFEHc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 00:07:32 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so3576940pdb.25
        for <git@vger.kernel.org>; Sat, 05 Jul 2014 21:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fhnxw2E9RjcgGAXQjfyElkrGBuWfdgMoupcX2X2bjZw=;
        b=Kxt1ubfclT/1o3keJQdi0xxHPr6qYO6/t04y5Ag3tdx3VIUB5X7VFXwlZyZcQItnPv
         nqnaWWrnYOiRtGjrN8YaEAxsbDHwUJebzxQzTBw3pzSbc/Ygq9tPPRu3D1xfgT+euFLQ
         ekjVeEyyU8B3piajVlQnMhdRtJPTJ0l9g71O4CCdNjgxN6r7HMeoCb+9d7WhZQa1PE0m
         Sb1MKcPiaLzCSoBs1Y8fHiOA5u1g/B8+RU7bcl/CQlvut+UgPuTYEi9bAYOoW2eipLBl
         IOOcf0fYmQzqJGly2BjO+2Rze+g6+VWHn491UWAYlTxXVI7UOx7dsh9UO/NqfR7+YMEb
         WTpA==
X-Gm-Message-State: ALoCoQkr/8GtHtOVBuVh+HEVI97uoINJKsghFPlSE5qZKiRP/uE3cp1oRLXjbw92qK4vG75lXuAd
X-Received: by 10.68.194.229 with SMTP id hz5mr10100622pbc.91.1404619651718;
        Sat, 05 Jul 2014 21:07:31 -0700 (PDT)
Received: from stross.twitter.corp (c-67-169-40-58.hsd1.ca.comcast.net. [67.169.40.58])
        by mx.google.com with ESMTPSA id by1sm48542593pbb.75.2014.07.05.21.07.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Jul 2014 21:07:30 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1404619619-4774-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252927>

During the commit process, update the cache-tree. Write this updated
cache-tree so that it's ready for subsequent commands.

Add test code which demonstrates that git commit now writes the cache
tree.  Make all tests test the entire cache-tree, not just the root
level.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/commit.c      | 31 +++++++++++-------
 t/t0090-cache-tree.sh | 87 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 91 insertions(+), 27 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..5981755 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -342,6 +342,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 
 		discard_cache();
 		read_cache_from(index_lock.filename);
+		if (update_main_cache_tree(WRITE_TREE_SILENT) >= 0)
+			write_cache(fd, active_cache, active_nr);
 
 		commit_style = COMMIT_NORMAL;
 		return index_lock.filename;
@@ -363,10 +365,18 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 		fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
-		update_main_cache_tree(WRITE_TREE_SILENT);
-		if (write_cache(fd, active_cache, active_nr) ||
-		    close_lock_file(&index_lock))
-			die(_("unable to write new_index file"));
+		if (active_cache_changed
+		    || !cache_tree_fully_valid(active_cache_tree)) {
+			update_main_cache_tree(WRITE_TREE_SILENT);
+			active_cache_changed = 1;
+		}
+		if (active_cache_changed) {
+			if (write_cache(fd, active_cache, active_nr) ||
+			    close_lock_file(&index_lock))
+				die(_("unable to write new_index file"));
+		} else {
+			rollback_lock_file(&index_lock);
+		}
 		commit_style = COMMIT_NORMAL;
 		return index_lock.filename;
 	}
@@ -383,14 +393,10 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	if (!only && !pathspec.nr) {
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
-		if (active_cache_changed) {
-			update_main_cache_tree(WRITE_TREE_SILENT);
-			if (write_cache(fd, active_cache, active_nr) ||
-			    commit_locked_index(&index_lock))
-				die(_("unable to write new_index file"));
-		} else {
-			rollback_lock_file(&index_lock);
-		}
+		update_main_cache_tree(WRITE_TREE_SILENT);
+		if (write_cache(fd, active_cache, active_nr) ||
+		    commit_locked_index(&index_lock))
+			die(_("unable to write new_index file"));
 		commit_style = COMMIT_AS_IS;
 		return get_index_file();
 	}
@@ -435,6 +441,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	fd = hold_locked_index(&index_lock, 1);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
+	update_main_cache_tree(WRITE_TREE_SILENT);
 	if (write_cache(fd, active_cache, active_nr) ||
 	    close_lock_file(&index_lock))
 		die(_("unable to write new_index file"));
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 8437c5f..15f1484 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -7,8 +7,14 @@ cache-tree extension.
 "
  . ./test-lib.sh
 
+grep_nonmatch_ok () {
+    grep $@
+    test "$?" = "2" && return 1
+    return 0
+}
+
 cmp_cache_tree () {
-	test-dump-cache-tree >actual &&
+	test-dump-cache-tree | grep_nonmatch_ok -v \#\(ref\) >actual &&
 	sed "s/$_x40/SHA/" <actual >filtered &&
 	test_cmp "$1" filtered
 }
@@ -16,15 +22,33 @@ cmp_cache_tree () {
 # We don't bother with actually checking the SHA1:
 # test-dump-cache-tree already verifies that all existing data is
 # correct.
-test_shallow_cache_tree () {
-	printf "SHA  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >expect &&
+generate_expected_cache_tree () {
+	dir="$1${1:+/}" &&
+	parent="$2" &&
+	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
+	# We want to count only foo because it's the only direct child
+	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
+	subtree_count=$(echo "$subtrees"|grep_nonmatch_ok -c .) &&
+	entries=$(git ls-files|wc -l) &&
+	printf "SHA $dir (%d entries, %d subtrees)\n" $entries $subtree_count &&
+	for subtree in $subtrees
+	do
+	    cd "$subtree"
+	    generate_expected_cache_tree "$dir$subtree" $dir || return 1
+	    cd ..
+	done &&
+	dir=$parent
+}
+
+test_cache_tree () {
+	generate_expected_cache_tree >expect &&
 	cmp_cache_tree expect
 }
 
 # Test that the cache-tree for a given directory is invalid.
 # If no directory is given, check that the root is invalid
 test_invalid_cache_tree () {
-	test-dump-cache-tree >actual &&
+	test-dump-cache-tree | grep_nonmatch_ok -v \#\(ref\) >actual &&
 	sed -e "s/$_x40/SHA/" -e "s/[0-9]* subtrees//g" <actual >filtered &&
 	expect=$(printf "invalid                                  $1 ()\n") &&
 	fgrep "$expect" filtered
@@ -35,14 +59,14 @@ test_no_cache_tree () {
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
@@ -60,6 +84,18 @@ test_expect_success 'git-add in subdir invalidates cache-tree' '
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
@@ -67,8 +103,10 @@ test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
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
@@ -81,7 +119,7 @@ test_expect_success 'update-index invalidates cache-tree' '
 test_expect_success 'write-tree establishes cache-tree' '
 	test-scrap-cache-tree &&
 	git write-tree &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'test-scrap-cache-tree works' '
@@ -92,37 +130,56 @@ test_expect_success 'test-scrap-cache-tree works' '
 
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
