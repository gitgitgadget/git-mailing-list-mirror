Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714DE2021E
	for <e@80x24.org>; Mon, 31 Oct 2016 17:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945254AbcJaRzu (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 13:55:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53132 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S945204AbcJaRzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 13:55:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00E3F48E13;
        Mon, 31 Oct 2016 13:55:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QLQf4rHDgFF/o1goyzvi3acswyw=; b=UJ1EC+
        azB9SCJrrefDz8m9HHEHm4hQV/Lwb5+jiZ2l8heZBxpfSH3JfPMt/zyuUR5EcDQ+
        pnYKUbzUcMY/a9tqXluWytifiQYz3S6MKqMt2CHgQD8D6uXWZN2oAo50zkgrsiy4
        RpgR+GPQNr9PP9qTQNxGLw2AAcQZVCKWyrUco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lgqkVHWhDWLF7+/lANAd6uujh4k5TrPd
        RR5RhS++SfnPSdtIpUJuQAKechEauJsHYbnC1ydxAA9LdAxMdnyfe+vHa/V8l5Fu
        dPivAK9Ru73P5wZ0KfwH63upqv76ibYZXYxqnIfhp17dk8YxUFKFNJQcp5/PK8gx
        pSMzPgQuF6Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9DCE48E11;
        Mon, 31 Oct 2016 13:55:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61D9748E0E;
        Mon, 31 Oct 2016 13:55:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
        <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
        <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
        <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
        <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
        <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
        <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com>
        <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610281306320.3264@virtualbox>
        <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
        <20161031135601.7immbp44wn7uksvs@sigill.intra.peff.net>
Date:   Mon, 31 Oct 2016 10:55:32 -0700
In-Reply-To: <20161031135601.7immbp44wn7uksvs@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 31 Oct 2016 09:56:01 -0400")
Message-ID: <xmqqwpgotncb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38E4A8E2-9F93-11E6-BD8A-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you set a probe on touch_atime() in the kernel (which is called for
> every attempt to smudge the atime, regardless of mount options, but is
> skipped when the descriptor was opened with O_NOATIME), you can see the
> impact. Here's a command I picked because it reads a lot of objects (run
> on my git.git clone):
>
>   $ perf stat -e probe:touch-atime git log -Sfoo >/dev/null
>
> And the probe:touch_atime counts before (stock git) and after (a patch
> to drop O_NOATIME):
>
>   before: 22,235
>    after: 22,362
>
> So that's only half a percent difference. And it's on a reasonably messy
> clone that is partway to triggering an auto-repack:
> ...
> So I guess it's possible that it produces a noticeable effect in some
> cases, but I'm still somewhat doubtful. And actually repacking your
> repository had a greater effect in every case I measured (in addition to
> providing other speedups).

Let's keep doubting.  I prefer one-step-at-a-time approach to
things anyway, and what I plan in the near term are:

 * use the "open() with O_NOATIME|O_CLOEXEC, gradually losing the
   bits during fallback" approach in the ls/git-open-cloexec topic,
   in order to help ls/filter-process topic be part of the upcoming
   release;

 * simplify the logic to the "open(2) with O_CLOEXEC, set O_NOATIME
   with fcntl(2)" in jc/git-open-cloexec~1 after 2.11 ships;

 * cook "drop the latter half of setting O_NOATIME" which is at the
   tip of jc/git-open-cloexec in 'next', and while Linus is looking
   the other way ^W^W^W^W^W^W^W after people had chance to complain
   with numbers, merge it to a future release iff it still looked OK
   to drop O_NOATIME thing.
