Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E7C678DC
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 00:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356722AbjHRAgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 20:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356715AbjHRAf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 20:35:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B892D65
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 17:35:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD8091A8F3D;
        Thu, 17 Aug 2023 20:35:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KI5zdelGDoeMSayFwNUrhVqTK6hHyKWdmHJzf/
        UQJVE=; b=DoZ0p5Nd4NaPVwQQ570kSX2I3P5BrMLsUlZgXjyDE98HdPmm8FmtX9
        /NeVoirNpgNsnML8NG2AILGBJExELmOZRQ4VLf4s5IjAeESBM5WG77+Z7A+tZzwx
        lmXoL8bpFabmHY8x+Q2nupt8VCRzLmYdjSBkh/LW2CcbHFmPvSz/8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3E8D1A8F3C;
        Thu, 17 Aug 2023 20:35:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B00F1A8F3B;
        Thu, 17 Aug 2023 20:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Jeff King'" <peff@peff.net>, "'Taylor Blau'" <me@ttaylorr.com>,
        "'Andy Koppe'" <andy.koppe@gmail.com>, <git@vger.kernel.org>
Subject: Re: main != master at github.com/git/git
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
        <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
        <xmqq7cpwjhr1.fsf@gitster.g>
        <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>
        <xmqq350kjfk8.fsf@gitster.g>
        <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com>
        <ZNv5PQlkn6tbUcH7@nand.local>
        <20230816022420.GA2248431@coredump.intra.peff.net>
        <000901d9d045$e780f790$b682e6b0$@nexbridge.com>
Date:   Thu, 17 Aug 2023 17:35:53 -0700
In-Reply-To: <000901d9d045$e780f790$b682e6b0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 16 Aug 2023 09:30:57
        -0400")
Message-ID: <xmqqo7j5uqza.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3094F888-3D5F-11EE-94C4-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> Would it not be more convenient just to add a GitHub action that
> set main = master for each push?

If "my private working area calls the primary integration branch
'master', but for publishing repositories, I have to push it twice,
once to 'master' and then to 'main'" were the problem, the solution
I would rather want to see implemented is to an ability for the
repository owners to set a symref that makes 'main' refer to
'master', so that I do not have to worry about the aliasing.  But it
is not a problem (the push refspec can be set up to send the same
commit to two different branches just fine).

In any case, I am not sure if it would solve the problem being
discussed: when CI runner sees branches updated to commit that
hasn't been worked on, a new job is created to work on that commit,
and updating two branches with the same commit at the same time
unfortunately means two independent CI jobs work on the same commit
in parallel.  The 'lagging behind by 24 hours' hack I mentioned
earlier was one way to work it around, but it would confuse folks.

I'd really prefer not to special case 'main' (or 'master' for that
matter), primarily because some downstreams rely more heavily on
'main' as Peff pointed out, but also because the problem is not
'master' vs 'main'.  If 'next' happens to become empty soon after a
new cycle starts and points at the same commit as 'master', we will
see the same waste of cycles between 'master' and 'next'.

Thanks.
