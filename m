From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 19:25:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607011905030.9789@iabervon.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <20060701180125.GA27550@fieldses.org>
 <Pine.LNX.4.64.0607011115500.12404@g5.osdl.org> <Pine.LNX.4.64.0607011754370.9789@iabervon.org>
 <Pine.LNX.4.64.0607011552170.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 01:25:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwopo-0007Lu-W8
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 01:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWGAXZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 19:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWGAXZF
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 19:25:05 -0400
Received: from iabervon.org ([66.92.72.58]:13576 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751163AbWGAXZE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 19:25:04 -0400
Received: (qmail 22550 invoked by uid 1000); 1 Jul 2006 19:25:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Jul 2006 19:25:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607011552170.12404@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23076>

On Sat, 1 Jul 2006, Linus Torvalds wrote:

> On Sat, 1 Jul 2006, Daniel Barkalow wrote:
> > 
> > I think a...b can be computed by (in pseudocode, obviously):
> 
> Nope.
> 
> > It's basically the original merge-bases code, from way back;
> 
> And it has basically the same bug.
> 
> It is possible to have
> 
> 		a
> 	       / \
> 	      b   c
> 	      |\ /|
> 	      d e f
> 	       \|/
> 		g
> 
> and clearly "e" is the only valid merge-base of b and c.
> 
> HOWEVER. It's actually possible that we traverse d, f and g before we even 
> look at 'e' (because somebody had a bogus date, and 'e' _looks_ old).

But that wouldn't actually affect b...c, because we don't actually care 
that 'e' is the correct merge-base and 'g' is not, because "b c ^e ^g" is 
the same as "b c ^e".

Your point is correct, though; if we look at e before c, we could think 
that it's interesting when it isn't, so we have to wait until we've 
drained the list to output anything.

> So that's why git-merge-base has all that extra "unnecessary" complexity. 
> You cannot output anything at all until you've guaranteed that all pending 
> objects are uninteresting.

That's not all the complexity in git-merge-base, though. There's a ton 
more that's about why e is right and g is wrong in your example, and we 
don't care about *that* part in b...c.

Actually, I think that it would work to have object flags "LEFT" and 
"RIGHT", mark b with left, mark c with right, and mark anything with both 
LEFT and RIGHT as UNINTERESTING as we go through the revisions. The 
time-ordering problem with symmetric difference isn't absent with regular 
difference, and, assuming that b..c works in the tricky cases, the same 
logic should handle symmetric difference.

	-Daniel
*This .sig left intentionally blank*
