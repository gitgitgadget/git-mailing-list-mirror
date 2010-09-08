From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 2/2] merge-recursive: D/F conflicts where was_a_dir/file -> was_a_dir
Date: Wed,  8 Sep 2010 00:40:41 -0600
Message-ID: <1283928041-9882-3-git-send-email-newren@gmail.com>
References: <1283928041-9882-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, oinksocket@letterboxes.org,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 08:39:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtEJi-00060v-Dr
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 08:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab0IHGjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 02:39:31 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48651 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab0IHGjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 02:39:21 -0400
Received: by mail-qy0-f181.google.com with SMTP id 33so6160227qyk.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 23:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=t3/HFMZhpWm4dvxedc4DsFjAgryJlqVQ6pJohxt3zGk=;
        b=lXQSpuQ5bWhhr6UnOXUJLVGL+h+E1RDnOhBaoT/zYvXfKlJxi4XSOL41rGvciqe0oX
         UbUdkqO7sb12ratKBk3RRaCw2GMaFm+aOeiUyCc5PZL319qm9N0tsluRWZ2p0V/YHF6I
         yffs76Dp8J0vHR6osb+1H8bj5Yd+uGVMez1EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v5ioDie8d8bzFVB0bFxwiV9b96ujJhYELknWA0spDT6AyLSHlOI9RGQ8WNHtNN/4E/
         BlDT8qB091Z81s5vhMH22KbvBt4FIwSYcRtzzQgRvhQY6sov2+4BhJyg1RnDcXN3Pxx6
         9T7sFrcO6DMW8bvWTZPOspgQSLlVGwVSS6mCo=
Received: by 10.224.36.207 with SMTP id u15mr1594213qad.332.1283927960649;
        Tue, 07 Sep 2010 23:39:20 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t4sm8076432qcs.40.2010.09.07.23.39.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 23:39:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc0.8.g2ec3f
In-Reply-To: <1283928041-9882-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155771>

In merge-recursive.c, whenever there was a rename where a file name on one
side of the rename matches a directory name on the other side of the merge,
then the very first check that
  string_list_has_string(&o->current_directory_set, ren1_dst)
would trigger forcing it into marking it as a rename/directory conflict.

However, if the path is only renamed on one side and a simple three-way
merge between the separate files resolves cleanly, then we don't need to
mark it as a rename/directory conflict.  So, we can simply move the check
for rename/directory conflicts after we've verified that there isn't a
rename/rename conflict and that a threeway content merge doesn't work.

This changes the particular error message one gets in the case where the
directory name that a file on one side of the rename matches is not also
part of the rename pair.  For example, with commits containing the files:
  COMMON    -> (HEAD,           MERGE )
  ---------    ---------------  -------
  sub/file1 -> (sub/file1,      newsub)
  <NULL>    -> (newsub/newfile, <NULL>)
then previously when one tried to merge MERGE into HEAD, one would get
  CONFLICT (rename/directory): Rename sub/file1->newsub in HEAD  directory newsub added in merge
  Renaming sub/file1 to newsub~HEAD instead
  Adding newsub/newfile
  Automatic merge failed; fix conflicts and then commit the result.
After this patch, the error message will instead become:
  Removing newsub
  Adding newsub/newfile
  CONFLICT (file/directory): There is a directory with name newsub in merge. Adding newsub as newsub~HEAD
  Automatic merge failed; fix conflicts and then commit the result.
That makes more sense to me, because git can't know that there's a conflict
until after it's tried resolving paths involving newsub/newfile to see if
they are still in the way at the end (and if newsub/newfile is not in the
way at the end, there should be no conflict at all, which did not hold with
git previously).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c               |   16 ++++++++--------
 t/t3509-cherry-pick-merge-df.sh |    4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 20e1779..5ea6d11 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -935,14 +935,7 @@ static int process_renames(struct merge_options *o,
 
 			try_merge = 0;
 
-			if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
-				clean_merge = 0;
-				output(o, 1, "CONFLICT (rename/directory): Rename %s->%s in %s "
-				       " directory %s added in %s",
-				       ren1_src, ren1_dst, branch1,
-				       ren1_dst, branch2);
-				conflict_rename_dir(o, ren1, branch1);
-			} else if (sha_eq(src_other.sha1, null_sha1)) {
+			if (sha_eq(src_other.sha1, null_sha1)) {
 				clean_merge = 0;
 				output(o, 1, "CONFLICT (rename/delete): Rename %s->%s in %s "
 				       "and deleted in %s",
@@ -1034,6 +1027,13 @@ static int process_renames(struct merge_options *o,
 					if (!ren1->dst_entry->stages[2].mode !=
 					    !ren1->dst_entry->stages[3].mode)
 						ren1->dst_entry->processed = 0;
+				} else if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
+					clean_merge = 0;
+					output(o, 1, "CONFLICT (rename/directory): Rename %s->%s in %s "
+					       " directory %s added in %s",
+					       ren1_src, ren1_dst, branch1,
+					       ren1_dst, branch2);
+					conflict_rename_dir(o, ren1, branch1);
 				} else {
 					if (mfi.merge || !mfi.clean)
 						output(o, 1, "Renaming %s => %s", ren1_src, ren1_dst);
diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index eb5826f..948ca1b 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -58,7 +58,7 @@ test_expect_success 'Cherry-pick succeeds with was_a_dir/file -> was_a_dir (reso
 	git cherry-pick --strategy=resolve simple
 '
 
-test_expect_failure 'Cherry-pick succeeds with was_a_dir/file -> was_a_dir (recursive)' '
+test_expect_success 'Cherry-pick succeeds with was_a_dir/file -> was_a_dir (recursive)' '
 	git reset --hard &&
 	git checkout -q nick-testcase^0 &&
 	git cherry-pick --strategy=recursive simple
@@ -92,7 +92,7 @@ test_expect_success 'Cherry-pick with rename to different D/F conflict succeeds
 	git cherry-pick --strategy=resolve mergeme
 '
 
-test_expect_failure 'Cherry-pick with rename to different D/F conflict succeeds (recursive)' '
+test_expect_success 'Cherry-pick with rename to different D/F conflict succeeds (recursive)' '
 	git reset --hard &&
 	git checkout -q newhead^0 &&
 	git cherry-pick --strategy=recursive mergeme
-- 
1.7.3.rc0.8.g2ec3f
