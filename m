From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Tue, 12 Jul 2005 09:48:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507120938240.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
 <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
 <20050712021004.GA27576@buici.com> <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org>
 <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org> <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org>
 <20050712074801.GD6363@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marc Singer <elf@buici.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 18:54:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsO0b-00028E-Ou
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 18:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVGLQxC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 12:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVGLQur
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 12:50:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261649AbVGLQtN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 12:49:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6CGmpjA011027
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 12 Jul 2005 09:48:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6CGmorT020458;
	Tue, 12 Jul 2005 09:48:50 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050712074801.GD6363@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 12 Jul 2005, Petr Baudis wrote:
> 
> Could we please have the branch name written to .git/head-name in case
> we switch the branch?

I wouldn't mind per se, but on the other hand I really _hate_ having 
"parallel" information that can get out of sync. If you have two places 
holding the same information, they had better match. And this is something 
that sounds like it could very easily start to not match, and then we're 
screwed.

So I'd _much_ rather see instead:

 - .git/head-name is a cogito-specific thing that is only active while 
   cogito is _seeking_. So then "cg-unseek" ends up being pretty much 
   equivalent to

	[ -e .git/head-name ] || die "You weren't seeking"
	git checkout $(cat .git/head-name)
	rm .git/head-name

   This way "head-name" is really never even supposed to be "in sync" with 
   .git/HEAD, and there are no synchronization issues. 

 - in order for a "git checkout" to not get confused and possibly throwing 
   a cogito temporary head away (and so that git-fsck-cache is happy 
   during a seek), would it be possible to make "seek" use a real 
   temporary branch instead? Ie, "cg-seek" would be something like

	[ -e .git/head-name ] && die "You are already seeking"
	readlink .git/HEAD > .git/head-name
	echo $seekpoint > .git/refs/heads/cg-seek-point
	git checkout -f cg-seek-point

   or similar?

Then "cg-seek" and "cg-unseek" would continue to work, but the core git 
layer would never be confused because they're really using normal 
branches?

		Linus
