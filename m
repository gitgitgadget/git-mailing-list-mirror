From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 14:08:35 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <alpine.LSU.1.00.0801112127040.31053@racer.site> <34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDS3r-00055w-Sw
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 23:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760586AbYAKWIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 17:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760383AbYAKWIo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 17:08:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57858 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753467AbYAKWIn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 17:08:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BM8ZK1024291
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jan 2008 14:08:36 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BM8ZkM000447;
	Fri, 11 Jan 2008 14:08:35 -0800
In-Reply-To: <34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70213>



On Fri, 11 Jan 2008, Kevin Ballard wrote:
> 
> Oh, I'm not surprised git doesn't handle this case, nor do I think git's
> required to. I merely think that, given the increasing relevance of OS X and
> the fact that it uses a case-insensitive system by default, this sort of
> problem is going to occur more and more frequently and it's quite a learning
> experience trying to fix it by hand. It would be very helpful if git could
> detect these problems itself.

I do agree that we could/should do something to help with case-insensitive 
filesystems.

I absolutely *detest* those things, and I think that people who design 
them are total morons - with MS-DOS, you could understand it (people 
didn't know better), but with OS X?

But considering that they exist, we should probably offer at least *some* 
help for people who didn't realize that you could make OS X behave better.

However, it's not like there is even a simple solution. The right place to 
do that check would probably be in "add_index_entry()", but doing a check 
whether the same file already exists (in a different case) is simply 
*extremely* expensive for a very critical piece of code, unless we were to 
change that index data structure a lot (ie add a separate hash for the 
filenames).

Inside the Linux kernel, we have support for insane case-insensitive 
filesystems, and it really does need a lot of effort to do an even 
half-way decent thing while not penalizing the sane case. So it's hard.

(And that's totally ignoring the fact that case-insensitivity then also 
has tons of i18n issues and can get *really* messy - in the above I'm 
talking purely about the issues that would hit us even with 7-bit straight 
ASCII).

So handling case-sensitivity (even when you restrict it to ASCII-only) is 
actually rather messy. The obvious thing to do is to sort everything using 
a case-insensitive sort, but that in turn would break all the rules git 
has for the sorting of trees.

So you can't just change the sort order: you'd literally have to have two 
*different* lookup keys for the index (the "strict sort" and the "case- 
insensitive sort"), and keep them both around.

Almost all of the code that actually touches the index is in read-cache.c, 
and it's not like that is a very complex data structure (or a very big 
file), so adding another key to the sorting probably wouldn't be too 
horrid. But it's definitely a lot more than just a few lines of code!

		Linus
