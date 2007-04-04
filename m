From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Partitioned packs
Date: Tue, 3 Apr 2007 19:14:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031858470.6730@woody.linux-foundation.org>
References: <db69205d0704031836u3b3dfc2pb9825dd649aca58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Chris Lee <clee@kde.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 04:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYv1q-0007Fw-PZ
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 04:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966269AbXDDCPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 22:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966271AbXDDCPO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 22:15:14 -0400
Received: from smtp.osdl.org ([65.172.181.24]:53740 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966269AbXDDCPM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 22:15:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l342EXPD031535
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 19:14:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l342EXTK009786;
	Tue, 3 Apr 2007 19:14:33 -0700
In-Reply-To: <db69205d0704031836u3b3dfc2pb9825dd649aca58@mail.gmail.com>
X-Spam-Status: No, hits=-0.453 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 Apr 2007, Chris Lee wrote:
> 
> These experiments include trying to see if there's a noticeable
> performance improvement by splitting out objects of different types
> into different packs. So far, it definitely seems to make a
> difference, though not the one I was initially expecting. For all of
> these tests, I did 'sysctl -w vm.drop_caches=3' before running, to
> effectively simulate a cold-cache run.

Ok, the wordwrap makes it a bit hard to read, but it looks like the 
single-pack always wins. Sometimes by a huge amount.

The reason is simple: not only are single packs well sorted anyway (so if 
you only look at commits, it will only look at the head of the pack 
anyway), but a single pack is much faster to look things up in: you can do 
a single binary lookup.

If you have multiple packs, you *may* be able to do a single binary 
lookup, but quite often you'll do one *failing* binary lookup, and then go 
on to the next pack - in other words, you'll do a linear search over a set 
of binary lookups.

So trying to partition things doesn't help (because the objects are 
already well sorted), and it does hurt.

That said, for most operations it's probably in the noise. Something bad 
happened for your "git-blame" thing for the "commits" and "everything 
else" case. Perhaps just unlucky ordering of packs.

		Linus
