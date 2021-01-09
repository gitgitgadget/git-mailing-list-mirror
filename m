Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD48AC433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 23:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8D32311E
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 23:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbhAIXJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 18:09:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52123 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAIXJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 18:09:28 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C40A11010A;
        Sat,  9 Jan 2021 18:08:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5TMUwexJE4PdXnavD45wL3uMdKk=; b=wDgaM7
        SKS3z+GnT/LqbqtGkcCR26W63SI9gOzCWnpI5W4y2xeV0C9H/j1yXcXb1TyLzCJW
        ags9y6CokxRmlHEQpM4ySKNHCBYLiQMLIVI1NW6KOcvrvQEq9/qrPaSRNoG0Sn/N
        3l772MkhZ90H6Mg4uDAMhTbv56F17UQAqRcSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a0gV6RAJ9UJnFN2Vf/0B1q2eb3aYpV6l
        b/xD/RkcIRHuM7DYzaWQ//VuPWvujx2T/hRou0p0m7uKFMS9zDgF3kzUnh87Tptl
        nJ2xVcUwCGoYPYufck6q4+CbWr1QQkD2KDtERyuhAVwCUPPIB+ByWQbB4ChnwLIy
        UoMcoLonsTY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 942ED110109;
        Sat,  9 Jan 2021 18:08:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01A04110108;
        Sat,  9 Jan 2021 18:08:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <CAJDDKr6V+kKMs4yz+YQx1AhiY5qQwENfs_yZqxXWBqmLUk2oAw@mail.gmail.com>
Date:   Sat, 09 Jan 2021 15:08:41 -0800
In-Reply-To: <CAJDDKr6V+kKMs4yz+YQx1AhiY5qQwENfs_yZqxXWBqmLUk2oAw@mail.gmail.com>
        (David Aguilar's message of "Sat, 9 Jan 2021 13:38:20 -0800")
Message-ID: <xmqqft39emiu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EC33D4C-52CF-11EB-A527-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Fun times in sed portability land.  After a bit of experimentation,
> this is what I've managed to whip up:
>
> cr=$(printf '\x0d')
> sed -e "/^<<<<<<< /,/^=======$cr\{0,1\}$/d" -e '/^>>>>>>> /d' tiger
>
> - Instead of \r use printf to capture CR into a string so that we can
> embed the literal using $cr.
> - DQ "..." instead of SQ '...' to allow $cr to be substituted in the string.
> - Instead of \? use \{0,1\} which seems to work on both macOS and Linux.

Ah, all the fun with avoiding GNU-ism in scripts; thanks for
figuring it out.

I am perfectly fine with the above, but I also am OK with Perl
script.  We may even be able to generate three output files in a
single pass by passing their filenames and open them for writing in
the script.

> That seems to work and the tests now pass.
> If not sed, is there perhaps a perl equivalent for these multi-line
> delete-from-X-until-Y expressions that might provide better
> portability?

> I'll start putting together a patch shortly as this seems to work in
> practice.  Let me know if y'all have any sugs or if there are any
> portability pitfalls I'm not considering.
