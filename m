From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/2] shallow: Remove unused code
Date: Mon, 06 Jan 2014 00:00:58 +0000
Message-ID: <52C9F23A.40902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 01:01:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzxcy-0001Ex-5L
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 01:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbaAFABC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 19:01:02 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:41445 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751407AbaAFABB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 19:01:01 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id E51A0A64914;
	Mon,  6 Jan 2014 00:00:59 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id B439BA647C2;
	Mon,  6 Jan 2014 00:00:59 +0000 (GMT)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Mon,  6 Jan 2014 00:00:59 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239982>


Commit 58babfff ("shallow.c: the 8 steps to select new commits for
.git/shallow", 05-12-2013) added a function to implement step 5 of
the quoted eight steps, namely 'remove_nonexistent_ours_in_pack()'.
This function implements an optional optimization step in the new
shallow commit selection algorithm. However, this function has no
callers. (The commented out call sites would need to change, in
order to provide information required by the function.)

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

This should, perhaps, be marked as RFC; if the patch to actually
use this function is coming soon, then this is not needed.
However, I suspect it could be slow in coming ... :-P

ATB,
Ramsay Jones

 builtin/receive-pack.c |  1 -
 commit.h               |  2 --
 fetch-pack.c           |  1 -
 shallow.c              | 16 ----------------
 4 files changed, 20 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index de869b5..85bba35 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1059,7 +1059,6 @@ static void update_shallow_info(struct command *commands,
 	struct command *cmd;
 	int *ref_status;
 	remove_nonexistent_theirs_shallow(si);
-	/* XXX remove_nonexistent_ours_in_pack() */
 	if (!si->nr_ours && !si->nr_theirs) {
 		shallow_update = 0;
 		return;
diff --git a/commit.h b/commit.h
index 5507460..30598c6 100644
--- a/commit.h
+++ b/commit.h
@@ -230,8 +230,6 @@ struct shallow_info {
 extern void prepare_shallow_info(struct shallow_info *, struct sha1_array *);
 extern void clear_shallow_info(struct shallow_info *);
 extern void remove_nonexistent_theirs_shallow(struct shallow_info *);
-extern void remove_nonexistent_ours_in_pack(struct shallow_info *,
-					    struct packed_git *);
 extern void assign_shallow_commits_to_refs(struct shallow_info *info,
 					   uint32_t **used,
 					   int *ref_status);
diff --git a/fetch-pack.c b/fetch-pack.c
index 1d0328d..d52de74 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -984,7 +984,6 @@ static void update_shallow(struct fetch_pack_args *args,
 		return;
 
 	remove_nonexistent_theirs_shallow(si);
-	/* XXX remove_nonexistent_ours_in_pack() */
 	if (!si->nr_ours && !si->nr_theirs)
 		return;
 	for (i = 0; i < nr_sought; i++)
diff --git a/shallow.c b/shallow.c
index f48f732..bbc98b5 100644
--- a/shallow.c
+++ b/shallow.c
@@ -358,22 +358,6 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *info)
 	info->nr_theirs = dst;
 }
 
-/* Step 5, remove non-existent ones in "ours" in the pack */
-void remove_nonexistent_ours_in_pack(struct shallow_info *info,
-				     struct packed_git *p)
-{
-	unsigned char (*sha1)[20] = info->shallow->sha1;
-	int i, dst;
-	trace_printf_key(TRACE_KEY, "shallow: remove_nonexistent_ours_in_pack\n");
-	for (i = dst = 0; i < info->nr_ours; i++) {
-		if (i != dst)
-			info->ours[dst] = info->ours[i];
-		if (find_pack_entry_one(sha1[info->ours[i]], p))
-			dst++;
-	}
-	info->nr_ours = dst;
-}
-
 define_commit_slab(ref_bitmap, uint32_t *);
 
 struct paint_info {
-- 
1.8.5
