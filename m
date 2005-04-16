From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: Merge with git-pasky II.
Date: Sat, 16 Apr 2005 13:29:02 -0700
Message-ID: <E1DMtuY-0002fL-3b@approximate.corpus.cam.ac.uk>
References: <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 22:26:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMtrh-0004wI-Ci
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 22:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVDPU3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 16:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVDPU3m
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 16:29:42 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:8640 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262751AbVDPU3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 16:29:38 -0400
Received: from approximate.corpus.cam.ac.uk ([68.99.205.42])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416202913.ZLFE18934.fed1rmmtao08.cox.net@approximate.corpus.cam.ac.uk>;
          Sat, 16 Apr 2005 16:29:13 -0400
Received: from sanjoy by approximate.corpus.cam.ac.uk with local (Exim 4.50)
	id 1DMtuY-0002fL-3b; Sat, 16 Apr 2005 13:29:02 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: Your message of "Fri, 15 Apr 2005 08:32:46 MST."
             <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org> 
X-Mailer: MH-E 7.82; nmh 1.1; GNU Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> And that "where did this come from" decision should be done at _search_
> time, not commit time.

I like this elegant approach, but clever pattern matching can help even
at commit time.  Suppose hello.c is simply:

  printf ("Hello %d\n", year);

And then developer A updates hello.c to:

  printf ("Hello %d\n", year);
  printf ("And   %d\n", year+1);

Meanwhile developer B updates hello.c to:

  printf ("Hello %d\n", yyyy);

How to merge these two changes?  The psychic solution is

  printf ("Hello %d\n", yyyy);
  printf ("And   %d\n", yyyy+1);

Darcs handles token renames specially, but it's not a general solution
so let's leave it aside.  The example does not have enough information
to make the psychic solution unique or reliable, but imagine that the
example were longer to solve that problem.  You'd want to describe the
delta A(hello.c) as
   
  1. duplicated message line
  2. changed 2nd line a bit

And B(hello.c) as

  1. Changed year to yyyy

In that representation, merging the two deltas becomes

  1. duplicated message line
  2. changed 2nd line a bit
  3. Changed year to yyyy in both lines

Or, by commuting the merge operations and adjusting for their
non-commutativity (in terminology like darcs's -- I'm also a physicist):

  1. Changed year to yyyy
  2. duplicated message line
  3. changed 2nd line a bit

So here some of the computation that Linus wants only at question time
(e.g. 'how did that line get here??') is also useful at merge time.
It's difficult (expensive, unreliable) to describe deltas in the form
above or, worse, to merge two such descriptions, but I hope it
illustrates the point.  And perhaps a robust and easier-to-compute
change-description language can be dreamt up, even if the general
problem of describing changes compactly is not computable -- it's almost
the same, or is the same, as finding the Kolmogorov complexity of a data
set.

Or have I missed a fundamental point?

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
