From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Bad merging with stgit or git
Date: Tue, 21 Mar 2006 16:34:13 -0300
Message-ID: <1142969653.4749.109.camel@praia>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Mar 21 20:34:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLmcw-0004Uv-GA
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 20:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWCUTeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 14:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWCUTeU
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 14:34:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53194 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964847AbWCUTeT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 14:34:19 -0500
Received: from [200.181.90.159] (helo=[192.168.255.65])
	by pentafluge.infradead.org with esmtpsa (Exim 4.54 #1 (Red Hat Linux))
	id 1FLmcU-0005Rz-1U; Tue, 21 Mar 2006 19:34:18 +0000
To: Git List <git@vger.kernel.org>
X-Mailer: Evolution 2.4.2.1-3mdk 
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17782>

I have a -git tree that generated a really bad result when committed by
Linus, generating a really bad history log. My tree is located at:
kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git.

I'll try to make a brief from what's happened:

According to him:
"
...
In particular, commit e338b736f1aee59b757130ffdc778538b7db18d6 is crap,
crap, CRAP.
It's "Merging Linus tree", but it's not a merge at all: you have just 
applied the _patch_ to merge the changes in my tree, but you haven't 
actually told git to do so.

I don't know how/why you did that, but it's totally bogus, and I refuse
to 
pull from that tree. That's a 5000+ line diff, affecting about 180
files! 
...
"

After a further analysis, it seemed that a merge conflict were badly
solved. It is showing this message to Linus:

diff-tree e338b736f1aee59b757130ffdc778538b7db18d6 (from
cb31c70cdf1ac7034bed5f83d543f4888c39888a)
        Author:     Mauro Carvalho Chehab <mchehab@infradead.org>
        AuthorDate: Fri Mar 10 01:30:04 2006 -0300
        Commit:     Mauro Carvalho Chehab <mchehab@infradead.org>
        CommitDate: Fri Mar 10 01:30:04 2006 -0300

            Merging Linus tree

        :100644 100644 be5ae600f5337dbb14daa8d4cace110486e14f79
81bc51369f59a413108fd8b150c3090541ba49f8 M
Documentation/feature-removal-schedule.txt
        :100644 100644 75205391b335f85c9b8a599d0d3b4c0dd1a8b41b
fc99075e0af47f0b73a2ae2dfb7d19920c604dea M
Documentation/kernel-parameters.txt
        :100644 100644 9006063e73691da7b68449955a135f7c9317e2cd
da677f829f7689966bf09aeda6d89fc4b6a876d1 M      arch/alpha/kernel/irq.c

For me, those tree last lines, don't appear. Instead, it just shows,
with git-show:

diff-tree e338b736f1aee59b757130ffdc778538b7db18d6 (from
cb31c70cdf1ac7034bed5f83d543f4888c39888a)
Author: Mauro Carvalho Chehab <mchehab@infradead.org>
Date:   Fri Mar 10 01:30:04 2006 -0300

    Merging Linus tree

and a diff file, with:
 179 files changed, 1274 insertions(+), 785 deletions(-)

With git-cat-file, it shows:

$ git-cat-file commit e338b736f1aee59b757130ffdc778538b7db18d6
tree b233a18f740a2883e4863506175f671d821f1e5e
parent cb31c70cdf1ac7034bed5f83d543f4888c39888a
author Mauro Carvalho Chehab <mchehab@infradead.org> 1141965004 -0300
committer Mauro Carvalho Chehab <mchehab@infradead.org> 1141965004 -0300

Merging Linus tree

It shouldn't have any conflicts here for Linus, since those patches came
from his tree.

My current procedure is:

branch origin - Linus tree replica
branch work - my stgit main tree
branch work-fixes - my stgit tree for bug fixes
branch master - patches to current kernel
branch devel - patches to next kernel

All patches are generated against work branch, with stgit.
Branch work-fixes receives patches by using:

        stg pick <sha>@work

Before commiting to kernel.org, I do:
at origin:
        git pull linus_tree

at master:
        git pull . origin
        git pull . work-fixes

at devel:
        git pull . origin
        git pull . work

My environment is:

Stacked GIT 0.8.1
git version 1.2.4.gfd662
Python version 2.4.2 (#2, Jan 30 2006, 18:33:58)
[GCC 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1)]

Any ideas?
