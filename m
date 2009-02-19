From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Really slow 'git gc'
Date: Thu, 19 Feb 2009 12:24:43 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902191200010.21686@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 21:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFTk-00027F-F5
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbZBSUZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZBSUZL
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:25:11 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47308 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753280AbZBSUZK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 15:25:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1JKOitv012100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Feb 2009 12:24:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1JKOhEV020680;
	Thu, 19 Feb 2009 12:24:43 -0800
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.457 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110743>


Ok, so I was wondering why doing a 'git gc' on my kernel backup on one of 
the linux-foundation machines was taking so long, and I think I've found a 
performance problem.

The way I do kernel back-ups is that I just push to two different sites 
every once in a while (read: multiple times a day when I do lots of 
merging), and one of them is master.kernel.org that then gets published to 
others.

The other one is a linux-foundation machine that I have a login on, and 
that's my "secondary" back-up, in case both kernel.org and my own home 
machines were to be corrupted somehow. And because it's my secondary, I 
seldom then log in an gc anything, so it's a mess.

But it was _really_ slow when I finally did so today. The whole "Counting 
objects" phase was counting by hundreds, which it really shouldn't do on a 
fast machine.

The reason? Tons and tons of pack-files. But just the existence of the 
pack-files is not what killed it: things were _much_ faster if I just did 
a "git pack-objects" by hand. 

The real reason _seems_ to be the "--unpacked=pack-....pack" arguments. I 
literally had 232 pack-files, and it looks like a lot of the time was 
spent in that silly loop oer 'ignore_packed' in find_pack_entry(), when 
revision.c does that "has_sha1_pack()" thing. You get a O(n**2) effect in 
number of pack-files: for each commit we look over every pack-file, and 
for every pack-file we look at, we look over each ignore_pack entry.

I didn't really analyze this a lot, and now the thing is packed and much 
faster, but I thought I'd throw this out there..

		Linus
