From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: BUG: git rebase -i -p silently looses commits
Date: Fri, 13 Nov 2009 10:07:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911130958190.4985@pacific.mpi-cbg.de>
References: <20091104214611.GL9139@dr-wily.mit.edu>  <alpine.DEB.1.00.0911111804520.19111@intel-tinevez-2-302> <1ac2d430911120957gecb6a27k4166016ef8498eab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1029395916-1258103252=:4985"
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 10:04:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8s4a-000280-7B
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 10:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbZKMJDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 04:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbZKMJDv
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 04:03:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:42791 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754730AbZKMJDs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 04:03:48 -0500
Received: (qmail invoked by alias); 13 Nov 2009 09:03:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 13 Nov 2009 10:03:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IWZx27FPIKZ4qe3O+KhWqw190kC/XOfMFggK59c
	12BR78XZpjkUO9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1ac2d430911120957gecb6a27k4166016ef8498eab@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132825>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1029395916-1258103252=:4985
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Greg,

On Thu, 12 Nov 2009, Greg Price wrote:

> On Wed, Nov 11, 2009 at 12:32 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > That is very interesting!
> >
> > However, for rebase-i-p to have a chance to be accepted, I think a few 
> > things are necessary still (this is all from memory, so please take 
> > everything with a grain of salt):
> 
> Great, this is helpful, and it overlaps with my existing to-do list. I 
> have a couple of questions.
> 
> > - rework the mark stuff so that 'todo' works properly, and then change 
> >   the  system to use ':<name>' style bookmarks.
> 
> This is the biggest change I was going to suggest!  Glad we're on the
> same page.  To be clear, what I want to do here is
>  - add a 'mark' command
>  - emit 'mark' commands in the TODO generation for the target of each
> 'goto', and use them.
> Is that also what you had in mind?

Almost.  I called it "bookmark" so that the abbreviated command does not 
clash with "merge".  And there are possible goto targets you have never 
been at:

- A - B - C
    \   /
      D

If C is your HEAD, and you "rebase -i -p B", before cherry-picking D, you 
have to "goto A".

So I strongly advise against trying to give all goto targets a name, just 
the obvious one: onto (you do not need upstream, as all the commits which 
have upstream as parent are supposed to be applied on top of onto anyway).
 
> > - fix that nasty bug which makes one revision not pass the tests (I 
> >   forgot  which one, but it should be in the TODOs)
> 
> Hmm.  I see one TODO comment in your patches, and it doesn't sound like 
> this.  Is there a TODO somewhere else that I'm missing? Alternatively, I 
> can always end up just running the tests on all the revisions and find 
> out.

It should be in one commit message (something like WIP...).

> > - add proper handling for the case when a patch has been applied in 
> >    upstream already, but was not correctly identified as that by 
> >    --cherry-pick (well, this TODO is actually not really related to 
> >   rebase  -i -p, but something I deeply care about)
> 
> Hmm.  I'll have to think about what the behavior could be here.

At the moment, it gives you the status (which is multiple pages long here, 
due to untracked files that I am unwilling to move elsewhere) and then 
"nothing to commit".  You do not even see which commit was to be applied.

My plan was to detect that condition in the error case and _not_ output 
what the cherry-pick printed, but a much more helpful message along the 
lines

	It appears "Bla bli blu" was already applied

For the exact message, I am sure all kinds of painters will want to help 
you.

> For context, I think the issue you're referring to is that sometimes
> the patch-id changed, so that --cherry-pick doesn't identify the
> patch;

Correct.

> and then some later upstream patch has touched the same code again, so 
> that there's a conflict when we try to apply the older patch.

No, that is not what I mean.  I mean when more than one context line 
changes.  Then patch-ids will differ, but a 3-way merge will still succeed 
in finding that there was actually no change.

> > Unfortunately, I am getting more and more deprived of Git time budget 
> > these days, so that I cannot seem to find a few hours to at least 
> > restart my efforts.
> 
> Understood.  I may have some time to work on this soon, we'll see.  I
> think the priorities will be to
>  - add "mark" as you say
>  - add the "pause" command, to make it possible to amend a merge
>  - write tests
>  - fix a couple of bugs, track down the one you mentioned
>  - write documentation
> 
> At that point, and with the reordering you suggested, I think it will
> be ready to submit for inclusion.
> 
> Further comments, and bug reports from anyone else using the
> development version, are welcome.

Thanks,
Dscho

P.S.: I am mostly off-line until Monday.
--8323328-1029395916-1258103252=:4985--
