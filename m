Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781DDC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF432071A
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lHMtFzny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgFNVc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:32:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56477 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNVc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 17:32:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6314B9A35;
        Sun, 14 Jun 2020 17:32:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sOC4+GUcgcqTjvJsN7hrL1KipnY=; b=lHMtFz
        ny2pDcA8toye9hn/zkKPMqE3Lwtag2VESkTryX63CAFo20OLicOOoPEKQRFDKsDF
        4mZkAvUe6WHPT0c3uoVs0VFU/A47l1MoGabFKKNC66OKDyAcSc71k4SPXjBCA1mj
        3+3GkhsxDCuhe1nPtic9OzYIGRF7AAi/Z0Iks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HfXNp2umZVQ3aQ2P3UsAp8pcyFP42xy0
        6xYi6lcXuA3ydJUZ+VPl4tAA/9zQ+O6zx2BDQJOx1zr570cqkB0BBHBXHGcR6Xx+
        kDLsxWiUbNrHvudVQuGf9aobkFQerqPH2tqQcnuGfEu6asxAPP6Oa33ANHc5vj+6
        H6EI5A/Qg2o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CDFC4B9A34;
        Sun, 14 Jun 2020 17:32:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19F25B9A33;
        Sun, 14 Jun 2020 17:32:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] pkt-line: war on magical `4` literal
References: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com>
        <cover.1592119902.git.liu.denton@gmail.com>
Date:   Sun, 14 Jun 2020 14:32:51 -0700
In-Reply-To: <cover.1592119902.git.liu.denton@gmail.com> (Denton Liu's message
        of "Sun, 14 Jun 2020 03:31:57 -0400")
Message-ID: <xmqqimftxri4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A9F4FFA-AE86-11EA-BAC3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +static inline void control_packet_write(int fd, const char *s, const char *type)
> +{
> +	packet_trace_str(s, 1);
> +	if (write_str_in_full(fd, s) < 0)
> +		die_errno(_("unable to write %s packet"), type);

This construct, whether "type" is a localized string _("...")  or
English literal "...", would not translate well, would it?  The
former causes sentence lego and the latter injects untranslated
adjective that modifies the word "packet" in the final sentence.

As write_str_in_full() MUST count how long the string is at runtime,
without any possibility to offload the work to compiler, when these
strings that are sent with the "magical 4" are all compile-time
constant literal strings, I am not sure if this is something we
should be happy with---we should aim better for a solution that does
not require the runtime to count if possible.

Thanks.
