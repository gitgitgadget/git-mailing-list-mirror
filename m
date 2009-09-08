From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv5 00/14] git notes
Date: Tue, 8 Sep 2009 11:32:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302>
References: <1252376822-6138-1-git-send-email-johan@herland.net> <200909080512.34634.johan@herland.net> <7vd462qdeg.fsf@alter.siamese.dyndns.org> <200909081054.02523.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 11:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkx3j-0006XE-7V
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 11:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbZIHJcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 05:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbZIHJcH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 05:32:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:52895 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753625AbZIHJcF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 05:32:05 -0400
Received: (qmail invoked by alias); 08 Sep 2009 09:32:06 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp065) with SMTP; 08 Sep 2009 11:32:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Yvnse7S2YTpNg4T/e8XKagD5L+tvhTJ6FOU4H/2
	12LsuXAaXzrpg+
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200909081054.02523.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127996>

Hi,

On Tue, 8 Sep 2009, Johan Herland wrote:

> Algorithm / Notes tree   git log -n10 (x100)   git log --all
> ------------------------------------------------------------
> next / no-notes                4.77s              63.84s
> 
> before / no-notes              4.78s              63.90s
> before / no-fanout            56.85s              65.69s
> 
> 16tree / no-notes              4.77s              64.18s
> 16tree / no-fanout            30.35s              65.39s
> 16tree / 2_38                  5.57s              65.42s
> 16tree / 2_2_36                5.19s              65.76s
> 
> flexible / no-notes            4.78s              63.91s
> flexible / no-fanout          30.34s              65.57s
> flexible / 2_38                5.57s              65.46s
> flexible / 2_2_36              5.18s              65.72s
> flexible / ym                  5.13s              65.66s
> flexible / ym_2_38             5.08s              65.63s
> flexible / ymd                 5.30s              65.45s
> flexible / ymd_2_38            5.29s              65.90s
> flexible / y_m                 5.11s              65.72s
> flexible / y_m_2_38            5.08s              65.67s
> flexible / y_m_d               5.06s              65.50s
> flexible / y_m_d_2_38          5.07s              65.79s

It's good to see that the no-notes behaves roughly like baseline.

I can see that some people may think that date-based fan-out is the cat's 
ass, but I have to warn that we have no idea how notes will be used, and 
the date-based fan-out is rather limiting in certain respects:

- for the typical nightly-build-generated notes, this fan-out is pretty 
  inefficient memory-wise.

- I find the restriction to commits rather limiting.

- most of the performance difference between the date-based and the SHA-1 
  based fan-out looks to me as if the issue was the top-level tree.  
  Basically, this tree has to be read _every_ time _anybody_ wants to read 
  a note.

  Maybe a finer-grained fan-out (finer than 16-bits) could help.  After 
  all, if you have 16 different notes, chances are that they have 16 
  different first letters, but all have the same commit year.  That's 
  where the top-level notes with a fan-out perform incredibly bad.

  But I think that having a dynamic fan-out that can even put blobs into 
  the top-level tree (nothing prevents us from doing that, right?) would 
  _outperform_ the date-based one, at least with less than 1 note/commit 
  (and maybe even then, because the year-based fan-out results in pretty 
  varying entropies per fan-out depth).

  The real question for me, therefore, is: what is the optimal way to 
  strike the balance between size of the tree objects (which we want to 
  be small, so that unpacking them is fast)  and depth of the fan-out 
  (which we want to be shallow to avoid reading worst-case 39 tree objects 
  to get at one single note).

- related to the previous point is my gut feeling that the date-based 
  fan-out has nothing to do with any theoretical optimum.  I am pretty 
  certain that the optimal fan-out strategy depends heavily on the SHA-1s 
  of the annotated objects (if you have 10,000 notes in 2009, but only 1 
  in 2008, the year-based fan-out _must_ be suboptimal)  and maybe is 
  something like a sibling to the Fibonacci heap.

- I'd love to see performance numbers for less than 157118 notes.  Don't 
  get me wrong, it is good to see the worst-case scenario in terms of 
  notes/commits ratio.  But it will hardly be the common case, and I 
  very much would like to optimize for the common case.

  So, I'd appreciate if you could do the tests with something like 500 
  notes, randomly spread over the commits (rationale: my original 
  understanding was that the notes could amend commit messages, and that 
  is much more likely to be done with relatively old commits that you 
  cannot change anymore).

Please understand that I might not have the time to participate in this 
thread as much as I would like to.  The next 4 days will be especially 
hard.

Ciao,
Dscho
