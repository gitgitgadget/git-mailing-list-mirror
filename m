X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 09 Dec 2006 07:42:25 -0500
Message-ID: <457AAF31.2050002@garzik.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org> <46a038f90612081756w1ab4609epcb4a2cbd9f4d8205@mail.gmail.com> <200612091251.16460.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 12:43:18 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <200612091251.16460.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33812>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt1Xl-0004E8-6R for gcvg-git@gmane.org; Sat, 09 Dec
 2006 13:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030645AbWLIMma (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 07:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030722AbWLIMma
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 07:42:30 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:60192 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1030645AbWLIMm3
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 07:42:29 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1Gt1X8-0005iQ-Jz; Sat, 09 Dec 2006 12:42:27 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> First, it would (and could) work only for serving gitweb over mod_perl.
> I'm not sure if overhead with IPC and complications implementing are
> worth it: this perhaps be better solved by caching engine.

It is.  At least for kernel.org, the issue isn't that CGI is expensive, 
its that I/O is expensive.


> In addition to setting either Expires: header or Cache-Control: max-age
> gitweb should also set Last-Modified: and ETag headers, and also 
> probably respond to If-Modified-Since: and If-None-Match: requests.
> 
> Would be worth implementing this?

IMO yes, since most major browsers, caches, and spiders support these 
headers.


> For some pages ETag is natural; for other Last-Modified: would be more
> natural.

Yes, a good point to note.


> Usualy you can compare ETags base on URL alone.

Mostly true:  you must also consider HTTP_ACCEPT


> Wouldn't it be simplier to just set Last-Modified: header (and check
> it?)

That would be a good start, and suffice for many cases.  If the CGI can 
simply stat(2) files rather than executing git-* programs, that would 
increase efficiency quite a bit.

A core problem with cache hints via HTTP headers (last-modified, etc.) 
is that you don't achieve caching across multiple clients, just across 
repeated queries from the same client (or caching proxy).

At least for the RSS/Atom feeds and the git main page, it makes no sense 
to regenerate that data repeatedly.

Internally, gitweb would need to do a stat() on key files, and return 
pre-generated XML for the feeds if the stat() reveals no changes.  Ditto 
for the front page.


> P.S. Can anyone post some benchmark comparing gitweb deployed under 
> mod_perl as compared to deployed as CGI script? Does kernel.org use 
> mod_perl, or CGI version of gitweb?

CGI version of gitweb.

But again, mod_perl vs. CGI isn't the issue.

	Jeff

