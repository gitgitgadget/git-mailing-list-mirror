From: Petr Baudis <pasky@suse.cz>
Subject: Re: How do I clear the directory cache
Date: Fri, 21 Oct 2005 12:52:35 +0200
Message-ID: <20051021105235.GF30889@pasky.or.cz>
References: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com> <20051020085931.GW30889@pasky.or.cz> <2b05065b0510202023i62ab7c03uea1381d76535dcc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 12:55:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESuWB-0002sa-Vx
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 12:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVJUKwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 06:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVJUKwj
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 06:52:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10723 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964799AbVJUKwj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 06:52:39 -0400
Received: (qmail 17491 invoked by uid 2001); 21 Oct 2005 12:52:35 +0200
To: eschvoca <eschvoca@gmail.com>
Content-Disposition: inline
In-Reply-To: <2b05065b0510202023i62ab7c03uea1381d76535dcc7@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10430>

Dear diary, on Fri, Oct 21, 2005 at 05:23:28AM CEST, I got a letter
where eschvoca <eschvoca@gmail.com> told me that...
> Yes, "cg-reset --adds-removals" is what I want (how do I do this with
> pure git?).

	git-read-tree HEAD
	git-update-cache --refresh

> I would like to clear/reset the index because I've screwed it all up. 
> I don't think I can do as you suggested because of the way I got into
> this mess.
> 
> I'm using git/cogito to version control my hard drive and I've been
> gradually adding more entries into the .gitignore file because some
> files change too frequently or I don't want them backed up.  The OS
> modified a bunch of files, I cg-rm'd 1/4 of them, then I changed my
> mind and added them back, also did some genuine cg-adds, etc. and now
> I'm all confused (it's a whole hard drive).

Well, cg-status should show you what you effectively did, and then you
could just do something like:

	cg-status -w | grep ^D | tr '\n' '\0' | xargs -0 cg-add
	cg-status -w | grep ^A | tr '\n' '\0' | xargs -0 cg-rm

> If other people are interested in doing this I can pass on the lessons
> I learned.
> 
> What I found it git is amazingly fast!  cg-status only takes a few
> seconds.  I think there are some problems if you try to do:
> 
> cd /
> cg-add -r usr
> cg-commit -m "take a long break"
> 
> It seems that cg-add-ing and cg-commit-ing smaller chunks is faster
> than one big chunk.

Interesting. I cannot spot anything which would bog it down in Cogito.
Is both cg-add and cg-commit significantly slower? (That is, if it takes
longer than sum of the smaller chunks.) Perhaps it's a cache issue, not
everything from the chunk fits into your cache during cg-add, so
cg-commit has to reread it from the disk.

> I think commands for the following should be added to cogito:

I'd prefer:

> cg-status -<status_flag>  # list files with given status flag (without
> status flag in column 1)
>   git-ls-files [--others|--deleted|etc] --exclude-per-directory=/.gitignore

All right, this might be useful. Implemented as cg-status -s '?' and such,
thanks for the idea.

> cg-add [-r] -<status_flag> # add files with a given status flag
>   git-ls-files [--others|--deleted|etc]
> --exclude-per-directory=/.gitignore | while read i; do cg-add "$i;
> done
> 
> cg-rm [-r] -<status_flag> # you get the idea.
> 
> cg-addremove  # recursively add new files, remove deleted files

I implemented the cg-reset --adds-removes option, but I don't feel
comfortable with the cg-add change - just -r would be enough to add new
files, and if you are in mess big enough, you can just cg-reset. It
would be useful to make cg-rm symmetric to cg-add, though. Then you
could do just

	cg-add -r . && cg-rm -r .

and it would be equivalent to cg-addremove.

> I use "while read i" so it will work with spaces in filenames.

And break with leading spaces unless you modified $IFS properly. Note
that those people having filenames starting by spaces are either
seriously sick or script kiddies who just rooted you (or warez kiddies
on your FTP server with anonymously-writable incoming).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
