From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Second parent for reverts
Date: Wed, 09 May 2007 18:43:17 -0700
Message-ID: <7vzm4do3m2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
	<7v7irhslx1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 10 03:43:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlxgi-0007My-Ai
	for gcvg-git@gmane.org; Thu, 10 May 2007 03:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbXEJBnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 21:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbXEJBnT
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 21:43:19 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53101 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbXEJBnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 21:43:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510014319.TOJS24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 21:43:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xDjH1W00k1kojtg0000000; Wed, 09 May 2007 21:43:18 -0400
In-Reply-To: <7v7irhslx1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 09 May 2007 14:54:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46819>

Junio C Hamano <junkio@cox.net> writes:

>> But a' doesn't actually take anything from b, since it's reverting all of 
>> b (unless it's only reverting part of b), and, if b isn't there, it 
>> doesn't need a commit message, either, so it's not different from a. So 
>> the flow should be:
>>
>> a -> b -> c -> d -> e
>>   \              /
>>    --------------
>>
>> And this means blame work correctly: lines that b changed will be blamed 
>> on a (or an ancestor), because e will match a there and be different from 
>> d. So I think git-revert should simply add in the reverted patch's parent. 
>> Does this analysis make sense to other people?
>
> The revert operation at the tree level (not commit level) treats
> AS IF b is a common ancestor between a and d and computes a
> merge between a and d using that fake common ancestor to reach
> at e.  So it is understandable that you are confused that the
> result somehow has something to do with a merge between a and d.
>
> But other than that, the "analysis" does not make any sense to
> me.

Side note.

In the same spirit as gitk and history browsers pay attention to
the in-body SHA-1 of reverted commits, you could make git-blame
pay attention to the revert message.  I think the rough outline
would go like this.

 (1) you run pass_blame_to_parent() on 'e' as usual and give as
     much blame as you can to 'd'; the remainder are attributed
     to 'e' but it is actually a revert of what 'b' did.

 (2) you notice that 'e' is a revert of 'b';

 (3) 'b' always has only one parent, as we do not revert a
     merge; so you can find 'a' easily.

 (4) instead of "take the responsibility for the remaining
     entries" as usual in assign_blame() while drilling down
     'e', you find the matching blob using find_origin and
     find_rename between 'a' and 'e'.  And pass blames that are
     attributed to 'e' down to 'a'.

 (5) then you keep going, digging 'd' and 'a'.
 
