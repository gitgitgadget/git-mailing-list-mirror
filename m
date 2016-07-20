Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263AB1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 17:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbcGTR3C (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 13:29:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:42797 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbcGTR3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 13:29:00 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 8E9758463B;
	Wed, 20 Jul 2016 13:28:59 -0400 (EDT)
Subject: Re: [PATCH v1 1/6] Allow --porcelain[=<n>] in status and commit
 commands
To:	Jeff King <peff@peff.net>, Jeff Hostetler <jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-2-git-send-email-jeffhost@microsoft.com>
 <20160720155837.GA24902@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, gitster@pobox.com
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <578FB453.7080303@jeffhostetler.com>
Date:	Wed, 20 Jul 2016 13:26:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160720155837.GA24902@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/20/2016 11:58 AM, Jeff King wrote:
> On Tue, Jul 19, 2016 at 06:10:53PM -0400, Jeff Hostetler wrote:
>
>> +static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
>> +{
>> +	enum wt_status_format *value = (enum wt_status_format *)opt->value;
>> +	if (unset) {
>> +		*value = STATUS_FORMAT_UNSPECIFIED;
>
> Nice attention to detail here and below in handling "unset" and "!arg"
> cases.  I think should be STATUS_FORMAT_NONE, though, which is what the
> old code used to do (since "0" is the usual special value for --no-*
> options). It only matters if you do:
>
>    git status --no-porcelain
>
> Right now that will switch to the long format, regardless of your
> config. With your path it defaults to any configured value. It's
> probably a case that nobody hits ever, but in the absence of a good
> reason to do otherwise, I'd stick with the current behavior.

Good catch. I'll make it _NONE.

>
>> +	} else if (arg) {
>> +		int n = strtol(arg, NULL, 10);
>> +		if (n == 1)
>> +			*value = STATUS_FORMAT_PORCELAIN;
>> +		else
>> +			die("unsupported porcelain version");
>
> This silently allows:
>
>    git status --porcelain="1 for the money"
>
> and later:
>
>    git status --porcelain="2 for the show"
>
> Probably not a big deal in practice, but since the list of formats is
> constrained, we don't really care about parsing arbitrary numbers.
> So:
>
>    if (!strcmp(arg, "1"))
> 	*value = STATUS_FORMAT_PORCELAIN;
>
> is actually simpler, and more robust.
>
> I also wondered if:
>
>    git status --porcelain=v1
>
> is more self-documenting about the meaning of "1". It's purely
> aesthetics, but it somehow looks better to me. Matching that is also
> much easier with pure strcmps.

I wondered about making it =v1 rather than just =1. It seemed
more aesthetically pleasing, even if it was an extra character
to type.  In a later email in this thread you mention a JSON
option.  If I switched this here to be "=v1" and "=v2", it would
be easy later to have a "=j2" or "=v2j" to do that.


>
>> @@ -1381,6 +1392,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>>
>>   	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
>>   	s.ignore_submodule_arg = ignore_submodule_arg;
>> +	s.status_format = status_format;
>> +
>
> I wonder what happens if you pass a "wt_status" with a format of "SHORT"
> to the long-formatting code.
>
> I think it is ignored completely, as you are just now introducing the
> s.status_format field. But I wonder if there is room for further cleanup
> in pushing the big switch statements from run_status() and cmd_status()
> into wt-status.c.

I'll look into that.

Jeff
