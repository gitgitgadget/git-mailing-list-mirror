From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 14:26:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
 <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz>
 <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 23:33:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgrT0-0000Sn-NH
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 23:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVK1W1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 17:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVK1W1T
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 17:27:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932244AbVK1W1S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 17:27:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jASMQvnO030311
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Nov 2005 14:26:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jASMQtRT024339;
	Mon, 28 Nov 2005 14:26:56 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051128212804.GV22159@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12908>



On Mon, 28 Nov 2005, Petr Baudis wrote:
> 
> >  - should it do 'git-checkout', 'git-reset --hard HEAD', or
> >    'git-pull . branch_to_push_into'?  The former two pretty much
> >    assumes no development happens on the server repository and
> >    git push is used primarily as an installation mechanism.
> 
> Files should be removed properly, which pretty much excludes the former
> two, I think.

There are major locking issues with two people pushing at the same time.

The git logic does the right thing for a non-checked-out branch, but it 
can do the right thing exactly _because_ it's not checked out. It can 
create all the new objects whether the actual push succeeds or not, and it 
can do the final switch-over as a single atomic file operation.

The same is most emphatically _not_ true of "git checkout".

In other words, you need to add your very own locking for the shared 
checked-out tree, and you need to (_within_ that lock) separately remember 
what the _previous_ tree was that was checked out, because you can't just 
rely on the previous head as reported by git, because that will have been 
done ourside your "checked out lock".

And locking really isn't trivial. Especially if you _also_ do this with 
multiple clients touching the same checked-out repo over NFS (which I'd 
seriously suggest you not do).

There's a really good reason why the git core does _not_ do this. It's 
damn complicated.

		Linus
