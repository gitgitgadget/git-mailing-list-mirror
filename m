X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 16:51:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101647310.12500@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> 
 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org> 
 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com> 
 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org> 
 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org> 
 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com> 
 <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org> 
 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com> 
 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org>
 <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 00:52:17 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33969>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtZOr-0007ds-DD for gcvg-git@gmane.org; Mon, 11 Dec
 2006 01:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762618AbWLKAwG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 19:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757935AbWLKAwG
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 19:52:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54430 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762618AbWLKAwE
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 19:52:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBB0ptID002863
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 16:51:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBB0pswA008738; Sun, 10 Dec
 2006 16:51:55 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Marco Costalba wrote:

> 
> But it's still slow. Almost one second (985ms) to read the little qgit repo:

Right. Because every time you sleep, you sleep for 100 ms.

That's why I was saying that you need to add polling to the thing. I don't 
know what the QT interfaces to asynchronous polling file descriptors are, 
but as long as you just blindly wait for 100ms whenever you run out of 
data, things will always suck.

Using "fread()" hid this problem, because the thing would block in 
fread(), and thus you'd nor see as many of these events.

> As a compare the temporary file version needs a mere 105ms (1030 revs).

How about you just compare something simpler:

	git-rev-list | cat > /dev/null

vs 

	git-rev-list > tmpfile ; cat tmpfile > /dev/null

and see which one works better.

If the pipe works better, that means that it's your code that is buggy and 
broken.

Which gets us back to the basic issue: you're asking for a bad interface.

This is your problem:

> 		guiUpdateTimer.start(100, true);

rather than just blindly starting a timer, you should ask it to wait until 
more data is available.

