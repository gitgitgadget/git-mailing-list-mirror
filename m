From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-log to go forward instead of reverse?
Date: Mon, 10 Jul 2006 12:20:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607101212410.5623@g5.osdl.org>
References: <86bqrxpai1.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0607101151470.5623@g5.osdl.org>
 <863bd9p9en.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 21:21:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G01JP-0006VL-DY
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 21:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWGJTUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 15:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422790AbWGJTUw
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 15:20:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422778AbWGJTUw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 15:20:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6AJKmnW031080
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Jul 2006 12:20:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6AJKjnX015379;
	Mon, 10 Jul 2006 12:20:47 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <863bd9p9en.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23641>



On Mon, 10 Jul 2006, Randal L. Schwartz wrote:
> 
> Linus> Well, as long as you realize that that automatically means that you
> Linus> have to walk the whole commit list, and you won't be able to get the
> Linus> incremental output that git-log and friends normally are able to give?
> 
> Wow.  Yes, I think I can live with that for the application.

It's a big deal for me, I often end up doing things like

	git log -p some-random-file

to see what has happened, and getting the most recent changes basically 
instantaneously (rather than waiting for the thing to traverse all of the 
history) is a big deal.

If you have a fairly small archive, or you don't use pathname limiting, 
the history generation is so fast that you'll never even notice. But with 
the kernel, doing something like

	git log drivers/serial

takes just over two seconds for me, and if I had to wait for two seconds 
before the first data starts arriving, I'd go nuts.

To see this in cold hard numbers:

	// Full log
	[torvalds@g5 linux]$ time git log drivers/serial > /dev/null 

	real    0m2.267s
	user    0m2.204s
	sys     0m0.020s

	// Simulate "get the first screenful"
	[torvalds@g5 linux]$ time git log drivers/serial | head -25 > /dev/null 

	real    0m0.054s
	user    0m0.048s
	sys     0m0.008s

	// Simulate "get the first screenful of reverse output"
	[torvalds@g5 linux]$ time git log --reverse drivers/serial | head > /dev/null 

	real    0m2.218s
	user    0m2.176s
	sys     0m0.044s

and it's the difference between the second and the third case I wanted to 
point out.

The difference between getting the first screenful in 0.054 seconds versus 
it taking 2.218 seconds is quite noticeable, and one of the things I've 
actually spent a fair amount of time on is to make sure that the 
incremental output case is the _common_ one for all the normal operations 
like "git log -p".

			Linus
