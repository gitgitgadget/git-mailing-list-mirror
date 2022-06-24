Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F46C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 20:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiFXU7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiFXU7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 16:59:10 -0400
X-Greylist: delayed 1258 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jun 2022 13:59:04 PDT
Received: from gateway10.unifiedlayer.com (gateway10.unifiedlayer.com [74.220.218.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFAF6DB3A
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 13:59:04 -0700 (PDT)
Received: from cm3.websitewelcome.com (unknown [108.167.139.23])
        by gateway10.unifiedlayer.com (Postfix) with ESMTP id 605352009A09F
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 15:38:06 -0500 (CDT)
Received: from uscentral455.accountservergroup.com ([174.136.13.174])
        by cmsmtp with ESMTP
        id 4q46oOdXqpPDo4q46oO7zf; Fri, 24 Jun 2022 15:38:06 -0500
X-Authority-Reason: nr=8
Received: from 76-222-220-222.lightspeed.rcsntx.sbcglobal.net ([76.222.220.222]:17413 helo=bigbox.attlocal.net)
        by uscentral455.accountservergroup.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <git@tim.thechases.com>)
        id 1o4q46-002n6T-39
        for git@vger.kernel.org; Fri, 24 Jun 2022 15:38:06 -0500
Date:   Fri, 24 Jun 2022 15:38:04 -0500
From:   Tim Chase <git@tim.thechases.com>
To:     git@vger.kernel.org
Subject: Re: stashing only unstaged changes?
Message-ID: <20220624153804.44089117@bigbox.attlocal.net>
In-Reply-To: <CA+JQ7M9jBSB8tdpz85imER4SF1yhn3jes8ThnzkA_O9+mus1Ng@mail.gmail.com>
References: <20220621142618.239b02cd@bigbox.attlocal.net>
        <CA+JQ7M9jBSB8tdpz85imER4SF1yhn3jes8ThnzkA_O9+mus1Ng@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; amd64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - uscentral455.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-BWhitelist: no
X-Source-IP: 76.222.220.222
X-Source-L: No
X-Exim-ID: 1o4q46-002n6T-39
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 76-222-220-222.lightspeed.rcsntx.sbcglobal.net (bigbox.attlocal.net) [76.222.220.222]:17413
X-Source-Auth: tim@thechases.com
X-Email-Count: 1
X-Source-Cap: dGhlY2hhc2U7dGhlY2hhc2U7dXNjZW50cmFsNDU1LmFjY291bnRzZXJ2ZXJncm91cC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-06-24 13:23, Erik Cervin Edin wrote:
> > Using `git stash --saved` does the opposite of what I want
> > (stashing the index, not the difference between the index and the
> > working-copy)  
> 
> I'm unaware of a --saved option

Derp, meant to type "--keep-index" there.

> My understanding (which may be incorrect) is that a shash is always
> of the staged/unstaged changes and there's no way to stash only one
> or the other in a single stash operation.

That seems to be what I'm experiencing.

> A stash is always both staged and unstaged changes of the files.
> 
> To stash only staged you may do
>   git stash --keep-index
>   git stash
> The first stash will include staged/unstaged and the second only
> staged

Right, which is what I'd tried.  Except

  git stash

effectively takes a diff of HEAD..{working copy} and stashes that,
while --keep-index also takes note of what was in the index.

My hope had been for an option to have git-stash use the index as its
baseline rather than use HEAD.

> To create a stash of only unstaged
>   git commit -m tmp # create temporary commit w staged
>   git stash # stash unstaged
>   git reset HEAD~ &&  git stash # stash the previous staged as
> unstaged (optionally git add  in the middle)
>   git stash apply/pop stash@{1} # get the "unstaged" stash
> As you noted such a stash is still based on a tree that may have
> contained staged changes (ORIG_HEAD).
> Ie. if you staged line 1 but not 2-3 the "unstaged" stash will also
> contain line 1
> This is doesn't happen if the staged/unstaged contain different
> files

Yeah, those are among the issues I was bumping against.  With
different files, it's a little less troublesome. But when there might
be some overlap, became problematic.

> > To work around it, I did a `git diff >
> > temp.patch` to obtain the stuff I'd wanted to stash, a `git reset
> > --staged` to clear out those changes, ran my code to verify
> > (eventually committing it), and then applied the `temp.patch`
> > back on top of my changes. It worked, but felt convoluted.  
> 
> That's basically what you have to do if you only want certain
> changes. (and also what --patch does under the hood)

Okay, based on the other replies, it sounds like it might be the most
practical route to go since I'm not missing some existing
functionality of git-stash.

> > I did see the `git stash -p` option, to manually choose the
> > inverse bits, but for what I was doing, it was more sensible to
> > `git add -p` and try to stash the rest.  
> 
> git stash --patch is MUCH slower than git add -p, so I personally
> never use it.

I don't find the speed an issue as much as I have trouble with any of
the --patch variants that aren't `git add -p` because I'm never 100%
positive which direction + vs - means.  Which is partly why I wanted
to stick with `add -p` and stash the non-staged stuff.

> > So is there some option I've missed to tell `git stash` to stash
> > only the delta between the uncommitted-index and the
> > working-copy?  
> 
> No, there is none.

Thanks! That's pretty much what I'm getting from the rest of the
replies, too.

-Tim





