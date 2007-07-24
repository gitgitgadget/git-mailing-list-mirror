From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] filter-branch: rewrite only refs which were not 
 excludedbythe options
Date: Tue, 24 Jul 2007 17:03:42 +0200
Organization: eudaptics software gmbh
Message-ID: <46A614CE.597C7130@eudaptics.com>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>   
	 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241205480.14781@racer.site>
	   <46A5E136.D413D3B7@eudaptics.com> <Pine.LNX.4.64.0707241229170.14781@racer.site>
	  <46A5FF69.F5D75C9E@eudaptics.com> <Pine.LNX.4.64.0707241435290.14781@racer.site>
	 <46A607EB.BA31D7C5@eudaptics.com> <Pine.LNX.4.64.0707241518290.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 17:03:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDLvK-0007ha-RM
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 17:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbXGXPDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 11:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXGXPDj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 11:03:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33224 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbXGXPDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 11:03:38 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1IDLvB-0002wm-LW; Tue, 24 Jul 2007 17:03:34 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 70C8355DD; Tue, 24 Jul 2007 17:03:33 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 2.3 (++)
X-Spam-Report: AWL=-1.366, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53607>

Johannes Schindelin wrote:
> 
> Hi,
> 
> On Tue, 24 Jul 2007, Johannes Sixt wrote:
> 
> > Johannes Schindelin wrote:
> >
> > > On Tue, 24 Jul 2007, Johannes Sixt wrote:
> > >
> > > > But there's another problem. Consider this history:
> > > >
> > > >    ---X--o--M         <- master
> > > >              \
> > > >           ...-o-...-o <- topic
> > > >
> > > > Then this (rather contrieved) command:
> > > >
> > > >    $ git-filter-branch -n $n master topic --not X
> > > >
> > > > If $n is small enough so that M is never rewritten, then
> > > >
> > > >    git rev-list -1 "$ref" $negatives
> > > >
> > > > still expands to non-empty even for 'master' (= M), which then
> > > > incorrectly ends up in "$tempdir"/heads.
> > >
> > > Aaargh!  Of course!  Since I have to add --topo-order at the end.
> > > Otherwise it makes no sense.
> >
> > No, that was no my point: In my example above, if n=1, `git rev-list -1
> > "$ref" $negatives` evaluates to
> >
> >     $ git rev-list -1 "master" -n 1 ^X
> >
> > which returns M, even though M is not going to be rewritten.
> > --topo-order changes nothing. The problem is that the -n is a relative
> > restriction. --since is turned into --max-age, which is absolute,
> > therefore, the test works as expected with --since.
> 
> So you think we have to say something like
> 
>         git rev-list "$ref" $negatives | grep "$ref" > /dev/null || continue
> 
> ?

No, doesn't help either.

We are talking about a case where there is more than one positive ref.
We need not consider the -- sub/ case - it makes things just even more
complicated. There are two different rev ranges to be considered:

  # (1) candidate range to be rewritten
  $ git rev-list "$@"

  # (2) test if positive ref is in candidate range
  $ git rev-list $ref $negatives

Usually (without -n) (2) is a subset of (1) because (1) has all positive
refs and (2) has only one. And the subset is empty iff the positive ref
is not in the rewritten range.

However, if "$@" (and, hence, $negatives) contains the -n limiter, this
is no longer true. Example:

 (1)  is: "rev-list -n 1 A B ^C": we get either A or B, but not both;
      lets say A.
 (2A) is: "rev-list -n 1 A ^C": we get A -- good
 (2B) is: "rev-list -n 1 B ^C": we get B -- ouch!

For each positive ref, A, B, we conduct test (2). For A, the test result
is correct. But for B it is not. We expect it to tell us that B is not
rewritten; but in fact it tells the opposite by returning something
instead of nothing.

-- Hannes
