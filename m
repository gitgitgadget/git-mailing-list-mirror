Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E9F1F62D
	for <e@80x24.org>; Thu,  5 Jul 2018 19:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbeGETvD (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 15:51:03 -0400
Received: from [195.159.176.226] ([195.159.176.226]:40843 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753828AbeGETvC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 15:51:02 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1fbAFE-0006Dp-8A
        for git@vger.kernel.org; Thu, 05 Jul 2018 21:48:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH] builtin/config: work around an unsized array forward
 declaration
Date:   Thu, 5 Jul 2018 21:50:53 +0200
Message-ID: <phlsmp$mot$1@blaine.gmane.org>
References: <20180705183445.30901-1-dev+git@drbeat.li>
 <20180705193807.GA4826@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
In-Reply-To: <20180705193807.GA4826@sigill.intra.peff.net>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 05.07.18 21:38, Jeff King wrote:
> On Thu, Jul 05, 2018 at 08:34:45PM +0200, Beat Bolli wrote:
> 
>> As reported here[0], Microsoft Visual Studio 2017.2 and "gcc -pedantic"
>> don't understand the forward declaration of an unsized static array.
>> They insist on an array size:
>>
>>     d:\git\src\builtin\config.c(70,46): error C2133: 'builtin_config_options': unknown size
>>
>> The thread [1] explains that this is due to the single-pass nature of
>> old compilers.
> 
> Right, that makes sense.
> 
>> To work around this error, introduce the forward-declared function
>> usage_builtin_config() instead that uses the array
>> builtin_config_options only after it has been defined.
>>
>> Also use this function in all other places where usage_with_options() is
>> called with the same arguments.
> 
> Your patch is obviously correct, but I think here there might be an even
> simpler solution: just bump option_parse_type() below the declaration,
> since it's the only one that needs it. That hunk is bigger, but the
> overall diff is simpler, and we don't need to carry that extra wrapper
> function.

That was dscho's first try in the GitHub issue. It doesn't compile
because the OPT_CALLBACK* macros in the builtin_config_options
declaration inserts a pointer to option_parse_type into the array items.
We need at least one forward declaration, and my patch seemed the least
intrusive.

> As a general rule for this case (because reordering isn't always an
> option), I also wonder if we should prefer just introducing a pointer
> alias:
> 
>   /* forward declaration is a pointer */
>   static struct option *builtin_config_options;
> 
>   /* later, declare the actual storage and its alias */
>   static struct option builtin_config_options_storage[] = {
> 	...
>   };
>   static struct option *builtin_config_options = builtin_config_options_storage;
> 
> There are occasionally cases where the caller really wants an array and
> not a pointer, but in practice those are pretty rare.
> 
> I have a slight preference for the reordering solution in this case, but
> any of them would be OK with me.
> 
> -Peff 

Regards, Beat

