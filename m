Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A471C433E2
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A06A2071B
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pTWzsZKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgGPRgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:36:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64410 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPRgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 13:36:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8277260B36;
        Thu, 16 Jul 2020 13:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C4fRpGpCFC9vIxVsR50mwa1lDTc=; b=pTWzsZ
        KGLoJGUT2Z4eb8aNJssqRN06qsplZOba+2/xDL7KVOW/0tfWR9hnQDn324ptqtEv
        4IXjtCkSXVQX59lpRnDppAFzXw+btu0B9qk+9T5ePwAhtYawMCTeITtjX++Y7EBK
        xms8cehglWLZm5AU/+U+3Ead+fng4rqnXHzxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TlsvnCwqmJwONxOB3qAXtM9vu1GU3t1w
        r3spbP8R3/NayUDSToJRytxWcprArGsYNMLtxhJBNlm+pwr9hAAYOI9AJrOxCp4R
        4F7yDJTbyrDv6WeSBUq/v9HynedlKiSUhW1L6xkEl0TlfcWqE/4mkMiiOLQwA3Tp
        Lq0xUoZXs6U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A7DD60B34;
        Thu, 16 Jul 2020 13:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 098A260B33;
        Thu, 16 Jul 2020 13:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] upload-pack: do not lazy-fetch "have" objects
References: <20200715223112.2018556-1-jonathantanmy@google.com>
        <xmqqpn8wie21.fsf@gitster.c.googlers.com>
        <20200716104149.GA376357@coredump.intra.peff.net>
Date:   Thu, 16 Jul 2020 10:36:09 -0700
In-Reply-To: <20200716104149.GA376357@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 16 Jul 2020 06:41:49 -0400")
Message-ID: <xmqqk0z3gy5y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6BFF508-C78A-11EA-B331-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the instance fixed here _probably_ could be converted to QUICK
> as well. It saves extra refreshes of the pack directory when a client
> asks for an object we don't have. That's usually not too expensive, but
> can be in some cases (many alternates, slow NFS filesystems, client has
> many objects we don't). In the worst case, using QUICK would mean we can
> get fooled by a simultaneous repack into thinking we don't have an
> object we _do_ have, and end up negotiating a worse pack for the client.
>
>> Thanks.  Will queue.
>
> That said, yeah, I think Jonathan's patch is a strict improvement by
> itself.

I'll see what Jonathan would say, hoping that he'd consider if QUICK
is appropriate or not sufficiently enough to result in an updated
patch, that either has QUICK in the code or the reason why QUICK is
not used in the log message.

Thanks.
