From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Mon, 25 Apr 2005 20:04:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251938210.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <426DA7B5.2080204@timesys.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 04:59:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQGHS-0002mn-Sr
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 04:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVDZDDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 23:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVDZDDh
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 23:03:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:50606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261291AbVDZDDa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 23:03:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q32us4029675
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 20:02:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3Q32sHN022501;
	Mon, 25 Apr 2005 20:02:55 -0700
To: Mike Taht <mike.taht@timesys.com>
In-Reply-To: <426DA7B5.2080204@timesys.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Mike Taht wrote:
> 
> One difference is probably - mercurial appears to be using zlib's 
> *default* compression of 6....
> 
> using zlib compression of 9 really impacts git...

I agree that it will hurt for big changes, but since I really do believe 
that most changes are just a couple of files, I don't believe it matters 
for those. 

I forget what the exact numbers were, but I did some timings on plain
"gzip", and it basically said that doing gzip on a medium-sized file was
not that different for -6 and -9. Why? Because most of the overhead was
elsewhere ;)

Oh, well, I just re-created some numbers. This wasn't exactly what I did 
last time I tested it, but it's conceptually the same thing:

	torvalds@ppc970:~> time gzip -9 < v2.6/linux/kernel/sched.c > /dev/null 
	real    0m0.018s
	user    0m0.018s
	sys     0m0.000s

	torvalds@ppc970:~> time gzip -6 < v2.6/linux/kernel/sched.c > /dev/null 
	real    0m0.015s
	user    0m0.013s
	sys     0m0.001s

ie there's a 0.003 second difference, which is certainly noticeable, and
would be hugely noticeable if you did a lot of these. But in my world-view
(which is what git is optimized for), the common case is that you usually
end up compressing maybe five-ten files, so the _compression_ overhead is
not that huge compared to all the other stuff.

But yes, testing git on big changes will test exactly the things that git
isn't optimized for. I think git will normally hold up pretty well (ie it
will still beat anything that isn't designed for speed, and will be
comparable to things that _are_), but it's not what I'm interested in
optimizing for.

That said - these days we can trivially change over to a "zlib -6" 
compression, and nothing should ever notice. So if somebody wants to 
test it, it should be fairly easy to just compare side-by-side: the 
results should be identical.

The easiest test-case is Andrew's 198-patch patch-bomb on linux-kernel a 
few weeks ago: they all apply cleanly to 2.6.12-rc2 (in order), and you 
can use my "dotest" script to automate the test..

			Linus
