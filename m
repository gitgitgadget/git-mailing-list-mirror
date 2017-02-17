Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A54D9201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964901AbdBQXkb (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:40:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61502 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964862AbdBQXkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:40:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C432169197;
        Fri, 17 Feb 2017 18:40:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=wDahcHq+fFpqw/HgaQUKSBWH8yU=; b=gZPvU7
        B6QsCS9N1Fx8BdMnphJZ20V8l/vHgZjhVl/00nSHgL2iCy83CAuUDCrv5n+/hNEM
        S87ub0L4aTC6nvB95nVaaF0lcAkpNlzGJ6WDoMRiancbATd8WA5wIiLhHuFLQ88I
        ukHHg5sTjNdH9aIr1s4McoZoRwElfXLXjpkNI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA12D69196;
        Fri, 17 Feb 2017 18:40:29 -0500 (EST)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2EE7C69193;
        Fri, 17 Feb 2017 18:40:29 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] update-ref: pass reflog message argument to delete_refs
In-Reply-To: <20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net> <20170217035800.13214-1-kyle@kyleam.com> <20170217035800.13214-3-kyle@kyleam.com> <20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 18:40:28 -0500
Message-ID: <8737fcqtcj.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76EEECF6-F56A-11E6-BCED-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=wDahcHq+fFpqw/HgaQUKSBWH8yU=; b=F/xEgNERhtJqC9xh+XL/gHGQTxgefDn5Ee5wVde7JHCoxb8MQKacn0ah0a9ynNmcd+E9RsFuPxAcW2zG1ikg5oa8ZJP3gmOPXNPQssNgp/NncrGNTEyjB7Eb+wsqvyzYfOct2xn8EG/QkTAxdk3GcQBcEEzXQBTT12lMWqy+rFM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

[...]

>> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
>> index b0ffc0b57..65918d984 100755
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -85,6 +85,15 @@ test_expect_success "delete $m (by HEAD)" '
>>  '
>>  rm -f .git/$m
>>  
>> +test_expect_success "deleting current branch adds message to HEAD's log" '
>> +	git update-ref $m $A &&
>> +	git symbolic-ref HEAD $m &&
>> +	git update-ref -mdelmsg -d $m &&
>> +	! test -f .git/$m &&
>> +	grep "delmsg$" .git/logs/HEAD >/dev/null
>> +'
>> +rm -f .git/$m
>
> I think covering this with a test is good.
>
> I don't know if it's also worth testing that deleting via HEAD also
> writes the reflog. I.e.,:
>
>   git update-ref -m delete-by-head -d HEAD

Seems reasonable to cover this case as well.

> Some of the style here is a bit out-dated, but I think you are just
> matching the surrounding tests.  So that's OK by me (though a patch to
> modernize the whole thing would be welcome, too).

Right.  I'd be happy to follow up with a patch updating the style in
t1400-update-ref.sh.

> For reference, the two things I notice are:
>
>   - we prefer test_path_is_missing to "! test -f" these days.
>
>   - we don't redirect the output of grep (it's handled already in
>     non-verbose mode, and in verbose mode we try to be...verbose).

Would moving cleanup like "rm -f .git/$m" within the test's body using
test_when_finished also be preferred?

-- 
Kyle
