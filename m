Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC101F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 19:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755801AbcIFTpy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 6 Sep 2016 15:45:54 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:38168 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754593AbcIFTpy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2016 15:45:54 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail)
        by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
        iface 141.3.10.81 id 1bhMJa-0002d0-Sm; Tue, 06 Sep 2016 21:45:50 +0200
Received: from apache by webmail with local (Exim 4.84_2)
        (envelope-from <szeder@ira.uka.de>)
        id 1bhMJa-0003Bx-Py; Tue, 06 Sep 2016 21:45:50 +0200
Received: from x590cf886.dyn.telefonica.de (x590cf886.dyn.telefonica.de
 [89.12.248.134]) by webmail.informatik.kit.edu (Horde Framework) with HTTPS;
 Tue, 06 Sep 2016 21:45:50 +0200
Date:   Tue, 06 Sep 2016 21:45:50 +0200
Message-ID: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
From:   SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, leho@conversionready.com
Subject: Re: 2.10.0: multiple versionsort.prereleasesuffix buggy?
References: <20160905232145.fr46rgfb66eeymwp@sigill.intra.peff.net>
 <20160906010759.14883-1-szeder@ira.uka.de>
 <20160906040739.37otpk3l2wt7qfbb@sigill.intra.peff.net>
In-Reply-To: <20160906040739.37otpk3l2wt7qfbb@sigill.intra.peff.net>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1473191150.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,


Quoting Jeff King <peff@peff.net>:

> On Tue, Sep 06, 2016 at 03:07:59AM +0200, SZEDER Gábor wrote:
>
>>> So that seems wrong. Even weirder, if I set _only_ "-beta", I get:
>>>
>>>  $ git tag -l --sort=version:refname | grep -v ^2.6.0
>>>  2.6.0-beta-2
>>>  2.6.0-beta-3
>>>  2.6.0-beta-4
>>>  2.6.0
>>>  2.6.0-RC1
>>>  2.6.0-RC2
>>>  2.6.0-beta-1
>>>
>>> Umm...what? beta-1 is sorted away from its companions? That's weird.
>>>
>>> I wondered if the presence of "-" after the suffix ("beta-1" rather than
>>> "beta1") would matter. It looks like that shouldn't matter, though; it's
>>> purely doing a prefix match on "do these names differ at a prerelease
>>> suffix".
>>>
>>> But something certainly seems wrong.
>>
>> Some of the weirdness is caused by the '-' at the _beginning_ of the
>> suffixes, because versioncmp() gets confused by suffixes starting with
>> the same character(s).
>
> Oh, right, that makes sense. So it's effectively not finding _any_
> suffix between X-RC1 and X-beta-1, because we only start looking after
> "X-", and none of them match.
>
> I am still confused why "2.6.0-beta-1" doesn't get sorted with its
> peers. I'd guess that the comparison function doesn't actually provide a
> strict ordering, so the results depend on the actual sort algorithm, and
> which pairs it ends up comparing.

Turns out that this weirdness is caused by that leading '-' in the suffix,
too.

Here is a manageably small recipe to reproduce:

     $ git -c versionsort.prereleasesuffix=-beta tag -l  
--sort=version:refname v2.1.0* v2.1.{1,2}
     v2.1.0-beta-2
     v2.1.0-beta-3
     v2.1.0
     v2.1.0-RC1
     v2.1.0-RC2
     v2.1.0-beta-1
     v2.1.1
     v2.1.2

Tracing which pairs of tagnames are compared, I found that somewhere along
the line "v2.1.0-beta-1" happens to be compared to "v2.1.0-RC2", and the
issue described in my previous email strikes again: the '-' is part of the
common part of the two tagnames, swap_prereleases() gets only "beta-1" and
"RC2", thus it can't match the configured "-beta" suffix, and since the
byte value of 'b' is higher than that of 'R', "-beta-1" is sorted after
"-RC2".  OTOH, "v2.1.0-beta-2" and "v2.1.0-beta-3" are only compared to
each other or to final release tags, but never to any "-RCx" tags, hence
they are sorted properly.

Once I finish teaching versioncmp() and swap_prereleases() to cope with
leading characters of a prereleaseSuffix being part of the common part of
two tagnames, this out-of-order "beta-1" issue will be gone as well.

Best,
Gábor
