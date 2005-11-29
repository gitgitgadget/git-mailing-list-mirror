From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] SVN import: Use one log call
Date: Tue, 29 Nov 2005 12:22:11 -0800
Message-ID: <7vhd9vdx1o.fsf@assigned-by-dhcp.cox.net>
References: <pan.2005.11.29.07.13.02.145977@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 21:28:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhBzV-0000aG-9v
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 21:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVK2UWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVK2UWN
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 15:22:13 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:235 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932376AbVK2UWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 15:22:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129202103.MLWR17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 15:21:03 -0500
To: Matthias Urlichs <smurf@smurf.noris.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12953>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> One "svn log" (or its equivalent) per revision adds delay and server load.
> Instead, open two SVN connections -- one for the log, and one for the files.

Thanks, applied and pushed out.

BTW, I've never successfully managed to run svnimport from my
private svn repository.  Admittedly the repository does not
follow the recommended layout and that probably is the major
cause (it started its life when svn documentation recommended
{trunk,branches,tags}/{projectA,projectB,projectC} layout.
{projectA,projectB,projectC}/{trunk,branches,tags} is the layout
they recommend these days, I think [*1*]).

It does not use any branches (it is primarily a random
collection of small throwaway scripts).  The repository hosts
many unrelated pieces ("http://127.0.0.1/svn/private/" is the
root level of the repository), organized like this:

    $ svn ls http://127.0.0.1/svn/private/
    attic/
    main/
    tags/

   main/ is the active one (trunk), and it has bunch of
   unrelated subdirectories.

   attic/ is where I prepared to "svn mv" things from main/ that
   are no longer needed, but is empty.

   tags/ have one tree that is a copy of one of the subtrees
   under main/ from distant past.

I wanted to convert one of the subsubdirectory of main to git.

    $ svn ls http://127.0.0.1/svn/private/main/sources/photocat
    Makefile
    Notes
    cmdmason.pm
    ...

What is the svnimport command line I should give?  Luckily, I do
not have "tags" or "branches" under private/main/sources/, so I
tried to cheat like this, hoping it would mistake "photocat" is the trunk of 
"main/sources" project in the repository.  No such luck.

$ cd /var/tmp && rm -fr try0 && mkdir try0 && cd try0
$ git svnimport -v -i -t photocat http://127.0.0.1/svn/private main/sources
1: Unrecognized path: /main/sources
1: Unrecognized path: /main/in-place
1: Unrecognized path: /main
...
1500: Unrecognized path: /main/sources/photocat/db/catalog.sql
1501: Unrecognized path: /main/sources/photocat/data/035-maribon-making.yaml
DONE; creating master branch
cp: cannot stat `/var/tmp/try0/.git/refs/heads/origin': No such file or directory
fatal: master: not a valid SHA1
$ 

If your answer is "your repository layout is too weird and
nonstandard, you are screwed", that is perfectly fine.  I do not
want you to bend over backwards to butcher the import script to
support it, if it is too nonstandard.  I already converted what
I wanted to convert manually already; history being linear
without branches, that was easy enough.

But I thought it would never hurt to ask ;-).

[Footnote]

*1*

http://svnbook.red-bean.com/en/1.1/svn-book.html#svn-ch-5-sect-6.1
shows two layouts, one with {trunk,tags,branches} at the top
level of each project, another with nested projects (if you look
at "utils" in the picture as a project with two subcomponents
"calc" and "calendar"), with {trunk,tags,branches} under each
subproject.  I think the current code should import from
"calendar" or "calc" level just fine, but I wonder if we want to
support importing from "utils" level.
