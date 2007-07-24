From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: rewrite only refs which were not 
 excludedbythe options
Date: Tue, 24 Jul 2007 20:52:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707242047400.14781@racer.site>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>    
 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241205480.14781@racer.site>
    <46A5E136.D413D3B7@eudaptics.com> <Pine.LNX.4.64.0707241229170.14781@racer.site>
   <46A5FF69.F5D75C9E@eudaptics.com> <Pine.LNX.4.64.0707241435290.14781@racer.site>
  <46A607EB.BA31D7C5@eudaptics.com> <Pine.LNX.4.64.0707241518290.14781@racer.site>
 <46A614CE.597C7130@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:52:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDQQq-0003NR-34
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 21:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822AbXGXTw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 15:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756475AbXGXTw2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 15:52:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:57700 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756136AbXGXTw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 15:52:27 -0400
Received: (qmail invoked by alias); 24 Jul 2007 19:52:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 24 Jul 2007 21:52:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uhuclbJGudsRCMIp7l0folDojfWgaahUlIszsAL
	pLw0ok4V1pl6Mg
X-X-Sender: gene099@racer.site
In-Reply-To: <46A614CE.597C7130@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53634>

Hi,

On Tue, 24 Jul 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> 
> > On Tue, 24 Jul 2007, Johannes Sixt wrote:
> > 
> > > Johannes Schindelin wrote:
> > >
> > > > On Tue, 24 Jul 2007, Johannes Sixt wrote:
> > > >
> > > > > But there's another problem. Consider this history:
> > > > >
> > > > >    ---X--o--M         <- master
> > > > >              \
> > > > >           ...-o-...-o <- topic
> > > > >
> > > > > Then this (rather contrieved) command:
> > > > >
> > > > >    $ git-filter-branch -n $n master topic --not X
> > > > >
> > > > > If $n is small enough so that M is never rewritten, then
> > > > >
> > > > >    git rev-list -1 "$ref" $negatives
> > > > >
> > > > > still expands to non-empty even for 'master' (= M), which then
> > > > > incorrectly ends up in "$tempdir"/heads.
> > > >
> > > > Aaargh!  Of course!  Since I have to add --topo-order at the end.
> > > > Otherwise it makes no sense.
> > >
> > > No, that was no my point: In my example above, if n=1, `git rev-list -1
> > > "$ref" $negatives` evaluates to
> > >
> > >     $ git rev-list -1 "master" -n 1 ^X
> > >
> > > which returns M, even though M is not going to be rewritten.
> > > --topo-order changes nothing. The problem is that the -n is a relative
> > > restriction. --since is turned into --max-age, which is absolute,
> > > therefore, the test works as expected with --since.
> > 
> > So you think we have to say something like
> > 
> >         git rev-list "$ref" $negatives | grep "$ref" > /dev/null || continue
> > 
> > ?
> 
> No, doesn't help either.
> 
> We are talking about a case where there is more than one positive ref.
> We need not consider the -- sub/ case - it makes things just even more
> complicated. There are two different rev ranges to be considered:
> 
>   # (1) candidate range to be rewritten
>   $ git rev-list "$@"
> 
>   # (2) test if positive ref is in candidate range
>   $ git rev-list $ref $negatives

Okay, but with out any subdirs,

	git rev-list "$@" | grep $(git rev-parse "$ref") > /dev/null || continue

should do exactly what we want.  But in that case, we could just use the 
generated list ../revs to grep for the positive refs.

Darn, this _is_ getting complicated.

Ciao,
Dscho
