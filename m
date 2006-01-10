From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 20:38:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601102010100.27199@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
 <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
 <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com> <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org>
 <Pine.LNX.4.63.0601101938420.26999@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601101048440.4939@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:39:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwPKT-0005pr-8u
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 20:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWAJTir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 14:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWAJTiq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 14:38:46 -0500
Received: from mail.gmx.net ([213.165.64.21]:7100 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932345AbWAJTiq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 14:38:46 -0500
Received: (qmail invoked by alias); 10 Jan 2006 19:38:44 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp034) with SMTP; 10 Jan 2006 20:38:44 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601101048440.4939@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14439>

Hi,

[cut down the Cc: list, since this is getting special]

On Tue, 10 Jan 2006, Linus Torvalds wrote:

> > If you bisect, you test a commit. If the commit is bad, you assume *all* 
> > commits before that as bad. If it is good, you assume *all* commits after 
> > that as good.
> 
> No, that's not how bisect works at all.

Okay, so I got that wrong. But for a good reason: this is not the meaning 
of bisection in my lectures. Doesn't matter.

> It's true that if a commit is bad, then all the commits _reachable_ from 
> that commit are considered bad. 
> 
> And it's true that if a commit is good, then all commits that _reach_ that 
> commit are considered good.
> 
> But that doesn't mean that there is an ordering. The commits that fall 
> into the camp of being "neither good nor bad" are _not_ ordered. There are 
> commits in there that are not directly reachable from the good commit.

Those commits not reachable from the good commit are of no interest. Let's 
just ignore them.

> > Now, if you have a 2-dimensional surface, you don't have a *point*, but 
> > typically a *line* separating good from bad.
> 
> Exactly. 
> 
> And a git graph is not really a two-dimensional surface, but exactly was 
> with a 2-dimensional surface, it is _not_ enough to have a *point* to 
> separate the good from bad.
> 
> You need to have a _set of points_ to separate the good from the bad. You 
> can think of it as a line that bisects the surface: if you were to print 
> out the development graph, the set of points literally _do_ form a virtual 
> line across the development surface.

Okay, so there is a cut: Every directed path from good to bad has a single 
commit which is the first bad. Let's call the set of all such bad commits 
the cut set.

Is git-bisect capable of identifying all of the cut set, or just a single 
one?

> > Further, the comparison with 2 dimensions is particularly bad.
> 
> No it is not. It's a very good comparison.

>From your explanation I understand now why you like that comparison.

> > So, how is bisect supposed to work if you don't have one straight 
> > development line from bad to good?
> 
> Read the code.
> 
> I'm pretty proud of it.

I bet nobody can tell ;-)

Well, I read the code. And I answer my own question from 18--19 lines ago:

git-bisect is not capable of identifying the cut set, but pretends that 
there really is only one bad commit (see bisect_bad()).

That may be the best choice if all commits in the cut set except one are 
merges. (It is the best if the cut set contains only one element.)

But I see two problems with that:

- a problem can be introduced independently in two different branches, and
  occur in both of them before the merge (in which case bisect only 
  catches one of the commits), and

- AFAICT if the cut set is one merge and one regular commit, bisect could
  identify the merge by error.

Of course, all this makes only a difference if the bisect has to cross a 
merge.

BTW I think there is a thinko in git-rev-list.txt:

> Thus, if 'git-rev-list --bisect foo ^bar ^baz' outputs 'midpoint', the 
> output of 'git-rev-list foo ^midpoint' and 'git-rev-list midpoint ^bar 
             ^ this should be
	'git-rev-list foo ^midpoint ^bar ^baz'
> ^baz' would be of roughly the same length

Ciao,
Dscho
