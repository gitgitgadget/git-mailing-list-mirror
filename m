Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5EBC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhKVNed (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:34:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhKVNec (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 08:34:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CDE49217BA;
        Mon, 22 Nov 2021 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637587883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAK0H13lkQKMIPon5Bi2FywiKPyhNC/G83C6owgq69g=;
        b=2ilxanhJrxaDGKzpUhCtZTwT81eAf3VKDNdxfXeOCYhNgeZo1x3zG+KTdv+A9aC3bjjnt+
        NCMZKRfvbyzF9xvJflD5lsDxXox1fJB7FeWMOPWuiQ8moQGHzcTthcHDiKCCvdtZeQZgvF
        Jx3BViCxpp2mMgEYcYDEMO06NT/JIl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637587883;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAK0H13lkQKMIPon5Bi2FywiKPyhNC/G83C6owgq69g=;
        b=UBFZdakH0+JZeLKQfeL05chbEtdiI9VMMaA40zYKCFI1Sub360O+G5dAlZk2D6LybnUx9b
        rFy0QsMvqkdqloDQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id BB305A3B84;
        Mon, 22 Nov 2021 13:31:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 83DC41F2B50; Mon, 22 Nov 2021 14:31:23 +0100 (CET)
Date:   Mon, 22 Nov 2021 14:31:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, git <git@vger.kernel.org>
Subject: Re: Stochastic bisection support
Message-ID: <20211122133123.GF24453@quack2.suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
 <CAP8UFD0fhKxmuXT40oVj-m6nfkgH+=0isf+vo6bcXW4YbkTEkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD0fhKxmuXT40oVj-m6nfkgH+=0isf+vo6bcXW4YbkTEkg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

On Mon 22-11-21 13:55:33, Christian Couder wrote:
> On Thu, Nov 18, 2021 at 9:33 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello,
> >
> > In some cases regressions (or generally changes) we are trying to bisect have
> > probabilistic nature. This can for example happen for hard to trigger race
> > condition where it is difficult to distinguish working state from just not
> > hitting the race or it can happen for performance regressions where it is
> > sometimes difficult to distinguish random workload fluctuations from the
> > regression we are looking for. With standard bisection the only option we have
> > is to repeatedly test suggested bisection point until we are sure enough which
> > way to go. This leads to rather long bisection times and still a single wrong
> > decision whether a commit is good to bad renders the whole bisection useless.
> >
> > Stochastic bisection tries to address these problems. When deciding whether a
> > commit is good or bad, you can also specify your confidence in the decision.
> > For performance tests you can usually directly infer this confidence from the
> > distance of your current result from good/bad values, for hard to reproduce
> > races you are usually 100% confident for bad commits, for good commits you need
> > to somehow estimate your confidence based on past experience with reproducing
> > the issue. The stochastic bisection algorithm then uses these test results
> > and confidences to suggest next commit to try, tracking for each commit the
> > probability the commit is the bad one given current test results. Once some
> > commit reaches high enough probability (set when starting bisection) of being
> > the bad one, we stop bisecting and annouce this commit.
> 
> The following project is based on Bayesian Search Theory and might be
> interesting if you haven't looked at it:
> 
> https://github.com/Ealdwulf/BBChop

Thanks for the link. I already know about that project and I had a look
into it when doing some initial research. But the biggest limitation of
that project is that it works only for linear history. I need to generally
bisect Linux kernel repository which has enough merges that the limitation
of linear history makes the use of the above tool impractical.

Furthermore direct integration of stochastic bisection into git makes this
easier to integrate into our performance testing framework.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
