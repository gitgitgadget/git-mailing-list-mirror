Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F70AC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC9020792
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WIFVv1km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHEUK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:10:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62319 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHEQ2p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:28:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C827B88331;
        Wed,  5 Aug 2020 12:28:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=whD4AWlHYwbWLN/hulmDHxc/0dE=; b=WIFVv1
        kmSvb+LPPPGCDRyp7twv75Xf8wzo4l1KVcc0Y0gTtHpcglpQ2g/EgQ28pwVAZrui
        veHioh7lqFL5Fvs7C+N3Sft5Ht/QbqJKP9FLEZ7l6yNi/KLboDl7WjQ0fKglbdCx
        H4NS4lR15XQVLj6jhJsOhtkGubeQ5UWyK6Vw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cjEIhPGFAR/xML1B/g+2VnP9KqjoTTUA
        B+ypsFiGxtcMId3wlT/sl8FABLxgPsYzmN0xDzEK+W8SKo4TiIZLuk9YiSzB6RlK
        4RONhgLc1ZwZz7ssKYePNdXVe3oOk8OtgNR/mbYLl26mjRGaXqcfXUnSm+Yq93mm
        b24TP+EnKDU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCA5888330;
        Wed,  5 Aug 2020 12:28:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48D848832F;
        Wed,  5 Aug 2020 12:28:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: racy test failure in tb/upload-pack-filters
References: <20200805084240.GA1802257@coredump.intra.peff.net>
        <20200805090641.GR2898@szeder.dev>
        <20200805092658.GA1803042@coredump.intra.peff.net>
Date:   Wed, 05 Aug 2020 09:28:42 -0700
In-Reply-To: <20200805092658.GA1803042@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 5 Aug 2020 05:26:58 -0400")
Message-ID: <xmqqwo2dnjk5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA5F7D3A-D738-11EA-A04D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> By the way, grepping for "remote error:" shows that when we get an error
> over sideband 3 we produce the same message but _don't_ translate it.
> That seems inconsistent.

IOW

    die(_("remote error: %s"), buf + 1);

in sideband.c?  I think it makes sense.

IIRC, the current thinking is to let the remote side localize their
message before sending them over the wire and we'll worry about how
we let the receiving end tell what l10n it wants later.  So "remote
error:" prefix may have to be translated on receiving end and the
remainder of the line, which is already localized, can just be
interpolated.



