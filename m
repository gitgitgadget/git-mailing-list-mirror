Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36988C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 04:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AF461450
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 04:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhD3EvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 00:51:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55660 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhD3EvE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 00:51:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42AFAC1E15;
        Fri, 30 Apr 2021 00:50:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J7RpR6L6epY3BYgtf6+OdiBuFwIv4eDfq98QCT
        K+ho0=; b=Haxl9b+iEFn57yuCy0rFEeKNJfC4ogJV7EPXuniRwRLWq3V0U5Qpei
        DK+kSL86lleUyZZLAv4IY0qp+AGO/kADM0901kIl1ugDfC2zBs20EVT0Pdp/vAR5
        vHF/57U3OeRFRLYGLAJgBec23drc707buBF6MjZ8Oed/Qb6W5MpPU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26C62C1E12;
        Fri, 30 Apr 2021 00:50:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 831DFC1E11;
        Fri, 30 Apr 2021 00:50:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g>
Date:   Fri, 30 Apr 2021 13:50:14 +0900
In-Reply-To: <xmqqmttgfz8e.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        30 Apr 2021 08:27:29 +0900")
Message-ID: <xmqqy2d0cr5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E1B3444-A96F-11EB-8410-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Yep, but --diff-merges=m doesn't imply -p either, though it does produce
>> diff output without -p, for merge commits only.
>
> I misspoke without thinking it through.  It is absolutely wrong for
> the "-m" option (or "--diff-merges=m" for that matter) to imply
> "-p".
>
> $ git log --stat --summary
>
> would show "diff", but the kind of "diff" requested is not a textual
> patch but just diffstat and the summary of new/removed files, and
> the "diff" is shown only for single-parent commits, and it omits
> "diff" for merge commits.  Adding "-m" to this command line is *not*
> a request to show the textual patch.  It is to ask "diff" to be
> shown pairwise with each of the parent.
>
> $ git log -m --stat --summary
>
> It is probably OK to special case "-m" given alone without any other
> option [*1*] that specifies what kind of "diff" is requested and
> make it imply "-p".  But unconditionally flipping "-p" on only
> because you saw "-m" (or "--diff-merges=m" for that matter) is just
> wrong.

Luckily,

    $ git log [--stat] --diff-merges=first-parent master..seen

seems to do almost the right thing, with respect to the "It is
probably OK to special case" I gave above.

It only "enables diff" for merge commits, which does not quite feel
right and we may want to do the same "enable diff" for single parent
commits, but the good part is that it does not blindly imply "-p".

It seems to do the "enable diff" the right way by honoring other
command line options that specify the format of the diff, so with
"--stat" included in the sample command line above, we get the
diffstat for single parent commits (because we ask for "--stat" from
the command line to show it throughout the history) and also for
merge commits (because --diff-merges=first-parent does *not* blindly
turn the textual patch '-p' on).

> [Footnote]
>
> *1* They are not limited to "-p", "--stat" and "--summary", but
> you'd need to also pay attention to "--raw", "--name-only", etc.)

I've merged the so/log-diff-merge topic to 'master', with this
(possibly) known breakage that it does not do anything for single
parent commits.  We may want to fix this last mile before the
release that is scheduled to happen around early June.

Note that I didn't check if you are doing the right thing for all
formats, or if I was lucky and --stat was only one of them you paid
attention to, when you needed to notice all others that you don't.
But if you used the same logic that allows "git show" to by default
give "-p/--cc" output while "git show --stat" to squelch the patch
output, you should be OK.

Thanks.
