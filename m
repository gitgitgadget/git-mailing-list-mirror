Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EC4C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 17:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiITRwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiITRw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 13:52:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D1721E10
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 10:52:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A16C1C6C77;
        Tue, 20 Sep 2022 13:52:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=SVveWXwoM99eQsmK6zfZC2flM
        0rpoS86rE+8SfI/3oA=; b=Yf6vD5wsncunH3hHh5OPWkSw1NMkB2qhWGI5CbPSP
        HxGy/tJ6t3drIR1R8yNbc6GKUdLVAFx1R8vYn0RkzhTmBCAJ9kvtTjLu9Q0rKPOn
        0ZU8cLoutUJGiR7Ij1OS7Yp8ay0x3vpfRGMQT53Vu0fgWupl3p3lAR+ruO125Hkv
        HE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 528341C6C76;
        Tue, 20 Sep 2022 13:52:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 137E81C6C75;
        Tue, 20 Sep 2022 13:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] t: remove \{m,n\} from BRE grep usage
References: <cover.1663688697.git.congdanhqx@gmail.com>
        <752b12ef1e27d3b69d6aa3734309895082be7886.1663688697.git.congdanhqx@gmail.com>
Date:   Tue, 20 Sep 2022 10:52:20 -0700
Message-ID: <xmqq35cm6ii3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FA5A1CE6-390C-11ED-80B4-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> \{m,n\} is a GNU extension to BRE, and it's forbidden by our
> CodingGuidelines.

Is it?

https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#=
tag_09_03_06

says otherwise.  There may be some other GNU extensions to BRE that
allows you to write ERE elements with different syntax, but I doubt
this is one of them.  Perhaps you are thinking about "A\|B"
alternation?  In ERE "A|B" is alternation, and GNU BRE allows "A\|B"
but that is outside POSIX, IIUC.  "A\+" (1 or more of A) and "A\?"
(0 or 1 of A) are the same way.

We do say we don't use "\{m,n\}" in the guidelines, which was
written more than 10 years ago that codifies the habit acquired
while having to deal with regexp implementations of various UNIX
variants like early SystemV and BSD4 from more than 20 years ago.

If we are using the syntax in many of our tests that everybody runs,
that can be taken as a sign that those platforms who had problems
with the syntax have died out, or at least to them Git does not
matter.

So my prefererence is to

 - Allow \{m,n\} when it makes sense and codify it in the guidelines

 - Rewriting tests is fine if it makes the result easier to read,
   but it shouldn't be done for the sole purpose of getting rid of
   the \{m,n\} syntax.

 - As there are folks without GNU, until these GNU extensions for |,
   +, and ? are adopted widely, keep forbidding their use in BRE.

>  test_expect_success 'git branch -M baz bam should add entries to .git/=
logs/HEAD' '
>  	msg=3D"Branch: renamed refs/heads/baz to refs/heads/bam" &&
> -	grep " 0\{40\}.*$msg$" .git/logs/HEAD &&
> -	grep "^0\{40\}.*$msg$" .git/logs/HEAD
> +	zero=3D"00000000" &&
> +	zero=3D"$zero$zero$zero$zero$zero" &&
> +	grep " $zero.*$msg$" .git/logs/HEAD &&
> +	grep "^$zero.*$msg$" .git/logs/HEAD
>  '

This is not good

>  test_expect_success 'git branch -M should leave orphaned HEAD alone' '
> diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
> index 22ffe5bcb9..aa3bb2e308 100755
> --- a/t/t3305-notes-fanout.sh
> +++ b/t/t3305-notes-fanout.sh
> @@ -9,7 +9,7 @@ path_has_fanout() {
>  	path=3D$1 &&
>  	fanout=3D$2 &&
>  	after_last_slash=3D$(($(test_oid hexsz) - $fanout * 2)) &&
> -	echo $path | grep -q "^\([0-9a-f]\{2\}/\)\{$fanout\}[0-9a-f]\{$after_=
last_slash\}$"
> +	echo $path | grep -q -E "^([0-9a-f][0-9a-f]/){$fanout}[0-9a-f]{$after=
_last_slash}$"

The use of -E makes it more readable and is good.  The innermost "a
pair of hexdigits" that would repeat $fanout times may be easier to
read if you keep the {2}, though.

