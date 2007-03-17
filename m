From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Sat, 17 Mar 2007 10:55:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 18:55:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSd7o-0004dv-Gt
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 18:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbXCQRz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 13:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbXCQRz0
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 13:55:26 -0400
Received: from smtp.osdl.org ([65.172.181.24]:39988 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601AbXCQRzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 13:55:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2HHt3cD005932
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 10:55:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2HHt2tM007273;
	Sat, 17 Mar 2007 09:55:03 -0800
In-Reply-To: <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42445>



On Fri, 16 Mar 2007, Nicolas Pitre wrote:
> 
> In the worst case, yes.  And if you're walking history then the 
> probability of hitting the worst case eventually is rather high.

Actually, it's even better than that.

If we're walking a certain pathspec (which is reall ythe only thing that 
is expensive), we're pretty much *guaranteed* that we'll hit exactly this 
case. Doing some instrumentation on the test-case I've been using (which 
is just "git log drivers/usb/ > /dev/null") shows:

	[torvalds@woody linux]$ grep Needs delta-base-trace | wc -l
	469334
	[torvalds@woody linux]$ grep Needs delta-base-trace | sort -u | wc -l
	21933

where that delta-base-trace is just a trace of which delta bases were 
needed. Look how we currently generate almost half a million of them, but 
only 22000 are actually unique objects - we just generate many of them 
over and over again. In fact, the top delta bases with counts looks like:

    558 Needs 102398354
    556 Needs 161353360
    554 Needs 161354852
    552 Needs 161354916
    550 Needs 161354980
    526 Needs 161355044
    524 Needs 161355108
    522 Needs 161355174
    520 Needs 161355238
    508 Needs 161445724
    446 Needs 119712387
    425 Needs 133406737
    420 Needs 161513997
    387 Needs 120784913
    331 Needs 127094253
    321 Needs 95694853
    319 Needs 125888524
    303 Needs 155109487
    301 Needs 155627964
    299 Needs 155628028
    .....

ie the top twenty objects were all generated hundreds of times each.

More importantly, the trace also shows that it actually has very good 
locality too - exactly as you'd expect, since when we traverse the trees, 
we'd generally see a particular delta base used as a base when that thing 
is slowly changing, so of the half-million "needs" entries in my trace, if 
I pick the top delta_base (102398354), and use "cat -n" to give them all 
line numbers (from 1 to half a million), and grep for that particular 
delta:

	grep Needs delta-base-trace | cat -n | grep 102398354 | less -S

they are *all* at lines 61624..89352, with the bulk of them being very 
close together (the bulk of those are all around 88k line mark).

In other words, it's not "spread out" over time. It's very clustered, 
which I'd expect anyway, which means that even a simple cache of just a 
few hundred entries (statically sized) will be very effective.

So the cache doesn't need to be "complete". It will get good hit-rates 
even from being very simple. I think I have a very simple and cunning 
plan, I'll try it out asap.

		Linus
