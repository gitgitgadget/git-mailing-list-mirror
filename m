From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon,  7 Jul 2014 17:33:45 -0700
Message-ID: <1404779625-16972-4-git-send-email-dturner@twitter.com>
References: <1404779625-16972-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 02:34:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4JMX-00081w-Q5
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 02:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbaGHAeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 20:34:16 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:52750 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbaGHAeK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 20:34:10 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so4508060qgd.35
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 17:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tsPVVcOyxDemtLo50OfYEJUsP1ZFPDAVDWMqC5cfoXc=;
        b=BmSXUltnLRzONRXpJidrvIhFDvkZY2Bo+m48BsMginfrUp9rwHwQRjveGjhcqPRtyz
         jW+Ejcvsrp+/LqPeQB6P/h/SY0XK4NMxzVpU0AUgrzXhBElwu5gGZ/QEoQkGX7MtEGd9
         X/AL3WnpTfJVzrddRbvq8ZONclzMBO57yRTM1AWpVVsYoGx8Gj107QWThZ3o0zBxAnyp
         s+i9qpL7ijY90nihGFyhuSarj0Wey0xm//VLfd40ZKHUcvyDf52oOon+Y+kCTRxdS2Jl
         LxodaJiYxhqyEbux+0R7HC6cbc+gsmM124VAHGYg3GFTcoO+Uma1I23pRhzmOcd8FZRK
         7ixQ==
X-Gm-Message-State: ALoCoQlIMaL9T6AlyV7poyNJRoqwXAOBoKStdcdO1m8zk1yW4+NK5v2LGODJKb1mOI+eM0rOotHn
X-Received: by 10.224.76.1 with SMTP id a1mr50996632qak.4.1404779649128;
        Mon, 07 Jul 2014 17:34:09 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id z14sm77426952qaw.7.2014.07.07.17.34.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jul 2014 17:34:08 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1404779625-16972-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252999>

During the commit process, update the cache-tree. Write this updated
cache-tree so that it's ready for subsequent commands.

Add test code which demonstrates that git commit now writes the cache
tree.  Make all tests test the entire cache-tree, not just the root
level.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/commit.c      |  9 +++++-
 t/t0090-cache-tree.sh | 79 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 73 insertions(+), 15 deletions(-)

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
index 496c034..8c89689 100755
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
@@ -16,8 +16,26 @@ cmp_cache_tree () {
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
+	subtree_count=$(echo "$subtrees"|awk '$1 {++c} END {print c}') &&
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
 
@@ -33,14 +51,14 @@ test_no_cache_tree () {
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
@@ -58,6 +76,18 @@ test_expect_success 'git-add in subdir invalidates cache-tree' '
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
@@ -65,8 +95,10 @@ test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
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
@@ -79,7 +111,7 @@ test_expect_success 'update-index invalidates cache-tree' '
 test_expect_success 'write-tree establishes cache-tree' '
 	test-scrap-cache-tree &&
 	git write-tree &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'test-scrap-cache-tree works' '
@@ -90,37 +122,56 @@ test_expect_success 'test-scrap-cache-tree works' '
 
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
