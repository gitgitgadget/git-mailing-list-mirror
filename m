From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv5 00/14] git notes
Date: Tue, 8 Sep 2009 17:53:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909081741590.4330@intel-tinevez-2-302>
References: <1252376822-6138-1-git-send-email-johan@herland.net> <200909081054.02523.johan@herland.net> <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302> <200909081436.30761.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 17:53:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml30R-0006kG-16
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 17:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbZIHPxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 11:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbZIHPxI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 11:53:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:58174 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750890AbZIHPxH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 11:53:07 -0400
Received: (qmail invoked by alias); 08 Sep 2009 15:53:07 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 08 Sep 2009 17:53:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EGwY9Xt0Eq9optrBITPpT3qkLrfdyyYcy63jxo9
	z0TIyykjyzFICX
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200909081436.30761.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128014>

Hi,

On Tue, 8 Sep 2009, Johan Herland wrote:

> On Tuesday 08 September 2009, Johannes Schindelin wrote:

> > I can see that some people may think that date-based fan-out is the 
> > cat's ass, but I have to warn that we have no idea how notes will be 
> > used,
> 
> I don't agree. Although we will certainly see many more use cases for 
> notes, I believe that the vast majority of them can be placed in one of 
> two categories:

My experience with Git is that having beliefs how my work is used was a 
constant source of surprise.

> > - I find the restriction to commits rather limiting.
> 
> I see your point, but I don't agree until I see a compelling case for 
> annotating a non-commit.

My point is that it is too late by then, if you don't allow for a flexible 
and still efficient scheme.

> > - most of the performance difference between the date-based and the 
> >   SHA-1 based fan-out looks to me as if the issue was the top-level 
> >   tree. Basically, this tree has to be read _every_ time _anybody_ 
> >   wants to read a note.
> 
> Not sure what you're trying to say here. The top-level notes tree is 
> read (as in fill_tree_descriptor()) exactly _once_. After that, it is 
> cached by the internal data structure (until free_commit_notes() or 
> end-of-process).

By that reasoning, we do not need any fan-out scheme.

Keep in mind: reading a large tree object takes a long time.  That's why 
we started fan-out.  Reading a large number of tree objects also takes a 
long time.  That's why I propagated flexible fan-out that is only read-in 
on demand.

> > But I think that having a dynamic fan-out that can even put blobs into 
> > the top-level tree (nothing prevents us from doing that, right?)
> 
> Well, the "flexible" code does add the new requirement that all entries 
> in a notes (sub)tree object must follow the same scheme, i.e. you 
> cannot have:
> 
>   /12/34567890123456789012345678901234567890
>   /2345/678901234567890123456789012345678901
> 
> but you can have
> 
>   /12/34567890123456789012345678901234567890
>   /23/45/678901234567890123456789012345678901

Umm, why?  Is there any good technical reason?

> > The real question for me, therefore, is: what is the optimal way to 
> > strike the balance between size of the tree objects (which we want to 
> > be small, so that unpacking them is fast)  and depth of the fan-out 
> > (which we want to be shallow to avoid reading worst-case 39 tree 
> > objects to get at one single note).
> 
> s/39/19/ (each fanout must use at least 2 chars of the 40-char SHA1)

That is another unnecessary restriction that could cost you dearly.  Just 
think what happens if it turns out that the optimal number of tree items 
is closer to 16 than to 255...

> Yes, the challenge is indeed striking the correct balance. I believe 
> that the notes code should be taught to write (and automatically 
> re-organize) the notes tree so that it is optimized for the current 
> collection of notes.

Of course!  I never thought that the user should be allowed to make the 
choice how to organize the notes.

Ciao,
Dscho
