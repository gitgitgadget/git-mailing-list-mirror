From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: pcre performance, was Re: git log filtering
Date: Wed, 7 Mar 2007 18:37:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703071807250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
 <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org>
 <20070208061654.GA8813@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP066-0000lS-BH
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 18:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbXCGRiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 12:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422948AbXCGRhc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 12:37:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:58706 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422867AbXCGRh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 12:37:28 -0500
Received: (qmail invoked by alias); 07 Mar 2007 17:37:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 07 Mar 2007 18:37:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WvepureRW2U1HKiwzP6oGRTcH0EXQ9d30gw68LE
	p3fU7zXHL7gXeW
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070208061654.GA8813@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41682>

Hi,

On Thu, 8 Feb 2007, Jeff King wrote:

> In every case there, pcre has either comparable performance, or simply 
> blows away glibc.

So I tested this against external grep. For completeness' sake, I tested 
these against each other: GNU regex-0.12, Git _without_ external grep 
(relies on glibc's regex), Git _with_ external grep ("original"), pcre, 
and for good measure, pcre with NO_MMAP=1 (to test if disk access is the 
problem).

Here are the numbers:

grep-gnu-regex:

21.41user 1.08system 0:22.52elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7210minor)pagefaults 0swaps
21.40user 1.06system 0:22.47elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7209minor)pagefaults 0swaps
21.61user 1.06system 0:22.68elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7209minor)pagefaults 0swaps
21.30user 1.10system 0:22.48elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7210minor)pagefaults 0swaps
21.30user 1.08system 0:22.43elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7209minor)pagefaults 0swaps

grep-no-external-grep:

6.98user 1.17system 0:08.16elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7120minor)pagefaults 0swaps
7.07user 1.16system 0:08.27elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7121minor)pagefaults 0swaps
6.98user 1.12system 0:08.11elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7121minor)pagefaults 0swaps
7.00user 1.18system 0:08.20elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7121minor)pagefaults 0swaps

grep-original:

0.82user 1.15system 0:01.97elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7090minor)pagefaults 0swaps
0.94user 1.03system 0:01.97elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7099minor)pagefaults 0swaps
0.89user 1.07system 0:01.96elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7092minor)pagefaults 0swaps
0.81user 1.15system 0:01.97elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7092minor)pagefaults 0swaps

grep-pcre:

4.04user 1.18system 0:05.24elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7205minor)pagefaults 0swaps
4.16user 1.08system 0:05.25elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7206minor)pagefaults 0swaps
4.24user 0.98system 0:05.23elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7206minor)pagefaults 0swaps
4.08user 1.14system 0:05.23elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7206minor)pagefaults 0swaps

grep-pcre-no-mmap:

4.15user 1.07system 0:05.22elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7210minor)pagefaults 0swaps
4.01user 1.14system 0:05.17elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7209minor)pagefaults 0swaps
3.94user 1.18system 0:05.14elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7210minor)pagefaults 0swaps
4.11user 1.06system 0:05.18elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7210minor)pagefaults 0swaps

BTW this was "git grep Lin.*valds" on linux-2.6, just updated.

The first test was run 5 times instead of 4 to make sure it is hot cache. 
This is on a dual 1.2GHz 2GB machine.

I cannot really say anything about the pagefaults, so I'll leave that to 
the wizards.

Result: external grep wins hands-down. GNU regex loses hands-down. pcre 
seems to be better than glibc's regex engine, and gains ever so slightly 
when using NO_MMAP.

I ran the same test on a 1GHz 256MB machine which is overloaded, and in 
that case, GNU regex is still worst (~55 sec), while glibc and pcre are 
equal (glibc slightly slower with ~35 sec, pcre ~34 sec), and external 
grep wins (~29 sec). Of course, this is io-bound, but it shows that pcre 
uses more memory than glibc.

Ciao,
Dscho
