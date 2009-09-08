From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 00/14] git notes
Date: Wed, 09 Sep 2009 00:46:45 +0200
Message-ID: <200909090046.45213.johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
 <200909081436.30761.johan@herland.net>
 <alpine.DEB.1.00.0909081741590.4330@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 09 00:46:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml9Si-00029m-AB
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 00:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbZIHWqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 18:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbZIHWqq
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 18:46:46 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54451 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751168AbZIHWqp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 18:46:45 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPO001U6CLYBOD0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 09 Sep 2009 00:46:46 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPO0005WCLXO400@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 09 Sep 2009 00:46:46 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.8.223332
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
In-reply-to: <alpine.DEB.1.00.0909081741590.4330@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128046>

On Tuesday 08 September 2009, Johannes Schindelin wrote:
> On Tue, 8 Sep 2009, Johan Herland wrote:
> > On Tuesday 08 September 2009, Johannes Schindelin wrote:
> > > I can see that some people may think that date-based fan-out is the
> > > cat's ass, but I have to warn that we have no idea how notes will be
> > > used,
> >
> > I don't agree. Although we will certainly see many more use cases for
> > notes, I believe that the vast majority of them can be placed in one of
> > two categories:
> 
> My experience with Git is that having beliefs how my work is used was a
> constant source of surprise.

And you believe that a system that only allows SHA1-based fanout schemes is 
better equipped to tackle such surprises than a system that provides both 
date-based and SHA1-based fanout schemes?

> > > - I find the restriction to commits rather limiting.
> >
> > I see your point, but I don't agree until I see a compelling case for
> > annotating a non-commit.
> 
> My point is that it is too late by then, if you don't allow for a
>  flexible and still efficient scheme.

As I replied to Junio, we could use the epoch as a "commit date" for tree 
and blob objects, thus making them representable in a date-based fanout 
scheme (although if there are a signficant number of non-commit notes, the 
code should be smart enough to find a better (SHA1-based probably) fanout 
scheme for those notes).

> > > - most of the performance difference between the date-based and the
> > >   SHA-1 based fan-out looks to me as if the issue was the top-level
> > >   tree. Basically, this tree has to be read _every_ time _anybody_
> > >   wants to read a note.
> >
> > Not sure what you're trying to say here. The top-level notes tree is
> > read (as in fill_tree_descriptor()) exactly _once_. After that, it is
> > cached by the internal data structure (until free_commit_notes() or
> > end-of-process).
> 
> By that reasoning, we do not need any fan-out scheme.
> 
> Keep in mind: reading a large tree object takes a long time.  That's why
> we started fan-out.  Reading a large number of tree objects also takes a
> long time.  That's why I propagated flexible fan-out that is only read-in
> on demand.

Not sure where you're going with this. Of course we want to strike an 
optimal balance between the size of tree objects and the number of tree 
objects. Nobody is arguing about that. Both SHA1-based and (in the most 
common cases) date-based schemes can be used to achieve this balance. But 
using date-based fanout has the added advantage of providing better 
performance (both runtime- and memory-wise) when looking up notes in a 
chronological order.

> > > But I think that having a dynamic fan-out that can even put blobs
> > > into the top-level tree (nothing prevents us from doing that, right?)
> >
> > Well, the "flexible" code does add the new requirement that all entries
> > in a notes (sub)tree object must follow the same scheme, i.e. you
> > cannot have:
> >
> >   /12/34567890123456789012345678901234567890
> >   /2345/678901234567890123456789012345678901
> >
> > but you can have
> >
> >   /12/34567890123456789012345678901234567890
> >   /23/45/678901234567890123456789012345678901
> 
> Umm, why?  Is there any good technical reason?

In the date-based parts of notes tree, there are very good reasons for doing 
so: The code peeks at the first tree entry in order to determine what kind 
of date-based fanout is used in the current tree object. Subsequent entries 
(in that tree object) that do not follow the same format are 
skipped/ignored.

The SHA1-based fanout code has not changed since the last iteration, so this 
extra requirement is not absolutely necessary for the SHA1-based parts of 
the notes tree. However, the extra requirement does guarantee that commit 
notes have exactly one unique location in the notes tree, and thus relieves 
us of having to keep searching for alternative notes locations, and 
concatenate the notes found.

> > > The real question for me, therefore, is: what is the optimal way to
> > > strike the balance between size of the tree objects (which we want to
> > > be small, so that unpacking them is fast)  and depth of the fan-out
> > > (which we want to be shallow to avoid reading worst-case 39 tree
> > > objects to get at one single note).
> >
> > s/39/19/ (each fanout must use at least 2 chars of the 40-char SHA1)
> 
> That is another unnecessary restriction that could cost you dearly.  Just
> think what happens if it turns out that the optimal number of tree items
> is closer to 16 than to 255...

The code can easily be rewritten to allow for "odd" fanouts (1/39, 1/1/38, 
etc.). Feel free to submit a patch.

I was, however, naive enough to assume that when git.git decided on using 
2/38 fanout for its loose objects, then some performance-related thoughts
went into that decision. If there are indications that multiple-of-2-type 
fanouts are not optimal, we should probably reconsider.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
