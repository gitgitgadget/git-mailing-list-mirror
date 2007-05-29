From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Mon, 28 May 2007 20:26:42 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705282014480.26602@woody.linux-foundation.org>
References: <20070529000949.28007.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Tue May 29 05:26:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HssMI-0006Fe-Of
	for gcvg-git@gmane.org; Tue, 29 May 2007 05:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbXE2D0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 23:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbXE2D0s
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 23:26:48 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:43706 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752274AbXE2D0r (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2007 23:26:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4T3QhpI027453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2007 20:26:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4T3Qg3s026074;
	Mon, 28 May 2007 20:26:42 -0700
In-Reply-To: <20070529000949.28007.qmail@science.horizon.com>
X-Spam-Status: No, hits=-3.081 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48664>



On Mon, 28 May 2007, linux@horizon.com wrote:
> 
> Even losing a constant factor of 2, it still seems like it might offer a 
> factor-of-2 speedup for large repositories.

Well, not so much according to the numbers I had.

Yes, SHA-1's are very nicely distributed on a larger scale, but on a 
_small_ scale they aren't. 

So you end up being able to get very good initial guesses for the first 
few iterations, but once you get "close enough", you can't do anything at 
all, and then you're actually worse off.

Also, please do realize that the binary search is actually a *smart* 
binary search, which does a radix-256 fan-out at the beginning, getting 
rid of the first 8 levels of searching for free.

The Newton-Raphson thing can do that too (and in my trial patch, did), but 
it means that you actually get rid of just the initial guess (the one that 
worked the best!) and you still have the problem that once you get close 
enough, the distribution at a local level is not at all nice and linear.

So what I did with my patch (you can find it in the archives - search for 
Newton-Raphson, I'd say about 3 months ago) was to do three cycles of 
approximating, and then a linear search. The linear search has good cache 
behaviour, so it's not as horrid as it might sound, but for some numbers I 
did, my approximate thing would hit on the exact first entry about half 
the time, but would have to walk up to ~20 entries occasionally.

Which meant that the binary search (with the initial radix-256 fan-out) 
actually mostly outperformed the Newton-Raphson thing.

Also, object lookup is certainly noticeable, but the biggest cost of it is 
the cache misses, and even then it's not really _that_ noticeable. And 
it's really neither slow nor stupid as it is.

So I'd love to see somebody try to do a _proper_ apprixmation of Newton- 
Raphson, not the quick hack I did. But I think factor-of-two is actually 
optimistic, even for pretty large repos. And it would have to be no worse 
than what we have now for average-sized ones.

(And object lookup time is generally not the dominant cost, so while it's 
noticeable, cutting it down by even a whole 50% isn't going to speed up 
any normal git operations by more than a couple of percent.. Generating 
diffs in particular is a much more costly op for things like "git blame")

		Linus
