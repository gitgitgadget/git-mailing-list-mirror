From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 28/56] merge-recursive: Allow make_room_for_path() to remove D/F entries
Date: Thu, 11 Aug 2011 23:20:01 -0600
Message-ID: <1313126429-17368-29-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBp-00051N-0b
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab1HLFVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:34 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab1HLFVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:30 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eqQMnOev5F8Q6SxpYYiqcmIzo47wz+3DbSIkPOnfvLk=;
        b=FTshRmXssxvW2Mzi9MZHmGN5NygD/d0+aTir5k9CQ7nK7D4DV0SEdRGYi15iMRVXbD
         PYiu2lAn+fH2qHB1LfP9WLBgay1tfjxCT+BbvApXf9YFgeA5jWiGUoLrF87SX/fmzBQz
         n4jrxGv0K/cnIfHUnhohb+P25d2rXXHJs7koo=
Received: by 10.231.224.23 with SMTP id im23mr1138017ibb.35.1313126490621;
        Thu, 11 Aug 2011 22:21:30 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.28
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179179>

If there were several files conflicting below a directory corresponding
to a D/F conflict, and the file of that D/F conflict is in the way, we
want it to be removed.  Since files of D/F conflicts are handled last,
they can be reinstated later and possibly with a new unique name.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1:
  (1) Made use of Johannes' new string-list API to remove items we
      have already checked in order to avoid trying to unlink a path
      more than once
  (2) Moved the comment about removing paths to make room to the
      location where we actually remove the path.
  (3) Fixed a bug with accidentally removing wrong paths (by adding the
        path[df_pathlen] == '/'
      check)

 merge-recursive.c                 |   26 ++++++++++++++++++++++----
 t/t6036-recursive-corner-cases.sh |    2 +-
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c12e4d5..1547691 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -412,7 +412,6 @@ static void record_df_conflict_files(struct merge_options *o,
 		    len > last_len &&
 		    memcmp(path, last_file, last_len) == 0 &&
 		    path[last_len] == '/') {
-			output(o, 3, "Removing %s to make room for subdirectory; may re-add later.", last_file);
 			string_list_insert(&o->df_conflict_file_set, last_file);
 		}
 
@@ -652,11 +651,30 @@ static int would_lose_untracked(const char *path)
 	return !was_tracked(path) && file_exists(path);
 }
 
-static int make_room_for_path(const char *path)
+static int make_room_for_path(struct merge_options *o, const char *path)
 {
-	int status;
+	int status, i;
 	const char *msg = "failed to create path '%s'%s";
 
+	/* Unlink any D/F conflict files that are in the way */
+	for (i = 0; i < o->df_conflict_file_set.nr; i++) {
+		const char *df_path = o->df_conflict_file_set.items[i].string;
+		size_t pathlen = strlen(path);
+		size_t df_pathlen = strlen(df_path);
+		if (df_pathlen < pathlen &&
+		    path[df_pathlen] == '/' &&
+		    strncmp(path, df_path, df_pathlen) == 0) {
+			output(o, 3,
+			       "Removing %s to make room for subdirectory\n",
+			       df_path);
+			unlink(df_path);
+			unsorted_string_list_delete_item(&o->df_conflict_file_set,
+							 i, 0);
+			break;
+		}
+	}
+
+	/* Make sure leading directories are created */
 	status = safe_create_leading_directories_const(path);
 	if (status) {
 		if (status == -3) {
@@ -724,7 +742,7 @@ static void update_file_flags(struct merge_options *o,
 			}
 		}
 
-		if (make_room_for_path(path) < 0) {
+		if (make_room_for_path(o, path) < 0) {
 			update_wd = 0;
 			free(buf);
 			goto update_index;
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index ed6c6f4..279f33c 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -496,7 +496,7 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 	git tag E2
 '
 
-test_expect_failure 'merge of D & E1 fails but has appropriate contents' '
+test_expect_success 'merge of D & E1 fails but has appropriate contents' '
 	get_clean_checkout D^0 &&
 
 	test_must_fail git merge -s recursive E1^0 &&
-- 
1.7.6.100.gac5c1
