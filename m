From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 10:53:25 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803141041080.3557@woody.linux-foundation.org>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:54:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaE6a-0004uD-J8
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbYCNRx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbYCNRx3
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:53:29 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56281 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754789AbYCNRx2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 13:53:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2EHsMrU002862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Mar 2008 10:54:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2EHrPOs012097;
	Fri, 14 Mar 2008 10:53:25 -0700
In-Reply-To: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.326 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77267>



On Fri, 14 Mar 2008, Geoff Russell wrote:
>
> This should be simple! I have a series of commits:
> 
>            1---2---3---4---5
> 
> I want to go back to 3 but not branch, so I want
> 
>            1---2---3---4---5---3

This is actually an uncommonly easy operation for core git, but it's a 
very unusual thing to want to do in general, so I don't think there is any 
high-level command to do it directly. But it's really easy to do with 
a single so-called "plumbing" command, namely "git read-tree".

So the "core git" way to do it is to literally just do

	git read-tree -u -m 3
	git commit

(or use "--reset" instead of "-m" if you want to do it even in the 
presense unmerged entries).

What the above does is to literally just read the tree state at "3", and 
make it the new index: the "-u" means that we also want to update the 
working tree to that state, and the "-m" means that we will merge in the 
old index stat information.

The commit then will then create the actual new commit: it will have the 
exact same tree as your commit '3', but it will be a new commit (so call 
it 3').

Of course, people have already pointed out that another easy way to do it 
is to just revert 5 and 4. That may be the more high-level way to do it, 
but the git-read-tree approach actually has the advantage that it will 
work even across merges etc, and it will be very unambiguous: we want 
*exactly* the state at commit 3 back, nothing else.

			Linus
