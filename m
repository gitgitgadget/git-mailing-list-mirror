X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 14:53:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> 
 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org> 
 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com> 
 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org> 
 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org> 
 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com> 
 <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org>
 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 22:54:00 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33950>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXYS-0004a5-QS for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760593AbWLJWxy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761625AbWLJWxy
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:53:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44284 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760593AbWLJWxx
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 17:53:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBAMriID028182
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 14:53:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBAMrhWC005848; Sun, 10 Dec
 2006 14:53:43 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 10 Dec 2006, Marco Costalba wrote:
> 
> I consistently have len == 65536 bytes until the last fread() where
> it's less.

That's because fread() will block until it gets all data. Did you actually 
ever try this with a uncached tree and did you compare what you got with a 
plain "read()". 

On older kernels, I guarantee that you get 4kB at a time for reads, even 
for a blocking pipe. Because we have bigger pipe buffers these days, it 
_may_ return 64kB at a time every time, but only if the writer is much 
faster than the reader.

Based on the fact that you say that "read()" was ten times slower than 
fread(), I very much suspect you got 4kB at a time, and then slept 100ms 
each time or something.

Anyway, you should seriously also check the case when "git rev-list" is 
slow because you have cold caches and unpacked objects. You can't wait for 
it to synchronously write a thousand lines or so - that could take 
seconds.

> How can open in nonblocking mode with popen() ?
> 
> FILE *popen(const char *command, const char *type);

something like

	fcntl(fileno(file), F_SETFL, O_NONBLOCK);

will do it, and then your loop should look something like

	for (;;) {
		int count = read(fileno(file), buf, BUFSIZE);
		if (!count) {
			/* All done, no more to read */
			return 0;
		}
		if (count < 0) {
			if (errno == EAGAIN)
				break;
			if (errno == EINTR)
				continue;
			/* Anything else is fatal - report error */
			return -1;
		}
		... handle 'count' new bytes here ...
	}
	.. this is the EAGAIN case ..
	either set polling on the file descriptor, or use a
	timer here yo get back to this loop eventually.

looks about right.

