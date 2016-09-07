Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B201F859
	for <e@80x24.org>; Wed,  7 Sep 2016 15:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbcIGPtL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 7 Sep 2016 11:49:11 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48834 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753560AbcIGPtH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 11:49:07 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail)
        by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
        iface 141.3.10.81 id 1bhf5d-0000CB-SV; Wed, 07 Sep 2016 17:48:41 +0200
Received: from apache by webmail with local (Exim 4.84_2)
        (envelope-from <szeder@ira.uka.de>)
        id 1bhf5d-0004Mr-Py; Wed, 07 Sep 2016 17:48:41 +0200
Received: from x590d6d43.dyn.telefonica.de (x590d6d43.dyn.telefonica.de
 [89.13.109.67]) by webmail.informatik.kit.edu (Horde Framework) with HTTPS;
 Wed, 07 Sep 2016 17:48:41 +0200
Date:   Wed, 07 Sep 2016 17:48:41 +0200
Message-ID: <20160907174841.Horde.Ru1LBEeLKomznlWVG-ZnS-Q@webmail.informatik.kit.edu>
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
In-Reply-To: <20160907151251.30978-6-szeder@ira.uka.de>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1473263322.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Quoting SZEDER Gábor <szeder@ira.uka.de>:

> Version sort with prerelease reordering sometimes puts tagnames in the
> wrong order, when the common part of two compared tagnames ends with
> the leading character(s) of one or more configured prerelease
> suffixes.
>
>   $ git config --get-all versionsort.prereleaseSuffix
>   -beta
>   $ git tag -l --sort=version:refname v2.1.*
>   v2.1.0-beta-2
>   v2.1.0-beta-3
>   v2.1.0
>   v2.1.0-RC1
>   v2.1.0-RC2
>   v2.1.0-beta-1
>   v2.1.1
>   v2.1.2
>
> The reason is that when comparing a pair of tagnames, first
> versioncmp() looks for the first different character in a pair of
> tagnames, and then the swap_prereleases() helper function checks for
> prerelease suffixes _starting at_ that character.  Thus, when in the
> above example the sorting algorithm happens to compare the tagnames
> "v2.1.0-beta-1" and "v2.1.0-RC2", swap_prereleases() will try to match
> the suffix "-beta" against "beta-1" to no avail, and the two tagnames
> erroneously end up being ordered lexicographically.
>
> To fix this issue change swap_prereleases() to look for configured
> prerelease suffixes containing that first different character.

Now, while I believe this is the right thing to do to fix this bug,
there is a corner case, where multiple configured prerelease suffixes
might match the same tagname:

   $ git config --get-all versionsort.prereleaseSuffix
   -bar
   -baz
   -foo-bar
   $ ~/src/git/git tag -l --sort=version:refname
   v1.0-foo-bar
   v1.0-foo-baz

I.e. when comparing these two tags, both "-bar" and "-foo-bar" would
match "v1.0-foo-bar", and as "-bar" comes first in the config file,
it wins, and "v1.0-foo-bar" is ordered first.  An argument could be
made to prefer longer matches, in which case "v1.0-foo-bar" would be
ordered according to "-foo-bar", i.e. as second.  However, I don't
know what that argument could be, to me neither behavior is better
than the other, but the implementation of the "longest match counts"
would certainly be more complicated.

The argument I would make is that this is a pathological corner case
that doesn't worth worrying about.


Best,
Gábor
