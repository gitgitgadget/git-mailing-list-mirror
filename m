From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFD/PATCH] submodule doc: describe where we can configure
 them
Date: Wed, 11 May 2016 18:54:00 +0200
Message-ID: <20160511165400.GB3321@sandbox>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
 <20160503235652.GA395@google.com>
 <CAGZ79kb4GNZi93JpsPKUb7ScmePqDC1Xp+WZTGD7hfPUn9tWaQ@mail.gmail.com>
 <20160504150143.GA8575@sandbox>
 <CAGZ79kZs5zLAUdi53D=pTyFZF__73ZbW4o28C2hOuTV7_NfaDQ@mail.gmail.com>
 <20160508215401.GA59077@book.hvoigt.net>
 <CAGZ79kZ+WzVwhj77zkHKbX-PmgfPvCO9qcX07vyC-BG+nDhWxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 11 18:54:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0XOq-0008Sq-8b
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 18:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbcEKQyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 12:54:13 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:42746 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbcEKQyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 12:54:11 -0400
Received: from [62.224.169.60] (helo=sandbox)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1b0XOb-0006dR-JV; Wed, 11 May 2016 18:54:01 +0200
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ+WzVwhj77zkHKbX-PmgfPvCO9qcX07vyC-BG+nDhWxA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294352>

On Mon, May 09, 2016 at 10:32:50AM -0700, Stefan Beller wrote:
> >> Here is what I imagine
> >> When B mirrors from A, B sets up this special ref for its repository,
> >> e.g. refs/meta/submodule-B and have a symbolic ref pointing at that.
> >> (e.g. SUBMODULE_CONFIG pointing at refs/meta/submodule-B,
> >> which has a worktree which contains a .gitmodules files which
> >> sets up
> >>   "submodule.baz.url = http://B/baz"
> >>   "submodule.relativeBase = http://A"
> >>
> >> That way anyone cloning from B would get
> >> the superproject and the submodule baz from B while the
> >> rest of the submodules are found at A.
> >
> > This sounds sensible. But my imagination of a conflict was in a
> > different way. E.g. project A has a submodule B. And now A has a remote
> > 1 where you publish and maybe another remote 2 where someone else (a
> > colleague?) publishes. Which configuration do you use? Here the two
> > remotes are independent instead of subsequent forks. In this case my
> > solution would be to use the configuration branch from 1 for B when
> > interacting with 1. I do not have completely checked whether we always
> > have a remote at hand for such a resolution.
> 
> I think it is the responsibility of the pusher to make sure the
> configuration is sane.
> So if I were to push to remote 2 and you push to remote 1, we'd both configure
> the special branch of our superprojects for these remotes for that submodule.
> 
> If the superproject has relative urls for the submodule, all we had to do was
> unset (or overwrite) the submodule.baseConfig.

What if (because we work together) you and me have both remotes in our
local repository. We only push to our private remotes but fetch from
both. Since we work together we also forked the same submodule B and
have different URL configurations for it. I push to B1 and you to B2.
Now we both have two special branches (one from B1 and one from B2) in
our local repositories, since on either of our private remotes there is
one special branch.

Which values are valid now? I see you are advocating for a symbolic ref
SUBMODULE_CONFIG that points to a single special branch in charge, but
maybe we can avoid that. In this case there actually is no real
conflict, since we can just add both remotes B1, B2 to the submodule B.
Which one is used is a choice of the user during push.

For submodule.relativeBase we could try a similar solution and just add
all remotes that can be constructed with the different configurations.
Probably under the same name as in the superproject.

So if we limit ourselves to only allow URL'ish (actually remote'ish is
probably a better term) we can actually avoid conflict resolution and
just add/use them all. If we limit ourselves to the fork use case and my
hypothesis that we only need to allow remote'ish values in these special
branches for it is true, we can actually keep it quite simple and have
no conflict resolution at all I think (and realize now).

What do you think?

> >> When C mirrors from A, they add another branch  refs/meta/submodule-C,
> >> which can either be a fork of refs/meta/submodule-B with some changes on
> >> top of it or it can add a reference to refs/meta/submodule-B, i.e. the
> >> configuration
> >> would be:
> >>
> >>   "submodule.baseConfig = refs/meta/submodule-B"
> >>   "submodule.foo.url = ssh://C/foo"
> >>
> >> and SUBMODULE_CONFIG would point at refs/meta/submodule-C.
> >>
> >> When cloning from C, the user would get
> >>
> >>  * the superproject from C
> >>  * submodule foo from C
> >>  * submodule baz from B
> >>  * all other submodules from A
> >>
> >> By the inheriting property of the branch of B there are no conflicting values.
> >> C could just overwrite submodule.baseConfig for example.
> >
> > So that means in the default case we create a chain of all previous
> > forks embedded in repository database.
> 
> Not necessarily. I was just pointing out that this was possible. The
> intermediate
> party could decide that their upstream is too unreliable and not point
> to their upstream.
> 
> This would incur the cost of having to clone all submodules and
> overwriting the absolute
> urls. For the relative URLs this would just work as of now.
> 
> All I wanted with that example is to offer the flexibility to not have
> to clone all the
> submodule, but I can fork a mega-project with 100s of submodules and maybe
> just fiddle with one of them and then publish that.

Do you mean 'not having to fork all the submodules' here? Since 'without
cloning' is already possible, no?

I am assuming you meant fork. So submodule.relativeBase is meant to
solve that right? You set it and all relative submodule URLs that are
not configured otherwise relate to it.

My point was about the chaining with submodule.baseConfig. That is not
necessary to support partial forks of just a few submodules.

Actually while thinking about submodule.relativeBase now, I found it
might be nice to extend it a little. Imagine someone wants fork a set of
submodules and specify a relativeBase for them and then someone else
forking again wants to do that with another set of submodules. I imagine
subsequents forks are quite usual in git (like in the kernels workflow).
Maybe we can extend this scheme a little bit and allow to set
submodule.relativeBase for groups of submodules somehow?

> > I am not saying that this is
> > necessarily a bad thing but I feel that it is a new property which we
> > should think about. It helps because users will get updated values from
> > sources that are in the chain. On the other hand it adds a lot of
> > dependencies which are point of failures in case a remote disappears. I
> > am undecided on this. I would prefer if we could let people play with it
> > a little (maybe on pu?) and then decide if there are practical pitfalls
> > with this.
> >
[...]

> >
> > Only things like the technical organisation (like the place where a
> > repository can be found) justify to be outside of the repository IMO.
> >
> > A repository without submodules does have one collection of remote
> > repository urls. To me adding proper fork support seems be the switch
> > from one collection for one repository to many collections for many
> > repositories. Since this one collection is already outside of the
> > superproject it makes sense to do the same for the submodules. So my
> > question reformulated could be: Are there more values we currently keep
> > inside the repository for submodules that actually belong outside? A
> > good indication could be that they are already outside in the
> > superproject.
> >
> > I did not find any flaw in these statements yet, but maybe I am
> > oversimplifying?
> 
> They sound right to me.

Great. Then my simplification suggestion above should work as well.

> Thanks for the discussion :)
Thank you for caring about this topic! I think this is quite some
important work to get submodule forking almost as simple as forking
their superprojects. I am happy to continue this discussion and
bounce ideas off of each other :)

Cheers Heiko
