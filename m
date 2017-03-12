Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6350A202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 18:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934821AbdCLSDt (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 14:03:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56746 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934670AbdCLSDr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 14:03:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E8138599B;
        Sun, 12 Mar 2017 14:03:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uCl3skxBkXsXkKAicApRpHEfbSI=; b=HrD7pr
        xhIa3/w0jkz9pj1Z9LbcaxJx02hTzxzhYW9W5XoKaMghPYO7k8biPmaptOiaNCEA
        8GlcLKt3riYtGV0W/+ttsf/FE4MsDBEyVKNPw7xpBjBMmMhCvlJjcoxQh2eyb2lf
        tMag2sgWmpS7W7B/E6pvIjM9f6VIQXYWfulEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wGadGP4n9c3m6CoAfD7CkQeYeWmgc7SQ
        j1NVg61dxjwtwvsCpkwFtdmIxfTzGuE+rDoxglv9ugnGrIB/izRFiHn1YxXH+xKQ
        IHMBithLeWxXp+DFqRXdbiMunQFfyrA1RhDPOJFx5gH+jG4X9YIdaosx9UYMf5MA
        Ml9bCL4ylLI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 686EE8599A;
        Sun, 12 Mar 2017 14:03:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9EED85999;
        Sun, 12 Mar 2017 14:03:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     James Melvin <jmelvin@codeaurora.org>, git@vger.kernel.org,
        nasserg@codeaurora.org, mfick@codeaurora.org, sbeller@google.com
Subject: Re: [PATCH v2] repack: Add option to preserve and prune old pack files
References: <20170310220020.2666-1-jmelvin@codeaurora.org>
        <xmqqmvcswvdc.fsf@gitster.mtv.corp.google.com>
        <20170312122418.e544nrmqniycqouc@sigill.intra.peff.net>
Date:   Sun, 12 Mar 2017 11:03:44 -0700
In-Reply-To: <20170312122418.e544nrmqniycqouc@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 12 Mar 2017 08:24:18 -0400")
Message-ID: <xmqqbmt6v0cf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C5389C6-074E-11E7-9364-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I can think of one downside of a time-based solution, though: if you run
> multiple gc's during the time period, you may end up using a lot of disk
> space (one repo's worth per gc). But that's a fundamental tension in the
> problem space; the whole point is to waste disk to keep helping old
> processes.

Yes.  If you want to help a process that mmap's a packfile and wants
to keep using it for N seconds, no matter how many times somebody
else ran "git repack" while you are doing your work within that
timeframe, you somehow need to make sure the NFS server knows the
file is still in use for that N seconds.

> But you may want a knob that lets you slide between those two
> things. For instance, if you kept a sliding window of N sets of
> preserved packs, and ejected from one end of the window (regardless of
> time), while inserting into the other end. James' existing patch is that
> same strategy with a hardcoded window of "1".

Again, yes.  But then the user does not get any guarantee of how
long-living a process the user can have without getting broken by
the NFS server losing track of a packfile that is still in use.  My
suggestion for the "expiry" based approach is essentially that I do
not see a useful tradeoff afforded by having such a knob.

> The other variable you can manipulate is whether to gc in the first
> place. E.g., don't gc if there are N preserved sets (or sets consuming
> more than N bytes, or whatever). You could do that check outside of git
> entirely (or in an auto-gc hook, if you're using it).

Yes, "don't gc/repack more than once within N seconds" may also be
an alternative and may generally be more useful by covering general
source of wastage coming from doing gc too frequently, not necessarily
limited to preserved pack accumulation.


