X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 12:08:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> 
 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org>
 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 20:09:21 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33920>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtUz8-0005b7-Nh for gcvg-git@gmane.org; Sun, 10 Dec
 2006 21:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762442AbWLJUJP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 15:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762457AbWLJUJP
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 15:09:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57382 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762411AbWLJUJO
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 15:09:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBAK94ID018484
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 12:09:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBAK8sLe001833; Sun, 10 Dec
 2006 12:08:59 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 10 Dec 2006, Marco Costalba wrote:
> 
> - memory use: the next natural step with files is, instead of loading
> the file content in memory and *keep it there*, we could load one
> chunk at a time, index the chunk and discard. At the end we keep in
> memory only indexing info to quickly get to the data when needed, but
> the big part of data stay on the file.

Well, that's still just going slower than swapping.

The reason loading things into memory is nice is that:
 - in the common case, you don't need to do anything else.
 - if  the machine is low on memory, it can page things out just about as 
   easily as you could write things to a file anyway.

So don't worry too much about low-memory situations. Yes, there are cases 
where it's better to keep things in files and simply not have a big 
working set AT ALL, but if you keep something in a file and the file data 
is still part of the working set (ie you read it several times, but at the 
beginning and the end), that really isn't any better than having it in 
memory.

So the time to try to optimize memory usage is really only for "streaming 
behaviour" - where you need to touch something only once. Then the best 
option is to actually use a pipe and re-use the memory, but if you have 
file data, you can use things like fadvise(DONTNEED).

> - This is probably my ignorance, but experimenting with popen() I
> found I could not know *when* git-rev-list ends because both feof()
> and ferror() give 0 after a fread() with git-rev-list already defunct.

I suspect you had a bug somewhere. It could be a bug in stdio, but I doubt 
it.

You do realize that the correct way to check "feof()" is only _after_ 
fread() returns 0? 

Stdio ferror/feof is horrible to use corrrectly, and few people get it 
right.  Mostly because it's such a crap interface thanks to being "easy" 
to use and thus hiding all the error handling details on purpose.

