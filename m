From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/6] WIP: mess only with mark_reachable
Date: Fri, 26 Feb 2016 17:39:44 +0100
Message-ID: <b318af9a93f1d49f4480d63b74fa07d4b605f16b.1456504190.git.git@drmicha.warpmail.net>
References: <cover.1456504190.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 17:40:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLR1-00014b-NZ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbcBZQj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 11:39:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54147 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754786AbcBZQjx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 11:39:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id E0A3120C7F
	for <git@vger.kernel.org>; Fri, 26 Feb 2016 11:39:52 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 26 Feb 2016 11:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=CZv+El28lr7nS7YDwNF32yQ8Tgc
	=; b=XA1E3oMTQBouOJHZieFu4py7nvWUXbmkZvbqEHlx4ClMZVuDm/egsoFVSD4
	H4Xfecjo0IGCFZxtGU4dc4fRZIbRau55l0iPQxe3I5B0Xr1cpeOTnc17dX34Fvig
	fwhv0wrf8851ZoZ1LXlbb0FKsyvYKlJOAtvOKpphXoVuMNfQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=CZv+
	El28lr7nS7YDwNF32yQ8Tgc=; b=bbRGKOnICTCmcO6KVhwuWVNX61LyfrOQbbct
	1bcslo27KcO1pzVvbntDviAabEVc38YODWXg6lrhNB0J+29hAN50bN4FqKBLRTmk
	kPUsGq4DP17AmEsoauxjsiu0eyBRaje4OnpFkxVB3zineG0GGur9NzFlDLlsrS44
	HF3fgHw=
X-Sasl-enc: 3ecoUPXOtnNff1SQ9MhsosErDKRVhP8A1aSfe7kxB/Qp 1456504792
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 891C9C00012;
	Fri, 26 Feb 2016 11:39:52 -0500 (EST)
X-Mailer: git-send-email 2.7.2.618.g7a61b68
In-Reply-To: <cover.1456504190.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287583>

This still messes up gc/prune on an empty repo where the worktree code
can't parse HEAD properly. Bummer. That code sucks for the non-worktree
case.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 reachable.c          |  2 +-
 refs.h               |  1 +
 refs/files-backend.c | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/reachable.c b/reachable.c
index ed35201..15a06a7 100644
--- a/reachable.c
+++ b/reachable.c
@@ -177,7 +177,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	for_each_ref(add_one_ref, revs);
 
 	/* detached HEAD is not included in the list above */
-	head_ref(add_one_ref, revs);
+	head_ref_worktrees(add_one_ref, revs);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/refs.h b/refs.h
index 2f3decb..c9621b4 100644
--- a/refs.h
+++ b/refs.h
@@ -183,6 +183,7 @@ typedef int each_ref_fn(const char *refname,
  * stop the iteration.
  */
 extern int head_ref(each_ref_fn fn, void *cb_data);
+extern int head_ref_worktrees(each_ref_fn fn, void *cb_data);
 extern int for_each_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 extern int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5bdb568..f020c52 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1749,6 +1749,24 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
+	int flag;
+
+	if (submodule) {
+		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
+			return fn("HEAD", &oid, 0, cb_data);
+
+		return 0;
+	}
+
+	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
+		return fn("HEAD", &oid, flag, cb_data);
+
+	return 0;
+}
+
+static int do_head_ref_worktrees(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	struct object_id oid;
 	struct worktree **worktrees;
 	int i, retval;
 
@@ -1775,6 +1793,11 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return do_head_ref(NULL, fn, cb_data);
 }
 
+int head_ref_worktrees(each_ref_fn fn, void *cb_data)
+{
+	return do_head_ref_worktrees(NULL, fn, cb_data);
+}
+
 int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(submodule, fn, cb_data);
-- 
2.7.2.618.g7a61b68
