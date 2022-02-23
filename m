Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7211C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 04:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiBWEj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 23:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBWEj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 23:39:27 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95321387BC
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 20:39:00 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E567D118A9F;
        Tue, 22 Feb 2022 23:38:57 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=mSxmvHGQWrzYHCiKqkACbPvuOKRmlTF3bV9sIav
        AEJ8=; b=wFz41grBiScet7whl4xgaN94Vhb/1puiQLKJrb0xYGZQ6gd2aYUZv3K
        UN1Fqir+OaCEGN8PnPkDGyWU+ujVAfsKeKVUqSdCdg8wtweKcH+oSwehMNN9nyKd
        0T71z9isMkIgwe0GWlWmul1dCUd8zTGtPm1Z7wSgC81p23bpt1qw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDAE7118A9E;
        Tue, 22 Feb 2022 23:38:57 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F43D118A9D;
        Tue, 22 Feb 2022 23:38:57 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Tue, 22 Feb 2022 23:38:55 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
Message-ID: <YhW6Xx5iVqVleUYc@pobox.com>
References: <20220203123724.47529-1-fs@gigacodes.de>
 <Yfw0kapgSSWO3Pyx@pobox.com>
 <20220207105240.dk443kcozynlonpp@fs>
 <YgFK+F6Ks8FnN5Q6@pobox.com>
 <20220209083351.dsoxnhhme3lracck@fs>
 <YgPpsJ1UCEI0a4b6@pobox.com>
 <20220221092234.6kg66c3tuo2pya2a@fs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221092234.6kg66c3tuo2pya2a@fs>
X-Pobox-Relay-ID: 83700CE8-9462-11EC-9CB8-CB998F0A682E-09356542!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer wrote:
> On 09.02.2022 11:20, Todd Zullinger wrote:
>> Interesting.  I do have a patch in my gnupg-2.3 series to
>> reload the gpg agent after changing the trustlist, as the
>> changes were not picked up prior to that.  In my case, I was
>> running the tests in an environment where gpg could not
>> prompt me.  (It also seems like we should try harder to have
>> the test suite reject such prompts).
>> 
> 
> Yes, gpg-agent in general can be problematic for the tests. I'm not familiar
> enough with gpg but I don't know if we can get by without it?

With modern gnupg, the secret keyring access is handled by
gpg-agent.  So it's no longer optional, which is mildly
unfortunate for automated tests..

>> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>> index 6bc083ca77..38e2c0f4fb 100644
>> --- a/t/lib-gpg.sh
>> +++ b/t/lib-gpg.sh
>> @@ -75,6 +75,7 @@ test_lazy_prereq GPGSM '
>> 	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
>> 	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
>> 		>"${GNUPGHOME}/trustlist.txt" &&
>> +	(gpgconf --reload all || : ) &&
>> 
>> 	echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
>> 	       -u committer@example.com -o /dev/null --sign -
>> 
>> --- 8< ---
> 
> This patch fixes it for me.

Excellent.

> I have prepared the patch with the simple strstr() matching I can post in a
> bit. I would add your two gpg test lib patches to it if thats ok?

Absolutely.  Thank you for working on this and pulling it
together.

Cheers,

-- 
Todd
