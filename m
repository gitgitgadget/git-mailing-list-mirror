Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2216DC282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 19:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A3420661
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 19:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jgf+adFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgAJTdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:33:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54435 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgAJTdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 14:33:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAE5F1DF08;
        Fri, 10 Jan 2020 14:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Lez5D+wIonRad3aajUxhmcjWUU=; b=jgf+ad
        FMed9da6jNOoZ6H6Gyg13Gfp2k8Az2q+h4LEzFX7FTVbmdjmpqFMBgL8Wwkld/jb
        N6kkXSn/mldx0IAS1r19Ju+g+fVB/cy7+3Lqu59wu7eBwYfwgS09m0i305SC5lt9
        7KaHS26nCIZcMq+j9+eg+633GBhzgy6C7Rtq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cVHl0Gd6XG7m+WPmKYVlVlBBudyqs/UR
        ytDEF4rBMjE71blbP6M/Rp8NFL24qNWLfvBEmGDVuz6xtsgQ1PzIMJvIvpR2c3DD
        7Nvtl9hNd43OfDnCJ3YdwQmWKdI/43D4jqgbedfIwTOWy23ac5NTIGGUnXqd4vHm
        pVoQBH6cfwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1EC81DF06;
        Fri, 10 Jan 2020 14:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F3B41DF05;
        Fri, 10 Jan 2020 14:33:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] unpack-trees: correctly compute result count
References: <pull.520.git.1578621570180.gitgitgadget@gmail.com>
        <20200110103729.GA470836@coredump.intra.peff.net>
Date:   Fri, 10 Jan 2020 11:33:27 -0800
In-Reply-To: <20200110103729.GA470836@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 10 Jan 2020 05:37:29 -0500")
Message-ID: <xmqqftgnm7i0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1432286E-33E0-11EA-92ED-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jan 10, 2020 at 01:59:30AM +0000, Derrick Stolee via GitGitGadget wrote:
>
>>     Here is a very small fix to the cone-mode pattern-matching in
>>     unpack-trees.c. Johannes found this while running a Coverity scan for
>>     other issues. He alerted me to the problem and I could immediately see 
>>     my error here. In creating this patch, most of my time was spent asking
>>     "how did this work before?" and "why didn't this hurt performance?"
>>     Hopefully my commit message explains this thoroughly enough.
>
> Yes, it makes perfect sense (and as soon as I saw the explanation of the
> problem, my immediate response was also "wait, how did this even work").
>
> And the patch itself looks good.
>
>>     As for making it into the release, I don't know. The change is small, it
>>     has a very limited scope, but this flaw is also not really hurting
>>     anything in a major way.
>
> I could go either way.
>
> This counts as something small and obvious enough that I'd consider
> slipping it in at the last minute if it were fixing a bad bug. But given
> how minor the bug is, being conservative makes sense to me, if only
> because it's good to exercise our release discipline muscles. :)

Heh.

On one hand, it is obvious, even to a mindless compiler, that the
author meant to count how many elements of cache[] array have been
processed in the loop, so it is clear that the patch makes the code
reflect the author's original intention better.

On the other hand, the code that reflects the author's original
intention has never been tested in the field---it could be possible
that the author thought cache[0] thru cache_end[0] have been
processed, but for some subtlety, only a very early part of the
range was correctly processed, and returning smaller range may have
been hiding that subtle bug ;-)

I do not see any such subtle bug in this particular case, so I am
somewhat tempted to say "it is clear that the 'fix' makes the code
do what the author wanted to do, *and* what the author wanted to do
seems sane, so let's apply it".

Having said that, the earlier part of the patch, i.e.

 	if (pl->use_cone_patterns && orig_ret == MATCHED_RECURSIVE) {
 		struct cache_entry **ce = cache;
-		rc = (cache_end - cache) / sizeof(struct cache_entry *);
+		rc = cache_end - cache;
 
 		while (ce < cache_end) {
 			(*ce)->ce_flags &= ~clear_mask;
 			ce++;
 		}

wouldn't have been needed any fix if it were actually *counting*,
which is what clear_ce_flags_dir() promises its callers it does,
instead of cheating with a subtraction. i.e.

	if (... RECURSIVE) {
		rc = 0;
		while (ce < cache_end) {
			clear;
			ce++;
			rc++;
		}
	}

and that may have been more future-proof way, in that the body of
the while loop may in the future decide to leave early etc. and
actually counting how far the processing progressed would be less
error prone.

ALso, the computation of cache_end earlier in the function looks
suspiciously similar to the code Emily recently touched to avoid
segfaulting against inconsistent index state, where it used
the entry count in the cache_tree structure (when it is valid) to
determine how many entries to skip over.  We may want to see if we
can apply the same optimization here.

Thanks.  Will queue but will not merge to 'master' ;-)
