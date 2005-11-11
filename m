From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: merge-base: fully contaminate the well.
Date: Thu, 10 Nov 2005 21:36:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511102125510.4627@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <7vll00ov2l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
 <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
 <20051109003236.GA30496@pasky.or.cz> <Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
 <7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511081716450.3247@g5.osdl.org>
 <7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net> <7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511090800330.3247@g5.osdl.org> <7virv1efzv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511091348530.4627@g5.osdl.org> <7virv1a0ro.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511091518370.4627@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 06:37:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaRaC-00043v-Av
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 06:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVKKFgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 00:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVKKFgM
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 00:36:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750782AbVKKFgM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 00:36:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAB5a7nO017861
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 10 Nov 2005 21:36:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAB5a3S1025354;
	Thu, 10 Nov 2005 21:36:05 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmobuc00.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11560>



On Thu, 10 Nov 2005, Junio C Hamano wrote:
>
> The discussion on the list demonstrated a pathological case where
> an ancestor of a merge-base can be left interesting.  This commit
> introduces a postprocessing phase to fix it.

Hmm. I'd suggest only doing this for the (relatively unlikely) case of 
there being more than one merge-base..

You don't even have to be exact about it: just see if the result list is 
bigger than one. (ie "result->next != NULL"). Yeah, sometimes there are 
result commits that get turned UNINTERESTING after they are added to the 
result list, and your "contaminate" phase would be strictly not needed
then, but that's already a pretty unusual case.

So the cheap test is to just say

	/* Do we have multiple results? */
	if (result->next)
		contaminate_well(result);

no?

Btw, I don't think your contamination logic is necessarily complete. We 
may not even have parsed some of the commits that end up being on that 
strange corner case. I think you catch the particular case you tried, but 
I think that in theory, with long chains of commits out of date order, you 
could be in the situation of having determined that everything was 
uninteresting before you even parsed enough to see the chain from one 
merge-base to another.

In fact, I think it would happen with your pathological example if it had 
just one more commit out-of-order in the E-D-C-B chain. But I didn't walk 
it through.

		Linus
