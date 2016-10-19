Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B514D20988
	for <e@80x24.org>; Wed, 19 Oct 2016 04:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbcJSEX7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 00:23:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60324 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750832AbcJSEX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 00:23:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33EEC47E18;
        Wed, 19 Oct 2016 00:23:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=kuEc
        8pgnWGAG5VsmvKtNQU/YbdU=; b=J7o3kX46z6IK4bbVoZFOVOJJUlz6M2/+K0ei
        nkGCD2s4lqQgkLcXLZrqbeVFQkeHPOO+KRjHldTPKynjTP9B+eai0PVRxLaGqp6f
        yd61FBh8vrhewCWtJW+Qo4RCxRN6sDd3Cz98FYej4I8X45SKQAAwjTMwoIYxenWS
        PXijsJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=dQMSaA
        UaHMnHwc0aKsx2INq7sJ/z2+QriIGiXWb57WXvXy9+v2ZsCaBoY6fv0T0wsBd2qn
        FjCjV8rekjzW6L/Qr6odds0tEf/KoojTRGRoXkJz/sRVixCd1ivEG5XwA4FSYGO8
        3bzL+7GEnJ/mjreqw2fs8osf4A51xAAz7MPs0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B0AC47E17;
        Wed, 19 Oct 2016 00:23:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97C0E47E16;
        Wed, 19 Oct 2016 00:23:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/7] merge-base: stop moving commits around in remove_redundant()
Date:   Tue, 18 Oct 2016 21:23:41 -0700
Message-Id: <20161019042345.29766-4-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-631-gb2c64dcf30
In-Reply-To: <20161019042345.29766-1-gitster@pobox.com>
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
 <20161019042345.29766-1-gitster@pobox.com>
X-Pobox-Relay-ID: D88FCF1E-95B3-11E6-A8EE-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge-base computation is performed in two steps.  First,
paint_down_to_common() traverses the history to find all possible
merge bases (and more), and then remove_redundant() checks the
result and culls the ones that can be reached from another commit
in the result.

The latter received an array of commits, and then returned the same
array after reordering the elements in it, moving the surviving ones
to the front and returning the number of surviving ones.

This arrangement works, but it makes it cumbersome for the callers
when they want to see the array's contents intact (e.g. the caller
may want to keep an additional per-commit data in an independent
array that parallels the array of commits).

Stop moving commits around in the array, and instead mark the ones
that are not merge bases with the STALE bit in their object->flags
bitword.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/commit.c b/commit.c
index 6266c0380c..59bd18e67c 100644
--- a/commit.c
+++ b/commit.c
@@ -888,11 +888,11 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	return ret;
 }
 
-static int remove_redundant(struct commit **array, int cnt)
+static void mark_redundant(struct commit **array, int cnt)
 {
 	/*
 	 * Some commit in the array may be an ancestor of
-	 * another commit.  Move such commit to the end of
+	 * another commit.  Mark such commit as STALE in
 	 * the array, and return the number of commits that
 	 * are independent from each other.
 	 */
@@ -930,18 +930,16 @@ static int remove_redundant(struct commit **array, int cnt)
 		free_commit_list(common);
 	}
 
-	/* Now collect the result */
-	COPY_ARRAY(work, array, cnt);
-	for (i = filled = 0; i < cnt; i++)
-		if (!redundant[i])
-			array[filled++] = work[i];
-	for (j = filled, i = 0; i < cnt; i++)
+	/* Mark the result */
+	for (i = 0; i < cnt; i++)
 		if (redundant[i])
-			array[j++] = work[i];
+			array[i]->object.flags |= STALE;
+		else
+			array[i]->object.flags &= ~STALE;
+
 	free(work);
 	free(redundant);
 	free(filled_index);
-	return filled;
 }
 
 static struct commit_list *get_merge_bases_many_0(struct commit *one,
@@ -984,10 +982,13 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(rslt, cnt);
+	mark_redundant(rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
-		commit_list_insert_by_date(rslt[i], &result);
+		if (!(rslt[i]->object.flags & STALE))
+			commit_list_insert_by_date(rslt[i], &result);
+		else
+			rslt[i]->object.flags &= ~STALE;
 	free(rslt);
 	return result;
 }
@@ -1086,9 +1087,12 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 			p->item->object.flags &= ~STALE;
 		}
 	}
-	num_head = remove_redundant(array, num_head);
+	mark_redundant(array, num_head);
 	for (i = 0; i < num_head; i++)
-		tail = &commit_list_insert(array[i], tail)->next;
+		if (!(array[i]->object.flags & STALE))
+			tail = &commit_list_insert(array[i], tail)->next;
+		else
+			array[i]->object.flags &= ~STALE;
 	return result;
 }
 
-- 
2.10.1-631-gb2c64dcf30

