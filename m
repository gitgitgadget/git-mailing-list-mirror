Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F4C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 18:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71AB61163
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 18:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbhHFSLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:11:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55034 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbhHFSLu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 14:11:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 349B4D4427;
        Fri,  6 Aug 2021 14:11:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tLBRvprQN4Xl
        xQ1qe7t78Xiqee3otyd8t62luZaocKw=; b=lO5bNN3SH9u+9lfPJiHhaDbLQ7B7
        FRPlAzNFANgCPV+H2xWk3SS9eGwYArGy4XH1TCPeFo3u+dPJ4s+vjvFd3mu+eyuw
        Dltb7CYgo6FGiMFYMIPZMe8Mws2XD+RhQxZ8gAT9L99pM+32ib4dLbdBH46OLu+z
        ymWOly0wVj0IFmQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AF51D4426;
        Fri,  6 Aug 2021 14:11:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8105CD4425;
        Fri,  6 Aug 2021 14:11:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] makefile: update detect-compiler for newer Xcode version
References: <20210806080634.11869-1-carenas@gmail.com>
        <m2sfzmu1t7.fsf@gmail.com>
Date:   Fri, 06 Aug 2021 11:11:31 -0700
In-Reply-To: <m2sfzmu1t7.fsf@gmail.com> (Atharva Raykar's message of "Fri, 06
        Aug 2021 19:12:44 +0530")
Message-ID: <xmqq8s1eigto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BAB53EE0-F6E1-11EB-9296-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>
> For those of us using Homebrew and using the LLVM installation from
> there, we get:
>
> $ cc --version
> Homebrew clang version 12.0.1
> ...
>> diff --git a/detect-compiler b/detect-compiler
>> index 70b754481c..c85be83c64 100755
>> --- a/detect-compiler
>> +++ b/detect-compiler
>> @@ -44,7 +44,7 @@ clang)
>>  "FreeBSD clang")
>>  	print_flags clang
>>  	;;
>> -"Apple LLVM")
>> +"Apple LLVM"|"Apple clang")
>>  	print_flags clang
>>  	;;
>>  *)
>
> So maybe we could add another case for "Homebrew clang"?

$ clang --version 2>&1 | sed -ne 's/ version .*//p'
Debian clang

It might be necessary to cope with this "$VENDOR clang version"
convention better with something like the following.

I am afraid that this patch is being a bit too aggressive about
LLVM, as I do not know if "$VENDOR LLVM version" is also a thing, or
it is just oddity only at Apple, though.

diff --git c/detect-compiler w/detect-compiler
index 70b754481c..a80442a327 100755
--- c/detect-compiler
+++ w/detect-compiler
@@ -38,13 +38,7 @@ case "$(get_family)" in
 gcc)
 	print_flags gcc
 	;;
-clang)
-	print_flags clang
-	;;
-"FreeBSD clang")
-	print_flags clang
-	;;
-"Apple LLVM")
+clang | *" clang" | *" LLVM")
 	print_flags clang
 	;;
 *)
