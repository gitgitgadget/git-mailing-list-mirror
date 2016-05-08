From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFD/PATCH] submodule doc: describe where we can configure
 them
Date: Sun, 8 May 2016 23:54:08 +0200
Message-ID: <20160508215401.GA59077@book.hvoigt.net>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
 <20160503235652.GA395@google.com>
 <CAGZ79kb4GNZi93JpsPKUb7ScmePqDC1Xp+WZTGD7hfPUn9tWaQ@mail.gmail.com>
 <20160504150143.GA8575@sandbox>
 <CAGZ79kZs5zLAUdi53D=pTyFZF__73ZbW4o28C2hOuTV7_NfaDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 08 23:54:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azWeZ-0005qB-Ge
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 23:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbcEHVyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 17:54:14 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:32980 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbcEHVyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 17:54:13 -0400
Received: from [95.90.185.119] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1azWeO-0003Ya-Ob; Sun, 08 May 2016 23:54:08 +0200
Content-Disposition: inline
In-Reply-To: <CAGZ79kZs5zLAUdi53D=pTyFZF__73ZbW4o28C2hOuTV7_NfaDQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293979>

Hi,

On Wed, May 04, 2016 at 01:50:24PM -0700, Stefan Beller wrote:
> On Wed, May 4, 2016 at 8:01 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > On Tue, May 03, 2016 at 05:59:58PM -0700, Stefan Beller wrote:
> >> On Tue, May 3, 2016 at 4:56 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> >> > Stefan Beller wrote:
> >> >
> >> >> This is similar to the gitignore document, but doesn't mirror
> >> >> the current situation. It is rather meant to start a discussion for
> >> >> the right approach for mirroring repositories with submodules.
> >> >
> >> > Ooh.
> >>
> >> Thanks for writing such a detailed answer. :)
> >
> > BTW, here is a pointer to the discussion (and what I wrote down) about
> > this from back in 2014:
> >
> > https://github.com/jlehmann/git-submod-enhancements/wiki/Ideas#special-ref-overriding-gitmodules-values
> 
> Thanks for pointing at the prior discussion!
> Although not much happened since then (code wise)?

Yes, IIRC nothing happened code wise. It went so far that a rough
consensus was made but nobody actually stepped in to scratch that itch.

> > Jonathan you suggested to copy the content from a remote to
> > .git/info/<remotename>/gitmodules locally. How would one get it to the
> > remote side? It seems to me as if we would need to implement additional
> > infrastructure to do this. Would it not be simpler if we just kept it on
> > a ref on the local side as well? We already have the infrastructure to
> > read those values from a ref. We only would need to add something to
> > write them. Then a simple push, which could be aliased in form of a
> > git-submodule subcommand, suffices to get the values to the remote.
> 
> That is good idea!

Thanks.

> > That also solves issues when people clone from their working copy.
> >
> > I would like to think a little bit further about the conflict situation
> > when two remotes are providing values. Configuring this looks to me like
> > a nightmare for users. Maybe there is some sort of elegant solution?
> > E.g. like we use the values from remote A during a fetch from A, the
> > ones from B during a fetch from B and no values from a special ref in
> > case there is no remote operation involved. Since the main goal is to
> > support forking of submodules isn't there always a remote operation
> > involved?
> 
> Here is what I imagine
> When B mirrors from A, B sets up this special ref for its repository,
> e.g. refs/meta/submodule-B and have a symbolic ref pointing at that.
> (e.g. SUBMODULE_CONFIG pointing at refs/meta/submodule-B,
> which has a worktree which contains a .gitmodules files which
> sets up
>   "submodule.baz.url = http://B/baz"
>   "submodule.relativeBase = http://A"
> 
> That way anyone cloning from B would get
> the superproject and the submodule baz from B while the
> rest of the submodules are found at A.

This sounds sensible. But my imagination of a conflict was in a
different way. E.g. project A has a submodule B. And now A has a remote
1 where you publish and maybe another remote 2 where someone else (a
colleague?) publishes. Which configuration do you use? Here the two
remotes are independent instead of subsequent forks. In this case my
solution would be to use the configuration branch from 1 for B when
interacting with 1. I do not have completely checked whether we always
have a remote at hand for such a resolution.

> When C mirrors from A, they add another branch  refs/meta/submodule-C,
> which can either be a fork of refs/meta/submodule-B with some changes on
> top of it or it can add a reference to refs/meta/submodule-B, i.e. the
> configuration
> would be:
> 
>   "submodule.baseConfig = refs/meta/submodule-B"
>   "submodule.foo.url = ssh://C/foo"
> 
> and SUBMODULE_CONFIG would point at refs/meta/submodule-C.
> 
> When cloning from C, the user would get
> 
>  * the superproject from C
>  * submodule foo from C
>  * submodule baz from B
>  * all other submodules from A
> 
> By the inheriting property of the branch of B there are no conflicting values.
> C could just overwrite submodule.baseConfig for example.

So that means in the default case we create a chain of all previous
forks embedded in repository database. I am not saying that this is
necessarily a bad thing but I feel that it is a new property which we
should think about. It helps because users will get updated values from
sources that are in the chain. On the other hand it adds a lot of
dependencies which are point of failures in case a remote disappears. I
am undecided on this. I would prefer if we could let people play with it
a little (maybe on pu?) and then decide if there are practical pitfalls
with this.

> > My suggested scheme above does not solve the currently quite typical use
> > case where you might 'git fetch' without submodules first and then do
> > the submodule fetches during a 'git submodule update'. On the other hand
> > in the 'ideal future world' where submodules behave like "normal files" the
> > fetch will be done during the superproject fetch so in that case we
> > could solve such conflicts.
> >
> > The main thing which we could keep in mind is that we only allow certain
> > values in such special refs. E.g. only the ones needed to support the
> > fork workflow. BTW, do we actually need to change other values than the
> > URL? Addtionally we ignore other values that are more related to the
> > overall project structure. E.g. like submodule.<name>.ignore.
> 
> Maybe we want to have a dedicated protocol field, eventually.
> A,B,C may have different standards on what they use by default.
> e.g. Use ssh at kernel.org, but http in a corporate mirror, because http is
> the only protocol not blocked by firewall. So I could imagine that a
> complete mirror of submodules with relative URLs wants to only replace
> ssh by http.

By this you mean 'submodule.relativeBase' that you introduced above
right? Or something similar. These values I would still consider them
URL'ish. But my question was more geared towards this direction: Are
there other values than the ones used to assemble the URL that make
sense to share?

E.g.: Someone might want to fork a repository and might want to change
the default set of submodules that are populated with 'git submodule
update --init'. Is this something we should allow via these special refs
or is this actually changing the project structure and should also be
reflected in project history? IMO the latter is the case.

Only things like the technical organisation (like the place where a
repository can be found) justify to be outside of the repository IMO.

A repository without submodules does have one collection of remote
repository urls. To me adding proper fork support seems be the switch
from one collection for one repository to many collections for many
repositories. Since this one collection is already outside of the
superproject it makes sense to do the same for the submodules. So my
question reformulated could be: Are there more values we currently keep
inside the repository for submodules that actually belong outside? A
good indication could be that they are already outside in the
superproject.

I did not find any flaw in these statements yet, but maybe I am
oversimplifying?

Cheers Heiko
