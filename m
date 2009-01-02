From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 19:46:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021918100.30769@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain> <20090102105537.GA14691@localhost>
 <20090102105856.GB14691@localhost> <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clemens Buchacher <drizzd@aon.at>,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 19:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIp3W-0006Y0-QA
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662AbZABSqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757532AbZABSqN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:46:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:57079 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757281AbZABSqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:46:12 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:46:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 02 Jan 2009 19:46:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eC4cFj/EeK6B+Sw8uAIzRzpn0G/PSHI0vveAfLr
	iTT8Py15BSSKZs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104399>

Hi,

On Fri, 2 Jan 2009, Linus Torvalds wrote:


> On Fri, 2 Jan 2009, Clemens Buchacher wrote:
> >
> > Only two choices, and I still get it wrong. The diffs should be 
> > labeled the other way around, of course.
> 
> Yes, this one is a real patience diff change, but it's also the same one 
> that I've seen in the google fanboi findings. What google did _not_ show 
> was any real-life examples, or anybody doing any critical analysis.

FWIW it's the test case in the commit introducing the --patience option.

> So I was hoping for something else than a single "in this case patience 
> diff works really well". I was hoping to see what it does in real life.

I will dig out a real-world example where I _know_ patience diff would 
have helped.  (I remember that I rewrote a pretty large diff which was 
sent on this list, only to understand what it actually does, and I am 
pretty certain this is a good real-world showcase.)

But yes, I agree, the thing does not matter _all_ that much in reality.

The case where I expect a real improvement is when you modify a function 
and insert a function just before it, and Myers' algorithm matches mainly 
empty lines and lines ending in curly brackets.

In other words: something I tried to tackle with ee95ec5d(xdl_merge(): 
introduce XDL_MERGE_ZEALOUS_ALNUM) for merges.

The typical look of such a diff is something like this:

-<... some function header ...>
+<... a completely different function header ...>
 {
-	<... variables ...>
+	<... other variables ...>
 
 	for (i = 0; i < 10; i++) {
-		<... some code ...>
+		<... some code doing something completely different ...>
	}
 
 	return 0;
 }

+<... the function header which was removed earlier ...>
+{
 	<... refactored _and also reindented_ code ...>

> And I haven't seen _any_ real critical analysis of it. Anywhere.

Neither have I.  Let alone something close to documentation.

For example, when the "patience diff algorithm" is explained, it looks 
more like a longest common sequence algorithm when the input is already 
sorted in the first item.

Further, there is no rigorous analysis of the runtime (I figured that the 
original runtime is O(nm) where "n" is the number of lines and "m" is the 
length of the maximal ordered sequence of common unique lines, and my 
implementation can only improve that to O(n log(m))).

This could be improved, I think, for the most common case where you have 
pretty long common _continuous_ sequences of unique lines, i.e. large 
ranges of lines that are identical.

The runtime is especially horrible in the light of the runtime of Myers' 
algorithm, which uses O(n d), where d is the edit distance, i.e. the 
number of lines added + number of lines removed.  (Note: in the real 
world, there are substantial speed ups for consecutive edits, i.e. line 
ranges where there are no common lines at all.)

Also, I am less than thrilled by the job the fanbois did coming up with 
"convincing" evidence: exactly as you pointed out, there are _no_ 
real-world examples where it helps.

And the worst part: one can only _guess_ what motivated patience diff.  I 
imagine it came from the observation that function headers are unique, and 
that you usually want to preserve as much context around them.

Ciao,
Dscho
