From: Petr Baudis <pasky@suse.cz>
Subject: Re: Bottlenecks in git merge
Date: Wed, 1 Feb 2006 00:35:04 +0100
Message-ID: <20060131233504.GB31278@pasky.or.cz>
References: <20060131213314.GA32131@ebar091.ebar.dtu.dk> <7vk6cgq9ny.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Eriksen <s022018@student.dtu.dk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 00:34:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F451O-0006vZ-5P
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 00:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWAaXer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 18:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWAaXer
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 18:34:47 -0500
Received: from w241.dkm.cz ([62.24.88.241]:7064 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932129AbWAaXer (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 18:34:47 -0500
Received: (qmail 15492 invoked by uid 2001); 1 Feb 2006 00:35:04 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6cgq9ny.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15363>

Dear diary, on Wed, Feb 01, 2006 at 12:06:57AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> "Peter Eriksen" <s022018@student.dtu.dk> writes:
> 
> > Recursive (default):  4m22.282s
> > Resolve (-s resolve): 3m23.548s
> >
> > What is taking so long?
> 
> I am actually surprised that recursive is not much slower than
> resolve.  I expected to see bigger difference for a merge like
> this.
> 
> > git checkout -b test v2.6.12
> > change_readme
> > git commit -a -m "Work, work, work"
> > time git merge $STRATEGY "Merging happily." HEAD v2.6.15
> 
> You are merging a variant of v2.6.12 and v2.6.15.  Each of these
> two official revisions has roughly 18,000 files, and they differ
> at 10,723 files among them.
> 
> With an up-to-date index that has small changes from v2.6.12,
> merging these two revisions using read-tree -m to do the trivial
> merge (the part that comes before recursive/resolve) leaves
> about 850 files to be resolved in the working tree.  For these
> files, you need to do an equivalent of merge-one-file to merge
> the differences (in this particular case, most of them are
> "removed in one but unchanged in the other" kind).  In addition,
> you have to checkout the result of the merge, which means you
> need to update at least 10,723 files.
> 
> I suspect that it might make things quite faster if we resolved
> case 8 and 10 (see either Documentation/technical/trivial-merge
> or t/t1000) in index for this particular case, but it has
> correctness issues.  A merge strategy may want to say "This file
> was removed by the other branch while it stayed on our branch;
> but this is not a remove but actually a rename", and do
> something different from what merge-one-file does, and resolving
> these cases in index closes the door for that possibility.

What about letting the file-handler actually tell merge-index what to
do? merge-index could make a fifo at fd 3 for it (we might fork a
special buffering process for it to avoid PIPE_BUF issues) and let it
write there a sequence of lines like:

	path\0{add|remove|update} {workingcopy|<sha1> <mode>}

That would avoid many in-file-handler forks and especially perpetual
reloading and rewriting of the index file, which _seems_ to be the main
time waster according to my somewhat fuzzy benchmarks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
