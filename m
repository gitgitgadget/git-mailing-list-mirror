From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Tue, 29 May 2007 09:06:29 +0200
Message-ID: <200705290906.29328.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705281948.27329.johan@herland.net>
 <7vwsysbrtg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 29 09:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsvnC-0002qB-GM
	for gcvg-git@gmane.org; Tue, 29 May 2007 09:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbXE2HGm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 03:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbXE2HGm
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 03:06:42 -0400
Received: from smtp.getmail.no ([84.208.20.33]:32829 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbXE2HGl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 03:06:41 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIS00E0PJR4MH00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 29 May 2007 09:06:40 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIS00HCNJQTO7A0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 29 May 2007 09:06:29 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIS00EU5JQT4W30@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 29 May 2007 09:06:29 +0200 (CEST)
In-reply-to: <7vwsysbrtg.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Monday 28 May 2007, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > On Monday 28 May 2007, Linus Torvalds wrote:
> >> On Mon, 28 May 2007, Johan Herland wrote:
> >> > I still don't see what makes note objects inherently more expensive than
> >> > commit objects. Except for the refs, of course, but we're getting rid
> >> > of those (at least replacing them with a more efficient reverse mapping).
> >> 
> >> It's exactly the refs that I worry about.
> >> 
> >> Anything that needs to read in all notes at startup is going to be _slow_.
> >> 
> >> In contrast, commits we read when (and only when) we need them.
> >
> > Ok. But the reverse mapping will help with this, won't it?
> > We'll look up the interesting commits and find their associated
> > note objects directly.
> 
> The issue Linus brought up worries me, too.
> 
> The "efficient reverse mapping" is still handwaving at this
> stage.  What it needs to do is an equivalent to your
> implementation with "refs/notes/<a dir per commit>/<note>".  The
> "efficient" one might do a flat file that says "notee note" per
> line sorted by notee, or it might use BDB or sqlite, but the
> amount of the data and complexity of the look-up is really the
> same.  A handful notes per each commit in the history (I think
> Linus's "Acked-by after the fact" example a very sensible thing
> to want from this subsystem).
> 
> I am not saying that it is impossible to make the set-up cost
> for the "efficient lookup" almost zero, and to make it lazy and
> on-demand.  The concern above just adds one design constraints
> to that "efficient reverse mapping" code yet to come.

Ok, here's what I'm thinking so far on that reverse mapping:

1. Keep a file, ".git/reverse_tagmap_sorted" with one entry of the form
"pointee pointer" per line. The file is sorted on "pointee", so we can
easily do the radix-256-fan-out-followed-by-binary-search trick that
Linus mentioned in another thread. This should hopefully make lookup
fairly cheap. BTW, if there is a similar "pointee pointer"-type format
already being used in git, I'd be happy to use that instead. I looked
at the "peeled" format being used by packed-refs, but using that
directly doesn't sound like a good idea, since the refname causes the
entries to be of variable length, and the refnames are not interesting
to me at all.

2. Keep another file, ".git/reverse_tagmap_unsorted" in front of (1).
This file has exactly the same format, minus the sorting. It exists just
to make insertion cheap. Once this file reaches a certain size (i.e.
when trawling it on lookup becomes slightly painful), we shuffle the
entries into the sorted file (this would happen automatically on
insertion of an entry, and should _not_ have to be triggered by 'git-gc'
etc.).


Of course, if we think insertion directly into (1) will never be too
expensive, we can drop (2) altogether.

I don't know enough about packing to have a good idea on how to pack
these reverse tagmaps, but Shawn's thoughts about keeping associated
tags/notes and objects close together makes a lot of sense. I'm just
not sure yet where these reverse tagmaps fit into the whole picture.

Currently, AFAICS, the packed-refs file is never propagated into the
packs, but stays separate for the lifetime of the repo, but then it
seems we're designing these reverse tagmaps for managing a handful of
notes per commit, i.e. to hold a couple of orders of magnitude more
entries than the packed-refs file.

Maybe each pack should keep the reverse tagmap for all the object->note
relationships internal to that pack? Everything else (unpacked notes,
and object->note relationships spanning packs) would be kept in (1).
Of course, when repacking, we'd try to keep objects and their notes
together as much as possible, to maximize the in-pack reverse tagmap,
and minimize the number of entries left behind in (1).


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
