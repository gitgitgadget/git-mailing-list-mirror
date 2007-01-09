From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 15:46:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87ps9xgkjo.wl%cworth@cworth.org>
 <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org>
 <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net>
 <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net>
 <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org>
 <7vy7obj07k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 00:46:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Qg0-0006TE-Js
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbXAIXql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbXAIXql
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:46:41 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54929 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932550AbXAIXqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:46:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l09NkXWi024939
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Jan 2007 15:46:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l09NkWsr018876;
	Tue, 9 Jan 2007 15:46:32 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7obj07k.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.665 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36428>



On Tue, 9 Jan 2007, Junio C Hamano wrote:
> 
> Being able to test merge or even make commits without being on a
> branch is vastly useful.

Yes. I think the detached head notion is really really important. I think 
it was a mistake to not allow it initially, but hey, there were various 
historical reasons, and the whole thing about how branches worked was a 
bit up in the air.

I would suggest a solution:

 - git checkout will refuse to switch AWAY from a detached head unless the 
   SHA1 of the detached head exactly matches some other branch.

Not any expensive "reachability" cheaks. Simple and straightforward: just 
say "no, I will not leave this branch-less HEAD behind, because it is not 
described by any other branch or tag".

So if you do

	git checkout v1.4.4

you'll be fine, because even though you got a detached HEAD that isn't 
attached to any branch, it still exists as a tag, so checking out 
something else is fine - you've not lost any state.

In contrast, if you actually start committing to that detached HEAD, you 
need to either

 - use some new flag ("git checkout --forget-old") to explicitly say that 
   you _want_ to leave this old naked branch behind

 - either tag the current point or make a real branch out of it (with 
   either "git tag <tagname>" or "git branch <branchname>" respectively) 
   and then you can check out some other tag/branch after that.

Doing "reachability analysis" is not only expensive, it's actually really 
wrong, because even if the current HEAD is _reachable_ from some other tag 
or branch, you're still going to drop that point in the development series 
unless it _exactly_ matchs it.

Hmm?

I'd love to see the detached HEAD series move into "master", but I do 
think we should make sure that people can't drop their work easily by 
mistake, and I think the above suggestion is both simple and workable.

Comments?

		Linus
