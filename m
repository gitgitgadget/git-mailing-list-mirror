Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68A11F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 17:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754025AbcIIRqZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 13:46:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53325 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754006AbcIIRqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 13:46:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD3DF3B895;
        Fri,  9 Sep 2016 13:46:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zvBUPBig4FLF
        yIyK5ooEsEYuMyM=; b=akfmmtSt4wL4a7f7klbNosqydosK40mJunlg51PExMcT
        MeK4I13wi6X5FvFi6goQOwuy3KvK9BXBnvMbesudNWDHEm+hljheKtJaTY2IarK3
        b9yxb8/JNvmSAQwM6uVbvuWe4A3sR+SXqNm8qV/QUgwbm49qTzsuVWvVi5pDXwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LDFHAZ
        jrn2nJ1CjNRaNa328WYb1NneY157we2KHK1mG+BfsxoIbolLPKggNEjpEovUyS4g
        WgPUD8TM9TD4w8P0oWrAvPEh56uhsk3K6XlZYQNuB9eORnMwLxB/BnqdWXtzGrBI
        xYIdIhv2k8QQ5EkvAo2qbAVrI++YXauLT+h2s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5BBB3B894;
        Fri,  9 Sep 2016 13:46:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2959E3B893;
        Fri,  9 Sep 2016 13:46:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on mmap()ed data
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
        <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com>
        <20160906071255.ggsoj2lh2f3kubhj@sigill.intra.peff.net>
        <alpine.DEB.2.20.1609061521410.129229@virtualbox>
        <20160906182942.s2mlge2vg65f5sy4@sigill.intra.peff.net>
        <alpine.DEB.2.20.1609080921030.129229@virtualbox>
        <20160908080035.czwn5y3re5bp5vkg@sigill.intra.peff.net>
        <alpine.DEB.2.20.1609091158550.129229@virtualbox>
Date:   Fri, 09 Sep 2016 10:46:21 -0700
In-Reply-To: <alpine.DEB.2.20.1609091158550.129229@virtualbox> (Johannes
        Schindelin's message of "Fri, 9 Sep 2016 12:09:18 +0200 (CEST)")
Message-ID: <xmqqmvjhc6fm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 52CED3D8-76B5-11E6-A5A2-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Besides avoiding a segfault, one of the benefits of regcomp_buf() is
>> that we will now find pickaxe-regex strings inside mixed binary/text
>> files. But it's not clear to me that NetBSD's implementation does this=
.
>>=20
>> I guess we can assume it is fine (it is certainly no _worse_ than the
>> current behavior), and if people's platforms do not handle it, they ca=
n
>> build with NO_REGEX.
>
> Ren=C3=A9 mentioned in f96e567 (grep: use REG_STARTEND for all matching=
 if
> available, 2010-05-22) something along the lines of REG_STARTEND being
> able to parse beyond NULs. My interpretation of NetBSD's documentation
> agrees with your interpretation, though, that the buffers are still
> thought of as being NUL-terminated, even if rm_eo makes the code *not*
> look at that particular NUL.
>
> Be that as it may: it is completely outside the purpose of my patch ser=
ies
> to take care of making it possible for Git's regex functions to match
> buffers with embedded NULs.

I think you two have agreed that regexec_buf() wrapper that always
relies on REG_STARTEND is a good first step whether we want to do an
embedded NUL, that we just need that good first step for now, and
that that good first step would not block future progress, i.e. our
wanting to handle embedded NUL.

So let's see how well the first step flies in practice.  We tell
people to build with NO_REGEX if their platform's regexp does not do
(any form of) REG_STARTEND.  We _might_ later have to tell them to
set NO_REGX even if they are on NetBSD and has REG_STARTEND that may
not handle embedded NUL the way we want, but that can safely be left
to the future.

Thanks.
