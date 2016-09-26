Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51BC207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 16:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422744AbcIZQQA (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 12:16:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59167 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1422737AbcIZQP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 12:15:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E28C04027F;
        Mon, 26 Sep 2016 12:15:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OsETcZjE38R8LP/xIUE1qUrz4Vk=; b=nLGtGW
        elohjkX7YYRdtjx0l5WOcVDqfZKx6FScH/Hgo0Han4GWVFowDb9XHUnvx01G6ba+
        HAE4CLaGQSDj/QvQVYW9SDa2Rho4wVKj6QYnZrecZuRBgddPv1rcw1CNnLmHr1QH
        xeKssUUspjrdt12cUJwj9DpVPDMojdMIbDD8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cmnXlG4yjKNW7EDRWMb5mqMeDG0z1oqd
        5m/ug6YOlAkeU1eYl1rO0ueqhVHCaUGgXUXSvW3B63vlrtBfdgIEDDVM/KstIBLn
        El8uWu31dH0ZSCOaRGAlSsDMFEnxIl4tjEW6lkdCPUZsODwM1JOlR6R/uioLG5Nz
        x70vetvxIMM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA6894027E;
        Mon, 26 Sep 2016 12:15:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63AB34027D;
        Mon, 26 Sep 2016 12:15:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
        Gustavo Grieco <gustavo.grieco@imag.fr>
Subject: Re: [PATCH] unpack_sha1_header(): detect malformed object header
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
        <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
        <xmqqshsnuvvz.fsf_-_@gitster.mtv.corp.google.com>
        <20160926140309.l2h4b65gpqyutepn@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 09:15:53 -0700
In-Reply-To: <20160926140309.l2h4b65gpqyutepn@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 26 Sep 2016 10:03:09 -0400")
Message-ID: <xmqqfuomvdqe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80A28078-8404-11E6-BB36-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This part I don't understand, though. We clearly need to look for the
> NUL. But why do we need to look for the space? The loop in
> parse_sha1_header() can easily detect this as it looks for the end of
> the type name (and if it hits the end-of-string, can bail as in your
> original patch).
> I.e., the root of the problem is that we pass parse_sha1_header() a the
> "ptr" half of a ptr/len buffer, and it has no idea how much we read.
> But once we get it that information (either by passing the length, or by
> ensuring that the buffer is NUL-terminated, it should be easy for it to
> do the right thing.

Yup.

> Anyway, here's my ptr/len version (which passes the length back out of
> unpack_sha1_header via an in/out pointer). After thinking on it, though,
> I'm of the opinion that we're better off just ensuring that "hdr" is
> NUL-terminated. We end up assuming that anyway later, since we have to
> know how much of the header buffer was consumed by parsing.

I'd agree, not because I didn't first go in this <ptr,len> route
myself, but because the attached change does look quite invasive.
Also, I think it is OK to ask unpack_*_header() to fail if what it
turns can no way be a header, e.g. lacks NUL termination.

> Do note the final call below in the streaming loose-open code, which
> exhibits that, but also seems to call parse_sha1_header() without
> checking its return value. I think that needs fixed regardless of the
> approach.

Good that your attempt to signature-changing change caught it.  I'll
take a further look.

Thanks.
