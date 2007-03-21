From: Junio C Hamano <junkio@cox.net>
Subject: Re: Set up for better tree diff optimizations
Date: Wed, 21 Mar 2007 12:05:01 -0700
Message-ID: <7vhcse1kpu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703181506570.6730@woody.linux-foundation.org>
	<7vircv3wfc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703210812590.6730@woody.linux-foundation.org>
	<7vslby1qvw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703211110050.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 20:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU67c-0004Dd-U9
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 20:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933740AbXCUTFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 15:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933757AbXCUTFF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 15:05:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63023 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933691AbXCUTFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 15:05:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321190502.UJRJ2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 15:05:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dX511W00F1kojtg0000000; Wed, 21 Mar 2007 15:05:01 -0400
In-Reply-To: <Pine.LNX.4.64.0703211110050.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 21 Mar 2007 11:21:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42814>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 21 Mar 2007, Junio C Hamano wrote:
> ...
>> Would something like this suit your taste?
>
> This looks fine, although the reason I didn't get it done myself is that I 
> have this nagging feeling that there must be some clever way to make it 
> even faster. I hated having to do the "strncmp()" early, when it's not 
> always needed. 
>
> But like your patch, I could never come up with a way to *both* do the 
> "don't strncmp() if you don't have to" *and* do the "nothing further will 
> be interesting any more" optimization..

I briefly tried match[0] < path[0] as a compromise, but it did
not fly well with the eclipse example for obvious reasons ;-).

>> The "rev-list org.eclipse.debug.ui/" test that took 16-17
>> seconds takes 9 seconds with this patch.  Running with a
>> diffrent pathspec "org.apache.ant/" obviously makes it go a lot
>> faster (15sec vs 7sec).
>
> Yeah, and conversely, a pathspec at the end of the list of paths will make 
> it less of an optimization. But in general it shouldn't ever be a loss 
> except for the rather rare case of asking for a path at the end of a tree, 
> and then the loss should be pretty small (ie it's the result of doing a 
> few strncmp's that we used to be able to skip).

We _could_ check never_interesting first and if it is already
dropped then defer strncmp() and check the pathlen > matchlen
comparison first.
