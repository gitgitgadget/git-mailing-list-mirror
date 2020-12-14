Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3169C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6390522510
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbgLNXUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:20:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64089 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgLNXUU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 18:20:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CF8210E4E0;
        Mon, 14 Dec 2020 18:19:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/1Q8/a9ipxQjADBKdrDSSXbNTbw=; b=UWT8Xw
        +X1Tq1Vggr/Fiu5NXC+/AAtALE0OIzm1goZ36/aAlFIqY7nhU98J3MHmNbIz46VF
        QJcQ+dVfM6ht+qBxWfakMnVRfExWvhT0RrFOQyMmj6lCK9hBMnfqO1FhUQqKriki
        VPNk9mg+yX8maSpk4eH5VQzmq0GQcqhoM0hzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fs+wFyhpg1rpiQXkPIezYDG9NNmCtBdm
        xVaLUptP0jNrwLsBDGcyp+6PXtJiOMekk11zKkh+zSdAHc41GdAA8uWG2PuvtaWc
        4bOMBRZ61i6cu5Oyo3HlVosEoT8KawDCpmIzGIu02a9/XPV7vC5RFB9X+CEoFCB6
        wyN2IFE9Jjk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3603410E4DF;
        Mon, 14 Dec 2020 18:19:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7AF8610E4DC;
        Mon, 14 Dec 2020 18:19:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 4/5] pull: correct condition to trigger non-ff advice
References: <20201214202647.3340193-1-gitster@pobox.com>
        <20201214202647.3340193-5-gitster@pobox.com>
        <5fd7d67c898e4_d44af20879@natae.notmuch>
Date:   Mon, 14 Dec 2020 15:19:32 -0800
In-Reply-To: <5fd7d67c898e4_d44af20879@natae.notmuch> (Felipe Contreras's
        message of "Mon, 14 Dec 2020 15:17:48 -0600")
Message-ID: <xmqqr1ns9drv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D457D39A-3E62-11EB-8FC6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Then, we could just do:
>
>   if (opt_verbosity >= 0)
>           advise(_(message_advice_pull_non_ff)).
>
> Or even better:
>
>   if (opt_verbosity >= 0)
>           advise_if_enabled(ADVICE_PULL_NON_FF, _(message_advice_pull_non_ff));

I do not think we've decided what's the right way to squelch this
advice, so it is a bit premature to favor the latter over the
former.  Between a fixed message[] variable and a single-purpose
helper function I have no real preference.  With either, we can
reword the message easily without disrupting any improvements to the
codeflow.  At least the first sentence in the existing message needs
to be separated out of the advice and turned into a separate error
or a warning.

