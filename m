From: David Turner <dturner@twopensource.com>
Subject: [PATCH 3/3] cache-tree: Write index with updated cache-tree after commit
Date: Mon, 30 Jun 2014 17:13:17 -0700
Message-ID: <1404173597-24713-3-git-send-email-dturner@twitter.com>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 02:13:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1lhf-0007mU-EQ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 02:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756872AbaGAANl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 20:13:41 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:51809 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbaGAANj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 20:13:39 -0400
Received: by mail-qg0-f49.google.com with SMTP id f51so2653050qge.8
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 17:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uTAT1cu1eWV/G5VHzy88mzg6960No2mwW9JeWGlfisU=;
        b=Z1OuZFB5x2274leWsQqlBy8tD/kcyLcrPlUZATIoeJgzbavc7Cmb+dcYCk5BTeuAL6
         NZZcUrx58oBG/wJljDJSOPk4AoV2MIRDdb731rideiRPLi+gfxueMsgjADNrsSC3YzBv
         oTZMhUfQQ5/mkk9Gc622vSjFYB7utXPSZmPeIVEDctPMVMPRVqmfQ2peF6Uehw0DsXoj
         OLbbMtj5hz3uGl094qMb9kMu8tzHvQgRz8GS2BetpbkL6luwRrMXxypbQ45v0i3V3xb9
         Ds5JydIGLOKjXCBKtsTruMR0CfTjc2WLFEtyVSU+qkK9A7mAGSOCyF1fS+cs9cv9K2En
         sp3A==
X-Gm-Message-State: ALoCoQnxrNifPyHjiP4KyEX39cSaQM3+AcGpD9oCWOWaVJhG0QA4Qs1rYkXATXEZD0HnJ7lGytHj
X-Received: by 10.140.47.173 with SMTP id m42mr39185652qga.9.1404173618835;
        Mon, 30 Jun 2014 17:13:38 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id p3sm316651qga.33.2014.06.30.17.13.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jun 2014 17:13:38 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1404173597-24713-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252704>

During the commit process, the cache-tree is updated. We need to write
this updated cache-tree so that it's ready for subsequent commands.

Add test code which demonstrates that git commit now writes the cache
tree.  Also demonstrate that cache-tree invalidation is correct.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/commit.c      | 15 ++++++-------
 t/t0090-cache-tree.sh | 61 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 11 deletions(-)

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
index 5383258..d50acb8 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -16,8 +16,31 @@ cmp_cache_tree () {
 # We don't bother with actually checking the SHA1:
 # test-dump-cache-tree already verifies that all existing data is
 # correct.
+generate_expected_cache_tree () {
+	if [ -n "$1" ]
+	then
+		local dir="$1/"
+	else
+		local dir="$1"
+	fi
+	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
+	# We want to count only foo because it's the only direct child
+	local subtrees=$(git ls-files|egrep '/' |cut -d / -f 1|uniq) &&
+	local subtree_count=$(echo "$subtrees"|grep -c .) &&
+	local files_count=$(git ls-files|grep -v /|wc -l) &&
+	local entries=$(expr "$subtree_count" + "$files_count") &&
+	printf "SHA $dir (%d entries, %d subtrees)\n" $entries $subtree_count &&
+	local subtree &&
+	for subtree in $subtrees
+	do
+	    cd "$subtree"
+	    generate_expected_cache_tree "$dir$subtree" || return 1
+	    cd ..
+	done
+}
+
 test_shallow_cache_tree () {
-	printf "SHA  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >expect &&
+	generate_expected_cache_tree > expect &&
 	cmp_cache_tree expect
 }
 
@@ -35,7 +58,7 @@ test_no_cache_tree () {
 	cmp_cache_tree expect
 }
 
-test_expect_failure 'initial commit has cache-tree' '
+test_expect_success 'initial commit has cache-tree' '
 	test_commit foo &&
 	test_shallow_cache_tree
 '
@@ -60,15 +83,28 @@ test_expect_success 'git-add in subdir invalidates cache-tree' '
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
 	git tag no-children
 	test_when_finished "git reset --hard no-children; git read-tree HEAD" &&
 	mkdir dir1 dir2 &&
 	test_commit dir1/a &&
 	test_commit dir2/b &&
+	cmp_cache_tree before &&
 	echo "I changed this file" > dir1/a &&
 	git add dir1/a &&
-	test_invalid_cache_tree dir1/
+	cmp_cache_tree expect
 '
 
 test_expect_success 'update-index invalidates cache-tree' '
@@ -95,6 +131,14 @@ test_expect_success 'second commit has cache-tree' '
 	test_shallow_cache_tree
 '
 
+test_expect_success 'commit in child dir has cache-tree' '
+	mkdir dir &&
+	>dir/child.t &&
+	git add dir/child.t &&
+	git commit -m dir/child.t
+	test_shallow_cache_tree
+'
+
 test_expect_success 'reset --hard gives cache-tree' '
 	test-scrap-cache-tree &&
 	git reset --hard &&
@@ -125,4 +169,15 @@ test_expect_success 'checkout -B gives cache-tree' '
 	test_shallow_cache_tree
 '
 
+test_expect_success 'partial commit gives cache-tree' '
+	git checkout -b partial no-children &&
+	test_commit one &&
+	test_commit two &&
+	echo "some change" > one.t &&
+	git add one.t &&
+	echo "some other change" > two.t &&
+	git commit two.t -m partial &&
+	test_shallow_cache_tree
+'
+
 test_done
-- 
2.0.0.390.gcb682f8
