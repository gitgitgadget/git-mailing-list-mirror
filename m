From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFD/WIP PATCH] rev-list: list all heads with --all
Date: Mon,  9 Nov 2015 16:24:11 +0100
Message-ID: <c224529fd3d2651baa0f9232a842e4ae7dd788cb.1447082178.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 16:24:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvoIv-0007Ro-NW
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 16:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbbKIPYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 10:24:17 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49390 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302AbbKIPYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 10:24:16 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 6F86120451
	for <git@vger.kernel.org>; Mon,  9 Nov 2015 10:24:13 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 09 Nov 2015 10:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=iJXU6n0ER+YkNIRqsSA3+fHfH+s=; b=Zah3fOiFPKgADoqpqJQZgSAdmk2K
	fVah/bQ6Ztf0H+Oileajetqs1FlK3Dsr/PBMvAcM4aEZ9IDhTNVQpF/MJLEExq/d
	ShGjBzyU3XpoqYeiujvVVSDqeECo9oRDDpUfYbnBR8rWSpHDSvNd6E011/j5ILrj
	uK39eJB0ztM2ih0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=iJXU6n0ER+YkNIRqsSA3+fHfH+
	s=; b=AWgckDMhWZRDLCfGtNAUIRMoDYF2Wi9O6L36EzD3vEDCdEjLQte9e1xeS/
	d6FR4nJvPdocap2k9Re3lJuYaLQM0RdI2+BYX1OtUj0qcomcN6r4iUTfl1yV/UhF
	eEwUDzbm9BGUF6gIveTH7HDSqhl9b5r+VU8uH+bJ8UpWR+xcM=
X-Sasl-enc: N1W7LNIzQU5kK5+LzjFRzlx/WIGPo9E51Ra94pT1GfYF 1447082653
Received: from localhost (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 037396800D1;
	Mon,  9 Nov 2015 10:24:12 -0500 (EST)
X-Mailer: git-send-email 2.6.3.507.gca54332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281051>

HEAD is a worktree specific sysmref, so that a repository with multiple
worktrees can have multiple HEADs, or HEADs in a worktree different from
the current worktree.

So far, "rev-parse --all" adds only the HEAD from the current worktree
to the list of refs (besides branches etc.). So, a detached HEAD from a
different checkout would be missed unless a shared ref (or current HEAD)
points to it (or descents from it). As a consequence, "git prune" can
prune detached HEADs from worktrees and leave the repo in an
inconsistent state.

Make "rev-parse --all" add the HEADs from all worktrees. This results in
a non-worktree-specific ref list amd solves the pruning problem.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

This patch solves the pruning problem with worktrees, but I feel quite
uneasy about substituting the ref solving at the very heart of refs.c. So
please consider this a mere poc and a request for discussion/input
about how to do this the right way.

I'll cook up a test in proper form, but all you have to do is "worktree
add --detach new" and build a new commit on top of the detached head in
the new worktree. Compare "git prune -n" in "new" and the main worktree...

In essence, I feel the worktree interface still has to evolve a bit: I'd
rather for_each_worktree than loop myself, and if many call sites need to
be aware of multiple heads or worktrees than get_worktrees() should be
part of our init stuff, not here.

 refs.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index bab92d7..c355171 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@
 #include "tag.h"
 #include "dir.h"
 #include "string-list.h"
+#include "worktree.h"
 
 struct ref_lock {
 	char *ref_name;
@@ -2091,10 +2092,11 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
+static int do_head_refs(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
-	int flag;
+	struct worktree **worktrees;
+	int i, retval;
 
 	if (submodule) {
 		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
@@ -2103,20 +2105,25 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 		return 0;
 	}
 
-	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
-		return fn("HEAD", &oid, flag, cb_data);
+	worktrees = get_worktrees();
+	retval = 0;
+	for (i=0; worktrees[i]; i++) {
+		hashcpy(oid.hash, worktrees[i]->head_sha1);
+		retval = retval || fn("HEAD", &oid, worktrees[i]->is_detached ? 0 : REF_ISSYMREF, cb_data);
+	}
 
-	return 0;
+	free_worktrees(worktrees);
+	return retval;
 }
 
 int head_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_head_ref(NULL, fn, cb_data);
+	return do_head_refs(NULL, fn, cb_data);
 }
 
 int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return do_head_ref(submodule, fn, cb_data);
+	return do_head_refs(submodule, fn, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
-- 
2.6.3.507.gca54332
