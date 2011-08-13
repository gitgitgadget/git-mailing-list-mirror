From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 57/57] merge-recursive: Don't re-sort a list whose order we depend upon
Date: Fri, 12 Aug 2011 20:23:51 -0600
Message-ID: <1313202231-10348-1-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 13 04:24:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs3tH-0002Co-HI
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 04:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab1HMCXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 22:23:54 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47584 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab1HMCXx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 22:23:53 -0400
Received: by gxk21 with SMTP id 21so2361326gxk.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=n8XXdIFdmcMgGJfgsjcL5tOLNmhfCMB4CoQsUgRt90U=;
        b=BgQ0L8PeMffooOjbYYHx7HJ2NJGCc6WkW6Ny0nRDajuP9E95bZR2VPNVPXnKjaxB6/
         wYC7LTXQjBr8bxYUxe4lBI0+2EUdcRVZ0xOM3H1PTZL0hgScjOxGR1BdAR0JvY4oKh2A
         M1Yubjbi/DqzRm0LfD+iDQom13GBS/jRJPl5E=
Received: by 10.150.13.3 with SMTP id 3mr2622451ybm.368.1313202232348;
        Fri, 12 Aug 2011 19:23:52 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id q25sm1757717yhm.48.2011.08.12.19.23.50
        (version=SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 19:23:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.100.g7c63c.dirty
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179267>

In record_df_conflict_files() we would resort the entries list using
df_name_compare to get a convenient ordering.  Unfortunately, this broke
assumptions of the get_renames() code (via string_list_lookup() calls)
which needed the list to be in the standard ordering.  When those lookups
would fail, duplicate stage_data entries could be inserted, causing the
process_renames and process_entry code to fail (in particular, a path that
that process_renames had marked as processed would still be processed
anyway in process_entry due to the duplicate entry).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Really this should just be a fixup commit to patch 23 ("merge-recursive:
Fix sorting order and directory change assumptions"), but that has some
(minor) contextual conflicts, which would require me to resubmit the
whole 50+ patch-series again.  I've already flooded everyone's inboxes
enough, so I just created an extra patch.

 merge-recursive.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 05ba41c..04f3c93 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -402,6 +402,7 @@ static void record_df_conflict_files(struct merge_options *o,
 	 * and the file need to be present, then the D/F file will be
 	 * reinstated with a new unique name at the time it is processed.
 	 */
+	struct string_list df_sorted_entries;
 	const char *last_file = NULL;
 	int last_len = 0;
 	int i;
@@ -414,14 +415,20 @@ static void record_df_conflict_files(struct merge_options *o,
 		return;
 
 	/* Ensure D/F conflicts are adjacent in the entries list. */
-	qsort(entries->items, entries->nr, sizeof(*entries->items),
+	memset(&df_sorted_entries, 0, sizeof(struct string_list));
+	for (i = 0; i < entries->nr; i++) {
+		struct string_list_item *next = &entries->items[i];
+		string_list_append(&df_sorted_entries, next->string)->util =
+				   next->util;
+	}
+	qsort(df_sorted_entries.items, entries->nr, sizeof(*entries->items),
 	      string_list_df_name_compare);
 
 	string_list_clear(&o->df_conflict_file_set, 1);
-	for (i = 0; i < entries->nr; i++) {
-		const char *path = entries->items[i].string;
+	for (i = 0; i < df_sorted_entries.nr; i++) {
+		const char *path = df_sorted_entries.items[i].string;
 		int len = strlen(path);
-		struct stage_data *e = entries->items[i].util;
+		struct stage_data *e = df_sorted_entries.items[i].util;
 
 		/*
 		 * Check if last_file & path correspond to a D/F conflict;
@@ -449,6 +456,7 @@ static void record_df_conflict_files(struct merge_options *o,
 			last_file = NULL;
 		}
 	}
+	string_list_clear(&df_sorted_entries, 0);
 }
 
 struct rename {
-- 
1.7.6.100.g7c63c.dirty
