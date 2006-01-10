From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: needs merge
Date: Tue, 10 Jan 2006 00:21:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601092356400.25300@iabervon.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A1336F@hdsmsx401.amr.corp.intel.com>
 <7vy81reoie.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 06:20:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwBvj-0002W9-LE
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 06:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWAJFT3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 00:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWAJFT3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 00:19:29 -0500
Received: from iabervon.org ([66.92.72.58]:10507 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750793AbWAJFT2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 00:19:28 -0500
Received: (qmail 9302 invoked by uid 1000); 10 Jan 2006 00:21:08 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jan 2006 00:21:08 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy81reoie.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14406>

On Sat, 7 Jan 2006, Junio C Hamano wrote:

> *1* While I was trying out the above scenario, I noticed that
> resolve strategy does not notice this and ended up picking one
> ancestor at random.  I think this is because case #16 covers
> only the case where the path P is not changed between C and E
> and D and F, and case #11 must pick an ancestor and picks one at
> random.  Daniel, any thoughts on this?

Right; in this case, we really want to use a merge program that takes 
multiple ancestors and handles the equivalent to case #16 at the hunk 
level, but we don't have such a program available. Such a program would be 
able to identify whether case #16 ever actually occurs for a hunk, which 
is important because there will generally be a bunch of case #11s at the 
file level, even if there aren't any reverts (if the common ancestors 
disagreed before, and the two branches both changed the file to something 
entirely new, with no reverts, either ancestor is correct to use and the 
merge result will be useful; we only need to be careful if there were 
reverts somewhere, which leads to the possibility of false sharing between 
a branch and an ancestor, and thereby to ignoring the revert, and my 
feeling is that rejecting case #11 with divergant ancestors would lead to 
too many conflicts to make crossing merges useable).

One possibility, actually, is to steal a trick from the recursive 
strategy, and have a multi-ancestor merge program which merges all of the 
ancestors with a merge-style diff (i.e., merge output, but on diff instead 
of diff3, with all differences being conflicts), and then uses the result 
as the ancestor for the three-way merge. It seems to me that this would 
capture the central advantage of the recursive strategy without quite so 
much work. Or I might be completely wrong; I'm kind of worn out, and may 
not be thinking clearly.

	-Daniel
*This .sig left intentionally blank*
