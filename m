From: Junio C Hamano <junkio@cox.net>
Subject: Re: Slow fetches of tags
Date: Wed, 24 May 2006 18:32:01 -0700
Message-ID: <7vd5e23n5a.fsf@assigned-by-dhcp.cox.net>
References: <20060524131022.GA11449@linux-mips.org>
	<Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605240947580.5623@g5.osdl.org>
	<7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605241200110.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 03:32:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj4hs-0002ST-PY
	for gcvg-git@gmane.org; Thu, 25 May 2006 03:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWEYBcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 21:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWEYBcE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 21:32:04 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:58103 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964807AbWEYBcD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 21:32:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525013202.ZPAY15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 21:32:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 24 May 2006 16:43:02 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20716>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 24 May 2006, Linus Torvalds wrote:
>> 
>> IOW, I think there's something more fundamentally wrong with the tag 
>> following. We _should_ have figured out much more quickly that we have it 
>> all.
>
> Actually, maybe the problem is that Ralf's tree has two roots, because of 
> the old CVS history. It might be following the other root down for the 
> "have" part, since that one doesn't exist at all in the target and the 
> other side will never acknowledge any of it. 
>
> I'll play with it.

I think I know what is going on.  You are exactly right -- the
two-root ness is what is causing this.

We used to stop sending "have" immediately after we get an ACK.
This was troublesome for trees with many long branches, so we
introduced multi_ack protocol extension to let the server side
(upload-pack) say "Ok, enough on this branch -- I know this
object so do not tell me any more about objects reachable from
it, but do tell me about other development tracks if you have
one".  If you run "fetch-pack -v" after priming a repository
with Ralf's tree and Chris's tree, you will see many "have" with
occasional "got ack 2 [0-9a-f]{40}".  The latter is upload-pack
acking this way.

This was done to prevent already-known-to-be-common objects
filling up the list of known common commits on the server side.
The remaining slots can be used to discover common commits on
other branches, so that we can minimize the transfer.  It was an
important optimization when dealing with sets of branches that
are long.

This unfortunately breaks down quite badly in this case, since
the remaining "branch" it keeps following is the other history
Chris's tree has never heard of down to its root in vain.

It might be worth changing fetch-pack to note that it has sent
many "have"s after it got an "continue" ACK, and give up early,
say using a heuristic between the age of the commit that did got
an ACK and the one we are about to send out as a "have".
