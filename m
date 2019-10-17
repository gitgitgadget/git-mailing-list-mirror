Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59DDE1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 18:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438835AbfJQSem (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 14:34:42 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49469 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJQSem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 14:34:42 -0400
X-Originating-IP: 1.186.12.12
Received: from localhost (unknown [1.186.12.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CF533240002;
        Thu, 17 Oct 2019 18:34:39 +0000 (UTC)
Date:   Fri, 18 Oct 2019 00:04:37 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v4 1/1] Make gitdir work with worktrees, respect
 core.hooksPath, etc
Message-ID: <20191017183437.pc6kpin2zvdtwmqu@yadavpratyush.com>
References: <pull.361.v3.git.gitgitgadget@gmail.com>
 <pull.361.v4.git.gitgitgadget@gmail.com>
 <2f55d6fb2a158c5b26b93ddb9c144ce1af5d9c32.1570534405.git.gitgitgadget@gmail.com>
 <20191011222611.le5lyf6mr5lmvbbd@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910122321211.3272@tvgsbejvaqbjf.bet>
 <20191013185540.fwyn4ox5dbyxgvnh@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910140015500.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910140015500.46@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/10/19 12:18AM, Johannes Schindelin wrote:
> Hi Pratyush,
> 
> On Mon, 14 Oct 2019, Pratyush Yadav wrote:
> 
> > On 12/10/19 11:24PM, Johannes Schindelin wrote:
> > > Hi Pratyush,
> > >
> > > On Sat, 12 Oct 2019, Pratyush Yadav wrote:
> > >
> > > > On 08/10/19 04:33AM, Johannes Schindelin via GitGitGadget wrote:
> > > >
> > > > > @@ -1453,10 +1501,16 @@ proc rescan {after {honor_trustmtime 1}} {
> > > > >  	global HEAD PARENT MERGE_HEAD commit_type
> > > > >  	global ui_index ui_workdir ui_comm
> > > > >  	global rescan_active file_states
> > > > > -	global repo_config
> > > > > +	global repo_config _gitdir_cache
> > > > >
> > > > >  	if {$rescan_active > 0 || ![lock_index read]} return
> > > > >
> > > > > +	# Only re-prime gitdir cache on a full rescan
> > > > > +	if {$after ne "ui_ready"} {
> > > >
> > > > What do you mean by a "full rescan"? I assume you use it as the
> > > > differentiator between `ui_do_rescan` (called when you hit F5 or choose
> > > > rescan from the menu) and `do_rescan` (called when you revert a line or
> > > > hunk), and a "full rescan" refers to `ui_do_rescan`.
> > > >
> > > > Well in that case, this check is incorrect. `do_rescan` passes only
> > > > "ui_ready" and `ui_do_rescan` passes "force_first_diff ui_ready".
> > > >
> > > > But either way, I'm not a big fan of this. This check makes assumptions
> > > > about the behaviour of its callers based on what they pass to $after.
> > > > The way I see it, $after should be a black box to `rescan`, and it
> > > > should make absolutely no assumptions about it.
> > > >
> > > > Doing it this way is really brittle, and would break as soon as someone
> > > > changes the behaviour of `ui_do_rescan`. If someone in the future passes
> > > > a different value in $after, this would stop working as intended and
> > > > would not refresh the cached list on a rescan.
> > > >
> > > > So, I think a better place for this if statement would be in
> > > > `ui_do_rescan`. This would mean adding a new function that does this.
> > > > But if we unset _gitdir_cache in prime_gitdir_cache (I see no reason not
> > > > to), we can get away with just something like:
> > > >
> > > >   proc ui_do_rescan {} {
> > > >   	rescan {prime_gitdir_cache; ui_ready}
> > > >   }
> > > >
> > > > Though since `prime_gitdir_cache` does not really depend on the rescan
> > > > being finished, something like this would also work fine:
> > > >
> > > >   proc ui_do_rescan {} {
> > > >   	rescan ui_ready
> > > >   	prime_gitdir_cache
> > > >   }
> > >
> > > That was my first attempt. However, there is a very important piece of
> > > code that is even still quoted above: that `if {$rescan_active > 0 ||
> > > ![lock_index read]} return` part.
> > >
> > > I do _not_ want to interfere with an actively-going-on rescan. If there
> > > is an active one, I don't want to re-prime the `_gitdir` cache.
> >
> > Good catch! In that case I suppose refreshing the cache in $after would
> > be the way to go (IOW, the former of my two suggestions). Anything
> > $after won't get executed if we return early from that check.
> 
> The obvious problem with that solution is that the `_gitdir` is reset
> _after_ the rescan. In my solution, it is reset _before_, as I have no
> idea how often the `_gitdir` values are used during a rescan (and if
> none of they were, I would like to be very cautious to prepare for a
> future where any of those `_gitdir` values _are_ used during a rescan).

_gitdir values are used quite often during a rescan, so yes, this won't 
work.
 
> So I am afraid that I find way too serious problems with both of your
> proposed alternatives.

One alternative I can see right now is adding another optional parameter 
to `rescan` that controls whether we refresh the gitdir cache or not. 
That parameter would default to 0/false. I'm not the biggest fan of 
something like this, but it might be the easiest way to do it given the 
constraints.

I also thought about trying to acquire the index lock in 
`prime_gitdir_cache`, but that could create a race on the lock between 
`prime_gitdir_cache` and `rescan`.

If you have any better ideas, I'm all ears, but otherwise, I maybe our 
best bet is to just go with adding an optional parameter to `rescan`.

-- 
Regards,
Pratyush Yadav
