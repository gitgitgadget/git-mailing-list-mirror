From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
 #04; Mon, 19)
Date: Wed, 21 Jan 2009 01:28:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210119510.19014@racer>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:29:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPQy3-0001ZF-TJ
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 01:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601AbZAUA1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757202AbZAUA1u
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 19:27:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:47800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753518AbZAUA1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 19:27:50 -0500
Received: (qmail invoked by alias); 21 Jan 2009 00:27:47 -0000
Received: from pD9EB302D.dip0.t-ipconnect.de (EHLO noname) [217.235.48.45]
  by mail.gmx.net (mp004) with SMTP; 21 Jan 2009 01:27:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HOHka/rmHzHd6mQGbLUUegnL1kN5X+Um6PpDovx
	sECliWkBJajVAL
X-X-Sender: gene099@racer
In-Reply-To: <20090121001551.GB18169@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106549>

Hi,

On Tue, 20 Jan 2009, Jeff King wrote:

> On Wed, Jan 21, 2009 at 01:10:22AM +0100, Johannes Schindelin wrote:
> 
> > > Hmm. I suppose that would work, since every test run is trying to create 
> > > the same state.
> > 
> > Yep, that's what I meant with "no race".
> 
> Right, but it is still possible to screw it up, if your creation process 
> does a delete-create. But it looks like you did it correctly in your 
> patch (try to create, and if you fail because it's there, assume it's 
> right).

Actually, I test first if it is there, and only if it is not, try to 
create the symlink.

Now, there is still a very minor chance for a race, namely if two 
processes happen to test the existence of the missing symlink at exactly 
the same time, and both do not find it, so both processes will try to 
create it.

However, the symlink creation is not checked for success, so the processes 
will still both run just fine.

There is a very subtle problem, though.  If you screw with your 
configuration, replacing a link in t/valgrind/ by a script, my code will 
not try to undo it.  However, I think that's really asking for trouble, 
and you can get out of the mess by "rm -r t/valgrind/git*".

Another problem which is potentially much more troublesome is this: 
when there was a script by a certain name, my code would symlink it 
to $GIT_DIR/$BASENAME (actually a relative path, but you get the 
idea).  If that script is turned into a builtin -- this list has certainly 
known a certain person to push for that kind of conversion :-) -- that 
fact is not picked up.

But I think I have an easy solution for that.

> > In any case, I already found a bug in the nth_last series, thanks to 
> > your work, which I'll send in a minute.
> 
> Yay! It's nice when infrastructure work like this actually pays off.

Yep!  Thanks!

> Thanks for picking up this topic...I can drop the size of my 
> ever-growing git todo list by one. :)

Actually, don't remind me... of my TODO list.

Ciao,
Dscho
