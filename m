Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2DF1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 02:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfKKCBR (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 21:01:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64754 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfKKCBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 21:01:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F02736C2A;
        Sun, 10 Nov 2019 21:01:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=duU7oOC2hD0Ha/MZfEnYn34mn1Q=; b=nu2ZXO
        m1cWzTAKzgc3WrfTAxN4e2+5jfqN37hBeiZl9PPr1bWCD1wcA/s7UGmCJDSvPn8z
        s/EbR+E5avsbpcrd4AaWRHdsx83zjJ4bq8quMcWsGX4VAxFHpaCHEVouE+L0Dz5S
        CcKp5+CDRdLKLKo0uT62GotLa4nJakTg0cujs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ncra/ynJeVcSOVTqyXEHwwk8SpqBsu/j
        0tUdPoBh186egE5Pkuu11NIYVzL4yON7Wjh7Z4KPBsHULdGrjruhGieiaam8etgW
        UhOsnIOGARxAP+DMfmmhPScQcMNMR930x5grj3D/0Pdkyl3njPYgqgiyHcWQeCTf
        II9/h0DnOFU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 669F236C29;
        Sun, 10 Nov 2019 21:01:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB5CE36C28;
        Sun, 10 Nov 2019 21:01:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>,
        William Baker <William.Baker@microsoft.com>
Cc:     git@vger.kernel.org, Utsav Shah <ukshah2@illinois.edu>
Subject: Re: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
        <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 11 Nov 2019 11:01:09 +0900
In-Reply-To: <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 11 Nov 2019 10:43:53 +0900")
Message-ID: <xmqqa793jhne.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21FA3E48-0427-11EA-8C3A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> At the very least, this patch mitigates an over-eager check for split index
>> users while maintaining good invariants for the standard case.
>
> OK, it sounds more like this "it does not make any sense to compare
> the position in the fsmonitor bitmap (which covers the entire thing)
> with the position in just a split part of the index (which covers
> only the delta over the base index)"?  If that is the case, it means
> that the "check" is even worse than being "over-eager"---it simply
> is not correct.

Having said all that, I wonder if we are doing the right thing with
or without 3444ec2e ("fsmonitor: don't fill bitmap with entries to
be removed", 2019-10-11) in the split-index mode in the first place.

The fact that your "loosen the check and allow 'pos' that identifies
a tracked path used by the fsmonitor bitmap to be larger than the
size of the istate->cache[]" patch under discussion is needed is
that 'pos' may sometimes be larger than isate->cache[] no?  Then
what happens in this hunk, for example?

diff --git a/fsmonitor.c b/fsmonitor.c
index 231e83a94d..1f4aa1b150 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -14,8 +14,13 @@ struct trace_key trace_fsmonitor = TRACE_KEY_INIT(FSMONITOR);
 static void fsmonitor_ewah_callback(size_t pos, void *is)
 {
 	struct index_state *istate = (struct index_state *)is;
-	struct cache_entry *ce = istate->cache[pos];
+	struct cache_entry *ce;
 
+	if (pos >= istate->cache_nr)
+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
+		    (uintmax_t)pos, istate->cache_nr);
+
+	ce = istate->cache[pos];
 	ce->ce_flags &= ~CE_FSMONITOR_VALID;

The istate->cache[] is a dynamic array whose size is managed via the
usual ALLOC_GROW() using istate->cache_nr and istate->cache_alloc,
whether the split-index feature is in use.  When your patch makes a
difference, then, doesn't the access to istate->cache[] pick up a
random garbage and then flip the bit?

Puzzled...  In any case, "check is worse than over-eager, it simply
is wrong" I wrote in the message I am responding to is totally
incorrect, it seems.  It smells like lifting the check would just
hide the underlying problem under the rug?

