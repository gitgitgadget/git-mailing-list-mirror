From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Removal of "--merge-order"?
Date: Fri, 24 Feb 2006 10:07:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602240957430.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org>
 <Pine.LNX.4.58.0602240840520.7894@shark.he.net> <Pine.LNX.4.64.0602240918030.3771@g5.osdl.org>
 <Pine.LNX.4.58.0602240942520.7894@shark.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 19:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FChLh-00045n-Jp
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 19:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWBXSHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 13:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWBXSHW
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 13:07:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15265 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932378AbWBXSHW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 13:07:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1OI7IDZ005886
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Feb 2006 10:07:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1OI7DhA000502;
	Fri, 24 Feb 2006 10:07:15 -0800
To: "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0602240942520.7894@shark.he.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16722>



On Fri, 24 Feb 2006, Randy.Dunlap wrote:
>
> Other than Ryan's reply, I found 2 users in a quick search,
> but they have already stated that they are willing to change, so I
> don't see objections unless someone else comes forward.

One thing we could do - and might be simpler - is to make the merge-order 
thing be a post-processing phase of git-rev-list.

IOW, instead of

	git-rev-list --merge-order

we could perhaps do

	git-rev-list --parents [--topo-order?] | git-merge-order

so that the merge-order code wouldn't impact git-rev-list itself.

As it is, the merge-order code ends up hooking into the "process_commit" 
thing (and thus to "filter_commit" which does the parent rewriting, and 
then show_commit), which makes it harder to work with.

Now, rev-list.c is not the biggest file (apply.c is about twice the size), 
but in many ways it's the most complex one by far. It's also the most 
performance-critical one, and the one that it would be really nice if we 
were to be able to libify it.

For example, instead of the horrid scriping language, I _think_ I could 
almost libify it by just hooking into "show_commit", and using a callback 
function for that (and then the stand-alone program would just make the 
callback function be one that prints out the commit). 

With some care, we might be able to make things like "git diff" be small C 
programs (or, more likely, to save space and not replicate the binaries 
many times - make the "git" binary able to do all the simple things on its 
own: "git-diff" would be just a link to "git").

That would possibly be a simpler way to get away from using nonportable 
scripts. Plain C really does remain one of the most portable things out 
there.

			Linus
