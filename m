From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: add "--dense" flag
Date: Fri, 21 Oct 2005 18:26:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510211814050.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
 <20051022003733.GA8351@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 03:27:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET89l-0003ZH-21
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 03:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbVJVB0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 21:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbVJVB0m
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 21:26:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965199AbVJVB0l (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 21:26:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9M1QSFC026630
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Oct 2005 18:26:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9M1QR8h031057;
	Fri, 21 Oct 2005 18:26:27 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051022003733.GA8351@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10459>



On Sat, 22 Oct 2005, Petr Baudis wrote:
> 
> There is no documentation for the --dense flag and it is even missing
> from the usage string.

I'm not much for docs ;)

The whole path argument also isn't even there (and without paths, --dense 
doesn't matter)

> But my main concern is - will it be possible to do the rename detection
> here as well?

Yes. Note that git-rev-list doesn't actually _do_ the diff, it only checks 
whether the tree is changed. You still just get a list of commits out of 
it, and it is up to you to decide what to do with it.

If you're just going to feed them to diff-tree _anyway_, then you might as 
well not even do the dense thing, because quite frankly, you're just doing 
extra work.

But let's say that you want to follow a certain filename, what you can do 
is basically (fake shell syntax with "goto restart")

	rev=HEAD
   restart:

	git-rev-list $rev --dense --parents -- "$filename" |
		while read commit parent1 restofparents
		do
			if [ "$restofparents" ]; then
				.. it's a merge, do whatever it is you do
				   with merges ..
			else
				shaold=$(git-ls-tree $parent -- "$filename")
				shanew=$(git-ls-tree $commit -- "$filename")

				# Did it disappear?
				# Maybe it got renamed from something
				if [ -z "$shaold" ]; then
					old=$(git-diff-tree -M -r $commit |
						grep " R .* $filename")
					echo "rename? $old"
					filename=figure-it-out-from-$old
					rev=$parent
					goto restart
				fi
				git-diff-tree -p $commit -- "$filename"
			fi
		while

or something similar. 

In other words: you'll basically have to figure out the renames on your 
own, and follow the renaming, but something like the above should do it.

			Linus
