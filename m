From: Johan Herland <johan@herland.net>
Subject: Re: rebasing commits that have notes, was Re: Git Notes idea.
Date: Wed, 17 Dec 2008 10:15:45 +0100
Message-ID: <200812171015.45303.johan@herland.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
 <20081216085108.GA3031@coredump.intra.peff.net>
 <alpine.DEB.1.00.0812170110160.14632@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Govind Salinas <govind@sophiasuchtig.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 10:20:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCsZv-0004ym-0Z
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 10:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075AbYLQJTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 04:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbYLQJTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 04:19:09 -0500
Received: from smtp.getmail.no ([84.208.20.33]:58520 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbYLQJTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 04:19:05 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KC000KC6KJRFD00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 17 Dec 2008 10:19:03 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KC00057AKEA9WE0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 17 Dec 2008 10:15:46 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KC000A7DKE9EFHN@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 17 Dec 2008 10:15:46 +0100 (CET)
In-reply-to: <alpine.DEB.1.00.0812170110160.14632@racer>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103327>

On Wednesday 17 December 2008, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 16 Dec 2008, Jeff King wrote:
> >   Some discussion of the interaction of notes and rebase:
> >   http://thread.gmane.org/gmane.comp.version-control.git/100533
>
> Oh, I misinterpreted that label... of course you can track rebases in
> notes, but some issue that we did not look into yet (I think) is the
> issue that you can cherry-pick and rebase commits and lose notes in the
> process.
>
> It seems that the notes idea is not that unintrusive as I thought...

So we have two issues here:

1. Using notes to annotate the rebase/cherry-pick action itself.

2. Preserving (or at least giving the user the option of preserving) notes 
across a rebase/cherry-pick.


I think issue #1 has already been discussed, and is largely resolved: People 
can do this if they want to; it probably only makes sense when 
rebasing/cherry-picking public branches; etc... AFAICS there are no 
remaining problems here that needs an intrusive solution (see below for one 
such unintrusive alternative).

Issue #2, however, is a little more involved. We can discuss the merits of 
wanting to preserve notes across a rebase/cherry-pick itself; e.g. when it 
makes sense to preserve notes, and when it doesn't make sense, but I think 
this is orthogonal to the issue of HOW to preserve them, so instead of 
focusing on WHY, I'll focus on HOW:

If notes are named according to the "refs/notes:<first byte in hex>/<rest of 
bytes>/<referenced object SHA-1>" scheme (and AFAICS this is still being 
discussed, so it's indeed a big IF), then rebase/cherry-pick of the 
referenced object simply translates to a rename/copy of the corresponding 
note (this is of course assuming that the note itself does not contain the 
SHA-1 of the referenced object). This could probably be solved fairly 
unintrusively in the current code, but there are (as always) complications:

- The user may want to amend the note after the rebase/cherry-pick (just as 
(s)he may want to amend the commit message).

- In some cases it may even make sense to fold (parts of) the note _into_ 
the commit message.

- probably more reasons...

So what about the following proposal: Add hooks that are invoked by 
rebase/cherry-pick with the <from-SHA1> and <to-SHA1> as arguments. A 
typical hook script can then use this information to look up notes 
referencing <from-SHA1> and update these to reference <to-SHA1> instead, 
and in the process, prompt the user to do whatever changes (s)he wants to. 
The hook scripts can do other things as well, e.g. implementing issue #1 
above (adding notes for annotating the rebase/cherry-pick itself.)


Have fun! :)

...Johan


PS: What's the current status on git-sequencer? It's probably the best place 
to invoke these hooks.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
