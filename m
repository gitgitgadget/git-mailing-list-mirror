From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-log to go forward instead of reverse?
Date: Mon, 10 Jul 2006 12:26:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607101221170.5623@g5.osdl.org>
References: <86bqrxpai1.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0607101151470.5623@g5.osdl.org>
 <863bd9p9en.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0607101212410.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 21:26:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G01Oo-0007lX-HA
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 21:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWGJT01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 15:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbWGJT01
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 15:26:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422797AbWGJT00 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 15:26:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6AJQPnW031395
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Jul 2006 12:26:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6AJQNVF015609;
	Mon, 10 Jul 2006 12:26:24 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <Pine.LNX.4.64.0607101212410.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23643>



On Mon, 10 Jul 2006, Linus Torvalds wrote:
> 
> The difference between getting the first screenful in 0.054 seconds versus 
> it taking 2.218 seconds is quite noticeable, and one of the things I've 
> actually spent a fair amount of time on is to make sure that the 
> incremental output case is the _common_ one for all the normal operations 
> like "git log -p".

Side note: the good news is that even with the reverse generation, if you 
also generate _diffs_, the diffs will be generated incrementally, so:

	// Full "git log" with diffs
	[torvalds@g5 linux]$ time git log -p drivers/serial > /dev/null 

	real    0m3.409s
	user    0m3.360s
	sys     0m0.052s

	// First screenful of reverse git log with diffs
	[torvalds@g5 linux]$ time git log -p --reverse drivers/serial | head -25 > /dev/null 
	
	real    0m2.228s
	user    0m2.216s
	sys     0m0.012s

	// First screenful of regular git log with diffs
	[torvalds@g5 linux]$ time git log -p drivers/serial | head -25 > /dev/null 
	
	real    0m0.038s
	user    0m0.036s
	sys     0m0.004s

here you can see how the full "git log -p" is obviously more expensive 
than the full "git log" was (the diff generation adds about a second to 
the full time), but because the diffs are generated incrementally as they 
are shown even with "--reverse", the first screenful of the "--reverse" 
case didn't get any more expensive, because we didn't generate all the 
diffs up-front, just the ones we needed.

And the first screenfull of the normal case obviously stays really fast, 
because both history generation _and_ diff generation is all on-the-fly.

			Linus
