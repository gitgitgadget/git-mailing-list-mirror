Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D1DEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 18:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjGESub (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGESua (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 14:50:30 -0400
Received: from haze.kloetzke.net (haze.kloetzke.net [IPv6:2a03:4000:13:91f:34ea:99ff:fed2:e113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27391723
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 11:50:27 -0700 (PDT)
Received: from localhost (p5dd48849.dip0.t-ipconnect.de [93.212.136.73])
        by haze.kloetzke.net (Postfix) with ESMTPSA id D1BFF800B7;
        Wed,  5 Jul 2023 20:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=kloetzke.net; s=2020;
        t=1688583024; bh=jqxdKBm+bRzlx9SjVb35oQiGY9SFZrAzs8Gly4mFndM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMqYLOPcoDKhJNsJuURI+AkdRYq+j/bw/5gXRQF4ULDMlB0HXeN+M1vaUdSDH4IyW
         44g0uwwTKbJXWwWWGQWQV6WR+pFYKL6LvRlRaii8GYvtlwfisZdcnTOCqRcYDc2eDL
         B5+coTouoRqIcxw4HHXb8zij1sQKeUwuZiHyMl5C5BIdnQefwxyMtI502rW66YMCo7
         6X41XQrpZ56d3cBR6LjKRUhM1KmCbQL4CAw8caWay7r4aBSf6wySYTuiX3uapG606k
         kmP6gjXC0AIFYMU/SCLzVVJ3AhzpgO6OqbmrnBA5bLDX7W5l9Dc9YmB3ZZuPKKM1ml
         I/1GHeA5eCAoA==
Date:   Wed, 5 Jul 2023 20:50:22 +0200
From:   Jan =?iso-8859-1?Q?Kl=F6tzke?= <jan@kloetzke.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Steve Kemp <steve@steve.org.uk>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] ref-filter: handle nested tags in --points-at option
Message-ID: <ZKW7bjVHeEOnza62@thinkpad.fritz.box>
References: <20230701205703.1172505-1-jan@kloetzke.net>
 <20230702125611.GA1036686@coredump.intra.peff.net>
 <xmqqmt0a3n2w.fsf@gitster.g>
 <20230705124107.GA3932508@coredump.intra.peff.net>
 <xmqqedlm2s9q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqedlm2s9q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Wed, Jul 05, 2023 at 10:16:17AM -0700 schrieb Junio C Hamano:
> > The one thing that would actually make us a lot faster (by using the
> > packed-refs peels) is to make full peels the only option, and do not
> > bother letting --points-at match "B" in an A->B->C peel. But that would
> > be removing something that is currently matched (even before the patch
> > in this thread), so I stopped short of it in my optimizations.
> 
> Interesting.  Right now, if I create a 'direct' tag that points
> directly at HEAD, and then create an 'indirect' tag that points at
> 'direct', i.e.
> 
>     $ git tag -a -m 'a direct tag to HEAD' direct HEAD
>     $ git tag -a -m 'an indirect tag' indirect direct
> 
> I would get a piece of advice message that encourages to correct the
> mistake with "git tag -f indirect direct^{}".  Then I ask for tags
> that point at HEAD, I see only 'direct' and not 'indirect'.  Your
> optimization would start showing both 'direct' and 'indirect' if
> they are packed.  But you are correct to worry about the opposite
> case.  If I ask for tags that point at 'direct', I currently see
> 'indirect', but of course 'indirect' will not appear as the peeled
> value of any ref, and the optimized version will stop saying that
> 'indirect' is a ref that points at 'direct'.  That sounds like a
> regression.

I agree. I purposely let the loop run through all the tags in the chain
in my inital patch to keep the existing behaviour. Unless there is a
compelling reason I would suggest do keep it this way. I wouldn't rule
out that someone relies on being able to query for indirect tags by
supplying a tag to the --points-at option.

> > But even
> > if we decide to do that, Jan's patch is not making anything worse there
> > (in fact, it is making it better, because it is matching "C" which we do
> > not currently match).
> > ...
> > So I'd be inclined to proceed with the patches I sent earlier, and then
> > if we choose to later refactor again to drop "B", we can.
> 
> We generally avoid taking away anything once we give it to users;
> once the patch under discussion goes in, there is no taking it back,
> i.e. the new _behaviour_ closes the door to certain optimizations.
> 
> I do not at all mind to see us decide and declare that it is a good
> thing to say that not just 'direct' but also 'indirect' points at
> HEAD, and that 'indirect' points at 'direct' and the patch under
> discussion makes the world a etter place, and we will not regret
> that decision.  But the time to make such a decision is now, before
> we give a go-ahead to the patch.

The reasoning why I came up with the patch in the first place was an odd
behaviour that was reported to me in [1]. The user had a recipe that
checked out a nested tag for a package but the Bob Build Tool thought
the user messed with the working copy. Behind the scenes Bob checked out
the indirect tag (foobar-3.13.1) successfully. But when the user
examined the project state ("bob status"), Bob ran

  git tag --points-at HEAD

in the working copy to get the list of tags for the current HEAD. That
did not return the expected tag in the list, so the workspace state was
flagged. OTOH, the tag _is_ visible when manually executing "git log" in
the workspace. Clearly this is confusing and so was I when I tried to
find the root cause. To sum up:

 $ git checkout nested-tag   --> works
 $ git log                   --> shows nested tag in decoration
 $ git tag --points-at HEAD  --> does *not* show nested tag

AFAICT the nested tag in the mentioned bug report was not created on
purpose. I haven't come across any sensible use case for them either.
But as most git commands can handle nested tags they should better be
supported consistently IMHO.

-- Jan

[1] https://github.com/BobBuildTool/bob/issues/520
