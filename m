Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60506209A9
	for <e@80x24.org>; Wed, 19 Oct 2016 04:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbcJSEXx (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 00:23:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59374 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750712AbcJSEXv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 00:23:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DC8D47E12;
        Wed, 19 Oct 2016 00:23:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=/hVp
        SPCS45IZjKWOc6hRq1mMrT0=; b=osO0HnrsIFTOoj82Np5Q0HGg4tixpVt+1JBn
        DvMFFQf+vGZr/1XAZWM/NJW6YjdOAgOKPDdOAYKEAUfyA7Dk/hVW0zsuy4OhfX9h
        DyT59PaSx9I4AI0gIvfQjKish9VfO7rUKe/2eeoGGM7K6o/2eVsUeq6z3mFquqbg
        qVpEqsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=B5Sj4D
        iiBIhnKkPtsbQt4I7cfrG1CMLT09Lia8xDM5zPiSsmYLn7M423zPRmwqZvchN465
        2PPV+GpOa9atG3elIs2YQ3fTqEyN1qi8TxiG5rl8jTSr5XYR6QPa+Uv/NcEAzOV0
        3VamjE7ey5ZqGhBDkKU7s/Q4Q08EUjOq/bzno=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 562CF47E11;
        Wed, 19 Oct 2016 00:23:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D25D847E10;
        Wed, 19 Oct 2016 00:23:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/7] commit: simplify fastpath of merge-base computation
Date:   Tue, 18 Oct 2016 21:23:39 -0700
Message-Id: <20161019042345.29766-2-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-631-gb2c64dcf30
In-Reply-To: <20161019042345.29766-1-gitster@pobox.com>
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
 <20161019042345.29766-1-gitster@pobox.com>
X-Pobox-Relay-ID: D5B91AD4-95B3-11E6-AE34-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The get_merge_bases_many*() family of functions first call
merge_bases_many() to find all possible merge bases between a single
commit "one" and a set of other commits "twos[]".  Because this
typically involves traversing the commit graph, which uses the
object flags on the commits involved, the function needs to clear
the flags before it returns.

Except for one special case.  If "one" is exactly one of the "twos",
"one" is the merge base and merge_bases_many() returns a list of
merge bases with a single element, "one", on it, without smudging
the object flags of the commits at all.

We used to use a loop over "twos[]" array to see if this fast-path
would have kicked in in merge_bases_many(), in which case we can
return without cleaning the bits at all.  We can do the same by
inspecting the result in a more direct way, which is conceptually
cleaner.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index aada266f9a..6266c0380c 100644
--- a/commit.c
+++ b/commit.c
@@ -955,10 +955,17 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	int cnt, i;
 
 	result = merge_bases_many(one, n, twos);
-	for (i = 0; i < n; i++) {
-		if (one == twos[i])
-			return result;
-	}
+
+	/*
+	 * The fast-path of 'one' being the merge-base; there is no
+	 * need to clean the object flags in this case.
+	 */
+	if (result && !result->next &&
+	    result->item == one &&
+	    !(one->object.flags & RESULT))
+		return result;
+
+	/* If we didn't get any, or there is only one, we are done */
 	if (!result || !result->next) {
 		if (cleanup) {
 			clear_commit_marks(one, all_flags);
-- 
2.10.1-631-gb2c64dcf30

