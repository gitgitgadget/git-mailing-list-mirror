From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Horrible re-packing?
Date: Mon, 5 Jun 2006 17:35:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606051723580.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org> <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
 <20060605211436.GA58708@dspnet.fr.eu.org> <Pine.LNX.4.64.0606051721180.24152@localhost.localdomain>
 <20060606001802.GB5401@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Olivier Galibert <galibert@pobox.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 02:35:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnPXf-0007UZ-1Z
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 02:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWFFAf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 20:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWFFAf2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 20:35:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47054 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750812AbWFFAf1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 20:35:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k560ZG2g021046
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jun 2006 17:35:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k560ZEfV030320;
	Mon, 5 Jun 2006 17:35:15 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20060606001802.GB5401@tuatara.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21359>



On Mon, 5 Jun 2006, Chris Wedgwood wrote:
>
> On Mon, Jun 05, 2006 at 05:22:02PM -0400, Nicolas Pitre wrote:
> 
> > Much more expensive for both memory usage and CPU cycles.
> 
> On a modern CPU I'm not sure you would notice unless the dataset was
> insanely large.

The dataset really _is_ pretty large.

For the kernel, we're talking about a quarter million strings, and it's 
not shrinking. Other (CVS imported from long histories) are in the several 
million object range.

The real problem, btw, is not the CPU cost of sorting them (hey, O(nlogn) 
works ok), but the memory use. We have to keep those quarter million names 
in memory too. At a "pointer + average of ~30 bytes of full pathname 
allocation + malloc overhead", the strings would basically take about 40 
bytes of memory each, and cause constant cache-misses.  In contrast, the 
"hash" value is a 32-bit unsigned, with no pointer overhead.

It's not the biggest part to keep track of (we need to obviously keep 
track of the 20-byte SHA1 and the pointers between objects), but if we had 
the full string info, it would be quite noticeable overhead, on the order 
of several tens of megabytes. 

Now, "tens of megabytes" is not a make-or-break issue any more (you 
definitely want lots of memory if you want to develop with large trees), 
but in a very real sense, the memory footprint of an app is often very 
closely correlated with its performance these days. 

Trying to keep things within the L2 cache can help a lot, and even if we 
expect 2MB and 4MB L2's to get more and more common, it means that we 
should _strive_ to keep datasets down. As it is, we have no _chance_ of 
staying in the L2 cache on the kernel, but for smaller projects we 
hopefully can still do so ;)

			Linus
