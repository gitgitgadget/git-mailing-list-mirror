From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Aggressive three-way merge: fix D/F case
Date: Sun, 11 Oct 2009 19:53:47 -0700
Message-ID: <7vaazxnwzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 04:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxB8R-0004Fj-VF
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 04:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZJLCzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 22:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbZJLCzA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 22:55:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbZJLCy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 22:54:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5052D550AF;
	Sun, 11 Oct 2009 22:53:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=1FYd
	kmmyHzl1/D2xGDQrPXSt9Fk=; b=v77BcMGq4o4fuec27LbGsn/FBe9AkS0INYHG
	R6HCthPfiESLxextxU+13ov8kLN49ANsitcqIFt7amf/F1lLl714ao8VZoI+Aub/
	2+gpLJk2OJxw16IZHoyzL8K4uvgihx5b0AmVCjuk7B7ZCCRKKXE5VKzEvAKwNBTn
	ezTtI5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=HGO
	KzTk8oclcOwYYonCWv1wmSBBHZqA14Q8kMV1SzvDUtLblmpV0/xkWmVIXuf52p9C
	DtRfILGWXdomyrjko49kZ+3KYW+kshTZszKvUVJYai3ZN0Py4PAsUwCE68sfE5Zs
	MHjU6LE9EDmGjKHheQnXtB9PlpBGpCjiF6j9Qtz8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E080550AE;
	Sun, 11 Oct 2009 22:53:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 924C8550AD; Sun, 11 Oct
 2009 22:53:48 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7820CA08-B6DA-11DE-AEA4-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129970>

When the ancestor used to have a blob "P", your tree removed it, and the
tree you are merging with also removed it, the agressive three-way cleanly
merges to remove that blob.  If the other tree added a new blob "P/Q"
while removing "P", it should also merge cleanly to remove "P" and create
"P/Q" (since neither the ancestor nor your tree could have had it, so it
is a typical "created in one").

The "aggressive" rule is not new anymore.  Reword the stale comment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This fixes one problem in the 3-way merge with corrected tree/index
   entry order the jc/fix-tree-walk topic exposes.

 t/t6035-merge-dir-to-symlink.sh |    2 +-
 unpack-trees.c                  |   13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index b9a280e..d1b2287 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -74,7 +74,7 @@ test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
 	git tag test2
 '
 
-test_expect_failure 'merge should not have conflicts (resolve)' '
+test_expect_success 'merge should not have conflicts (resolve)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s resolve test2 &&
diff --git a/unpack-trees.c b/unpack-trees.c
index c424bab..ec12341 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -767,7 +767,8 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 		remote = NULL;
 	}
 
-	/* First, if there's a #16 situation, note that to prevent #13
+	/*
+	 * First, if there's a #16 situation, note that to prevent #13
 	 * and #14.
 	 */
 	if (!same(remote, head)) {
@@ -781,7 +782,8 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 		}
 	}
 
-	/* We start with cases where the index is allowed to match
+	/*
+	 * We start with cases where the index is allowed to match
 	 * something other than the head: #14(ALT) and #2ALT, where it
 	 * is permitted to match the result instead.
 	 */
@@ -811,12 +813,13 @@ int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 	if (!head && !remote && any_anc_missing)
 		return 0;
 
-	/* Under the new "aggressive" rule, we resolve mostly trivial
+	/*
+	 * Under the "aggressive" rule, we resolve mostly trivial
 	 * cases that we historically had git-merge-one-file resolve.
 	 */
 	if (o->aggressive) {
-		int head_deleted = !head && !df_conflict_head;
-		int remote_deleted = !remote && !df_conflict_remote;
+		int head_deleted = !head;
+		int remote_deleted = !remote;
 		struct cache_entry *ce = NULL;
 
 		if (index)
-- 
1.6.5.59.g7e3f2
