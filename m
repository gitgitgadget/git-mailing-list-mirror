From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 37/56] merge-recursive: When we detect we can skip an update, actually skip it
Date: Thu, 11 Aug 2011 23:20:10 -0600
Message-ID: <1313126429-17368-38-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:22:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkCL-0005Kt-QG
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab1HLFWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:04 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab1HLFWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:00 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jndIRVdYk+Bo12AQHN9L41WecHtSLM+2BOcN2Z5mvd0=;
        b=d1SkHj/LiQx/zu+WjCY5hYX+KFc+Gb+tARH23DW9zF7y9gsL5OH2vlcRX7vLoU5hLJ
         wyftdDYwmGQutziSIGiFKcFk8YGaTrLozOwD2wu/iXFInpqPukWdEusLS47S5FjwlDvV
         Qn1HWaI69SPa0Xoa+7CKEqoNle0jZrHivmL9s=
Received: by 10.42.154.132 with SMTP id q4mr500996icw.489.1313126518718;
        Thu, 11 Aug 2011 22:21:58 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.56
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179194>

In 882fd11 (merge-recursive: Delay content merging for renames 2010-09-20),
there was code that checked for whether we could skip updating a file in
the working directory, based on whether the merged version matched the
current working copy.  Due to the desire to handle directory/file conflicts
that were resolvable, that commit deferred content merging by first
updating the index with the unmerged entries and then moving the actual
merging (along with the skip-the-content-update check) to another function
that ran later in the merge process.  As part moving the content merging
code, a bug was introduced such that although the message about skipping
the update would be printed (whenever GIT_MERGE_VERBOSITY was sufficiently
high), the file would be unconditionally updated in the working copy
anyway.

When we detect that the file does not need to be updated in the working
copy, update the index appropriately and then return early before updating
the working copy.

Note that there was a similar change in b2c8c0a (merge-recursive: When we
detect we can skip an update, actually skip it 2011-02-28), but it was
reverted by 6db4105 (Revert "Merge branch 'en/merge-recursive'"
2011-05-19) since it did not fix both of the relevant types of unnecessary
update breakages and, worse, it made use of some band-aids that caused
other problems.  The reason this change works is due to the changes earlier
in this series to (a) record_df_conflict_files instead of just unlinking
them early, (b) allowing make_room_for_path() to remove D/F entries,
(c) the splitting of update_stages_and_entry() to have its functionality
called at different points, and (d) making the pathnames of the files
involved in the merge available to merge_content().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1:
  (1) Moved to later in the series (used to be patch #29).
  (2) Changed the "was_tracked" logic to use information about what
      paths were involved in renames to determine whether the file
      really 'was tracked' before the merge started.  Thus, the code
      is now about checking "!path_renamed_outside_HEAD" rather than
      "was_tracked(path)" (The latter was problematic because it tells
      us whether path was tracked once unpack_trees finishes() rather
      than whether the path was tracked before the merge started.)
  (3) Added another minor tweak to get the expected "Skipped" messages
      that t6022.12 expects.  We need to report that we are skipping
      the update even if the content is only on the other side of the
      merge and we need to update the working directory contents.  At
      least, that's what the author of t6022.12 who put the message in
      explicitly expected.

 merge-recursive.c       |   19 ++++++++++++++++---
 t/t6022-merge-rename.sh |    4 ++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index bc99f1a..ccf71d3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1356,6 +1356,7 @@ static int merge_content(struct merge_options *o,
 {
 	const char *reason = "content";
 	char *side1 = NULL, *side2 = NULL;
+	const char *path1 = NULL, *path2 = NULL;
 	struct merge_file_info mfi;
 	struct diff_filespec one, a, b;
 	unsigned df_conflict_remains = 0;
@@ -1373,7 +1374,6 @@ static int merge_content(struct merge_options *o,
 	b.mode = b_mode;
 
 	if (rename_conflict_info) {
-		const char *path1, *path2;
 		struct diff_filepair *pair1 = rename_conflict_info->pair1;
 
 		path1 = (o->branch1 == rename_conflict_info->branch1) ?
@@ -1399,9 +1399,22 @@ static int merge_content(struct merge_options *o,
 	free(side2);
 
 	if (mfi.clean && !df_conflict_remains &&
-	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode)
+	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
+		int path_renamed_outside_HEAD;
 		output(o, 3, "Skipped %s (merged same as existing)", path);
-	else
+		/*
+		 * The content merge resulted in the same file contents we
+		 * already had.  We can return early if those file contents
+		 * are recorded at the correct path (which may not be true
+		 * if the merge involves a rename).
+		 */
+		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
+		if (!path_renamed_outside_HEAD) {
+			add_cacheinfo(mfi.mode, mfi.sha, path,
+				      0 /*stage*/, 1 /*refresh*/, 0 /*options*/);
+			return mfi.clean;
+		}
+	} else
 		output(o, 2, "Auto-merging %s", path);
 
 	if (!mfi.clean) {
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 4695cbc..d96d3c5 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -631,7 +631,7 @@ test_expect_success 'setup avoid unnecessary update, normal rename' '
 	git commit -m "Random, unrelated changes"
 '
 
-test_expect_failure 'avoid unnecessary update, normal rename' '
+test_expect_success 'avoid unnecessary update, normal rename' '
 	git checkout -q avoid-unnecessary-update-1^0 &&
 	test-chmtime =1000000000 rename &&
 	test-chmtime -v +0 rename >expect &&
@@ -664,7 +664,7 @@ test_expect_success 'setup to test avoiding unnecessary update, with D/F conflic
 	git commit -m "Only unrelated changes"
 '
 
-test_expect_failure 'avoid unnecessary update, with D/F conflict' '
+test_expect_success 'avoid unnecessary update, with D/F conflict' '
 	git checkout -q avoid-unnecessary-update-2^0 &&
 	test-chmtime =1000000000 df &&
 	test-chmtime -v +0 df >expect &&
-- 
1.7.6.100.gac5c1
