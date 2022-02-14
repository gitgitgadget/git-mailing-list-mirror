Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE8FC433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 17:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357099AbiBNRfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:35:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357102AbiBNRfA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 12:35:00 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3816540F
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:34:50 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71F5411DC56;
        Mon, 14 Feb 2022 12:34:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XSKm2MJZ9zpq
        8+rd8Nq+xLGeTIJka0TmEWR9BTx+68U=; b=nMflwmVirl7FXVtpZP/IEPEJXEg5
        RTnWKOeMLqJ8Ip2lr6ZLC0EqAu2tmSkq1+pY/dhNJew93a7KEIAYtWFtbHmo4a5Q
        rnGJ6za61mZSAeFP8DCx+9XLL33J3diaMSNP9eBOoLbwTbsZGgi4dvIUIS7mPaTL
        ioD+HrXtpzRComg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69AE411DC55;
        Mon, 14 Feb 2022 12:34:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D6B911DC54;
        Mon, 14 Feb 2022 12:34:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmaso?= =?utf-8?Q?n?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
References: <20220208083952.35036-1-chooglen@google.com>
        <20220210092833.55360-1-chooglen@google.com>
        <xmqqv8xj71mt.fsf@gitster.g> <xmqqr18770pc.fsf@gitster.g>
        <kl6la6et76bb.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 14 Feb 2022 09:34:47 -0800
In-Reply-To: <kl6la6et76bb.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 15 Feb 2022 00:37:28 +0800")
Message-ID: <xmqq1r054aiw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 686866AE-8DBC-11EC-84B7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Hm, I haven't looked at where the conflicts are yet, but I'll get to it
> as I'm reviewing the rest of the feedback.
>
> And on that note, what do you think of =C3=86var's suggestion to split =
off
> the 'easy to review' and 'obvious' patches into their own preparatory
> series? I wonder if this would make it harder or easier to manage the
> conflicts.

It depends on how small an interaction the "obvious and easy" part
has with topics in flight.  In the best case, if there aren't any
the preparatory series may even graduate before the other topics
that interfere with the main part of this series becomes ready.

In a worse case, what the preparatory work to lay more solid
foundation wants to do may contradict what some of these topics in
flight want to do.  Such semantic conflicts need to be resolved
before the main part (and these interfering topics) can move
forward, and with "split off", the core of the contradicting wish
may become easier to see and what needs to be resolved may become
clearer.

So, I do not think of a way for such a split to make things harder
for later.  Of course, the "easy to review" and "obvious" part has
to be justifiable on its own, i.e. "a larger series wants to build
on this foundation and for it to work this part must be done in this
way", when the other topics wants to do the part in question
differently, becomes a much weaker justification.  But if it is
truly "obvious", it is unlikely that the benefit of the change
becomes harder to justify.

