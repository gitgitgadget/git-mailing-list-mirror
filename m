Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C132C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3C422240
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lDitx5IW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbgJOQY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:24:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56393 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbgJOQY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:24:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E6C686776;
        Thu, 15 Oct 2020 12:24:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XKco8axdHw04qw+/2Y8B++uumVI=; b=lDitx5
        IWrittd20Sr6a8ZUmTUr5z8W1FzTz+JzZjh4AYjaLIzDMlZ/K4rc16y2FpsxYnKp
        ZBD3t7gqPL7LI7Vo6I9G24X/dkzlcFJ0mdbQVAaWDlaH2SEIyMAl+fK8lv9Gw2dN
        NpaAhyY/5PES5qXMNChJLGWblT52ODGIgYau8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vrJKc9eBH4WUhXQ0iMcYTOSC20CvZVc9
        wtT7ZKH99Qgcvu/bgNRznb7zsxcq6/mU1MX+BRCIbj8Glb6mu++F9xsSPh/g6Wn/
        76Y0wtuMUbPwMEIo7QxB/6Tq3cw4dyVvy1IbPaM2y4HYPMI2capiYBW/Zc+VwTzo
        JUDZ+GybrVU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8695F86774;
        Thu, 15 Oct 2020 12:24:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E18E86772;
        Thu, 15 Oct 2020 12:24:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Sean McAllister <smcallis@google.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
References: <20201013191729.2524700-1-smcallis@google.com>
        <20201013191729.2524700-3-smcallis@google.com>
        <20201013211453.GB3678071@coredump.intra.peff.net>
        <CAM4o00eCKP1+f=xBw4LJfNqrstEnutAe9StxknW9qLMtPBdhKQ@mail.gmail.com>
        <CAM4o00fO++JMNdES03JKRyxmZtiLjkrJ2nux0-TZYBdH2+0ijA@mail.gmail.com>
        <20201014193456.GA365553@coredump.intra.peff.net>
        <CAM4o00eZjr2apH6WO-sTvuOfR-cuiSh1yhh3j=14ZFstXDz7bA@mail.gmail.com>
        <20201015000410.GB328643@google.com>
Date:   Thu, 15 Oct 2020 09:24:53 -0700
In-Reply-To: <20201015000410.GB328643@google.com> (Jonathan Nieder's message
        of "Wed, 14 Oct 2020 17:04:10 -0700")
Message-ID: <xmqqsgafh2y2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5101190-0F02-11EB-8E9E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I see.  With Peff's proposal, the backend service could still set
> Retry-After, and *modern* machines with new enough libcurl would still
> respect it, but older machines[*] would have to use some fallback
> behavior.
>
> I suppose that fallback behavior could be to not retry at all.

Yup, that is a quite attractive approach.  We'll let the passage of
time work for us.
