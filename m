From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Run garbage collection with loose object pruning
 after svn dcommit
Date: Fri, 5 Oct 2007 09:27:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710050926160.4174@racer.site>
References: <20071005001528.GA13029@midwinter.com> <4705EFF2.9090506@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:27:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdiX3-0001BD-Ts
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbXJEI11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbXJEI11
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:27:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:43173 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752828AbXJEI10 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:27:26 -0400
Received: (qmail invoked by alias); 05 Oct 2007 08:27:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 05 Oct 2007 10:27:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vrO9Z8LmvlHjJB7L/wPok8f2xM2j+vpuuIQtb7l
	4VTIPVpnkxhGA4
X-X-Sender: gene099@racer.site
In-Reply-To: <4705EFF2.9090506@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60049>

Hi,

On Fri, 5 Oct 2007, Andreas Ericsson wrote:

> Steven Grimm wrote:
> > git-svn dcommit, by virtue of rewriting history to insert svn revision IDs,
> > leaves old commits dangling.  Since dcommit is already unsafe to run
> > concurrently with other git commands, no additional risk is introduced
> > by making it prune those old objects as needed.
> > 
> > Signed-off-by: Steven Grimm <koreth@midwinter.com>
> > ---
> > 
> > This is in response to a colleague who complained that, after I
> > installed the latest git release, he was getting lots of "too many
> > unreachable loose objects" errors from the new "git gc --auto" run.
> > Those objects turned out to be dangling commits from a year's worth of
> > git-svn usage, since every git-svn commit will abandon at least one
> > existing commit in order to rewrite it with the svn version data.
> > 
> >  git-svn.perl |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 777e436..be62ee1 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -441,6 +441,12 @@ sub cmd_dcommit {
> >  			}
> >  			command_noisy(@finish, $gs->refname);
> >  			$last_rev = $cmt_rev;
> > +
> > +			# rebase will have made the just-committed revisions
> > +			# unreachable; over time that can build up lots of
> > +			# loose objects in the repo. prune is unsafe to run
> > +			# concurrently but so is dcommit.
> > +			command_noisy(qw/gc --auto --prune/);
> >  		}
> >  	}
> >  }
> 
> I'd be surprised if this would ever prune anything, as git doesn't throw 
> out objects reachable by reflog (or, I assume, any of the objects 
> reachable from objects reachable from reflog).

It will so, in due time.  Reflogs have an expiry date, and will be culled 
by git gc --auto.  So if you dcommit often (which I do), the objects will 
be pruned, eventually.

Ciao,
Dscho
