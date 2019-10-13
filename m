Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF0D1F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 18:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfJMSzp (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 14:55:45 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51225 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbfJMSzp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 14:55:45 -0400
X-Originating-IP: 1.186.12.3
Received: from localhost (unknown [1.186.12.3])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B56691C0003;
        Sun, 13 Oct 2019 18:55:42 +0000 (UTC)
Date:   Mon, 14 Oct 2019 00:25:40 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v4 1/1] Make gitdir work with worktrees, respect
 core.hooksPath, etc
Message-ID: <20191013185540.fwyn4ox5dbyxgvnh@yadavpratyush.com>
References: <pull.361.v3.git.gitgitgadget@gmail.com>
 <pull.361.v4.git.gitgitgadget@gmail.com>
 <2f55d6fb2a158c5b26b93ddb9c144ce1af5d9c32.1570534405.git.gitgitgadget@gmail.com>
 <20191011222611.le5lyf6mr5lmvbbd@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910122321211.3272@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910122321211.3272@tvgsbejvaqbjf.bet>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/19 11:24PM, Johannes Schindelin wrote:
> Hi Pratyush,
> 
> On Sat, 12 Oct 2019, Pratyush Yadav wrote:
> 
> > On 08/10/19 04:33AM, Johannes Schindelin via GitGitGadget wrote:
> >
> > > @@ -1453,10 +1501,16 @@ proc rescan {after {honor_trustmtime 1}} {
> > >  	global HEAD PARENT MERGE_HEAD commit_type
> > >  	global ui_index ui_workdir ui_comm
> > >  	global rescan_active file_states
> > > -	global repo_config
> > > +	global repo_config _gitdir_cache
> > >
> > >  	if {$rescan_active > 0 || ![lock_index read]} return
> > >
> > > +	# Only re-prime gitdir cache on a full rescan
> > > +	if {$after ne "ui_ready"} {
> >
> > What do you mean by a "full rescan"? I assume you use it as the
> > differentiator between `ui_do_rescan` (called when you hit F5 or choose
> > rescan from the menu) and `do_rescan` (called when you revert a line or
> > hunk), and a "full rescan" refers to `ui_do_rescan`.
> >
> > Well in that case, this check is incorrect. `do_rescan` passes only
> > "ui_ready" and `ui_do_rescan` passes "force_first_diff ui_ready".
> >
> > But either way, I'm not a big fan of this. This check makes assumptions
> > about the behaviour of its callers based on what they pass to $after.
> > The way I see it, $after should be a black box to `rescan`, and it
> > should make absolutely no assumptions about it.
> >
> > Doing it this way is really brittle, and would break as soon as someone
> > changes the behaviour of `ui_do_rescan`. If someone in the future passes
> > a different value in $after, this would stop working as intended and
> > would not refresh the cached list on a rescan.
> >
> > So, I think a better place for this if statement would be in
> > `ui_do_rescan`. This would mean adding a new function that does this.
> > But if we unset _gitdir_cache in prime_gitdir_cache (I see no reason not
> > to), we can get away with just something like:
> >
> >   proc ui_do_rescan {} {
> >   	rescan {prime_gitdir_cache; ui_ready}
> >   }
> >
> > Though since `prime_gitdir_cache` does not really depend on the rescan
> > being finished, something like this would also work fine:
> >
> >   proc ui_do_rescan {} {
> >   	rescan ui_ready
> >   	prime_gitdir_cache
> >   }
> 
> That was my first attempt. However, there is a very important piece of
> code that is even still quoted above: that `if {$rescan_active > 0 ||
> ![lock_index read]} return` part.
> 
> I do _not_ want to interfere with an actively-going-on rescan. If there
> is an active one, I don't want to re-prime the `_gitdir` cache.

Good catch! In that case I suppose refreshing the cache in $after would 
be the way to go (IOW, the former of my two suggestions). Anything 
$after won't get executed if we return early from that check.
 
> That was the reason why I put the additional code into `rescan` rather
> than into `ui_do_rescan()`.
> 
> Ciao,
> Johannes
> 
> >
> > This would allow us to do these two things in parallel since `rescan` is
> > asynchronous. But that would also mean it is possible that the status
> > bar would show "Ready" while `prime_gitdir_cache` is still executing.
> >
> > I can't really make up my mind on what is better. I'm inclining on using
> > the latter way, effectively trading a bit of UI inconsistency for
> > performance (at least in theory).
> >
> > Thoughts?
> >
> > > +		array unset _gitdir_cache
> > > +		prime_gitdir_cache
> > > +	}
> > > +
> > >  	repository_state newType newHEAD newMERGE_HEAD
> > >  	if {[string match amend* $commit_type]
> > >  		&& $newType eq {normal}

-- 
Regards,
Pratyush Yadav
