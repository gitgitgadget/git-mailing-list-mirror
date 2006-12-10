X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 14:16:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> 
 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org> 
 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com> 
 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org> 
 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org>
 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 22:16:56 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33941>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWyR-0000bh-2Y for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758797AbWLJWQk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759006AbWLJWQk
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:16:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41036 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1758797AbWLJWQj
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 17:16:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBAMGVID025564
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 14:16:32 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBAMGUUQ004863; Sun, 10 Dec
 2006 14:16:31 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 10 Dec 2006, Marco Costalba wrote:
> 
> Ok. Perhaps I'm doing something wrong but the following code it's
> always 10% slower then the temporary file one (4.7s against 4.3s for
> linux tree)

Why do you seem to be doing a "new" on every iteration inside the loop?

Also, why do you have that strange FILE_BLOCK_SIZE thing, and in 
particular the "if (len < FILE_BLOCK_SIZE)" check? One thing that pipes vs 
files do is the blocking factor.

Especially with older kernels, I _guarantee_ you that you'll only ever get 
4kB at a time, so because of that "if (len < 64kB) break" thing, the only 
thing you're doing is to make sure things suck performance-wise, and you 
won't be reading the rest of the data until 100ms later.

IOW, your code is written for a file, and makes no sense there either 
(checking "feof(file)" is wrong, since you may well have hit the EOF 
*at*that*time*, but the file may GROW since you are doing it all in the 
background, so you can't rely on feof() anyway).

For a pipe, what you should do is to make sure it's in nonblocking mode, 
and just continue reading until it gets no more. And instead of using a 
timeout, you should use poll() or something to get notified when there is 
more data.

IOW, the reason it's slow is because you're doing the wrong thing.

