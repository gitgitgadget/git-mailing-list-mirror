From: Petr Baudis <pasky@suse.cz>
Subject: Re: Bottlenecks in git merge
Date: Wed, 1 Feb 2006 00:27:32 +0100
Message-ID: <20060131232731.GA31278@pasky.or.cz>
References: <20060131213314.GA32131@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 01 00:27:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F44uG-0005FD-1f
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 00:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWAaX1Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 18:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWAaX1Z
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 18:27:25 -0500
Received: from w241.dkm.cz ([62.24.88.241]:34246 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932122AbWAaX1Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 18:27:25 -0500
Received: (qmail 14302 invoked by uid 2001); 1 Feb 2006 00:27:32 +0100
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060131213314.GA32131@ebar091.ebar.dtu.dk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15362>

Hello,

Dear diary, on Tue, Jan 31, 2006 at 10:33:14PM CET, I got a letter
where Peter Eriksen <s022018@student.dtu.dk> said that...
> In connection with Ian Molton's question about merge have I played a
> little with 'git merge' on the kernel sources.  What I find is that a
> merge can take quite some time, but I'm not sure where that time exactly
> goes to.  Here are the times I got:
> 
> Recursive (default):  4m22.282s
> Resolve (-s resolve): 3m23.548s
> 
> 
> What is taking so long?

it is difficult to benchmark for me since everything required for the
merge (that is, both all the objects and the whole working tree) just
won't fit into my caches (or Linux at least won't let it stay there for
long enough). I ended up repeatedly calling the subcommands, but that
obviously is not a real world usage pattern. Proportionally, the
significant eaters of time for cg-merge (similar to -s resolve) are:

git-merge-base       --- 1s cached, 10s to 20s uncached
git-read-tree -m     --- 1s cached, 10s or more uncached
git-read-tree -m -u  --- 1m50s w/ heavy disk activity, but big part of it
                         is writing blocks
git-merge-index -a \
	-o /bin/true --- 1s cached
git-merge-index -a \
	-o ~/cogito/cg-Xmergefile
                     --- 1m27s with some disk activity (44s user, 20s sys)
                         cg-Xmergefile is very similar to
			 git-merge-one-file

Note that the time spent by git-read-tree here is just checking out the
new file versions, which is inevitable. ;-)

The real killer here is therefore git-merge-one-file. Most frequent hits
here are probably of the added-in-one case, resulting in two more
fork()s, reloading the index like mad all the time.

Comparing cg-merge to git-merge, one difference is that git-merge tries
to do kind of "trivial" merge first (apparently even if -s was passed to
it), the point of which kind of escapes me if you are using the resolve
strategy, but which causes two git-update-index calls - even one can
take good half a minute or more if your cache is cold.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
