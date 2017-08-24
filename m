Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B1E20285
	for <e@80x24.org>; Thu, 24 Aug 2017 14:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbdHXOPI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 24 Aug 2017 10:15:08 -0400
Received: from 10.mo64.mail-out.ovh.net ([87.98.138.33]:52057 "EHLO
        10.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdHXOPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 10:15:07 -0400
X-Greylist: delayed 108255 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Aug 2017 10:15:07 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id AEBCB8B0B2;
        Thu, 24 Aug 2017 16:15:05 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Aug 2017 16:15:05 +0200
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
To:     Jeff King <peff@peff.net>
CC:     <git@vger.kernel.org>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
 <20170816083432.rgurgckch6phcul3@sigill.intra.peff.net>
 <0beb0a6c-acb3-ae24-5c52-95747f74c07f@suse.de>
 <20170823214349.k4ayl2urqepch7p4@sigill.intra.peff.net>
 <e11d4449-8377-dbd7-3ad5-441baf7446b6@morey-chaisemartin.com>
 <20170824135331.27wtwicjuoiyremx@sigill.intra.peff.net>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <2875ec38-9d22-ef94-28e5-7b9c6855139d@morey-chaisemartin.com>
Date:   Thu, 24 Aug 2017 16:15:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <20170824135331.27wtwicjuoiyremx@sigill.intra.peff.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS4.indiv2.local (172.16.1.4) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 16098398346823198685
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtdeggdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 24/08/2017 à 15:53, Jeff King a écrit :
> On Thu, Aug 24, 2017 at 10:00:47AM +0200, Nicolas Morey-Chaisemartin wrote:
>
>>> Yes, I agree. I was hoping when we started this discussion that we were
>>> more ready to switch to curl-by-default. But sadly, that isn't close to
>>> being the case. But hopefully we can at least end up with logic that
>>> lets us use it in the easy cases (no tunneling) and falls back in the
>>> harder ones.
>> I opened a bug upstream and they already fixed this.
>> https://github.com/curl/curl/pull/1820
> Cool! That's much faster than I had expected. :)
>
>> At least bleeding edge curl user should be able to use this.
>> I'm not sure where to go with these patches now.
>>
>> 1) There does not seem to be an easy/clean workaround for the lack of socketpair on windows.
>> Fidling with a loopback AF_UNIX?AF_LOCAL socket should work but it
>> means creating a socket file somewhere which pulls a lot of potential
>> issues (where to put it ? Post-mortem cleanup ? Parallel imap-send ?)
> Even if you create a non-anonymous socket and connect to both ends, I'm
> not sure how it works to pass that to the spawned child. IIRC, our
> run_command emulation cannot pass arbitrary descriptors to the child
> processes (but I don't know the details of why that is the case, or if
> there are windows-specific calls we could be making to work around it).
Well as long as we can map it on a fd, the dup2 trickery should allow to remap whatever solution we pick to stdin/stdout.
Could this code be put in a #ifndef WINDOWS ?

>
>> 2) The PREAUTH support won't largely be available  for a while (curl,
>> release, distro, etc.)
>> - If this is the main use case, it does not make much sense to puch
>> curl; tunneling support without this. I could push the code and only
>> enable the curl tunneling for the next curl release ?
>>   Meaning no one (or close to no one) would use this until some later
>>   This also means very little testing (apart from mine) until the next
>> curl version gets widely available
>> - If this is not the main case (or at least the non PREAUTH is
>> important enough), it would make sense to get this changes in.
>>   But it would probably need some more to code to either fallback to
>> legacy mode when curl failed (due to PREAUTH) or detect PREAUTH and
>> directly use the legacy mode.
> It seems like we should be able to hit the cases that we know work out
> of the box, and just hold back the default for the others. Like:
>
>   static int use_curl_auto(void)
>   {
>   #ifndef USE_CURL_FOR_IMAP_SEND
> 	/* not built; we cannot use it */
> 	return 0;
>   #else
> 	if (srvc->tunnel) {
>   #if LIBCURL_VERSION < ...
> 		/* no preauth support */
> 		return 0;
>   #else
> 		return 1;
>   #endif /* LIBCURL_VERSION < ... */
> 	}
> 	... other checks go here ...
>   #endif /* USE_CURL */
>   }
>
>   ...
>   int use_curl = -1; /* auto */
>   ... set use_curl to 0/1 from --curl/--no-curl command line */
>   if (use_curl < 0)
>       use_curl = use_curl_auto();
>
> I'm not sure what other cases are left. But over time we'd hope that
> use_curl_auto() would shrink to just "return 1", at which point
> everybody is using it (and we can drop the fallback code).
>

This code works but I'm not that confortable getting code into master that will have been pretty much untested (I doubt there are many git pu/next user that run the bleeding edge curl on their setup)
and that may just break down once curl gets updated.
It has only been tested using the example line from imap-send man page which is a tiny coverage and I'm sure there are some IMAP server with funky interpreation of the standard out there (who said Exchange?)

Nicolas

