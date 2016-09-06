Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9548B20705
	for <e@80x24.org>; Tue,  6 Sep 2016 01:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbcIFBI1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 21:08:27 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57516 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750784AbcIFBI0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 21:08:26 -0400
Received: from x590cf886.dyn.telefonica.de ([89.12.248.134] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1bh4s7-0003ky-LE; Tue, 06 Sep 2016 03:08:21 +0200
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     peff@peff.net
Cc:     git@vger.kernel.org, leho@conversionready.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: 2.10.0: multiple versionsort.prereleasesuffix buggy?
Date:   Tue,  6 Sep 2016 03:07:59 +0200
Message-Id: <20160906010759.14883-1-szeder@ira.uka.de>
X-Mailer: git-send-email 2.10.0.74.g6632b1b
In-Reply-To: <20160905232145.fr46rgfb66eeymwp@sigill.intra.peff.net>
References: <20160905232145.fr46rgfb66eeymwp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1473124101.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Tue, Sep 06, 2016 at 01:42:28AM +0300, Leho Kraav (Conversion Ready) wrote:
> 
> > Here's the testing tree https://github.com/woothemes/woocommerce
> > 
> > .git/config has:
> > 
> > [versionsort]
> > 
> > 
> >     prereleasesuffix = -beta
> >     prereleasesuffix = -RC
> > 
> > $ git tag -l --sort=version:refname
> > [...]
> > 2.6.0-RC1
> > 2.6.0-RC2
> > 2.6.0-beta-1
> > 2.6.0-beta-2
> > 2.6.0-beta-3
> > 2.6.0-beta-4
> 
> So that seems wrong. Even weirder, if I set _only_ "-beta", I get:
> 
>   $ git tag -l --sort=version:refname | grep -v ^2.6.0
>   2.6.0-beta-2
>   2.6.0-beta-3
>   2.6.0-beta-4
>   2.6.0
>   2.6.0-RC1
>   2.6.0-RC2
>   2.6.0-beta-1
> 
> Umm...what? beta-1 is sorted away from its companions? That's weird.
> 
> I wondered if the presence of "-" after the suffix ("beta-1" rather than
> "beta1") would matter. It looks like that shouldn't matter, though; it's
> purely doing a prefix match on "do these names differ at a prerelease
> suffix".
> 
> But something certainly seems wrong.

Some of the weirdness is caused by the '-' at the _beginning_ of the
suffixes, because versioncmp() gets confused by suffixes starting with
the same character(s).

versioncmp() consumes two tagnames up to the first different character
and then calls swap_prereleases() to try to match prerelease suffixes
starting at those characters.  This works fine when comparing a
release with a prerelease, e.g. "2.6.0" and "2.6.0-RC1", because
swap_prereleases() gets "" and "-RC1" and the latter does match one of
the configured suffixes.  However, when comparing two prereleases,
e.g. "2.6.0-beta1" and "2.6.0-RC1", then the '-' is consumed from both
tagnames because the first differing characters are 'b' and 'R', thus
swap_prereleases() gets "beta1" and "RC1", which, of course, don't
match any of the configured suffixes without the leading '-'.

It's way past my bedtime, so for the time being I can only come up
with a hacky configuration workaround that seems to deliver the
expected results:

[versionsort]
	prereleasesuffix = beta
	prereleasesuffix = -beta
	prereleasesuffix = RC
	prereleasesuffix = -RC

Best,
Gábor

