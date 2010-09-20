From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 36/37] merge-recursive: Make room for directories in D/F conflicts
Date: Mon, 20 Sep 2010 02:29:09 -0600
Message-ID: <1284971350-30590-37-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblO-0006R4-VC
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab0ITI2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab0ITI2p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:45 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071833pvg.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=B44ZGNewDhl8RIQd6IsR+Yhf9cpcHqofQ9mb3OcCazo=;
        b=ZLgJHmnSo1nOWY4B3PbDXDiQxdmTelqxu9+BxOPDTnVwutqcQ+qx5MvaVlPwpfrdXy
         ReAg/edMz2i4Ne1N5QKtxiIQ3ox6Y8N32RnV8PPdnQlDKzh+t4EOwZXCqNe5zESAEhXn
         OY2gN+Z/VmWicgEzeOHpK12ozOT3hu2uAaQZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oxiOrapqvt5SIUFCSscxwzBYPk06ziLR8Zo7lNuIhJJhYt42BM06uXEhR1aVOclWJr
         kdIbCIpfxJPtvkwKfSaGkGc0tdYqQiQt6Jw9MJKepwoD3rnZLHVpKmElrNalT9x+AIy6
         VfeG9ZxmHrCcGjp0l2wpCUBfB1O+brl4ahq6g=
Received: by 10.142.216.8 with SMTP id o8mr5675939wfg.130.1284971325033;
        Mon, 20 Sep 2010 01:28:45 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156588>

When there are unmerged entries present, make sure to check for D/F
conflicts first and remove any files present in HEAD that would be in the
way of creating files below the correspondingly named directory.  Such
files will be processed again at the end of the merge in
process_df_entry(); at that time we will be able to tell if we need to
and can reinstate the file, whether we need to place its contents in a
different file due to the directory still being present, etc.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c   |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t6020-merge-df.sh |    2 +-
 2 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 05da47c..821bed8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -347,6 +347,63 @@ static struct string_list *get_unmerged(void)
 	return unmerged;
 }
 
+static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
+						      struct string_list *entries)
+{
+	/* If there are D/F conflicts, and the paths currently exist
+	 * in the working copy as a file, we want to remove them to
+	 * make room for the corresponding directory.  Such paths will
+	 * later be processed in process_df_entry() at the end.  If
+	 * the corresponding directory ends up being removed by the
+	 * merge, then the file will be reinstated at that time;
+	 * otherwise, if the file is not supposed to be removed by the
+	 * merge, the contents of the file will be placed in another
+	 * unique filename.
+	 *
+	 * NOTE: This function relies on the fact that entries for a
+	 * D/F conflict will appear adjacent in the index, with the
+	 * entries for the file appearing before entries for paths
+	 * below the corresponding directory.
+	 */
+	const char *last_file = NULL;
+	int last_len;
+	struct stage_data *last_e;
+	int i;
+
+	for (i = 0; i < entries->nr; i++) {
+		const char *path = entries->items[i].string;
+		int len = strlen(path);
+		struct stage_data *e = entries->items[i].util;
+
+		/*
+		 * Check if last_file & path correspond to a D/F conflict;
+		 * i.e. whether path is last_file+'/'+<something>.
+		 * If so, remove last_file to make room for path and friends.
+		 */
+		if (last_file &&
+		    len > last_len &&
+		    memcmp(path, last_file, last_len) == 0 &&
+		    path[last_len] == '/') {
+			output(o, 3, "Removing %s to make room for subdirectory; may re-add later.", last_file);
+			unlink(last_file);
+		}
+
+		/*
+		 * Determine whether path could exist as a file in the
+		 * working directory as a possible D/F conflict.  This
+		 * will only occur when it exists in stage 2 as a
+		 * file.
+		 */
+		if (S_ISREG(e->stages[2].mode) || S_ISLNK(e->stages[2].mode)) {
+			last_file = path;
+			last_len = len;
+			last_e = e;
+		} else {
+			last_file = NULL;
+		}
+	}
+}
+
 struct rename
 {
 	struct diff_filepair *pair;
@@ -1488,6 +1545,7 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, merge);
 
 		entries = get_unmerged();
+		make_room_for_directories_of_df_conflicts(o, entries);
 		re_head  = get_renames(o, head, common, head, merge, entries);
 		re_merge = get_renames(o, merge, common, head, merge, entries);
 		clean = process_renames(o, re_head, re_merge);
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 7b1ce82..b129f1d 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -83,7 +83,7 @@ test_expect_success 'modify/delete + directory/file conflict' '
 	test -f letters~modify
 '
 
-test_expect_failure 'modify/delete + directory/file conflict; other way' '
+test_expect_success 'modify/delete + directory/file conflict; other way' '
 	git reset --hard &&
 	git clean -f &&
 	git checkout modify^0 &&
-- 
1.7.3.271.g16009
