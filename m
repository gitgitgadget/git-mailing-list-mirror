From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 14:48:12 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101431410.3101@woody.linux-foundation.org>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>  <m3abhtp42o.fsf@localhost.localdomain>  <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>  <200806102159.02875.jnareb@gmail.com>  <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
  <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>  <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>  <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org> <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:49:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6BiJ-0003D4-EE
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 23:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbYFJVsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 17:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbYFJVsR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 17:48:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39707 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753362AbYFJVsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 17:48:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5ALmDkO015521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 14:48:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5ALmCNp031144;
	Tue, 10 Jun 2008 14:48:13 -0700
In-Reply-To: <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.382 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84551>



On Tue, 10 Jun 2008, Denis Bueno wrote:
> >
> > then *if* you have the files
> >
> >        .git/objects/32/0bd6e82267b71dd2ca7043ea3f61dbbca16109
> >        .git/objects/4d/0be2816d5eea5ae2b40990235e2225c1715927
> >
> > then those two files are interesting in themselves (most likely they are
> > not there at all, or are zero-sized, but if you have them, please post
> > them).
> 
> They are attached, and they are not zero-sized.

Very interesting.

Both of them look fairly sane as objects (ie random - it's supposed to eb 
zlib-compressed), but both of them have the first 512 bytes *identically* 
corrupted:

	0000000 6564 626e 6575 406e 6f64 6f72 6874 2e79
	          d   e   n   b   u   e   n   @   d   o   r   o   t   h   y   .
	0000020 6f6c 6163 2e6c 3634 0033 0000 0000 0000
	          l   o   c   a   l   .   4   6   3  \0  \0  \0  \0  \0  \0  \0
	0000040 0000 0000 0000 0000 0000 0000 0000 0000
	         \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
	*

ie it's an all-zero block, except for that email-looking thing at the 
head. 

Sadly, I don't think there is any way to find the missing block that got 
overwritten. And quite frankly, there's no way to really know whether the 
rest was really fine either - it just looks more likely, but quite 
frankly, it could have been random old contents on your disk too that just 
happens to look like the expected random pattern (which you'll get with 
any compression format - compression by definition removes patterns).

One thign that strikes me is that you seem to be really prone to this 
problem, since it happened to you a year ago too. I cannot swear to this, 
but I literally suspect your last case (July-2007) was the previous time 
we had a corruption issue. Why does it seem to happen to you, but not 
others?

Do you have some odd filesystem in play? Was the current corruption in a 
similar environment as the old one? IOW, I'm trying to find a pattern 
here, to see if there might be something we can do about it..

But it *sounds* like the objects you lost were literally old ones, no? Ie 
the lost stuff wasn't something you had committed in the last five minutes 
or so? If so, then you really do seem to have a filesystem that corrupts 
*old* files when it crashes. That's fairly scary. What FS is it?

		Linus
