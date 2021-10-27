Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAA7C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1307F610A3
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbhJ0SHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:07:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56658 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhJ0SHR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 14:07:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 036B4E9BF3;
        Wed, 27 Oct 2021 14:04:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zB5KjqJ+dYbUpKfeMWlavSUNNZzN4hEFDtuSWU
        1J79w=; b=dKSF1xLXoQJnh4sJTZ/YkiRJfJ7uuj0zksLzNVh5PnH6CKrmO2aLoX
        u4p4/QCKwetVMsIPWqpsqai5UXmVRQe5jLvSjwDVKnA+jLAhfzVTDD2Bt1t9igTE
        mQG/56aBLg9v34xqYjXDeIBp5qDnaU2Ndeu0o22f3flc0i9B94dsY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFEEBE9BF2;
        Wed, 27 Oct 2021 14:04:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D15BE9BF1;
        Wed, 27 Oct 2021 14:04:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: pre-v2.34.0-rc0 regressions: 'git log' has a noisy iconv() warning
References: <xmqq5ytkzbt7.fsf@gitster.g>
        <211026.86y26gyqui.gmgdl@evledraar.gmail.com>
        <YXk0hAgaSJbLUgeB@coredump.intra.peff.net>
Date:   Wed, 27 Oct 2021 11:04:50 -0700
In-Reply-To: <YXk0hAgaSJbLUgeB@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 27 Oct 2021 07:14:12 -0400")
Message-ID: <xmqqmtmuwdh9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 617AE5D2-3750-11EC-86FD-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The firehose of warnings for "git log --encoding=nonsense" was known and
> discussed in fd680bc558 (logmsg_reencode(): warn when iconv() fails,
> 2021-08-27). It's ugly for sure, but I'm still OK with it for the
> reasoning there: your next step is to fix the --encoding argument you
> gave. Whether you saw one line of warning or many is not that important,
> IMHO. Giving a single more sensible warning ("your encoding 'nonsense'
> isn't valid") would be better, but I think it's hard to do without
> creating other problems.
>
> But the most compelling argument against warning at all is the case you
> gave earlier: that there may be historical garbage commits, and you
> can't get rid of them, so being warned constantly that we're not going
> to show or grep them correctly is just annoying. And that is true
> whether the user sees one warning or a hundred.

Is it really a "firehose"?  I won't use the word for one warning
message per commit in the output of "git log --encoding=nonsense".

If you are running "git log --oneline", it may indeed be annoying to
double the number of lines shown, and indeed

    $ git log --oneline --encoding=US-ASCII -4 ab/doc-lint
    warning: unable to reencode commit to 'US-ASCII'
    414abf159f docs: fix linting issues due to incorrect relative section order
    warning: unable to reencode commit to 'US-ASCII'
    ea8b9271b1 doc lint: lint relative section order
    warning: unable to reencode commit to 'US-ASCII'
    cafd9828e8 doc lint: lint and fix missing "GIT" end sections
    warning: unable to reencode commit to 'US-ASCII'
    d2c9908076 doc lint: fix bugs in, simplify and improve lint script

is indeed annoying, as everything that is _shown_ ought to be
presentable in US-ASCII.  This observation makes us realize an
obvious approach to improve over the current behaviour without
losing the warning when it matters, but I think the required code
change, to first split the commit message into pieces (which roughly
corresponds to the atoms in the --format= placeholder language) and
reencode only these pieces that will be shown, may be too involved
to be worth the effort.

> So while I do hate to have Git just silently ignore errors, probably the
> original behavior is the least-bad thing, and we should just revert
> fd680bc558 (logmsg_reencode(): warn when iconv() fails, 2021-08-27). We
> probably want to salvage the documentation change (minus the "along with
> a warning") part.

I am all for making it convenient to squelch, but it would be sad to
lose the convenient way to notice possible misencoding in recent
commits.  Or can we have a command line option and pass it through
the callchain, or would that be too involved?
