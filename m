From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] Treat D/F conflict entry more carefully in unpack-trees.c::threeway_merge()
Date: Sat, 07 Apr 2007 17:14:33 -0700
Message-ID: <7vfy7bbu3a.fsf@assigned-by-dhcp.cox.net>
References: <7vabxkcknp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704071456470.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 08 02:14:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaL3J-0007Pw-4C
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 02:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966007AbXDHAOg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 20:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966011AbXDHAOg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 20:14:36 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53387 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966007AbXDHAOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 20:14:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070408001434.XPLP25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 20:14:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kQEZ1W00L1kojtg0000000; Sat, 07 Apr 2007 20:14:34 -0400
In-Reply-To: <Pine.LNX.4.64.0704071456470.27922@iabervon.org> (Daniel
	Barkalow's message of "Sat, 7 Apr 2007 15:08:06 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43992>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sat, 7 Apr 2007, Junio C Hamano wrote:
>
>> This fixes three buglets in threeway_merge() regarding D/F
>> conflict entries.
>> 
>> * After finishing with path D and handling path D/F, some stages
>>   have D/F conflict entry which are obviously non-NULL.  For the
>>   purpose of determining if the path D/F is missing in the
>>   ancestor, they should not be taken into account.
>> 
>> * D/F conflict entry is a phony entry and does not record the
>>   path being processed, so do not pick up the name from there.
>
> This bit is unnecessary, because the first bit means we treat D/F conflict 
> as missing in that conditional, and don't count it as an entry at all, let 
> alone one with a useful name.

I am not sure about what you mean by "first bit", but I added
this after noticing there was a case where the path was not
picked up from index/head/remote correctly because the "pick up
the path from ancestors, while we check for any_anc_missing and
no_anc_exists condition" loop at the beginning already set it to
point at stages[i]->name (which is an empty string "" name of
the df-conflict entry).

But I notice that "aggressive" codepath is the only thing that
wants to use the path (it uses it to check the working tree
status), so maybe we should move that path computation business
inside the aggressive codepath.
