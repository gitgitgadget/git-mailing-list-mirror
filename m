Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007A91FBB0
	for <e@80x24.org>; Fri,  9 Dec 2016 00:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932946AbcLIAWE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 19:22:04 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:38996 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932785AbcLIAWD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 19:22:03 -0500
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id DFA3C22693
        for <git@vger.kernel.org>; Fri,  9 Dec 2016 00:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1481242922;
        bh=5O+u0mmDQrjAs1OkIm9xfKJgLMHLrk2cb8OuZBx5nJ4=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=WofLqlLhKrl/ownbzowAtDbwiK8KZXhM1nKuaa47oRRdbLrW76fAb5Yhhcd8shNrQ
         VIt75lq8W6bJ5xDLv2lY9u8SUM1IdeXqg/IkXAO4ulkQ+VKZFfyruP+QC8CA79XBtY
         J6tIT6snK5BCNRYZxWUsyxYuCTeXOMSucruDhjQ4=
Received: from [192.168.0.10] (S0106c8fb26402908.ek.shawcable.net [24.66.132.201])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA;
        Fri,  9 Dec 2016 00:22:02 +0000 (UTC)
Subject: Re: [PATCH v4] diff: handle --no-abbrev in no-index case
To:     Junio C Hamano <gitster@pobox.com>
References: <20161206010134.21856-1-jack@nottheoilrig.com>
 <20161206165614.22921-1-jack@nottheoilrig.com>
 <xmqqtwaerq1x.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
From:   Jack Bates <bk874k@nottheoilrig.com>
Message-ID: <763ddb21-f735-342b-45a4-2f22e03dd346@nottheoilrig.com>
Date:   Thu, 8 Dec 2016 17:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqtwaerq1x.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/12/16 03:53 PM, Junio C Hamano wrote:
> Jack Bates <bk874k@nottheoilrig.com> writes:
>> @@ -3364,6 +3365,7 @@ void diff_setup(struct diff_options *options)
>>
>>  	options->file = stdout;
>>
>> +	options->abbrev = DEFAULT_ABBREV;
>
> This is a new change relative to your earlier one.
>
> I looked at all the callers of diff_setup() and noticed that many of
> them were initializing "struct diff_options" that is on-stack that
> is totally uninitialized, which means they were using a completely
> random value that happened to be on the stack.
>
> Which was surprising and made me wonder how the entire "diff" code
> could have ever worked correctly for the past 10 years, as it's not
> like all the users always passed --[no-]abbrev[=<value>] from the
> command line.
>
> In any case, this cannot possibly be introducing a regression; these
> callsites of diff_setup() were starting from a random garbage---now
> they start with -1 in this field.  If they were doing the right
> thing by assigning their own abbrev to the field after diff_setup()
> returned, they will continue to do the same, and otherwise they will
> keep doing whatever random things they have been doing when the
> uninitialized field happened to contain -1 the same way.
>
> I didn't look carefully at the additional tests, but the code change
> looks good.
>
> Thanks.

Great, thanks for reviewing it!
