Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF482C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 19:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A204F20768
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 19:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgDGTDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:03:51 -0400
Received: from mx.sdf.org ([205.166.94.20]:57097 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgDGTDu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 15:03:50 -0400
Received: from sdf.org (IDENT:lkml@otaku.sdf.org [205.166.94.8])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 037J3dGQ023459
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Tue, 7 Apr 2020 19:03:39 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 037J3dqS010756;
        Tue, 7 Apr 2020 19:03:39 GMT
Date:   Tue, 7 Apr 2020 19:03:39 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Sebastien Bruckert <sbruckert.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        lkml@sdf.org
Subject: Re: Feature request: rebase -i inside of rebase -i
Message-ID: <20200407190339.GA20902@SDF.ORG>
References: <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <20200328163024.GA26885@SDF.ORG>
 <nycvar.QRO.7.76.6.2004041417420.46@tvgsbejvaqbjf.bet>
 <20200404174116.GB11944@SDF.ORG>
 <CA+KXf2C0XytyNEAAdTOZAzw5YTQuv3PSjJ7RgyWqTj9MPp6BDQ@mail.gmail.com>
 <20200406152450.GA9609@SDF.ORG>
 <CA+KXf2A7L1fRC3+rmDaME186CYf4yS+-dBgy_FkEFVh887N7MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KXf2A7L1fRC3+rmDaME186CYf4yS+-dBgy_FkEFVh887N7MA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 07, 2020 at 05:16:50AM -0400, Sebastien Bruckert wrote:
> Hmmm so you need some way to move C before your actual commit. To make
> it like a pseudo command, some kind of "git rebase --reattach C
> --after A"? This seems closer to your original idea.

That seems too special-purpose and hard to remember.  The standard
rebase -i operation (generate a todo list and drop me into an editor)
is perfectly adequate and more familiar.  This is a very manual operation, 
after all.  ("-i" for "interactive" means "manual".)

> Or why not modify "--edit-todo" to get commits from before your actual
> point? It could works like this:
> 
> Before:
> ```
> #pick b2a96fe O
> #pick acb7459 A
> #pick 0dac4a4 B
> edit 1f54e51 C
> edit cda2a7e D
> ```
> 
> After:
> ```
> #pick b2a96fe O
> edit 1f54e51 C
> pick acb7459 A
> pick 0dac4a4 B
> edit cda2a7e D
> ```
> 
> So that you are still at C, but keeping the changes you made before on
> A and B, and going through them only if you have conflicts.

Because the only reason this is interesting assumes that A and B have 
changed!  If I didn't intend to modify A somehow, I wouldn't have included 
it in the rebase range.  They're now edited patches A' and B'.  So the
state I want to get to is:

#pick b2a96fe O
#pick acb7459 A
#pick 0dac4a4 B
reset b2a96fe O
edit 1f54e51 C
pick 7f0bcab A'
pick fcd3c62 B'
edit cda2a7e D

where it will pick the versions of A and B that include the edits I've
already made.

Now, having the original commits mentioned in comments is useful, in case 
I made a mess of the edit and want to revert it.  E.g. I can certainly see 
realizing, three commits later in the rebase, that I recolved a conflict 
wrong and should re-do it.  Although this can probably be handled with a 
fixup.
