From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFD 3/6] rev-list: list all heads with --all
Date: Fri, 26 Feb 2016 17:39:43 +0100
Message-ID: <61d93b0aba1d4cb7348066db0b48f1ce2d5b35c5.1456504190.git.git@drmicha.warpmail.net>
References: <cover.1456504190.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 17:40:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLR0-00014b-Uh
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:40:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbcBZQj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 11:39:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54597 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754632AbcBZQjw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 11:39:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id AECA420C91
	for <git@vger.kernel.org>; Fri, 26 Feb 2016 11:39:51 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 26 Feb 2016 11:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=XbZwcY1zifJ9NdPO58O+iJZQtE0
	=; b=XPI8D/PoGUEktzng+aVn/fByTRgcdtl6gJ8OB8tM9bck5WvZcZlmoI8cvcn
	GQ+9o8S/7dEoup28oJ1oWcL2/zvFlMPV7XITN2vuwqzZ5Pw/k344C0KrA27dKdjo
	+CTMNeREJFu5AENgH/+Txfa9J8/82uLvYmhuQ5VrNLPwLRKw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=XbZw
	cY1zifJ9NdPO58O+iJZQtE0=; b=U0/vQjY+kt9tLjnXiPKyrv9RbMIafNM9F2uo
	aG0daSnu9ZwafUm3YSR9dbTCB/btunFKA6mJTp70ycrST2EfXKxaZm93OOsrOy+q
	g9YdM5eRd6mFgrdDKN6Gwo8PPOM92+xTWCfUT+EdVSTWfOKHx2lr75ItEya8Z9k1
	55tkK+s=
X-Sasl-enc: 4CFbWYoUdlWVQIr5dkwxsD7ssQ41ETNDknBcJtXJekU1 1456504791
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4F4B3680180;
	Fri, 26 Feb 2016 11:39:51 -0500 (EST)
X-Mailer: git-send-email 2.7.2.618.g7a61b68
In-Reply-To: <cover.1456504190.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287584>

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
a non-worktree-specific ref list and solves the pruning problem.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    This patch solves the pruning problem with worktrees, but I feel quite
    uneasy about substituting the ref solving at the very heart of refs.c. So
    please consider this a mere poc and a request for discussion/input
    about how to do this the right way.
    
    In essence, I feel the worktree interface still has to evolve a bit: I'd
    rather for_each_worktree than loop myself, and if many call sites need to
    be aware of multiple heads or worktrees than get_worktrees() should be
    part of our init stuff, not here. [I may be out of sync of newer progress.]

 refs/files-backend.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 81f68f8..5bdb568 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4,6 +4,7 @@
 #include "../lockfile.h"
 #include "../object.h"
 #include "../dir.h"
+#include "../worktree.h"
 
 struct ref_lock {
 	char *ref_name;
@@ -1748,7 +1749,8 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
-	int flag;
+	struct worktree **worktrees;
+	int i, retval;
 
 	if (submodule) {
 		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
@@ -1757,10 +1759,15 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
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
-- 
2.7.2.618.g7a61b68
