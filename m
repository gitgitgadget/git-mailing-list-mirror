Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725ED1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 19:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbcK1TB7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 14:01:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63237 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750971AbcK1TB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 14:01:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 248C8540DA;
        Mon, 28 Nov 2016 13:59:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HVGOTlFlvoLOPCe3Uggi00KYzdc=; b=PZf0ZL
        I4FdoREsZAvkTh879nMQJV45feX00+4E3LOvxgDnkXiXRWJukQWNF0d/ZLXTv2Vo
        ktqIne/FPb04jRDtfz9zvT9Xcq8ZIoXt9J9Rit+1vsy/5sT4g0AJcEzEzlGijH2R
        7YFzYYK9yeFgNPXBxHKEpxZvn0YxHyKx34IRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TPUA9yO8OHPZbp0UBIewBjsqng3qpNEE
        2VNLmxzeSe0GLz0c5aySoTtZOJAZlSGVzDn+kbEih1mLeonVyaJ/sLisL077tEWN
        SegKJfotoPApwekSPM4uTYznoUIGC+ZRHKvgD2S1nbGcDZHvB5pupiX9BK0tmGzC
        sgF1qVp3u4Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19A70540D9;
        Mon, 28 Nov 2016 13:59:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 858A5540D7;
        Mon, 28 Nov 2016 13:59:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Markus Klein <markus.klein@reelworx.at>
Subject: Re: [PATCH v2 2/2] Avoid a segmentation fault with renaming merges
References: <cover.1480091758.git.johannes.schindelin@gmx.de>
        <cover.1480164459.git.johannes.schindelin@gmx.de>
        <d1571a25e8f3860a2867b00994d4d6938aa602ec.1480164459.git.johannes.schindelin@gmx.de>
        <alpine.DEB.2.20.1611261348420.117539@virtualbox>
        <xmqqmvgjjvk5.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 28 Nov 2016 10:59:49 -0800
In-Reply-To: <xmqqmvgjjvk5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 28 Nov 2016 10:42:02 -0800")
Message-ID: <xmqqinr7juqi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6DBFDCE-B59C-11E6-8280-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Looking at the commit you blamed, what happened in this case before
> that change was that
>
>  (1) make_cache_entry() would have called refresh_cache_entry() with
>      CE_MATCH_REFRESH and returned a NULL;
>
>  (2) merge-recursive.c::add_cacheinfo() noticed NULL and did
>
>      return error(_("addinfo_cache failed for path '%s'"), path)
>
> But the updated code forgot that refresh_cache_entry() could return
> NULL.  So 1335d76e45 ("merge: avoid "safer crlf" during recording of
> merge results", 2016-07-08) was not a faithful rewrite.

I'd tentatively queue the two patches fro you on top of the
jc/renormalize-merge-kill-safer-crlf topic that ends at 1335d76e45
("merge: avoid "safer crlf" during recording of merge results",
2016-07-08).  The real "fix" became like this with the above
analysis.  Semantic adjustment "error(" -> "err(o," between the old
codebase and the current one will be handled when merging.

Thanks for catching my incorrect refactoring.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 26 Nov 2016 13:48:06 +0100
Subject: [PATCH] merge-recursive: handle NULL in add_cacheinfo() correctly

1335d76e45 ("merge: avoid "safer crlf" during recording of merge
results", 2016-07-08) tried to split make_cache_entry() call made
with CE_MATCH_REFRESH into a call to make_cache_entry() without one,
followed by a call to add_cache_entry(), refresh_cache() and another
add_cache_entry() as needed.  However the conversion was botched in
that it forgot that refresh_cache() can return NULL, which was handled
correctly in make_cache_entry() but not in the updated code.

This fixes https://github.com/git-for-windows/git/issues/952

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c             | 2 ++
 t/t3501-revert-cherry-pick.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index de37e5153c..56385d4c01 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -213,6 +213,8 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 		struct cache_entry *nce;
 
 		nce = refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
+		if (!nce)
+			return error(_("addinfo_cache failed for path '%s'"), path);
 		if (nce != ce)
 			ret = add_cache_entry(nce, options);
 	}
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 5bef564ff1..22970d2223 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with arguments' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'cherry-pick works with dirty renamed file' '
+test_expect_success 'cherry-pick works with dirty renamed file' '
 	test_commit to-rename &&
 	git checkout -b unrelated &&
 	test_commit unrelated &&
-- 
2.11.0-rc3-172-gc8d0e450d3

