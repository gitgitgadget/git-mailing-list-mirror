Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6966AC388F9
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 22:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DCD221EB
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 22:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d1vtReZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgJ3Wb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 18:31:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61679 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgJ3Wb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 18:31:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF7AE8A49B;
        Fri, 30 Oct 2020 18:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yc/8RpiAEVI3pP0lDt8Py19OW3g=; b=d1vtRe
        ZmQ8PaFWBv6lMSr85aC/8ybApeG+dTH3XAXIytGupbOlyCK9+pUbfWD5cpHShyjV
        Z0tLZD94xWI9vqmhyWwnVHIXEfrAw6tqB1wnyr1f/XRQe+Zc7sU7GoIbYdDe73FE
        wCJ0GfT8e1bTj1LhRoI1qzY5af5j4cNyen3Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BnIZt+0SHo64rgAx3brOcyXpW85KZZeH
        UvvXpXzHMac3CdvAwBRQa/WU+qXB0/G96knK7IQN6FlcCOCapAMow7KvZY/m+OWh
        RAeEUAN5KT5jpaI1MkoSYf0x9RU+j5U8WNaHi9QHAcsgQldvCOL7w2gftMcWpPp3
        a4V0Ts5WLX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3DBC8A49A;
        Fri, 30 Oct 2020 18:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A0028A498;
        Fri, 30 Oct 2020 18:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/10] Advertise trace2 SID in protocol capabilities
References: <cover.1604006121.git.steadmon@google.com>
Date:   Fri, 30 Oct 2020 15:31:25 -0700
In-Reply-To: <cover.1604006121.git.steadmon@google.com> (Josh Steadmon's
        message of "Thu, 29 Oct 2020 14:32:30 -0700")
Message-ID: <xmqq4kmb5osi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A594B040-1AFF-11EB-96F8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> 2) upload-pack generally takes configuration via flags rather than
>   gitconfig. From offline discussions, it sounds like this is an
>   intentional choice to limit potential vulnerability from malicious
>   configs in local repositories accessed via the file:// URL scheme. Is
>   it reasonable to load the trace2.announceSID option from config files
>   in upload-pack, or should this be changed to a flag?

I do not know about your offline discussion, but it certainly would
make it easier to reason about the attack surface if we know it
never gets affected by any configuration files.

Having said that, upload-pack.c::upload_pack_config() already reads
a lot from the configuration file, many of these variables are named
"allowSomething", so...

IOW, I do not see why the announceSID (should it be in trace2.*
hierarchy, though?) needs to be treated in any more sensitive than
say uploadpack.allowrefinwant or *.allowfilter variables.
