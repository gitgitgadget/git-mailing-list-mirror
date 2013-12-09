From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC/WIP PATCH 0/4] less ignorance of submodules for
 ignore=all
Date: Mon, 9 Dec 2013 22:41:44 +0100
Message-ID: <20131209214144.GD9606@sandbox-ub>
References: <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
 <20131125174945.GA3847@sandbox-ub>
 <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
 <20131204221659.GA7326@sandbox-ub>
 <xmqq7gbkjlgx.fsf@gitster.dls.corp.google.com>
 <20131204231932.GG7326@sandbox-ub>
 <52A0E753.5090908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:42:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq8aW-0005hS-FN
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab3LIVl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:41:56 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:38220 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab3LIVlz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:41:55 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vq8aH-0007eG-SF; Mon, 09 Dec 2013 22:41:46 +0100
Content-Disposition: inline
In-Reply-To: <52A0E753.5090908@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239110>

On Thu, Dec 05, 2013 at 09:51:31PM +0100, Jens Lehmann wrote:
> Am 05.12.2013 00:19, schrieb Heiko Voigt:
> > On Wed, Dec 04, 2013 at 02:32:46PM -0800, Junio C Hamano wrote:
> > This series tries to achieve the following goals for the
> > submodule.<name>.ignore=all configuration or the --ignore-submodules=all
> > command line switch.
> 
> Thanks for the summary.
> 
> >  * Make git status never ignore submodule changes that got somehow in the
> >    index. Currently when ignore=all is specified they are and thus
> >    secretly committed. Basically always show exactly what will be
> >    committed.
> 
> Yes, what's in the index should always be shown as such even when the
> user chose to ignore the work tree differences of the submodule.
> 
> >  * Make add ignore submodules that have the ignore=all configuration when
> >    not explicitly naming a certain submodule (i.e. using git add .).
> >    That way ignore=all submodules are not added to the index by default.
> >    That can be overridden by using the -f switch so it behaves the same
> >    as with untracked files specified in one of the ignore files except
> >    that submodules are actually tracked.
> 
> I think we should do this part in a different series, as everybody
> seems to agree that this should be fixed that way and it has nothing
> to do with what is ignored in submodule history.

So how about I put the two points above into a separate series? IMO, add
and status belong together in this case.

> >  * Let diff always show submodule changes between revisions or
> >    between a revision and the index. Only worktree changes should be
> >    ignored with ignore=all.
> > 
> >  * Generally speaking: Make everything that displays diffs in history,
> >    diffs between revisions or between a revision and the index always
> >    show submodules changes (only the commit ids) even if a submodule is
> >    specified as ignore=all.
> 
> I'm not so sure about that. Some scripts really want to ignore the
> history of submodules when comparing a rev to the index:
> 
> git-filter-branch.sh:			git diff-index -r --name-only --ignore-submodules $commit &&
> git-pull.sh:    git diff-index --cached --name-status -r --ignore-submodules HEAD --
> git-rebase--merge.sh:	if ! git diff-index --quiet --ignore-submodules HEAD --
> git-sh-setup.sh:	if ! git diff-index --cached --quiet --ignore-submodules HEAD --
> git-stash.sh:	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
> 
> I didn't check each site in detail, but I suspect each ignore option
> was added on purpose to fix a problem. That means we still need "all"
> (at least when diffing rev<->index). Unfortunately that area is not
> covered well in our tests, I only got breakage from the filter-branch
> tests when teaching "all" to only ignore work tree changes (see at the
> end on how I did that).

Well all hits are on diff-index which is plumbing. If it is required for
some (internal) scripts to completely ignore submodules I think it is ok
to do so just for plumbing with a commandline option like that. But I am
not sure whether this should actually be configurable.

> So I'm currently in favor of adding a new "worktree"-value which will
> only ignore the work tree changes of submodules, which seems just what
> the floating submodule use case needs. But it looks like we need to
> keep "all".

But that will just add more complexity to the already complex topic of
submodules. There are already enough possibilities to get confused with
submodules. I would like to avoid making it more complex.

>From the feedback we get now from Sergey I take that not many users have
actually been using the 'all' option. Otherwise there would have been
more complaints. So the only thing we have to worry about are scripts
and those we could cover with plumbing commands.

> >  * If ignore=all for a submodule and a diff would usually involve the
> >    worktree we will show the diff of the commit ids between the current
> >    index and the requested revision.
> 
> I agree if we make that "ignore=worktree".
> 
> >> I do think that it is a good thing to make what "git add ." does and
> >> what "git status ." reports consistent, and "git add ." that does
> >> not add everything may be a good step in that direction
> 
> Yup, as written above I'd propose to start with that too.
> 
> >> (another
> >> possible solution may be to admit that ignore=all was a mistake and
> >> remove that special case altogether, so that "git status" will
> >> always report a submodule that does not match what is in the HEAD
> >> and/or index).
> 
> No, looking at the git-scripts that use it together with diff-index it
> wasn't a mistake. But we might be missing a less drastic option ;-)

Well, as said above diff-index is plumbing and as such allowed to do
non-user friendly stuff. For all the other commands I propose to never
hide stuff from the user. E.g. take update-index there you can actually
mark any index entry as "assume unchanged" which will make git stop
checking it for changes (like the submodule.<name>.ignore=all setting for
submodules). IMO that is a potentially problematic setting which no
normal user should do without really knowing the implications. Still I
think for plumbing that is ok since it is not really meant to be
directly used. For porcelain it is a different story and I think we
should really support/guard the users here to not hang themselves.

> > I think it was too early to add ignore=all back then when the ignoring
> > was implemented. We did not think through all implications. Since people
> > have always been requesting the floating model and as it seems started
> > using it I am not so sure whether there is not a valid use case. Maybe
> > Sergey can shed some light on their actual use case and why they do not
> > care about the precise revision most of the time.
> 
> You maybe right about not thinking things thoroughly through, but we
> helped people that rightfully complained when the (then new) submodule
> awareness broke their scripts.

Here you are confusing 'all' with 'dirty'. Before the submodule
awareness starting with 1.7.0 the behavior we now get with 'dirty' was
the default. So that would be the option that helped them.

While talking about I think we should really make 'dirty' the default
instead of 'all'. AFAIR, the goal of ignoring submodules was to take the
runtime penalty that came from recursively scanning submodules for
changes. That is already fulfilled with 'dirty'.

> Below is a hack that disables the diffing of rev and index, but not
> that against the work tree. It breaks t4027-diff-submodule.sh,
> t7003-filter-branch.sh and t7508-status.sh as expected:

I am not sure what this is for. My patch series already implements that
(and includes the needed test changes), The testsuite passes for me.
With my implementation we have fine grained control over where it is ok
to completely ignore submodule diffs and where not.

Cheers Heiko
