From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 20:22:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901022008490.30769@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain> <20090102105537.GA14691@localhost>
 <20090102105856.GB14691@localhost> <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain> <alpine.DEB.1.00.0901021918100.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901021050450.5086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clemens Buchacher <drizzd@aon.at>,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 20:24:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIpcU-00010M-15
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 20:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757880AbZABTWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 14:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbZABTWT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 14:22:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:47768 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750810AbZABTWT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 14:22:19 -0500
Received: (qmail invoked by alias); 02 Jan 2009 19:22:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 02 Jan 2009 20:22:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193r6BfslF30x2fggDWiLsCjbIS+bxCiB17aFh5QX
	AnH9Gamw6FO9Vo
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0901021050450.5086@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104408>

Hi,

On Fri, 2 Jan 2009, Linus Torvalds wrote:

> On Fri, 2 Jan 2009, Johannes Schindelin wrote:
> 
> > And the worst part: one can only _guess_ what motivated patience diff.  
> > I imagine it came from the observation that function headers are 
> > unique, and that you usually want to preserve as much context around 
> > them.
> 
> Well, I do like the notion of giving more weight to unique lines - I think 
> it makes sense. That said, I suspect it would make almost as much sense to 
> give more weight simply to _longer_ lines, and I suspect the standard 
> Myers' algorithm could possibly be simply extended to take line size into 
> account when calculating the weights.

I think that it makes more sense with the common unique lines, because 
they are _unambiguously_ common.  That is, if possible, we would like to 
keep them as common lines.

BTW this also opens the door for more automatic code movement detection.

As for the longer lines: what exactly would you want to put "weight" on?  
The edit distance is the number of plusses and minusses, and this is the 
thing that actually is pretty critical for the performance: the larger the 
distance, the longer it takes.  So if you want to put a different "weight" 
on a line, i.e. something else than a "1", you are risking a substantially 
worse performance.

And I am still not convinced that longer lines should get more weight. A 
line starting with "exit:" can be much more important than 8 tabs followed 
by a curly bracket.

> Because the problem with diffs for C doesn't really tend to be as much 
> about non-unique lines as about just _trivial_ lines that are mostly empty 
> or contain just braces etc. Those are quite arguably almost totally 
> worthless for equality testing.

Oh, but then we get very C specific.  Let's not go there.

> And btw, don't get me wrong - I don't think there is anything wrong with 
> the patience diff. I think it's a worthy thing to try, and I'm not at 
> all arguing against it.

I never took you to be opposed.  I myself mainly implemented it because I 
wanted to play with it, and have something more useful than what I found 
in the whole wide web.

> However, I do think that the people arguing for it often do so based on 
> less-than-very-logical arguments, and it's entirely possible that other 
> approaches are better (eg the "weight by size" thing rather than "weight 
> by uniqueness").

Actually, I think it is very possible that merging hunks if there are not 
enough alnums between them could make a whole lot of sense.

But IIRC it was shot down and replaced by the not-so-specific-to-C 
algorithm to merge hunks when the output is shorter than having separate 
hunks.

> The thing about unique lines is that there are no guarantees at all that 
> they even exist, so a uniqueness-based thing will always have to fall 
> back on anything else. That, to me, implies that the whole notion is 
> somewhat mis-designed: it's clearly not a generic concept.
> 
> (In contrast, taking the length of the matching lines into account would 
> not have that kind of bad special case)

However, we know that humans like to start from the unique features they 
see, and continue from there.

And while it is quite possible that it is the wrong approach (see all that 
security theater at the airport, and some nice rational analyses about the 
cost/benefit equations there), imitating humans is still the thing that 
will convince most humans.

Ciao,
Dscho
