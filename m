From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: add "--dense" flag
Date: Fri, 21 Oct 2005 20:30:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510212025260.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
 <20051022003733.GA8351@pasky.or.cz> <Pine.LNX.4.64.0510211814050.10477@g5.osdl.org>
 <20051022025638.GQ30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 05:31:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETA5w-00051a-63
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 05:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVJVDaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 23:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVJVDaq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 23:30:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932578AbVJVDap (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 23:30:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9M3UdFC030102
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Oct 2005 20:30:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9M3UcFc001548;
	Fri, 21 Oct 2005 20:30:38 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051022025638.GQ30889@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10466>



On Sat, 22 Oct 2005, Petr Baudis wrote:
> 
> > If you're just going to feed them to diff-tree _anyway_, then you might as 
> > well not even do the dense thing, because quite frankly, you're just doing 
> > extra work.
> 
> fork() is awfully expensive for me. fork()ing something (supposedly)
> trivial (it was stat) slowed my (non-trivial) loop about 4 times.

Not fork. More like

	git-rev-list .. | git-diff-tree --stdin

If you do it that way (which is quite common - git-whatchanged, git-log 
etc), there's no reason to ask for a dense output, because git-diff-tree 
can handle the non-dense one as fast as git-rev-list can.

But the --dense option is wonderful for "gitk", and for "slow stuff". 
Where "slow" can indeed be a fork, or just an interpreter loop like a 
shell/perl script, which would fork/exec git-diff-tree for each commit.

>From a commit-list standpoint

	git-rev-list --dense ... -- paths

is the same as

	git-rev-list -- paths | git-diff-tree -s -r --stdin -- paths

but it's somewhat more efficient, and more importantly, it rewrites the 
parents. So quite often, you'd want to use "--dense" together with 
"--parent" so that you get the "rewritten" history. That's how come gitk 
didn't need any changes, and it "just worked". It's also how my example 
script did the rename detection without having to traverse unnecessary 
commits.

		Linus
