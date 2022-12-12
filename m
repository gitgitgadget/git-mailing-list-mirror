Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C69C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 15:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiLLPiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 10:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiLLPhz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 10:37:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5397F12A8F
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 07:37:52 -0800 (PST)
Received: from [192.168.1.90] (unknown [86.123.78.117])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 155106602AE1;
        Mon, 12 Dec 2022 15:37:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670859471;
        bh=lakwaJ+ozh5QDO3DLq732NR4FOybQfG4Pbk9qgjqJgU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XDXOQi13284CU99cgprvf7CNDrWnhgN8riD8uEKU2quiBhBeoVc/URgTuv1DZAC3f
         Nar+79U12qoEm/ekoMTAI9tmAINT6Di0OpfspgbyTI2BfwK++OtHDG7TTz4nuJHq20
         WApJynQvacqt0gYgkqol7g6+rsJXCqWaXWQITWE0fdTxp6Wr11nGkr+9AXZm8ZHcGm
         S8Jck0P5pUU1o1eyc+ySqr3bWCpTjCCBSFzdFZxec0IU+xKXDhHEC5K0ShVjJbiuOB
         9pdj/cWsGYXFoZoF23Q300H1UWoquxQTQ4Mhag9+rZR28K5fty3zx5X7zDh+LIOOyu
         yxS1ECGpLWAXQ==
Message-ID: <0a5808eb-666e-26ed-edfa-69cc7752ea41@collabora.com>
Date:   Mon, 12 Dec 2022 17:37:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 1/1] rebase --onto: Skip previously applied commits
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
 <20221212113516.27816-2-cristian.ciocaltea@collabora.com>
 <221212.86cz8o6bwp.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <221212.86cz8o6bwp.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/12/22 14:27, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 12 2022, Cristian Ciocaltea wrote:
> 
>> When rebase is used with '--onto <newbase>', the patches that might have
>> been already applied on <newbase> are not detected, unless they resolve
>> to an empty commit. When the related files contain additional changes
>> merged, the rebase operation fails due to conflicts that require manual
>> intervention.
>>
>> Ensure the '--onto' variant behaviour is consistent with the common
>> rebase by dropping the already applied commits on the target branch.
>>
>> Note the current behavior is still reachable by using the
>> '--reapply-cherry-picks' flag.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   builtin/rebase.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index b22768ca5b9f..2907c6db5cce 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1659,8 +1659,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   		strbuf_addstr(&buf, "...");
>>   		strbuf_addstr(&buf, branch_name);
>>   		options.onto_name = xstrdup(buf.buf);
>> -	} else if (!options.onto_name)
>> +	} else if (!options.onto_name) {
>>   		options.onto_name = options.upstream_name;
>> +	} else if (options.upstream) {
>> +		options.restrict_revision = options.upstream;
>> +		options.upstream = NULL;
>> +	}
>>   	if (strstr(options.onto_name, "...")) {
>>   		if (get_oid_mb(options.onto_name, &branch_base) < 0) {
>>   			if (keep_base)
> 
> When I apply this & run the tests e.g. t3418 will segfault, and t3403
> seems to fail due to the new behavior not having adjusted the test.

Right, a bunch of the merge related tests are now failing, which is one 
of the reasons I submitted the patch as RFC. If this is not a (totally) 
wrong solution to the problem, I will try to get all the tests working 
in a subsequent patch revision.

> Which would be my "C" for the "RFC" :)
> 
> I.e. try to get the tests working, and not segfaulting.
> 
> If this is a good idea UX wise (I haven't formed an opinion) the main
> thing that should inform that is having to decide on the various cases
> that the tests are checking for already.
> 
> Do I understand this correctly that we'll currently stop and requise a
> "git rebase --continue" if we have an empty patch with "--onto", but
> without "--onto" we'll just print a warning, and that you'd like
> "--onto" to be consistent with the non-onto case?

The main use case I'm trying to address is the one described in the 
cover letter, mainly to avoid getting conflicts for the already applied 
commits when the rebase will not result in an empty patch anymore. This 
would be, indeed, consistent with the non-onto rebase variant.

Currently, "rebase --onto" behaves like "--reapply-cherry-picks" is 
being enforced, without having the possibility to disable it, which I 
found rather confusing and not expected.

Thanks for the quick feedback,
Cristian
