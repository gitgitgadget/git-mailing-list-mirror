From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: notes, was Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Wed, 8 Jul 2009 15:42:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907081519210.4302@intel-tinevez-2-302>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0907072206170.3155@pacific.mpi-cbg.de> <20090707201326.GB11191@spearce.org> <7vk52k9lvw.fsf@alter.siamese.dyndns.org> <20090707222820.GC11191@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 15:42:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOXPh-0004Rn-NO
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 15:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbZGHNmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 09:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755322AbZGHNmP
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 09:42:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:40781 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755094AbZGHNmO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 09:42:14 -0400
Received: (qmail invoked by alias); 08 Jul 2009 13:42:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp020) with SMTP; 08 Jul 2009 15:42:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dN9x6owZdj74SlDOHyDOcxC3NL64+RLrSyg6xVN
	9+83gMZrOldIfq
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090707222820.GC11191@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122898>

Hi,

On Tue, 7 Jul 2009, Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > >> 
> > >> > * jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
> > >
> > > I was thinking about this the other day.  We could use a hash of the 
> > > commit timestamp as the top level directory.  E.g. if we take the 
> > > commit time of the commit and convert it to a date string, we could 
> > > make the note path e.g.:
> > >
> > >   YYYY/MM/COMMITSHA1
> > 
> > Is the idea to make the tree object we need to scan for that 
> > particular SHA-1 hash smaller?
> 
> No, the idea was to avoid needing to create a massive hash of all
> commit notes just to answer `git log -10` on the current branch.
> I remember that was a concern last time we were talking about this.
> By putting the notes under a timestamped path we can scan only a
> small percentage of the notes before we have sufficient data to
> output the first few commits.

The problem is that you end up with possibly _very_ large root trees in 
the notes, and the whole idea was to reduce the root tree, and load the 
subtrees only on demand.  That way, outputting a couple of commits (or a 
single one) is still cheap.

To recapitulate mugwump's idea: allow not only blobs in the root tree of 
the notes, but also tree objects.  That allows for fan-out -- if you want 
it.

Example:

Commit 0123456789abcdef0123456789abcdef01234567 can be in 
refs/notes:0123456789abcdef0123456789abcdef01234567 or in
refs/notes:01/23456789abcdef0123456789abcdef01234567 or in
refs/notes:01/23/456789abcdef0123456789abcdef01234567 or in

My idea was to let shorter paths (in terms of characters used) precedence 
(and longer prefixes).  There was also the idea to always show all of 
them, but that would not appeal to me from a performance angle.

> > If so, I am not sure how it would help over another approach of say 
> > taking the first four hexdigits from the SHA-1 to use as the initial 
> > fan-out YYYY, then two hexdigits for the secondary fan-out MM.
> 
> See above, the idea is to avoid scanning all notes at once on startup.  
> SHA-1 is bad at this as a fanout because it is too good at uniform 
> distribution of the names.

The problem is the unpacking of the tree object.

> > Besides, trees and blobs cannot be annotated with that approach.
> 
> True.  But I didn't realize that was a goal.  :-|

It would be a nice-to-have, I guess.

Ciao,
Dscho
