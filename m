Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCD7C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AC522243
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pDNp1OSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgJOReN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:34:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58083 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgJOReN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:34:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 473498896E;
        Thu, 15 Oct 2020 13:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ki5F+Icab4wOj6+EcvwXZEOqWR8=; b=pDNp1O
        SS2pj0u53j2ek9u8Cp45Jg2ZzswegH7mji4t+DDvO+DMFWq6YIpIbGsGt8+hIiJS
        Po9yKoWE15Ep73rXn9Xns8FuQ2AtQ81HBAp5yzdjchK1c8i6LNdtbLC7jKqX6SG0
        bt8d2Reozk32Dmek2GU5MEKYRVvWb4Oup2Bes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c3cSq8ULSHCQf0OFSBzPD0aNfCrfjCul
        rMIC+MyG31/s7MDAG4DmkHQjHA0S6+A95keH+FbfOW8miK31rit6Zk2vdJkJq+Nt
        k+ujsAwYCUlzNVm599QaU/jdZVdA53LaoRGWe6eGkLutTQ8l3VlqOdeUfm2BIZFW
        dHDucHIuy+s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D7758896D;
        Thu, 15 Oct 2020 13:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 710398896C;
        Thu, 15 Oct 2020 13:34:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
        <20201015012636.GA387901@coredump.intra.peff.net>
        <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
        <20201015153849.GA551964@coredump.intra.peff.net>
        <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
Date:   Thu, 15 Oct 2020 10:34:07 -0700
In-Reply-To: <xmqqzh4nfldw.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 15 Oct 2020 10:29:31 -0700")
Message-ID: <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A28595B2-0F0C-11EB-93B6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Why does this vaguely look familiar, I wonder.  I can swear that we
> saw a breakage due to a similar pattern that attempts to convert a
> global to an arg that is passed down to the callchain but not doing
> so fully.

Are we revisiting this thread?

https://lore.kernel.org/git/xmqqtuzlld1d.fsf@gitster.c.googlers.com/

I wonder what happend to the thread at the end ...

> Anyway, the diagnoses above look correct and cleanly described.
>
> Will queue.  Thanks.
