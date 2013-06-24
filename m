From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 16/16] rev-list: Optimize --count using bitmaps too
Date: Tue, 25 Jun 2013 01:23:13 +0200
Message-ID: <1372116193-32762-17-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:24:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG7g-0003eB-7J
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab3FXXYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:24:23 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:39732 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab3FXXYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:24:16 -0400
Received: by mail-wi0-f173.google.com with SMTP id hq4so183198wib.6
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DdnFqwOUjcxli3RjMJd4c47khADmMzysALc4C7V9S8Y=;
        b=jZWd4pKq2bGH3yWs+1oe/Y50cYfjl3cccJT1E3idFZnwKPNdMgGkxPmrW+R/PSGEc7
         fYi6WFUITMK3XApPqdgu57Eq0KoTOMepKZQLmEdYOsiuLBGKqr9R/Wxfl6ckaBjtboZc
         fEhPYaBprCQyXMbUXMYqbJ8x0EKrBQk0S2mpudQ34LGNnf/trYaSDixK0stXiNRJATRw
         OfEpLhE3qZHIMNVyTzuHiFNJ0iTeT/ydY9H/8Ea26Dj1BM8hs3RvUCOO6dA4N1Kvh2eC
         gsSzbby1yMk9OLu2R265324PI/l/KZlUJ+BnZHrCxuOZEIZ/L95bXfKkMb0Ey9ID1Pl3
         L+8g==
X-Received: by 10.180.91.131 with SMTP id ce3mr7288162wib.55.1372116254611;
        Mon, 24 Jun 2013 16:24:14 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.24.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:24:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228932>

If bitmap indexes are available, the process of counting reachable
commits with `git rev-list --count` can be greatly sped up. Instead of
having to use callbacks that yield each object in the revision list, we
can build the reachable bitmap for the list and then use an efficient
popcount to find the number of bits set in the bitmap.

This commit implements a `count_bitmap_commit_list` that can be used
after `prepare_bitmap_walk` has returned successfully to return the
number of commits, trees, blobs or tags that have been found to be
reachable during the walk.

`git rev-list` is taught to use this function call when bitmaps are
enabled instead of going through the old rev-list machinery. Do note,
however, that counts with `left_right` and `cherry_mark` are not
optimized by this patch.

Here are some sample timings of different ways to count commits in
`torvalds/linux`:

	$ time ../git/git rev-list master | wc -l
	376549

	real    0m6.973s
	user    0m3.216s
	sys     0m5.316s

	$ time ../git/git rev-list --count master
	376549

	real    0m1.933s
	user    0m1.744s
	sys     0m0.188s

	$ time ../git/git rev-list --use-bitmaps --count master
	376549

	real    0m0.005s
	user    0m0.000s
	sys     0m0.004s

Note that the time in the `--use-bitmaps` invocation is basically noise.
In my machine it ranges from 2ms to 6ms.
---
 builtin/rev-list.c |   11 +++++++++--
 pack-bitmap.c      |   37 +++++++++++++++++++++++++++++++++++++
 pack-bitmap.h      |    2 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 905ed08..097adb8 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -354,8 +354,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		revs.limited = 1;
 
 	if (use_bitmaps && !prepare_bitmap_walk(&revs, NULL)) {
-		traverse_bitmap_commit_list(&show_object_fast);
-		return 0;
+		if (revs.count && !revs.left_right && !revs.cherry_mark) {
+			uint32_t commit_count;
+			count_bitmap_commit_list(&commit_count, NULL, NULL, NULL);
+			printf("%d\n", commit_count);
+			return 0;
+		} else {
+			traverse_bitmap_commit_list(&show_object_fast);
+			return 0;
+		}
 	}
 
 	if (prepare_revision_walk(&revs))
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 090db15..65fdce7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -720,6 +720,43 @@ void traverse_bitmap_commit_list(show_reachable_fn show_reachable)
 	bitmap_git.result = NULL;
 }
 
+static uint32_t count_object_type(
+	struct bitmap *objects,
+	struct ewah_bitmap *type_filter)
+{
+	size_t i = 0, count = 0;
+	struct ewah_iterator it;
+	eword_t filter;
+
+	ewah_iterator_init(&it, type_filter);
+
+	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+		eword_t word = objects->words[i++] & filter;
+		count += __builtin_popcountll(word);
+	}
+
+	return count;
+}
+
+void count_bitmap_commit_list(
+	uint32_t *commits, uint32_t *trees, uint32_t *blobs, uint32_t *tags)
+{
+	if (!bitmap_git.result)
+		die("Tried to count bitmap without setting it up first");
+
+	if (commits)
+		*commits = count_object_type(bitmap_git.result, bitmap_git.commits);
+
+	if (trees)
+		*trees = count_object_type(bitmap_git.result, bitmap_git.trees);
+
+	if (blobs)
+		*blobs = count_object_type(bitmap_git.result, bitmap_git.blobs);
+
+	if (tags)
+		*tags = count_object_type(bitmap_git.result, bitmap_git.tags);
+}
+
 struct bitmap_test_data {
 	struct bitmap *base;
 	struct progress *prg;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 8e7e3dc..816da6d 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -47,6 +47,8 @@ typedef int (*show_reachable_fn)(
 	struct packed_git *found_pack,
 	off_t found_offset);
 
+void count_bitmap_commit_list(
+	uint32_t *commits, uint32_t *trees, uint32_t *blobs, uint32_t *tags);
 void traverse_bitmap_commit_list(show_reachable_fn show_reachable);
 int prepare_bitmap_walk(struct rev_info *revs, uint32_t *result_size);
 void test_bitmap_walk(struct rev_info *revs);
-- 
1.7.9.5
