From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 3/3] merge-recursive: When we detect we can skip an update, actually skip it
Date: Mon, 28 Feb 2011 18:08:52 -0700
Message-ID: <1298941732-19763-4-git-send-email-newren@gmail.com>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 02:09:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuE5P-0004v0-8Z
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 02:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab1CABJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 20:09:06 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58756 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab1CABJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 20:09:03 -0500
Received: by mail-ey0-f174.google.com with SMTP id 24so1504609eyx.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 17:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=5oRk/qDeOHnHtW0soKHycxpzZlyXUI8oIg5Z4tYM9fM=;
        b=FfJDuV2Ssyo5rqkj+9UARKZcxzHPPZ6pp6S8bcTnJQScrozNzPBO1GHTG+mcwCiW2g
         Js22xI3YIPVSf2amv+BW/38YfLPrnPQWS+jVx3Zp0RWp2vZH3R3QzdRN+ddpcXhwWPE3
         +7XI1s4fdUP1ZZUWSyeFfscAKzG5NsZqlRo9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dbuRHpIUiD12Tdx/u4E/GBMCuF+rpqLXeraJgWydeCPg1g9z0BMixJK8p7osSqsu10
         OQndtwCG937vjsFiZ6yidcETf6qdu0VdhSIlC3XFjVqr1Mv2ySpAFiM9oNQQCrfX4My/
         eT53Y7OTE/Hk3SmTI0sdsa9VIHX1BS19LOsM4=
Received: by 10.213.22.6 with SMTP id l6mr2119723ebb.95.1298941742367;
        Mon, 28 Feb 2011 17:09:02 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id q52sm3692922eei.9.2011.02.28.17.08.59
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 17:09:01 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1298941732-19763-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168176>

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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c       |   17 +++++++++++------
 t/t6022-merge-rename.sh |    2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 16c2dbe..ec07a30 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -354,10 +354,11 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
 	 * make room for the corresponding directory.  Such paths will
 	 * later be processed in process_df_entry() at the end.  If
 	 * the corresponding directory ends up being removed by the
-	 * merge, then the file will be reinstated at that time;
-	 * otherwise, if the file is not supposed to be removed by the
-	 * merge, the contents of the file will be placed in another
-	 * unique filename.
+	 * merge, then the file will be reinstated at that time
+	 * (albeit with a different timestamp!); otherwise, if the
+	 * file is not supposed to be removed by the merge, the
+	 * contents of the file will be placed in another unique
+	 * filename.
 	 *
 	 * NOTE: This function relies on the fact that entries for a
 	 * D/F conflict will appear adjacent in the index, with the
@@ -1274,9 +1275,13 @@ static int merge_content(struct merge_options *o,
 	}
 
 	if (mfi.clean && !df_conflict_remains &&
-	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode)
+	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode &&
+	    lstat(path, &st) == 0) {
 		output(o, 3, "Skipped %s (merged same as existing)", path);
-	else
+		add_cacheinfo(mfi.mode, mfi.sha, path,
+			      0 /*stage*/, 1 /*refresh*/, 0 /*options*/);
+		return mfi.clean;
+	} else
 		output(o, 2, "Auto-merging %s", path);
 
 	if (!mfi.clean) {
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index a5d252b..a44117a 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -630,7 +630,7 @@ test_expect_success 'setup avoid unnecessary update, normal rename' '
 	git commit -m "Random, unrelated changes"
 '
 
-test_expect_failure 'avoid unnecessary update, normal rename' '
+test_expect_success 'avoid unnecessary update, normal rename' '
 	git checkout -q avoid-unnecessary-update-1^0 &&
 	touch -t 197001010000.01 rename &&
 	orig=$(stat --format="%Y" rename) &&
-- 
1.7.4
