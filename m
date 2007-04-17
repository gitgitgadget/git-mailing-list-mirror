From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] refs.c: add a function to sort a ref list, rather then
 sorting on add
Date: Tue, 17 Apr 2007 23:43:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704172304380.16435@beast.quantumfyre.co.uk>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
 <Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
 <7vslaymzk3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:43:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdwOd-0006Lc-Hk
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 00:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161388AbXDQWnc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 18:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161406AbXDQWnc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 18:43:32 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:34668 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161388AbXDQWnb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 18:43:31 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id A0AE5C645D
	for <git@vger.kernel.org>; Tue, 17 Apr 2007 23:43:30 +0100 (BST)
Received: (qmail 11332 invoked by uid 103); 17 Apr 2007 23:42:49 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3104. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.039985 secs); 17 Apr 2007 22:42:49 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 17 Apr 2007 23:42:49 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7vslaymzk3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44839>

On Tue, 17 Apr 2007, Junio C Hamano wrote:

> I wonder why the loss of "we are replacing the same one" case in
> the original add_ref() was not compensated for in the new
> sort_ref_list().

That would be because it didn't bite me during testing, and I forgot to 
double check the code I was removing after I was happy that the sort was 
producing sane output (it was getting rather late).

Thing is, I'm not sure what to do about it anyway.  You could drop the 
duplicate in the sort, but since add_ref returns a pointer to the added 
entry (and used to simply return a pointer to the one already in the list) 
it's possible that you would be dropping something that someone had a 
pointer to.

> I think we would not call add_ref() to the same list with
> duplicate names, unless (1) filesystem is grossly corrupt, (2)
> somebody added a new ref while we are walking (how does
> readdir() behave in such a case???), or (3) packed-refs file is
> corrupt.

This combined with the fact that the old code didn't check that the sha1 
was the same suggests to me that this behaviour may actually have been a 
subtle bug?  Perhaps the best thing to do is die if we find two entries 
with the same name when sorting?

-- 
Julian

  ---
What passes for optimism is most often the effect of an intellectual error.
 		-- Raymond Aron, "The Opium of the Intellectuals"
