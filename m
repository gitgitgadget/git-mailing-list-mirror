Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570F2C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 02:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3B16186A
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 02:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBPCal (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 21:30:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62619 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBPCal (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 21:30:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D611113581;
        Mon, 15 Feb 2021 21:29:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k4WJ2u0+bBML3zh8jh9fYUoTH8g=; b=vBrWBY
        nBfkiwJPEOvO0IheWMTJt+srubqT/7nwV5aqk/H/84+Ox9RMM6GOwrMpXnT1gczh
        1MUBXUv+wPJf7LkuVFJq3g+xLBhXY8DvMtvycDWf5FeUpJ7zZK7DEk2CWynwzbru
        VWWQtanDO4UTrqQ2cQejK21c894F4M3hA+jBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gk1SczId6EaUCC/46o+i/aNWk3nMalCr
        nyOljgWUSU1604P6KQmCwDyqILwIUioAznNokapt/QisR6tC0Fgj+b3csIJG62WC
        eOTj8pL5UBunX+A4bYuKnSNyEXHtFTpoIfi9AmpNs1Axgb2Z1sYf7E7r+cQfiUE8
        xKTtYAMJxus=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 560AC113580;
        Mon, 15 Feb 2021 21:29:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1F2011357E;
        Mon, 15 Feb 2021 21:29:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break
 parsing
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
Date:   Mon, 15 Feb 2021 18:29:55 -0800
In-Reply-To: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
        (Matthias Buehlmann's message of "Mon, 15 Feb 2021 22:54:52 +0100")
Message-ID: <xmqqczx0sq1o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBE901F6-6FFE-11EB-8EC6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Buehlmann <Matthias.Buehlmann@mabulous.com> writes:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.

Thanks; let's ping our resident trailers expert ;-)

I somehow thought that a trailer is always a single-line thing,
without funky line-folding that we have to deal with when we are
dealing with e-mail headers.


> What did you do before the bug happened? (Steps to reproduce your issue)
>
>     create a file containing multiline trailer:
>
>     $ echo "Test" > test.txt
>     $ git interpret-trailers --where end --if-exists addIfDifferent
> --trailer "SingleLineTrailer: This is a single line trailer"
> --in-place test.txt
>     $ git interpret-trailers --where end --if-exists addIfDifferent
> --trailer "MultiLineTrailer: This is"$'\n a folded multi-line\n
> trailer' --in-place test.txt
>
>     parse trailers:
>
>     $ git interpret-trailers --parse test.txt
>     SingleLineTrailer: This is a single line trailer
>     MultiLineTrailer: This is a folded multi-line trailer
>
>     (so far, all is as expected)
>
>     now, adding multiline trailer containing empty line:
>
>     $ git interpret-trailers --where end --if-exists addIfDifferent
> --trailer "MultiLineTrailer: This is"$'\n a folded multi-line\n
> trailer which\n \n contains an\n empty line' --in-place test.txt
>
>     parse trailers again:
>
>     $ git interpret-trailers --parse test.txt
>
> What did you expect to happen? (Expected behavior)
>
> I would expect the following output:
>
>     $ git interpret-trailers --parse test.txt
>     SingleLineTrailer: This is a single line trailer
>     MultiLineTrailer: This is a folded multi-line trailer
>     MultiLineTrailer: This is a folded multi-line trailer which
> contains an empty line
>
> What happened instead? (Actual behavior)
>
>     no output is generated, but exit code is nevertheless 0:
>
>     $ git interpret-trailers --parse test.txt
>     $ echo $?
>     0
>
> What's different between what you expected and what actually happened?
>
>     I would expect either to get an output or the call to exit non-zero
>
> Anything else you want to add:
>
>     According to my interpretation of the documentation of git
> intepret-trailers, empty lines should be supported if properly folded,
> in the same way as for example the PGP signature added to the commit
> header contains a (properly folded) empty line
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.30.0.windows.2
> cpu: x86_64
> built from commit: f8cbc844b81bf6b9e72178bbe891a86c8bf5e9e7
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Windows 10.0 18363
> compiler info: gnuc: 10.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe
>
>
> [Enabled Hooks]
> post-commit
