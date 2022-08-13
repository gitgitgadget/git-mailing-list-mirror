Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51714C25B0D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 05:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiHMFCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 01:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMFCO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 01:02:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732677286A
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 22:02:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7FE51B6A4B;
        Sat, 13 Aug 2022 01:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gliilc/icmu3
        kc381GvpTVeSYqPl6DQ2eSqWclMofmg=; b=wZNkLC3NLhPwuvoT86KbGomaU5mo
        PCMlAAr4LZUTx+ruFhREO8p0lCbJVWYN1RtcchXVXFm1z/bIWeuFweV4i8Rr/pg3
        WJMfTjSrTX9ZBVDdRlfxiZZbI3i0XcVb7TNw4162IeOxbXAPTyiHUKtgFXrTMiAX
        VySl1AVGeuV/BEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0B231B6A4A;
        Sat, 13 Aug 2022 01:02:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 869671B6A49;
        Sat, 13 Aug 2022 01:02:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Renato Botelho <garga@freebsd.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git maintenance broken on FreeBSD
References: <226317ba-a78f-216c-764c-52f4e393bd35@FreeBSD.org>
        <YvZnQFVMZZmz9TIX@danh.dev> <YvcdskzUkocUv/d7@pobox.com>
Date:   Fri, 12 Aug 2022 22:02:08 -0700
In-Reply-To: <YvcdskzUkocUv/d7@pobox.com> (Todd Zullinger's message of "Fri,
        12 Aug 2022 23:42:42 -0400")
Message-ID: <xmqqczd4ag8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 15D707BA-1AC5-11ED-82EB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> If a change like this is made, aren't we trading one group
> of broken users for another?  It would fix users of newer
> systems at the expense of those on older systems, I would
> suspect.

Thanks for raising this.  The description of POSIX "crontab"
command, cf.

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/crontab.html=20

talks about optional "file", but it is explicit that it has to be a
real file, i.e.

    file
        The pathname of a file that contains specifications, in the
        format defined in the INPUT FILES section, for crontab
        entries.

I would suspect that implementations may treat it as a sign to read
the standard input, but I do not think that is what the above
specifies.  For example, description of "file" argument of another
command, "diff", cf.

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html

explicitly calls out that "-" stands for the standard input, i.e.

    diff [-c|-e|-f|-u|-C n|-U n] [-br] file1 file2

    file1, file2
        A pathname of a file to be compared. If either the file1 or
        file2 operand is '-', the standard input shall be used in
        its place.

So, it is fairly clear that "crontab" wants a real file.  Somebody's
POSIX compliant "crontab" can be fed "-", attempt to read from a
file with such a name, and legitimately fail.  And on such a system,
the proposed patch causes a regression.

> In the end, cronie adjusted it's behavior, which was similar
> to that of the newer vixie-cron, in 8b0241f (Partially
> revert the behavior of crontab command without arguments,
> 2021-03-17)=C2=B9.  It now behaves as required by POSIX if stdin
> is not a TTY.  That seems like a reasonable compromise and
> perhaps vixie-cron would be willing to do the same?

It indeed is a pragmatic solution to use isatty() as a hint. =20
