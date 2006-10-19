From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Thu, 19 Oct 2006 09:48:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610190936440.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610181525410.1971@xanadu.home>
 <20061018204626.GA19194@spearce.org> <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
 <20061018214143.GF19194@spearce.org> <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org> <Pine.LNX.4.64.0610181910440.1971@xanadu.home>
 <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org> <7vac3tx900.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610190747060.3962@g5.osdl.org> <20061019160750.GS17794@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 18:49:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gab4f-0003Hh-Dy
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 18:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946208AbWJSQsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 12:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946212AbWJSQsu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 12:48:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946208AbWJSQst (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 12:48:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9JGmUaX014642
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Oct 2006 09:48:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9JGmTht016356;
	Thu, 19 Oct 2006 09:48:30 -0700
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20061019160750.GS17794@delft.aura.cs.cmu.edu>
X-Spam-Status: No, hits=-0.971 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29370>



On Thu, 19 Oct 2006, Jan Harkes wrote:
> 
> If we find a delta against a base that is not found in our repository we
> can keep it as a delta, the base should show up later on in the
> thin-pack. Whenever we find a delta against a base that we haven't seen
> in the received part of the thin pack, but is available from the
> repository we should expand it because there is a chance we may not see
> this base in the remainder of the thin-pack.

Yes, indeed. We can also have another heuristic: if we find a delta, and 
we haven't seen the object it deltas against, we can still keep it as a 
delta IF WE ALSO DON'T ALREADY HAVE THE BASE OBJECT. Because then we know 
that the base object has to be there later in the pack (or we have a 
dangling delta, which we'll just consider an error).

So yeah, maybe my patch-series is something we can still save.

However, the thing that makes me suspect that it is _not_ saveable, is 
this:

 - let's assume we have a nice thin pack, with object A B C D (in that 
   order), which is actually a good pack in itself (ie it _might_ be thin, 
   but it's actually self-sufficient)

 - let A be a full object, and B be packed as a delta off A, C as a delta 
   off B, and D as a delta off C.

 - Try to repack it as a streaming thing (the end result _should_ 
   obviously be exactly the same as the input, since it turns out to be 
   self-sufficient)

Looks trivial, no?

The answer is: no. It's not trivial. Or rather, it _is_ trivial, but you 
have to _remember_ all of the actual data for A, B, C and D all the way to 
the end, because only if you have that data in memory can you actually 
_recreate_ B, C and D even enough to get their SHA1's (which you need, 
just in order to know that the pack is complete, must less to be able to 
create a non-delta version in case it hadn't been).

So we can definitely do the one-pass creation, but it requires that we 
keep track of everything we've expanded so far in memory (because we won't 
have the data available any other way - we don't have them as objects in 
our object database, and we don't have a good new pack yet).

But if you do that, then yes, it's salvageable.

> About that patch series, is there a simple way to import the series into
> a local repository? git-am doesn't like it, even after splitting it into
> separate files on the linebreaks. I guess git-mailinfo could be taught
> to recognise the git-log headers. Or have I missed some useful git apply
> trick.

No, you've not missed anything. I didn't really expect anybody to want to 
seriously play with it, so I didn't bother to do things properly. 

Especially since I hadn't even written very good commit messages.

Anyway, I just pushed the "rewrite-pack" branch to my git repo on 
kernel.org, so once it mirrors out, if you really want to try to fix up 
the mess I left behind, there it is:

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git rewrite-pack

Maybe it's recoverable. 

		Linus
