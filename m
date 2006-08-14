From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git-publish
Date: Mon, 14 Aug 2006 07:25:44 -0400
Message-ID: <20060814112544.GA13116@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org> <20060813191346.GA21487@mars.ravnborg.org> <Pine.LNX.4.64.0608131536590.9789@iabervon.org> <20060814015127.GA18667@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 14 13:26:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCaZt-0006e7-Mz
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 13:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbWHNLZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 07:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWHNLZu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 07:25:50 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:5086 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751980AbWHNLZt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 07:25:49 -0400
Received: (qmail 30813 invoked from network); 14 Aug 2006 07:25:14 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 14 Aug 2006 07:25:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2006 07:25:44 -0400
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060814015127.GA18667@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25350>

On Sun, Aug 13, 2006 at 09:51:27PM -0400, Shawn Pearce wrote:

> But even worse this style of workflow will generate a very messy
> history.  Almost every commit will have been done in isolation,

I think the real reason CVS histories stay un-messy is that 'cvs commit' is
actually more like 'git-commit && git-fetch && git-rebase origin &&
git-push'.  That is the workflow I use for small personal repositories
where I am replacing CVS with git. I always want to keep the server up
to date so my work is accessible from multiple machines, and I almost
never want to branch (I generally only rebase because I forgot a push or
pull). I still don't think I'd want all of that in one command, though.

> So in my humble opinion I think this is not really a workflow style
> that should be encouraged with GIT.  But perhaps tools to show you
> what would happen if you pushed right now (e.g. a shortlog of the
> commits that would upload or that must be downloaded and merged)
> would be useful.

Like git-log --pretty=online origin..HEAD?

One of the things I like about git is how easy it is to find out
what's going on. I have a large number of small project repostories
checked out at any given time. I can quickly get the status of all of
them with this script:

  #!/bin/sh

  count_zero() {
      test `"$@" | wc -l` = 0
  }

  check_git() {
    cd $1
    count_zero git-ls-files \
      -m -o -d --exclude-per-directory=.gitignore \
      --directory --no-empty-directory || echo COMMIT:$1
    if test -e .git/branches/origin -o -e .git/remotes/origin; then
      git-fetch || echo FETCH:$1
      count_zero git-rev-list master..origin || echo MERGE:$1
      count_zero git-rev-list origin..master || echo PUSH:$1
    else
      echo ORIGIN:$1
    fi
    test "`git-count-objects | cut -d' ' -f1`" -gt 1000 && echo PACK:$1
  }

  for i in `find $PROJECT_ROOTS -type -d -name .git | sed 's!/.git$!!'`; do
    echo Checking $i...
    errors="$errors `check_git $i`
  done
  echo $errors | sed -e 's/ /\n/g' -e 's/:/: /g'

This lets me know if I've forgotten to commit anything, if I've forgotten to
push (or if I haven't even set up an origin yet!), or if there are new changes
waiting for me to merge.

-Peff
