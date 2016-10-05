Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEC220986
	for <e@80x24.org>; Wed,  5 Oct 2016 01:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbcJEBeE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 4 Oct 2016 21:34:04 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:53080 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752651AbcJEBeD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Oct 2016 21:34:03 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail)
        by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
        iface 141.3.10.81 id 1brb5l-0001G9-Er; Wed, 05 Oct 2016 03:33:53 +0200
Received: from apache by webmail with local (Exim 4.84_2)
        (envelope-from <szeder@ira.uka.de>)
        id 1brb5l-0004pl-CV; Wed, 05 Oct 2016 03:33:53 +0200
Received: from x4db0ff72.dyn.telefonica.de (x4db0ff72.dyn.telefonica.de
 [77.176.255.114]) by webmail.informatik.kit.edu (Horde Framework) with
 HTTPS; Wed, 05 Oct 2016 03:33:53 +0200
Date:   Wed, 05 Oct 2016 03:33:53 +0200
Message-ID: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
From:   SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Leho Kraav <leho@conversionready.com>,
        =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] versioncmp: cope with common leading parts in
 versionsort.prereleaseSuffix
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de>
 <20160907151251.30978-6-szeder@ira.uka.de>
 <20160907174841.Horde.Ru1LBEeLKomznlWVG-ZnS-Q@webmail.informatik.kit.edu>
In-Reply-To: <20160907174841.Horde.Ru1LBEeLKomznlWVG-ZnS-Q@webmail.informatik.kit.edu>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1475631233.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Quoting SZEDER Gábor <szeder@ira.uka.de>:

> Quoting SZEDER Gábor <szeder@ira.uka.de>:
>
>> Version sort with prerelease reordering sometimes puts tagnames in the
>> wrong order, when the common part of two compared tagnames ends with
>> the leading character(s) of one or more configured prerelease
>> suffixes.
>>
>> $ git config --get-all versionsort.prereleaseSuffix
>> -beta
>> $ git tag -l --sort=version:refname v2.1.*
>> v2.1.0-beta-2
>> v2.1.0-beta-3
>> v2.1.0
>> v2.1.0-RC1
>> v2.1.0-RC2
>> v2.1.0-beta-1
>> v2.1.1
>> v2.1.2
>>
>> The reason is that when comparing a pair of tagnames, first
>> versioncmp() looks for the first different character in a pair of
>> tagnames, and then the swap_prereleases() helper function checks for
>> prerelease suffixes _starting at_ that character.  Thus, when in the
>> above example the sorting algorithm happens to compare the tagnames
>> "v2.1.0-beta-1" and "v2.1.0-RC2", swap_prereleases() will try to match
>> the suffix "-beta" against "beta-1" to no avail, and the two tagnames
>> erroneously end up being ordered lexicographically.
>>
>> To fix this issue change swap_prereleases() to look for configured
>> prerelease suffixes containing that first different character.
>
> Now, while I believe this is the right thing to do to fix this bug,
> there is a corner case, where multiple configured prerelease suffixes
> might match the same tagname:
>
>  $ git config --get-all versionsort.prereleaseSuffix
>  -bar
>  -baz
>  -foo-bar
>  $ ~/src/git/git tag -l --sort=version:refname
>  v1.0-foo-bar
>  v1.0-foo-baz
>
> I.e. when comparing these two tags, both "-bar" and "-foo-bar" would
> match "v1.0-foo-bar", and as "-bar" comes first in the config file,
> it wins, and "v1.0-foo-bar" is ordered first.  An argument could be
> made to prefer longer matches, in which case "v1.0-foo-bar" would be
> ordered according to "-foo-bar", i.e. as second.  However, I don't
> know what that argument could be, to me neither behavior is better
> than the other, but the implementation of the "longest match counts"
> would certainly be more complicated.
>
> The argument I would make is that this is a pathological corner case
> that doesn't worth worrying about.

After having slept on this a couple of times, I think the longest
matching prerelease suffix should determine the sorting order.

A release tag usually consists of an optional prefix, e.g. 'v' or
'snapshot-', followed by the actual version number, followed by an
optional suffix.  In the contrived example quoted above this suffix
is '-foo-bar', thus it feels wrong to match '-bar' against it, when
the user explicitly configured '-foo-bar' as prerelease suffix as
well.

Then here is a more realistic case for sorting based on the longest
matching suffix, where

   - a longer suffix starts with the shorter one,
   - and the longer suffix comes after the shorter one in the
     configuration.

With my patches it looks like this:

    $ git -c versionsort.prereleasesuffix=-pre \
          -c versionsort.prereleasesuffix=-prerelease \
          tag -l --sort=version:refname
    v1.0.0-prerelease1
    v1.0.0-pre1
    v1.0.0-pre2
    v1.0.0

Yeah, having both '-pre' and '-prerelease' suffixes seems somewhat
silly, but who knows what similar but more reasonable prerelease
suffixes e.g. non-English speaking users might use in their native
language.

Anyway, my intuition says that any '-prereleaseX' tags should come
after all the '-preX' tags.  (Ironically, current git just happens
to get this particular case right.)

My patches get this wrong, because they look for prerelease suffixes
_containing_ the first different character.  However, when a '-preX'
and a '-prereleaseX' tag are compared, then the whole '-pre' suffix
is part of the common part, thus it doesn't match, only '-prerelease'
matches.

So, to sort this case right the implementation should

   - look for a prerelease suffix containing the first different
     character or ending right before the first different character,
     (This means that when comparing 'v1.0.0-pre1' and 'v1.0.0-pre2'
     swap_prereleases() would match '-pre' in both: no big deal, it
     should return "undecided" and let the caller do the right thing
     by sorting based on '1' and '2')

   - and sort a tag based on the longest matching prerelease suffix.
     (In my quoted email above I alluded that its implementation must
     be more complicated.  No, it turns out that it actually isn't.)

(Just for the record: it's still not 100% foolproof, though.  Someone
asking for trouble might use letters instead of numbers to indicate
subsequent prereleases, and might have tags 'v1.0-prea', 'v1.0-preb',
..., 'v1.0-prer', and 'v1.0-prerelease'.  In this case the sorting
algorithm might happen to decide to compare 'v1.0-prer' and
'v1.0-prerelease', and since the common part is 'v1.0-prer' it will
fail to recognize the '-pre' suffix.  I don't see how this case could
be supported in a sane way, or why it's worth to support it.)

And a final sidenote: sorting based on the longest matching suffix
also allows us to (ab)use version sort with prerelease suffixes to
sort postrelease tags as we please, too:

   $ ~/src/git/git -c versionsort.prereleasesuffix=-alpha \
                   -c versionsort.prereleasesuffix=-beta \
                   -c versionsort.prereleasesuffix= \
                   -c versionsort.prereleasesuffix=-gamma \
                   -c versionsort.prereleasesuffix=-delta \
                   tag -l --sort=version:refname 'v3.0*'
   v3.0-alpha1
   v3.0-beta1
   v3.0
   v3.0-gamma1
   v3.0-delta1

So, unless I hear a counterargument, I will submit a reroll with
longest matching suffix determining sort order added on top once I
get around to finish up its commit message.

Best,
Gábor

