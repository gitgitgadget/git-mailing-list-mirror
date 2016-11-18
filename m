Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB522209AE
	for <e@80x24.org>; Fri, 18 Nov 2016 20:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbcKRUE5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 15:04:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53577 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752923AbcKRUE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 15:04:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42ECD4F161;
        Fri, 18 Nov 2016 15:04:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GjtcHym+yJZdfw5d15ta2FnEjC0=; b=BRvJyN
        g/FsdJUZtC6Fbsg//DvHR3untZ+wz7LetyifYbQ32ebrwPRN52hO53LVP1bRoig2
        8TzoIx3VaDjGpLBYJM3Za57+Pth7gncyVJUxxmRFs6mR6IecgpsFJfxwb+sjeMG6
        xXxXaWWSKsn2p5bxBnCgI9rajlCglVV8XRAb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uEVlFIooEdGwNiha+2SXL+0xzTC21n2F
        i3uqaXQmTr5d9nGq3+qHDhtBGnhriwPkugVxqi48JDtKLJJjmG3gsX84oASUcfpX
        7GpfpZ7cjfIYzWJ0x9SPxo2EYqfOwjeOZ3FOALBI+5gjzKIDxHoR4JgtZR41g74S
        AMs+OkMIMZQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A8DE4F160;
        Fri, 18 Nov 2016 15:04:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB5374F15F;
        Fri, 18 Nov 2016 15:04:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net, spearce@spearce.org
Subject: Re: [PATCH v2] remote-curl: don't hang when a server dies before any output
References: <1479491919-12592-1-git-send-email-dturner@twosigma.com>
Date:   Fri, 18 Nov 2016 12:04:53 -0800
In-Reply-To: <1479491919-12592-1-git-send-email-dturner@twosigma.com> (David
        Turner's message of "Fri, 18 Nov 2016 12:58:39 -0500")
Message-ID: <xmqqh974mu56.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45C99BFE-ADCA-11E6-A522-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> In the event that a HTTP server closes the connection after giving a
> 200 but before giving any packets, we don't want to hang forever
> waiting for a response that will never come.  Instead, we should die
> immediately.
>
> One case where this happens is when attempting to fetch a dangling
> object by SHA.
>
> Prior to this patch, fetch-pack would wait for more data from the
> server, and remote-curl would wait for fetch-pack, causing a deadlock.
>
> Despite this patch, there is other possible malformed input that could
> cause the same deadlock (e.g. a half-finished pktline, or a pktline but
> no trailing flush).  There are a few possible solutions to this:
>
> 1. Allowing remote-curl to tell fetch-pack about the EOF (so that
> fetch-pack could know that no more data is coming until it says
> something else).  This is tricky because an out-of-band signal would
> be required, or the http response would have to be re-framed inside
> another layer of pkt-line or something.
>
> 2. Make remote-curl understand some of the protocol.  It turns out
> that in addition to understanding pkt-line, it would need to watch for
> ack/nak.  This is somewhat fragile, as information about the protocol
> would end up in two places.  Also, pkt-lines which are already at the
> length limit would need special handling.
>
> Both of these solutions would require a fair amount of work, whereas
> this hack is easy and solves at least some of the problem.
>
> Still to do: it would be good to give a better error message
> than "fatal: The remote end hung up unexpectedly".

It seems to me that there is some gap/leap in the description
between the second and third paragraph above (i.e. the client asks
for an object, the server tries to see if the object is reachable
from the refs, and then what?  who waits for more data without
asking?), but other than that, including the future direction, the
proposed log message is very nicely described.

Thanks, will queue.
