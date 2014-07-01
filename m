From: David Turner <dturner@twopensource.com>
Subject: [PATCH 3/3] cache-tree: Write index with updated cache-tree after commit
Date: Tue,  1 Jul 2014 12:14:35 -0700
Message-ID: <1404242075-7068-3-git-send-email-dturner@twitter.com>
References: <1404242075-7068-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 21:16:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X23XD-0007xq-E1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 21:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbaGATP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 15:15:59 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:58124 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758598AbaGATP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 15:15:57 -0400
Received: by mail-qg0-f47.google.com with SMTP id q108so3800119qgd.34
        for <git@vger.kernel.org>; Tue, 01 Jul 2014 12:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Jm2NrGIo8qAjCqbucr1IWIxg9E0MgmUvsQ1ETTVEhs=;
        b=dGlgXolw/IGbRg7i5rHiy9j1F8jr8RiUfvHC4nY9wNYFtcMvY70LauPNYuyS9YK3rr
         XWuqPBn3WJiB5Ims5PSEq6QL/89Zj+xZt3Pjcf0RElfAOkYe/dRAheDVmDD+y4uNIIJz
         REVoh+mO0EjnFIuMHNQKD+NdrKvRYJfyh877LlkBwwDwS3Omib3mEv5R2gafyHTyhh4Y
         mGcGjVAyvr1S3k2dAAoPzMbWvW45TFJRn4IySrO5oE1JJnPnP5nh3fkCbzUyeUsTUt0h
         9e04blD2N/vmjP6fusWqFiuZnfPScJy6IfW2N3wB2enPz0vEjQXxqzWfmxlr+Qisw3F+
         858w==
X-Gm-Message-State: ALoCoQlFAkTCz4o2BJNC71OzsPWkx3s+OS4iSSToEu9vAlTfNjfzIQqWnKNYcpMdVNL2BttoZM5r
X-Received: by 10.140.48.161 with SMTP id o30mr72712341qga.68.1404242156897;
        Tue, 01 Jul 2014 12:15:56 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id i44sm1094930qgd.13.2014.07.01.12.15.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Jul 2014 12:15:55 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1404242075-7068-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252738>

During the commit process, the cache-tree is updated. We need to write
this updated cache-tree so that it's ready for subsequent commands.

Add test code which demonstrates that git commit now writes the cache
tree.  Also demonstrate that cache-tree invalidation is correct.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/commit.c      | 15 ++++++------
 t/t0090-cache-tree.sh | 63 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..dbd4f4b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -342,6 +342,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 
 		discard_cache();
 		read_cache_from(index_lock.filename);
+		if (update_main_cache_tree(WRITE_TREE_SILENT) >= 0)
+			write_cache(fd, active_cache, active_nr);
 
 		commit_style = COMMIT_NORMAL;
 		return index_lock.filename;
@@ -383,14 +385,10 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
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
@@ -435,6 +433,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	fd = hold_locked_index(&index_lock, 1);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
+	update_main_cache_tree(WRITE_TREE_SILENT);
 	if (write_cache(fd, active_cache, active_nr) ||
 	    close_lock_file(&index_lock))
 		die(_("unable to write new_index file"));
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 8437c5f..625157e 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -13,11 +13,35 @@ cmp_cache_tree () {
 	test_cmp "$1" filtered
 }
 
+grep_nonmatch_ok () {
+    grep $@
+    test "$?" = "2" && return 1
+    return 0
+}
+
 # We don't bother with actually checking the SHA1:
 # test-dump-cache-tree already verifies that all existing data is
 # correct.
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
 test_shallow_cache_tree () {
-	printf "SHA  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >expect &&
+	generate_expected_cache_tree >expect &&
 	cmp_cache_tree expect
 }
 
@@ -35,7 +59,7 @@ test_no_cache_tree () {
 	cmp_cache_tree expect
 }
 
-test_expect_failure 'initial commit has cache-tree' '
+test_expect_success 'initial commit has cache-tree' '
 	test_commit foo &&
 	test_shallow_cache_tree
 '
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
@@ -95,6 +133,14 @@ test_expect_success 'second commit has cache-tree' '
 	test_shallow_cache_tree
 '
 
+test_expect_success 'commit in child dir has cache-tree' '
+	mkdir dir &&
+	>dir/child.t &&
+	git add dir/child.t &&
+	git commit -m dir/child.t &&
+	test_shallow_cache_tree
+'
+
 test_expect_success 'reset --hard gives cache-tree' '
 	test-scrap-cache-tree &&
 	git reset --hard &&
@@ -125,4 +171,15 @@ test_expect_success 'checkout -B gives cache-tree' '
 	test_shallow_cache_tree
 '
 
+test_expect_success 'partial commit gives cache-tree' '
+	git checkout -b partial no-children &&
+	test_commit one &&
+	test_commit two &&
+	echo "some change" >one.t &&
+	git add one.t &&
+	echo "some other change" >two.t &&
+	git commit two.t -m partial &&
+	test_shallow_cache_tree
+'
+
 test_done
-- 
2.0.0.390.gcb682f8
