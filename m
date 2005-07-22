From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 16:50:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507221640050.6074@g5.osdl.org>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
 <20050722181800.GU20369@mythryan2.michonline.com> <7vsly6vd2b.fsf@assigned-by-dhcp.cox.net>
 <42E1571B.8070108@gmail.com> <Pine.LNX.4.58.0507221340450.6074@g5.osdl.org>
 <7vhdempmgg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507221447420.6074@g5.osdl.org>
 <20050722233344.GP11916@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:50:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw7Hu-0005WO-Tx
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVGVXua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVGVXua
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:50:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262239AbVGVXu2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 19:50:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6MNoCjA009227
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Jul 2005 16:50:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6MNo9B5024578;
	Fri, 22 Jul 2005 16:50:10 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050722233344.GP11916@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Jul 2005, Petr Baudis wrote:
> 
> Yes, but this stuff is not for personal preferences. It is for
> project-wide preferences and policies, which can be still normally
> overridden or altered locally in each repository.

What you are describing is a nightmare.

Let's assume that a user alters the settings locally.

EVERY SINGLE TIME he does a "cg-commit", those local alterations would get 
committed, since that config file is part of the same project, and cogito 
by default commits all changes.

That's just insane. It means that in practive it's simply not reasonable 
to have your own local copies of that file. So what would you do? You'd 
add more and more hacks to cover this up, and have a "commit-ignore" file 
that ignores the .gitinfo files etc etc. UGLY. All because of a design 
mistake.

In contrast, let's say that the .gitinfo/xyzzy files were in another 
unrelated branch altogether: that means that normally those files wouldn't 
even be seen by git as being under revision control (the "index" file 
doesn't mention them, nor the tree pointed to by HEAD), but you could, if 
you wanted to, do a simple

	#
	# edit the control files  and check the
	# changes  in to the control stream
	#
	git switch control-files
	.. edit .gitinfo/xyzzy
	git commit --all

	#
	# get back to the real project
	#
	git switch master

and it just works. In the above "git switch" would be exactly the same as
a normal "git checkout", except it's told to not update the current
directory contexts on switch and instead just save the index file away and
restore it. (In contrast, using a full "git checkout" would remove the
real project when switching to the control files, and then again remove
the control files when switching back to the main project).

		Linus
