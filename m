Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 674C21F600
	for <e@80x24.org>; Thu, 20 Jul 2017 20:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934707AbdGTUA1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 16:00:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59982 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934609AbdGTUA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 16:00:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B99FB7714F;
        Thu, 20 Jul 2017 16:00:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FOWZdp85aUybrNTcDQVPMH8XWIM=; b=xmRgtD
        2Q56QEIckAtoZu/krjOJyJom8xXRtQcsVpL+4a3vh71L3HXc1fkifZ/Hi5VqwgiT
        furEwMyFfH0rc7/FfyFzVyW9UyidVsil+D9RbitUR9uYgYoxIhlG2bOCKdzZ13Ch
        qvu0yhZpWGyNKFv/UlDOqrPBj8seh1ZAFMxeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HzgiDogmSJscie6LRcrd1bNM8NMlChuE
        GYFAAg03Yj3xlJvsW/rluQrSEAWs/ZvZUUgafXbIb8tV37ZKTJ1P8FE+d5mM4hnj
        yhsb82nfeMLzfEzYH40dwwl2Mz82WsXlbqsC+VbkdllMC6KCWxSxNsXySVB2qYXH
        XTCbyVkQ5pA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB5567714E;
        Thu, 20 Jul 2017 16:00:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1ABC57714D;
        Thu, 20 Jul 2017 16:00:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t: lib-gpg: flush gpg agent on startup
References: <20170720165814.30037-1-santiago@nyu.edu>
        <20170720170113.fvquowatpv4ms6if@LykOS.localdomain>
Date:   Thu, 20 Jul 2017 13:00:17 -0700
In-Reply-To: <20170720170113.fvquowatpv4ms6if@LykOS.localdomain> (Santiago
        Torres's message of "Thu, 20 Jul 2017 13:01:14 -0400")
Message-ID: <xmqq379qlvzi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DB6933A-6D86-11E7-8E48-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

> This is the patch that stemmed from [1].
>
> I tried to keep it simple and not noisy, alhtough it breaks the &&
> chain, it needs to be run right before the --import command. I also
> decided to drop the switch chain in case that regression was to be
> introduced in the future in other versions (hopefully gpgconf goes
> nowhere by then).

I'm inclined to do

	...
	export GNUPGHOME &&
	( gpgconf --kill gpg-agent 2>&1 >/dev/null || : ) &&
	gpg --homedir ... --import ...

Imagine "chmod 0777 ./gpghome" failed and what happens. We skip the
part that exports GNUPGHOME and attempts to kill gpg-agent as if
nothing bad happened, and then we try to "--import".  At that point
we do not know what value GNUPGHOME has---are we clobbering the real
keychain the user who runs the test has?

With that "run it but ignore the outcome even if we failed to.", we
do not have to worry about any of that ;-)

>
> I was able to test this on debian oldstable/stable and arch.
>
> Cheers!
> -Santiago.
>
> [1] https://public-inbox.org/git/xmqqvampmnmv.fsf@gitster.mtv.corp.google.com/
>
> On Thu, Jul 20, 2017 at 12:58:14PM -0400, santiago@nyu.edu wrote:
>> From: Santiago Torres <santiago@nyu.edu>
>> 
>> When running gpg-relevant tests, a gpg-daemon is spawned for each
>> GNUPGHOME used. This daemon may stay running after the test and cache
>> file descriptors for the trash directories, even after the trash
>> directory is removed. This leads to ENOENT errors when attempting to
>> create files if tests are run multiple times.
>> 
>> Add a cleanup script to force flushing the gpg-agent for that GNUPGHOME
>> (if any) before setting up the GPG relevant-environment.
>> 
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Santiago Torres <santiago@nyu.edu>
>> ---
>>  t/lib-gpg.sh | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>> index ec2aa8f68..7a6c7ee6f 100755
>> --- a/t/lib-gpg.sh
>> +++ b/t/lib-gpg.sh
>> @@ -31,6 +31,7 @@ then
>>  		chmod 0700 ./gpghome &&
>>  		GNUPGHOME="$(pwd)/gpghome" &&
>>  		export GNUPGHOME &&
>> +		gpgconf --kill gpg-agent 2>&1 >/dev/null
>>  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
>>  			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
>>  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
>> -- 
>> 2.13.3
>> 
