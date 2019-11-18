Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E0E1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 19:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKRTsJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 14:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfKRTsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 14:48:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 181E72230F;
        Mon, 18 Nov 2019 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574106487;
        bh=CRT5AsiklE8UBnzI46KWJI+GgkLzqT65uKMX5KjaECk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrNALO9sGiaUWgW5vaoFLgIbs+uGKTeIfDd0Wty3VJdsLU6RxuuZCcP/Hh8GYeCw3
         0AcN1doOb017ByxLm4uoIygOCO9Cq8oKLyPjFv/a5SI/CiCV2pkv7N7tm/P3TO2ynZ
         bQAUDx58pybgho4y+h4NxkT7Gqt899V3G/jjWX4I=
Date:   Mon, 18 Nov 2019 20:48:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Signal conflict on merging metadata-differing patches
Message-ID: <20191118194804.GA662468@kroah.com>
References: <20191118172917.GA6063@vmlxhi-102.adit-jv.com>
 <20191118173517.GA599094@kroah.com>
 <20191118184523.GA6894@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118184523.GA6894@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 07:45:23PM +0100, Eugeniu Rosca wrote:
> On Mon, Nov 18, 2019 at 06:35:17PM +0100, Greg KH wrote:
> > On Mon, Nov 18, 2019 at 06:29:17PM +0100, Eugeniu Rosca wrote:
> > > Dear Git community,
> > > 
> > > Due to high inflow of patches which Linux maintainers carry on their
> > > shoulders and due to occasionally intricate relationships between
> > > consecutive revisions of the same series, it may [1] happen that two
> > > distinct revisions of the same patch (differing only/mostly in
> > > metadata, e.g. Author's time-stamp and commit description) may end up
> > > being merged on the same branch, without git to complain about that.
> > 
> > Why would git complain about that?
> 
> This would help those performing the merge identify and (if needed)
> avoid having several slightly different patches on the same branch.

The patches were not on the same branch to start with, they ended up on
two different branches that got merged together at some point in time
later on.

This happens all the time in kernel development :)

> > > Is there any "git merge" flag available off-the-shelf which (if used)
> > > would signal such situations?
> > 
> > I don't understand what you are looking for here.  Two different
> > versions of the patch were merged to different branches and then merged
> > together, and git did the right thing with the resolution of the code.
> 
> I personally care about commit metadata (i.e. Author's/Committer's names
> and timestamps, as well as commit description) as much as (and sometimes
> more than) the code contents of the patch.
> 
> If I am given multiple patches which perform the same code changes, but
> provide different descriptions, this _already_ generates potential work
> on my plate, since I have to make sense of those differences when I
> stumble upon them. Which patch do I recommend to the customer (who,
> let's say, still lives on the older v4.14 LTS), if I am asked to?

Welcome to my life :)

As I said above, this happens quite frequently, and honestly, I just
live with it.  Look at the kernel's DRM branch for the main abusers of
this, they cherry-pick patches from their local tree to a tree to send
to Linus today, with the sha1 in the commit message.  That means that
Linus ends up with a commit referencing a sha1 that will not show up in
his tree until sometime in the _future_.

It causes havoc with my scripts and I hate it.

But, it makes things easier for the developers and maintainers of that
subsystem and in the end, that's what really matters.  Stable and
backports should almost never cause developers any problems or extra
work as that is not their responsibility.

> Why should I (or anybody else) spend time doing research at all, if this
> can be avoided by just passing an additional option to "git merge"?
> 
> It is the most basic requirement I can think of that the maintainers
> select the _latest_ version of a patch series, without intertwining it
> with a superseded version.

I really don't understand what you expect to have happen here.

Look at the drm tree again, what should git do sometime in the future
when the same "logical change" gets merged into Linus's tree.  I think
it should do what it does today, handle the merge of the code changes
just fine and allow for perfect representation at any point in time what
the tree looked like if you check it out then.

What should git do instead?

> > What more can it do here?
> 
> Currently Git says nothing in below merge scenarios (all of them are
> conflict-less successful merges):
>  - Merge two commits which perform identical code changes but have
>    different metadata
>  - Merge commit "A" and commits ("B", "C", "D"), the latter being
>    subsets of "A"
> 
> I don't advocate for "git merge" to fail in the above scenarios. No.
> I just say that Git could likely detect such scenarios and help people
> like you not pushing v2 and v5 of the same patch into the main tree.

But what should it do in either of those above situations?  Fail the
merge?  No, that's not ok as those different branches were just fine on
their own and I will never expect them to be rebased/rewritten just for
something like this.  That's crazy.

thanks,

greg k-h
