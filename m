From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 12:02:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 21:11:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCjHs-0003Hw-AY
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 21:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWBXULd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBXULd
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 15:11:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58563 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932446AbWBXULd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 15:11:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1OK2rDZ011953
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Feb 2006 12:02:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1OK2p4t005059;
	Fri, 24 Feb 2006 12:02:52 -0800
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20060224192354.GC387@hpsvcnb.fc.hp.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16734>



On Fri, 24 Feb 2006, Carl Baldwin wrote:
> 
> I meant that there is no benefit in disk space usage.  Packing may
> actually increase my disk space usage in this case.  Refer to what I
> said about experimentally running gzip and xdelta on the files
> independantly of git.

Yes. The deltas tend to compress a lot less well than "normal" files.

> I see what you're saying about this data reuse helping to speed up
> subsequent cloning operations.  However, if packing takes this long and
> doesn't give me any disk space savings then I don't want to pay the very
> heavy price of packing these files even the first time nor do I want to
> pay the price incrementally.

I would look at tuning the heuristics in "try_delta()" (pack-objects.c) a 
bit. That's the place that decides whether to even bother trying to make a 
delta, and how big a delta is acceptable. For example, looking at them, I 
already see one bug:

	..
        sizediff = oldsize > size ? oldsize - size : size - oldsize;
        if (sizediff > size / 8)
                return -1;
	..

we really should compare sizediff to the _smaller_ of the two sizes, and 
skip the delta if the difference in sizes is bound to be bigger than that.

However, the "size / 8" thing isn't a very strict limit anyway, so this 
probably doesn't matter (and I think Nico already removed it as part of 
his patches: the heuristic can make us avoid some deltas that would be 
ok).

The other thing to look at is "max_size": right now it initializes that to 
"size / 2 - 20", which just says that we don't ever want a delta that is 
larger than about half the result (plus the 20 byte overhead for pointing 
to the thing we delta against). Again, if you feel that normal compression 
compresses better than half, you could try changing that to

	..
	max_size = size / 4 - 20;
	..

or something like that instead (but then you need to check that it's still 
positive - otherwise the comparisons with unsigned later on are screwed 
up. Right now that value is guaranteed to be positive if only because we 
already checked

	..
	if (size < 50)
		return -1;
	..

earlier).

NOTE! Every SINGLE one of those heuristics are just totally made up by 
yours truly, and have no testing behind them. They're more of the type 
"that sounds about right" than "this is how it must be". As mentioned, 
Nico has already been playing with the heuristics - but he wanted better 
packs, not better CPU usage, so he went the other way from what you would 
want to try..

		Linus
