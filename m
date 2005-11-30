From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 18:12:57 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511301707020.25300@iabervon.org>
References: <20051128234256.1508.qmail@science.horizon.com>
 <7vhd9wngn6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511301235390.25300@iabervon.org>
 <7vsltdsxzb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511301514500.25300@iabervon.org>
 <7vy835okxs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 00:13:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehb7l-0004zG-Hk
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 00:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVK3XM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 18:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVK3XM1
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 18:12:27 -0500
Received: from iabervon.org ([66.92.72.58]:778 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751201AbVK3XM0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 18:12:26 -0500
Received: (qmail 31399 invoked by uid 1000); 30 Nov 2005 18:12:57 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Nov 2005 18:12:57 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy835okxs.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13029>

On Wed, 30 Nov 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I actually had that problem with the original tables; there isn't a 
> > canonical order in which to list a table of all of the possible matches 
> > and non-matches between items so as to be complete.
> >
> > Perhaps it ought to list, on each line, which previous cases would match, 
> > so that you could see that case 2 is really the conditions of 2 minus the 
> > conditions for 2ALT, which is "all of the ancestors are empty, the head 
> > has a directory/file conflict, and remote exists."
> 
> Sorry, I was not clear about it when I did that table the first
> time.  2ALT was "alternatives suggested to replace 2" and listed
> in the same table for comparison purpose.

I understood that; actually, when I found it, a number of the ALT cases 
had been implemented, and some of them supplimented rather than replaced 
the originals.

> The original table was designed in a way that if you have a
> match on case N, there would not be any other case M that matches
> the case, either N<M or M<N.  IOW, the order to read the table
> did not matter.  At least that was the intention.
> 
> If you read "missing" = 0, "exists" = 1, and take OAB as bit2,
> bit1, and bit0, you can easily see the pattern in the table.  It
> counts in binary, although bit1 has various subcases so the
> table has more than 8 rows, and it is easy to see it covers all.

The hard thing is to verify that all the subcases are listed. I switched 
the orders of matching and non-matching, so that I could make it matching 
and need-not-match. Your table is actually missing a few cases: what 
happens if O is missing, 2 has a directory, and 3 has a file? You note 
that we have to be careful, but don't list the result (which is "no 
merge").

Perhaps the table would be clearer if the lines were grouped in 
exists/missing? (With 5ALT repeated in the 011 and 111 groups, since it 
applies to both) Then you would only need to look at 5 lines with 
cascading (in the most complex case), rather than having to read the whole 
top of the table.

(It is actually written like that, with the exception of 5ALT, 2ALT, and 
3ALT, but it's not visually obvious.)

So case 11 is really: All three exist. Head and remote don't match 
(-5ALT), no ancestor matches remote (-13), and no ancestor matches head 
(-14). Case 13 is really: All three exist. Head and remote don't match 
(-5ALT), there aren't different ancestors which match head and remote 
(-16), and an ancestor matches remote.

The tricky bit is really cases 2ALT and 3ALT, which can be used in cases 
where some but not all of the ancestors are empty, and can't be used if 
there's a directory/file conflict; neither of these conditions matters for 
anything else in the table, so it's hard to fit this in. My strategy is to 
have those as special cases, and have the rest of the table cover 
everything (rather than having case 2 require a directory/file conflict 
and case 7 require that no ancestor be empty, which would be accurate, but 
would make it harder to check for missing cases).

	-Daniel
*This .sig left intentionally blank*
