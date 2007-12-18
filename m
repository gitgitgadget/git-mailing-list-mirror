From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 23:20:32 +0100
Message-ID: <20071218222032.GH2875@steel.home>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home> <200712182224.28152.jnareb@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dana How <danahow@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4koL-0002My-V8
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbXLRWUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbXLRWUg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:20:36 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:42119 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbXLRWUf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:20:35 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a72E=
Received: from tigra.home (Fc89a.f.strato-dslnet.de [195.4.200.154])
	by post.webmailer.de (klopstock mo39) (RZmta 14.6)
	with ESMTP id q03c6bjBIGiqXy ; Tue, 18 Dec 2007 23:20:33 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D8CCC277AE;
	Tue, 18 Dec 2007 23:20:32 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B034256D22; Tue, 18 Dec 2007 23:20:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200712182224.28152.jnareb@gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68832>

Jakub Narebski, Tue, Dec 18, 2007 22:24:26 +0100:
> On Tue, 18 Dec 2007, Alex Riesen wrote:
> > I think that we have parsing of the blob locators at the wrong level:
> > so that git-show, git-log and git-diff can handle its pathnames as
> > they handle path filters (relative to cwd),
> 
> What cwd? <path> in <tree-ish>:<path> syntax is "relative" to <tree-ish>.

But the act of running "git-show <tree-ish>:<path>" does have a
working directory relative to the project root. And usually the
relative directory makes a lot of sense in git-show commands.

> What should git do in your proposal when we are on master branch in
> Documentation subdirectory, and want to check TODO file in todo branch?
> "git show todo:TODO" is most natural IMHO.

Yes, and that's why I NAKed the patches in the mail to Dana. I just
hope the problem gets some attention. Maybe I even get something out
of it, maybe not. It is not that hard to keep the patches in my tree.

> Note that for true <tree> as <tree-ish> you just don't know where
> in the working area directory hierarchy <tree> can be. This means you
> do't know relation of <tree> and <path> in <tree>:<path> to cwd.

I understand. But... How often do you think people use git show with a
tree which was not pointed by a commit?

> > and git-cat-file, 
> > git-diff-tree, git-rev-list, etc can handle theirs always relative to
> > the project root.
> 
> Not "relative to project root". Relative to tree-ish used on right hand
> side in <tree-ish>:<path> extended SHA-1 syntax. It is usually project
> root, because when you specify <commit> or <tag> as <tree-ish> it refers
> to top/root directory of a project.

I know. My problem: it is also awkward. git-show :test-l<Tab>ib.sh just
does not do what I expect. Nor does git cat-file HEAD:test-l<Tab>ib.sh.
And git cat-file HEAD:t/test-l<Tab> does not work at all. And this is
very simple example. Normally the pathnames are about 100 characters
long.

You know, it maybe as much correct as you wish, but is not very
usable (and no, I can't use the contributed completion. For lots of
reasons).

> > I actually do not see any problem for git-show (being porcelain-level
> > program) to treat *each and every* path anywhere relatively to the
> > current directory. It is just more comfortable.
> 
> This breaks backward compatibility, hard. And IMHO breaks layers.

Maybe they should be broken in porcelain...

> But if (big if) it was to be implemented, default behavior should be
> unchanged, and relative to the cwd (layers!) should use new syntax,
> for example
> 
>      $ cd $GIT/t
>      $ git show 570f32266:t/test-lib.sh    # works
>      $ git show 570f32266:test-lib.sh      # should not work

Well... Frankly, I suggest changing this for porcelain-level
commands (show and diff) and leave it as it is for plumbing.

>      $ git show 570f32266:./test-lib.sh    # should work

Definitely. I even implemented a patch to allow just this, but scraped
it: it looked a bit small and the syntax is not obvious to the user.
Maybe that is what I end up with, though.

>      $ git show 570f32266:/t/test-lib.sh   # should perhaps work
> Currently ":/<text>" (but not "<ref>:/<text>") is taken; see

Yes, and it becomes more and more an obstacle. With just one user
standing, AFAICS (/me considers Dscho's assassination for moment...
Nah... Maybe poison?)
