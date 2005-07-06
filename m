From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: expensive local git clone
Date: Tue, 5 Jul 2005 17:42:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507051721450.3570@g5.osdl.org>
References: <20050704.125744.59481768.davem@davemloft.net>
 <Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 02:43:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpy09-000848-Rb
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 02:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVGFAmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 20:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVGFAml
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 20:42:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262025AbVGFAmP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 20:42:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j660g1jA007798
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 5 Jul 2005 17:42:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j660g0Y6002510;
	Tue, 5 Jul 2005 17:42:00 -0700
To: "David S. Miller" <davem@davemloft.net>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 4 Jul 2005, Linus Torvalds wrote:
> 
> I'm making something based on pack-files.

Ok, as of a few minutes ago there's now a pack-based "git clone" there. Of 
course, it hasn't percolated out to the mirrors yet, so you'll not see it 
for a while unless you have a master.kernel.org account like David, but 
basically you can do

	git clone /some/absolute/path new-dir

and it will clone the old project into new-dir using pack-files. The need 
for an absolute path in the source is just because the "git clone" script 
ends up "cd'ing" to the new directory before the clone, so a relative path 
would need to be relative to the "new-dir" location, which is just 
confusing. Oh, well.

Anyway, as mentioned, you can certainly do a local clone a lot faster with 
"cp -rl" (and yes, I'll apply Junio's patch if he makes it available 
against the new version, and adds a flag to make it conditional), but 
using a pack-file means that the new thing not only will be totally 
independent of the old one (which you may _want_ to do, especially if they 
are on different filesystems), but it also means that the above works over 
ssh too, ie

	git clone master.kernel.org:/pub/scm/git/git.git my-git

should now do the right thing (indeed, I've even tested it - although I've
not tried it with things like multiple branches etc, which _should_ all
work automatically but.. I'm pulling Jeff's tree as I write this, but 
master.kernel.org is slow, so it will be some time..).

Btw, one small note: when doing a "git clone", the newly cloned repo will 
not be checked out, and "master" will be the default HEAD regardless of 
what the other happened to be at (unless the other side was really screwed 
up and we can't match up any "master" at all). So use "git checkout xxx" 
to actually set whatever branch you want to use after a clone.

		Linus
