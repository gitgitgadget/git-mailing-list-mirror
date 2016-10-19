Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B370020988
	for <e@80x24.org>; Wed, 19 Oct 2016 04:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbcJSEYF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 00:24:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62323 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751082AbcJSEYA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 00:24:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 290AF47E27;
        Wed, 19 Oct 2016 00:24:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=sA3E
        7Hws1BZEa3+vpo7NI0k5Un0=; b=Lm860OMZDsFkjH2KxCAxxpZqYnGbnCKNyNl4
        MaRIHXrQGkrjipcSBorK3Qyb1OEm1rc9g3mWPRUuEvJ3hMiCP41wUT7ljRYICaQQ
        /Nzx/5K/H5EP047QBFI0DD4oa4PFrEcvzsKApXUEW69BSOKMVIFdq4RIS5wHz/RZ
        66ZT6P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=UY1pcP
        FjPmbadOlEo6nEUF4h0uqgl+rsSkf9F2GAgXTyn14pMVuTqX7XvB5umY5A0fdzvw
        X1ZYdK/TUYaSwuCMZpuVvJsJGwkIEKx4DkqXAkeOrdbhPwOfwWJ6TcySeSOhFfrw
        RcdJ8gwUBazp9tsuzZgq6rQ0/lUVodeQWfmC4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 210E447E24;
        Wed, 19 Oct 2016 00:24:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A31B47E22;
        Wed, 19 Oct 2016 00:23:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/7] merge-base: mark bases that are on first-parent chain
Date:   Tue, 18 Oct 2016 21:23:43 -0700
Message-Id: <20161019042345.29766-6-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-631-gb2c64dcf30
In-Reply-To: <20161019042345.29766-1-gitster@pobox.com>
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
 <20161019042345.29766-1-gitster@pobox.com>
X-Pobox-Relay-ID: DB5AF87C-95B3-11E6-9844-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a workflow where topic branches are first merged to the 'next'
integration branch to be tested before getting merged down to the
'master' integration branch to be consumed by the end users, merging
the 'master' branch back to the 'next' happens after topics graduate
to 'master' and release notes entries are written for them.

Git finds many merge bases between 'master' and 'next' while
creating this merge.  In addition to the tip of 'master' back when
we made such a merge back from 'master' to 'next' was made the last
time, which is the most reasonable merge base to explain the
histories of both branches, all the tips of topic branches that
graduated recently are merge bases.  Because these tips of topic
branches were already in 'next', the tip of 'next' reaches them, and
because they just graduated to 'master', the tip of 'master' reaches
them, too.  And these topics are independent most of the time (that
is the point of employing the topic-branch workflow), so they cannot
be reduced.

The merge-recursive machinery is very inefficient to compute this
merge, because it needs to create pointless virtual merge-base
commits across these many merge bases.  Conceptually, the point
where the histories of 'master' and 'next' diverged was the tip of
'master' back when we created such a merge back from 'master' to
'next' the last time, and in practice that is the only merge base
that matters.

Update the logic in paint_down_to_common() so that it can mark if a
merge-base commit was reached by following the first-parent chain of
either side of the merge to find such commit, and give an option to
get_merge_bases_opt() to return only merge-base commits that are on
the first-parent chain, so that a later step of this series can
introduce a command line option to enable it and avoid feeding
useless merge bases to the merge machinery.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 17 +++++++++++++++--
 commit.h |  1 +
 object.h |  2 +-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 92d23b1082..8e90531b05 100644
--- a/commit.c
+++ b/commit.c
@@ -765,8 +765,9 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 #define PARENT2		(1u<<17)
 #define STALE		(1u<<18)
 #define RESULT		(1u<<19)
+#define FPCHAIN		(1u<<20)
 
-static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
+static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT | FPCHAIN);
 
 static int queue_has_nonstale(struct prio_queue *queue)
 {
@@ -802,6 +803,7 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
 		struct commit *commit = prio_queue_get(&queue);
 		struct commit_list *parents;
 		int flags;
+		int nth_parent = 0;
 
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags == (PARENT1 | PARENT2)) {
@@ -816,11 +818,14 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
 		while (parents) {
 			struct commit *p = parents->item;
 			parents = parents->next;
+			nth_parent++;
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (parse_commit(p))
 				return NULL;
 			p->object.flags |= flags;
+			if (nth_parent == 1)
+				p->object.flags |= FPCHAIN;
 			prio_queue_put(&queue, p);
 		}
 	}
@@ -951,6 +956,8 @@ struct commit_list *get_merge_bases_opt(struct commit *one,
 	struct commit_list *result;
 	int cnt, i;
 	int cleanup = !!(flags & MB_POSTCLEAN);
+	int fpchain = !!(flags & MB_FPCHAIN);
+	char *on_fpchain;
 
 	result = merge_bases_many(one, n, twos);
 
@@ -975,21 +982,27 @@ struct commit_list *get_merge_bases_opt(struct commit *one,
 	/* There are more than one */
 	cnt = commit_list_count(result);
 	rslt = xcalloc(cnt, sizeof(*rslt));
+	on_fpchain = xcalloc(cnt, sizeof(*on_fpchain));
 	for (list = result, i = 0; list; list = list->next)
 		rslt[i++] = list->item;
 	free_commit_list(result);
 
+	for (i = 0; i < cnt; i++)
+		on_fpchain[i] = !!(rslt[i]->object.flags & FPCHAIN);
+
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
 	mark_redundant(rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
-		if (!(rslt[i]->object.flags & STALE))
+		if (!(rslt[i]->object.flags & STALE) &&
+		    (!fpchain || on_fpchain[i]))
 			commit_list_insert_by_date(rslt[i], &result);
 		else
 			rslt[i]->object.flags &= ~STALE;
 	free(rslt);
+	free(on_fpchain);
 	return result;
 }
 
diff --git a/commit.h b/commit.h
index 557f2814b7..ec6e09a985 100644
--- a/commit.h
+++ b/commit.h
@@ -254,6 +254,7 @@ extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struc
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 #define MB_POSTCLEAN 01
+#define MB_FPCHAIN 02
 extern struct commit_list *get_merge_bases_opt(struct commit *one, int n, struct commit **twos, unsigned flags);
 
 #define get_merge_bases_many_dirty(one, n, twos) get_merge_bases_opt((one),(n),(twos),MB_POSTCLEAN)
diff --git a/object.h b/object.h
index f8e218eccd..7e6729158a 100644
--- a/object.h
+++ b/object.h
@@ -36,7 +36,7 @@ struct object_array {
  * bisect.c:                               16
  * bundle.c:                               16
  * http-push.c:                            16-----19
- * commit.c:                               16-----19
+ * commit.c:                               16-------20
  */
 #define FLAG_BITS  27
 
-- 
2.10.1-631-gb2c64dcf30

