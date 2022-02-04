Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59AC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 19:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiBDTTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 14:19:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51348 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiBDTTo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 14:19:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8CCE11940C;
        Fri,  4 Feb 2022 14:19:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=9CIk/EK4iOFV7SOjdI8sBA8La
        xkH0mfnvPOWixsoUpU=; b=WnXhIKGk9N31REgEkZx8TnIbPRO8kotR3m+RUBiHC
        FYvBpHX00hN5g6g9Gnmj2fw5iI0W+4GwZsqwM54GQzD/fufH5VNoUvDCM0FA13QC
        3FSuDz65uDMpHSVaBPVayPsIg4cvn8Mbs4Y5K4xeKp3sY7IQdlS30suxG0+iZsfK
        lA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E90D11940B;
        Fri,  4 Feb 2022 14:19:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0DF9911940A;
        Fri,  4 Feb 2022 14:19:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Robin Jarry <robin.jarry@6wind.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4] receive-pack: check if client is alive before
 completing the push
References: <20220127215553.1386024-1-robin.jarry@6wind.com>
        <20220128194811.3396281-1-robin.jarry@6wind.com>
        <220204.864k5e4yvf.gmgdl@evledraar.gmail.com>
Date:   Fri, 04 Feb 2022 11:19:41 -0800
Message-ID: <xmqqczk2moc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6808EBAE-85EF-11EC-9107-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Is the motivation purely a UX change where it's considered that the use=
r
> *must* be shown the output, or are we doing the wrong thing and not
> continuing at all if we run into SIGPIPE here (then presumably only for
> hooks that produce output?).
>
> I admit this is somewhat contrived, but aren't we now doing worse for
> users where the pre-receive hook takes 10s, but they already asked for
> their push to be performed. Then they disconnect from WiFi unexpectedly=
,
> and find that that it didn't go through?
>
> Anyway, I see you made this opt-in configurable in earlier iterations. =
I
> wonder if that's still something worth doing, or if we should just take
> this change as-is.

I guess the above is exactly the same reaction I still have against
the series.  In a case where the user did *not* see "git push"
complete after getting a positive response from the other side that
says the changes to refs have succeeded, due to whatever reason
(e.g. "^C" or connection droppage), the user cannot expect whether
the push to have completed or got aborted, both from the UX point of
view and from the correctness point of view, I would think.

Your keyboard interrupt "^C" may have come too late to matter at the
receiving end, or your WiFi may or may not have disconnected before
the receiving end got everything necessary from you to carry out the
operation, for example, and you are not simply in control of these
things.
