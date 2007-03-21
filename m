From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Set up for better tree diff optimizations
Date: Wed, 21 Mar 2007 11:21:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703211110050.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703181506570.6730@woody.linux-foundation.org>
 <7vircv3wfc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703210812590.6730@woody.linux-foundation.org>
 <7vslby1qvw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 19:22:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU5Re-00021w-I0
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 19:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331AbXCUSV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 14:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933334AbXCUSV0
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 14:21:26 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47940 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331AbXCUSVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 14:21:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2LILKcD031490
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 11:21:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2LILIKF032547;
	Wed, 21 Mar 2007 10:21:18 -0800
In-Reply-To: <7vslby1qvw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.475 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42811>



On Wed, 21 Mar 2007, Junio C Hamano wrote:
> 
> As always, you are right and enlightened others with your
> superiour intelligence enough to produce code for you so that
> you do not have to write yourself ;-).

What can I say? It's a gift. I write _just_ enough code so that others get 
intrigued and encouraged to do the rest. Then I step in, and take all the 
glory.

> Would something like this suit your taste?

This looks fine, although the reason I didn't get it done myself is that I 
have this nagging feeling that there must be some clever way to make it 
even faster. I hated having to do the "strncmp()" early, when it's not 
always needed. 

But like your patch, I could never come up with a way to *both* do the 
"don't strncmp() if you don't have to" *and* do the "nothing further will 
be interesting any more" optimization..

That said, your numbers are pretty convincing:

> The "rev-list org.eclipse.debug.ui/" test that took 16-17
> seconds takes 9 seconds with this patch.  Running with a
> diffrent pathspec "org.apache.ant/" obviously makes it go a lot
> faster (15sec vs 7sec).

Yeah, and conversely, a pathspec at the end of the list of paths will make 
it less of an optimization. But in general it shouldn't ever be a loss 
except for the rather rare case of asking for a path at the end of a tree, 
and then the loss should be pretty small (ie it's the result of doing a 
few strncmp's that we used to be able to skip).

Considering that the win on _average_ is in the 50% range (and your 
numbers back that up), it's definitely worth it.

		Linus
