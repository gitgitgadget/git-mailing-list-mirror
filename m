From: Sam Vilain <sam@vilain.net>
Subject: Re: Continue git clone after interruption
Date: Fri, 21 Aug 2009 10:57:42 +1200
Message-ID: <1250809062.5963.24.camel@maia.lan>
References: <1250509342.2885.13.camel@cf-48>
	 <200908192142.51384.jnareb@gmail.com>
	 <alpine.LFD.2.00.0908191552020.6044@xanadu.home>
	 <200908200937.05412.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	nick edelen <sirnot@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 00:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeGXP-0002Yc-2Z
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 00:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbZHTWzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 18:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755396AbZHTWzH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 18:55:07 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:34782 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181AbZHTWzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 18:55:06 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 9FFB421C3C7; Fri, 21 Aug 2009 10:55:06 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 790BD21C39B;
	Fri, 21 Aug 2009 10:54:57 +1200 (NZST)
In-Reply-To: <200908200937.05412.jnareb@gmail.com>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126656>

On Thu, 2009-08-20 at 09:37 +0200, Jakub Narebski wrote:
> You would have the same (or at least quite similar) problems with 
> deepening part (the 'incrementals' transfer part) as you found with my
> first proposal of server bisection / division of rev-list, and serving
> 1/Nth of revisions (where N is selected so packfile is reasonable) to
> client as incrementals.  Yours is top-down, mine was bottom-up approach
> to sending series of smaller packs.  The problem is how to select size
> of incrementals, and that incrementals are all-or-nothing (but see also
> comment below).

I've defined a way to do this which doesn't have the complexity of
bisect in GitTorrent, making the compromise that you can't guarantee
each chunk is exactly the same size... I'll have a crack at doing it
based on the rev-cache code in C instead of the horrendously slow
Perl/Berkeley solution I have at the moment to see how well it fares.

> Another solution would be to try to come up with some sort of stable
> sorting of objects so that packfile generated for the same parameters
> (endpoints) would be always byte-for-byte the same.  But that might be
> difficult, or even impossible.

delta compression is not repeatable enough for this.

This was an assumption made by the first version of GitTorrent, that
this would be an appropriate solution.  

So, first you have to sort the objects - that's fine, --date-order is a
good starting point, then I reasoned that interleaving new objects for
each commit with commit objects would be a useful sort order.  You also
need to tie-break for commits with the same commit date; I just used the
SHA-1 of the commit for that.  Finally, when making packs to avoid
excessive transfer you have to try to make sure that they are "thin"
packs.

Currently, thin packs can only work starting at the beginning of history
and working forward, which is opposite to what happens most of the time
in packs.  I think this is the source of much of the inefficiency caused
by chopping up the object lists mentioned in my other e-mail.  It might
be possible, if you could also know which earlier objects were using
this object as a delta base, to try delta'ing against all those objects
and see which one results in the smallest delta.

> Well, we could send the list of objects in pack in order used later by
> pack creation to client (non-resumable but small part), and if packfile
> transport was interrupted in the middle client would compare list of 
> complete objects in part of packfile against this manifest, and sent
> request to server with *sorted* list of object it doesn't have yet.
> Server would probably have to check validity of objects list first (the
> object list might be needed to be more than just object list; it might
> need to specify topology of deltas, i.e. which objects are base for which
> ones).  Then it would generate rest of packfile.

Mmm.  It's a bit chatty, that.  Object lists add another 10-20% on,
which I think should be avoidable if the thin pack problem, plus the
problem of some objects ending up in more than one of the thin packs
that are created, should be reduced to very little.

Sam
