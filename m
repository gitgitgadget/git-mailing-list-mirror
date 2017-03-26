Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3338320958
	for <e@80x24.org>; Sun, 26 Mar 2017 23:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbdCZXXI (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 19:23:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64552 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751380AbdCZXXG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 19:23:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A71FA6E3E7;
        Sun, 26 Mar 2017 19:16:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dGuKNpe2qLSRCwVLFG2LzyiN+O8=; b=lAwvJU
        x4hIU05CcAI2WJd/fYHXO3kHkUu8++/HmCC30rjIzAY6zqhVsa6rGjJeBW3ZuUze
        O10qEE48JbqdAdQ3qOgEd0UGvRATedEL+Oq1ArxmQibpjv6F0LB1EhH26q8CKxnD
        mTAuB8PSNn6xDhPcRXQfaHeOwAMMJ+umiJxmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eTcad/sBzkiMXyLHNKr6VtyovmN6xebM
        XhEBEI3EvsDJCqpHm+A50hrv4DXrEUKlkV+1nfa4QMVQPkIFlz2FHgpnXysy69CU
        1W4DT35liP8DishEkMyLMSDcymWFUMbOHwb3HfoA+KsWtviabSVVvQBTRP5rSALl
        uwyBuTM4Cy0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A06566E3E6;
        Sun, 26 Mar 2017 19:16:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16F876E3E5;
        Sun, 26 Mar 2017 19:16:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
        <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
        <20170326061826.yx6nh3k2ps6uyyz6@sigill.intra.peff.net>
Date:   Sun, 26 Mar 2017 16:16:06 -0700
In-Reply-To: <20170326061826.yx6nh3k2ps6uyyz6@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 26 Mar 2017 02:18:26 -0400")
Message-ID: <xmqqinmv4ojt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31551BDE-127A-11E7-A5CA-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 24, 2017 at 11:37:54PM -0700, Junio C Hamano wrote:
>
>> The hash that names a packfile is constructed by sorting all the
>> names of the objects contained in the packfile and running SHA-1
>> hash over it.  I think this MUST be hashed with collision-attack
>> detection.  A malicious site can feed you a packfile that contains
>> objects the site crafts so that the sorted object names would result
>> in a collision-attack, ending up with one pack that contains a sets
>> of objects different from another pack that happens to have the same
>> packname, causing Git to say "Ah, this new pack must have the same
>> set of objects as the pack we already have" and discard it,
>> resulting in lost objects and a corrupt repository with missing
>> objects.
>
> I don't think this case really matters for collision detection. What's
> important is what Git does when it receives a brand-new packfile that
> would overwrite an existing one. It _should_ keep the old one, under the
> usual "existing data wins" rule.

If a malicious site can craft two packfiles that hash to the same,
then it can first feed one against a fetch request, then feed the
other one when a later fetch request comes, and then the later pack
is discarded by the "existing data wins" rule.  Even though this
later pack may have all the objects necessary to complete the refs
this later fetch request asked for, and an earlier pack that
happened to have the same pack trailer hash doesn't have these
necessary objects, the receiver ends up discarding this necessary
pack.  The end result is that the receiver's repository is now
corrupt, lacking some objects.

It is a different matter if such an "attack" is a useful one to
conduct from attacker's point of view. 

I highlighted this case as notable because the way the trailing hash
is also used as the name of packfile makes this fall into the same
category as object hash, in that the hash is used for identification
and deduplication (because we have a rule that says there can be
only one _thing_ that hashes to one value), for which we do want to
use the collision-attack detecting kind of hashing, even though it
otherwise should fall into the other category (i.e. use of csum-file
API to compute trailer hash), where the hash is used merely for
bit-flip detection (we are perfectly OK if you have multiple index
files with different contents that happen to have the same hash in
the trailer, because the hash is not used for identificaiton and
deduplication).
