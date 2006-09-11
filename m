From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Mon, 11 Sep 2006 09:31:30 -0700
Message-ID: <7v7j0ajrfh.fsf@assigned-by-dhcp.cox.net>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net>
	<ee3hac$n57$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 18:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMogN-0003Ya-08
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 18:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWIKQan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 12:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWIKQan
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 12:30:43 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49792 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965029AbWIKQam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 12:30:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911163040.XJGT18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Sep 2006 12:30:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id M4WW1V00K1kojtg0000000
	Mon, 11 Sep 2006 12:30:30 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ee3hac$n57$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	11 Sep 2006 13:29:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26853>

Jakub Narebski <jnareb@gmail.com> writes:

> Perhaps those two options, --stdin to feed arguments from standard input,
> and -revs to run rev-list logic internally should be used whenever possible
> in all the git commands? This would allow to avoid forks and/or command
> line length limit.

Some make more sense than others, from usability point of view.
It all depends on how much sense it makes to be able to run them
on sequence of commits.

>  * git-rev-list: --stdin to feed list of <commits>; it is not clear from 
>    the manpage if one can use ^<commit>, and commit related options
>    and shortcuts like --not, <commit>..<commit>, <commit>...<commit>
>  * git-pack-objects: --revs to provide arguments to rev-list from stdin,
>    instead of list of objects. UNDOCUMENTED.

Time spent whining about it is better spent finding it out
yourself (UTSL) and writing it I suspect.  You'll learn how
things actually work while doing so ;-).

> It would be nice if the following commands had --stdin or had it's --stdin
> usage extended:
>  * git-diff-tree: --stdin to allow to provide path limits, separated 
>    by ' -- ' from <tree-ish> or pair of <tree-ish>

Something like this could be used to follow renames and do more
interesting stuff.  The caller would create a pair of pipes,
throw first tree-pair at it, receive and examine the output, and
decide what pathspec to use for the next one and continue.  If
you do not limit yourself to pathspec but e.g. allow -S to be
also specified per invocation, then you can make it to follow
line movements, not just renames.  So in the bigger picture, I
like what something like this can offer to the Porcelain writers.

It is a separate story if it is worth building that _into_
diff-tree itself.  A sane way to see if it is is to start by
writing a rough equivalent that is:

	#!/bin/sh
	while read stuff;
        do
		# Note: this really needs to do shell quote
        	git-diff-tree $stuff
		echo I am done with one record.
        done

Then, write such a driver program to drive it and see if
per-line invocation of diff-tree is really the bottleneck.  For
any useful and interesting application of this pattern, I
suspect the process that drives this diff-tree loop will have
enough computation in it, and the only thing you are saving is
the start-up cost of diff-tree (i.e. fork+exec).  I am not sure
how much of the bottleneck it would be in the while thing.

>  * git-ls-tree: --stdin to loop over <tree-ish>, one tree per line.

Likewise.  Also you would need to decide the record delimiter.

>  * git-cat-object: --stdin to loop over objects, plus -z to change separator
>    between records to NULL (or have it turned on by default).

I would suggest TYPE SP BYTE-COUNT LF followed by payload
instead.  You cannot otherwise handle binary files with NUL
(lesson of the day: NULL is a pointer, the character's name is
NUL) in it.  If you do not mind redundancy to help the consumer
of this output, TYPE SP SHA-1 SP BYTE-COUNT LF followed by
payload might even be a better choice.

> For all "loop" --stdin, the output should begin with the line which was
> arguments, like git-diff-tree outputs first <tree-ish> used for diff.

That's something you cannot decide on a whim without knowing how
they are used and what convention is the most useful.  I suspect
that single record delimiter without frill might turn out to be
more useful.  Parrotting the arguments means you would need to
make sure the output format can easily parsable -- the issues
include that you need deal with embedded newlines in them.  To
quote them in the output routine is easy but the consumer now
needs to know they need to be dequoted.

> I think it is quite often to use git-rev-list ...| git-diff-tree ...
> pipeline, so it might be worth to add --revs option to git-diff-tree.

Are you talking about "git rev-list | git diff-tree --stdin"???

> P.S. does git-merge take -F <file> option?

No; it is not a Porcelain so ease of typing is not its goal.
You can say longhand: git-merge "`cat $file`" ...
Merge messages are supposed to be mostly automated and short,
so command line length limit is not much of an issue here.
