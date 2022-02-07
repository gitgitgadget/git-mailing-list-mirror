Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8D5C43217
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 16:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbiBGQqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377058AbiBGQjj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 11:39:39 -0500
X-Greylist: delayed 79 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 08:39:39 PST
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32761C0401D1
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 08:39:39 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E255C10F06B;
        Mon,  7 Feb 2022 11:38:18 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=qiEkOlMJuM5SwicdHnjjpm3in2Du907Az+26+Cp
        zt/0=; b=eu1IxTKaYhpWYzbRx91eyJXl8KbV04G6OAzD4P9Qx5KTVktJg911nyq
        IFFO7dQRUFHmUeXAcpTh+syIed8O11/olK2QD6VV6qWopoXXKnyAnj3B/vY0v3u5
        qb1DKhjYz0XoZU8nswjD3+QdZCE8X/Sz9F+dWMDGL3EQgQSp2dnY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D934410F06A;
        Mon,  7 Feb 2022 11:38:18 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5339610F068;
        Mon,  7 Feb 2022 11:38:18 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Mon, 7 Feb 2022 11:38:16 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
Message-ID: <YgFK+F6Ks8FnN5Q6@pobox.com>
References: <20220203123724.47529-1-fs@gigacodes.de>
 <Yfw0kapgSSWO3Pyx@pobox.com>
 <20220207105240.dk443kcozynlonpp@fs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207105240.dk443kcozynlonpp@fs>
X-Pobox-Relay-ID: 5AC260FA-8834-11EC-90A3-CB998F0A682E-09356542!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fabien,

Fabian Stelzer wrote:
> On 03.02.2022 15:01, Todd Zullinger wrote:
>> (To be clear, I mean "clever and wrong" in regard to my use
>> of the string list API, not anyone else's code.)
>
> string_list_split seems a bit like overkill.

I have little doubt that the string_list_split() method is
far from ideal. :)

> I looked for sth like this but gpgs --help does not list it so i didn't dig
> deeper. I've checked the blame and it seems like this was introduced >19
> years ago. So i guess we can probably use this ^^

Indeed, the --with-colons output goes much further back in
the GnuPG history than Git will ever have to care about.

>>    --- a/t/lib-gpg.sh
>>    +++ b/t/lib-gpg.sh
>>    @@ -72,12 +72,10 @@ test_lazy_prereq GPGSM '
>>                    --passphrase-fd 0 --pinentry-mode loopback \
>>                    --import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
>> 
>>    -	gpgsm --homedir "${GNUPGHOME}" -K |
>>    -	grep fingerprint: |
>>    -	cut -d" " -f4 |
>>    -	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
>>    +	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
>>    +	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
>>    +		>"${GNUPGHOME}/trustlist.txt" &&
> 
> This does not quite work for me. It will add the fingerprint without the
> colons into the trustlist which is not valid :/

The colons are optional, and have been documented as such
since cb1840720 ((Agent Configuration): New section.,
2005-04-20).  The text in the gpg-agent docs from GnuPG 2.2
say:

    Colons may optionally be used to separate the bytes of a
    fingerprint; this enables cutting and pasting the
    fingerprint from a key listing output.

Source: https://dev.gnupg.org/source/gnupg/browse/STABLE-BRANCH-2-2/doc/gpg-agent.texi;8021fe7670c79d5c698ec3fb600b02a9e5afb415$756?as=source&blame=off

How did it fail for you?  It passes all the tests when I've
run it against Fedora and RHEL-based hosts.  If it's flaky
on other systems, that would put a damper on doing it this
way.  Though it _should_ work.

[Note to myself] We don't just generate the key data,
trustlist, etc. and store it in t/lib-gpg like we do with
some other files per b41a36e635 (tests: create gpg homedir
on the fly, 2014-12-12).  That was because the gnupg home
directory layout changed a bit between 2.0 and 2.1.

Thanks,

-- 
Todd
