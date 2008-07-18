From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Teach git submodule update to use distributed
	repositories
Date: Fri, 18 Jul 2008 16:43:25 +0200
Message-ID: <20080718144325.GR10151@machine.or.cz>
References: <alpine.DEB.1.00.0807171351380.8986@racer> <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com> <alpine.DEB.1.00.0807171513560.8986@racer> <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com> <20080717182253.GZ32184@machine.or.cz> <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com> <20080718091608.GL10151@machine.or.cz> <320075ff0807180236u4e7f5f9bm81b702d14c052de8@mail.gmail.com> <20080718100048.GN10151@machine.or.cz> <320075ff0807180420k4b28c317mc026713b22c44839@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 16:44:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJrC8-0003Lq-1A
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 16:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbYGROn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 10:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbYGROn2
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 10:43:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58831 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbYGROn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 10:43:28 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id BC579393B322; Fri, 18 Jul 2008 16:43:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <320075ff0807180420k4b28c317mc026713b22c44839@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89046>

On Fri, Jul 18, 2008 at 12:20:13PM +0100, Nigel Magnay wrote:
> On Fri, Jul 18, 2008 at 11:00 AM, Petr Baudis <pasky@suse.cz> wrote:
> > On Fri, Jul 18, 2008 at 10:36:51AM +0100, Nigel Magnay wrote:
> >> On Fri, Jul 18, 2008 at 10:16 AM, Petr Baudis <pasky@suse.cz> wrote:
> >> > snip
> >> >
> >> >        "How do we mass-supply custom submodule URLs when publishing the
> >> >        customized main repository at a custom location too?"
> >> >
> >> Yes - that is an additional problem.
> >
> > Wait, I'm lost again - _additional_ problem? How does it differ from the
> > _original_ problem, how does it differ from what you're explaining below
> > and how does what you're explaining below differ from the original
> > problem?
> >
> In addition to the problem of needing to execute multiple commands and
> edit files to acheive what is a rather simple usecase, there is the
> additional problem of discovering (for a third party) a url for where
> their submodules are stored.

I see. That's interconnected as a single "How to check Fred's work"
problem for me. :-)

> >> If I may expand the usecase just so it's clear (and to check we're
> >> talkiing the same language)
> >>
> >> I do something like
> >> $ git remote add fred git://fredcomputer/superproject/.git
> >> $ git fetch --submodules fred
> >
> > I think you mean git pull --submodules fred. Well, actually, you want to
> > pull the main repository, then submodule update (_not_ pull in the
> > submodules). See? This is part of the "semantic swamp" I mentioned
> > before.
> 
> Ah - I understand. You're saying "you can't pull submodules when you
> pull the supermodule, because you don't know which submodules might be
> needed until you also merge / checkout the desired revision" ?
> 
> Ack.

That is something I might agree with, but my point is that within the
submodule,

	git pull

simply isn't a sensible operation at all! You don't want to do any
merges or whatever, just bring the submodule to a defined commit id.
So you want to do something significantly different:

	git fetch
	git reset --hard <commitid>

And that's what 'git submodule update' already does.

> Hm. It feels like each person could have some 'local' info in their
> .gitmodules, and rules around merging; but I'm not sure of exactly
> what, or how.

Again, when customizing .gitmodules, you need to either give up on

	(i) bisectability; it's not good enough to restore the canonical
	.gitmodules contents on merge, since the bisect can run into one
	of the commits on fred' branchs

	(ii) publishing the exact same branch for testing and merging

But I start to feel that the tradeoff of (ii) is really not so bad at
alland this would be perhaps the most elegant solution. You can either

	(a) make two parallel branches, one with your .gitmodules and
	one with the upstream's

	(b) probably better, stick a commit at the top of your branch
	that will change .gitmodules to your locations; others can
	check out fred, test things out, then merge fred^; you can even
	generally go back in fred's commits if you just 'git submodule
	update' right after checking fred out, since all the required
	submodule commits will be probably already fetched.

So I say just go for the (ii)-(b) combination. :-)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
