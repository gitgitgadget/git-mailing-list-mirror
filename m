Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B875C433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 23:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D852070B
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 23:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cjTkD47r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGXXHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:07:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54005 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgGXXHj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 19:07:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E300987FD3;
        Fri, 24 Jul 2020 19:07:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kSsr4wjQFn5MsaZoVFLRz4ESWG4=; b=cjTkD4
        7rg151cpMOyfT2265AQ9mcVIIIZTroQgWrinCtbs1q5fTWUtpIlt6IcRzOxUidR8
        gcv/WgjoN6cYPrRHuxGcxviRCazB1tro+FqCRaIhOEs3I4xqvETVrH1w7ipNiM79
        jYNrMJLyE4FpL1OMrNNi1JJz6lKYYsdGPg4aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qWGVZMOrpxULbmrQb8MRcNc/Kxsw8OgK
        VnExTk3udKOp9fjqX/MSCwd1ahyAXY0ojKP/6SihX/eww43qDlo8iVGwh0ENEAZ3
        dC+ulKOutmrRrn8ePRWfeKAPq01gJGHiSk96adEwm+KRp7WR62Wt+Ka3QvDo3Sxo
        EPmA+JCZjtE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAE8C87FD2;
        Fri, 24 Jul 2020 19:07:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6433687FD1;
        Fri, 24 Jul 2020 19:07:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
References: <20200724223844.2723397-1-jonathantanmy@google.com>
Date:   Fri, 24 Jul 2020 16:07:35 -0700
In-Reply-To: <20200724223844.2723397-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 24 Jul 2020 15:38:44 -0700")
Message-ID: <xmqqblk4jyvc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76A8B406-CE02-11EA-90F6-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> We've had a few instances where a lazy fetch in a partial clone fails,
> leading to a fatal error, when the calling code could have easily
> recovered - in other words, the severity of the bug should have just a
> wasted fetch instead of stopping the whole command. Part of the issue
> (and possibly the whole issue - I haven't looked at this beyond
> fetch-pack yet) is that fetch-pack dies whenever it encounters an
> error, so I took a look at fixing that.
>
> (Note that fetch-pack is sometimes run through a remote helper, meaning
> that we could leave the die() invocations in and just make sure that we
> handle failure in the separate process correctly. But when the promisor
> remote is HTTP protocol v2 or SSH protocol v0/v2, this is not true -
> fetch_pack() is run in-process.)

That is easily fixable ;-)  After all, we are talking about network
latency once we "lazily fetch" during a main operation, so why not
take advantage of the isolation that the operating system gives us?

> I think the best way for easy authorship and review is to convert each
> possibly-dying function into a function that either returns a
> possibly-null error string or returns success/failure and writes the
> error string into an "out" parameter.

Ugly.
