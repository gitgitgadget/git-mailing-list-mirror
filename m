From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 9 Jul 2007 15:11:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707091450440.5546@racer.site>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707090011070.4248@racer.site>
 <20070709094703.GP1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707091257470.5546@racer.site> <20070709134918.GT1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Jul 09 16:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7u5I-0003Jb-7A
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 16:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbXGIOTY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 10:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbXGIOTY
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 10:19:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:40070 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753308AbXGIOTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 10:19:23 -0400
Received: (qmail invoked by alias); 09 Jul 2007 14:19:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 09 Jul 2007 16:19:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Sm+hCnEcSn3vYgrurkZCTiQFK8LAciZzDsAX5eJ
	KSkW7uzaW9KOQ0
X-X-Sender: gene099@racer.site
In-Reply-To: <20070709134918.GT1528MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51995>

Hi,

On Mon, 9 Jul 2007, Sven Verdoolaege wrote:

> On Mon, Jul 09, 2007 at 01:57:10PM +0100, Johannes Schindelin wrote:
>
> > On Mon, 9 Jul 2007, Sven Verdoolaege wrote:
> >
> > > What if the commit message is larger than the pipe buffer?
> > 
> > You start_command().  Then you write() until it is all written, or the 
> > pipe is broken.  Then you get the output via index_pipe().  Which is a 
> > single sha1.  I do not understand your question.
> 
> Ah, but that is not how my commit "filter" works right now. It should 
> produce the whole commit on stdout (as mentioned in the documentation). 
> So the default filter is "cat" (and not "git-hash-object -t commit 
> --stdin", as you seem to assume).

Sorry. Somehow I misread that index_pipe() for a read_pipe().

> How about I change that to a filter that accepts a single SHA1 and
> produces zero or more SHA1's as output?
> A filter for the current rewrite-commits would then be replaced
> by "xargs | git-cat-file commit | original-filter | git-hash-object -t commit --stdin"

You still have not addressed the fundamental problem!  If the commit 
filter takes the things as a whole commit buffer or as a single sha1, or 
if it writes one, two or -1 commits is not really a fundamental problem.

The real problem is that this filter can only act on _one_ commit.  Yes, 
it wants to change only one commit at a time, but it might need 
information from _other_ commits, too!

> > To enhance on the above example: you're rewriting the commit messages 
> > so that commit names are rewritten to match the rewritten commits.  
> > That is possible by a message filter in cg-admin-rewritehist.
> > 
> > But now somebody comes along, and says "I have a history I need to 
> > rewrite.  All bug fixes.  The commit names were all abbreviated in the 
> > commit messages, but they always had 'commit ' in front of them.  I 
> > want to rewrite them, too."
> 
> The current git-rewrite-commits will rewrite all SHA1's it can find,
> irrespective of any 'commit ' that may precede it.

Even abbreviated ones?

> > > What's wrong with --author='!Darl McBribe' ?
> > 
> > It is a very special use case.  Not always will you be able to get all 
> > the information from the commit object you need for conditional 
> > operations.  My example only showed that you can do the same with that 
> > syntax.  But imagine what you could do if we just added a small 
> > syntactical sugar:
> > 
> > 	-e '?has-path:README?substitute/v2/v3/'
> 
> So you want to introduce a whole language?
> Isn't that a bit over-engineering?

We already have a tool which is powerful enough to do that.  Yes, it is a 
little complicated to operate, and yes, it is slower than your version.  
But darn it, it _does_ more than your version.

It is a pity that you did not address the fundamental problem, so I have 
to spend time (that I should really spend differently) thinking about it.

Alas, I think I have a solution. You need a flag:

	--write-sha1-mappings=<directory>

Yes, it makes your code slower again, but only if you need those mappings.

Yes, it is way less convenient than the "map" function, but then you could 
automatically write a script into that directory, providing the 
convenience functions, and exporting the path so that you can say

	--commit-filter '. "$G"; ... map "$sha1"'

and also add convenience functions "save <varname>" and "restore 
<varname>" so that finally a bit of convenience is restored to the filter 
writers.

But those are no longer fundamental problems.  I'd be glad if you could 
put these suggestions to use in rewrite-commits.

While at it, you should also change the semantics for the commit filter, 
probably even less so than you suggested: since you rewrite the parents, 
and the tree, you should continue to pipe this information into the commit 
filter.  That would be another place for a convenience function "commit", 
which does the same as "git hash-object -w --stdin".

Okay now. To be precise, here is my wish list:

* rename the darned things to "filter" again.

* --write-sha1-mappings=<directory> (or --write-commit-mappings), possibly 
  defaulting to .git/mappings/.  Be careful not to overwrite an existing 
  such directory.

* change the semantics of the commit filter: the output is a list 
  (possibly empty) of replacement sha1's for this commit.

* if any filters are called, provide a script with convenience functions, 
  and an environment variable pointing to it.  These functions should 
  include:

	* map
	* commit
	* save
	* restore

Ciao,
Dscho
