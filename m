From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix ls-tree usage with dash-prefixed paths
Date: Sun, 29 Mar 2009 14:56:51 -0700
Message-ID: <20090329215651.GA4355@dcvr.yhbt.net>
References: <22719363.post@talk.nabble.com> <20090326130213.GC3114@atjola.homenet> <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com> <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com> <20090329060858.GB15773@dcvr.yhbt.net> <20090329061045.GA29721@dcvr.yhbt.net> <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anton Gyllenberg <anton@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 23:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo31N-0002c7-Ms
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 23:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbZC2V4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 17:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbZC2V4x
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 17:56:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36187 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbZC2V4x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 17:56:53 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D6E1F79C;
	Sun, 29 Mar 2009 21:56:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115040>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > To find the blob object name given a tree and pathname, we were
> > incorrectly calling "git ls-tree" with a "--" argument followed
> > by the pathname of the file we wanted to get.
> >
> >   git ls-tree <TREE> -- --dashed/path/name.c
> >
> > Unlike many command-line interfaces, the "--" alone does not
> > symbolize the end of non-option arguments on the command-line.
> >
> > ls-tree interprets the "--" as a prefix to match against, thus
> > the entire contents of the --dashed/* hierarchy would be
> > returned because the "--" matches "--dashed" and every path
> > under it.
> 
> The above makes only half a sense to me.  In an empty directory:

Ah, I think you missed this line:

"the entire contents of the --dashed/* hierarchy would be"

>     $ git init
>     Initialized empty Git repository in /tmp/empty/.git
>     $ mkdir -p ./--dashed/path
>     $ >./--dashed/path/name

# Add a second file
	>./--dashed/path/ame

>     $ git add .
>     $ git ls-files
>     --dashed/path/name
>     $ git commit -a -m initial
>     [master (root-commit) cd44284] initial
>      0 files changed, 0 insertions(+), 0 deletions(-)
>      create mode 100644 --dashed/path/name
>     $ git ls-tree HEAD^{tree} --
>     $ git ls-tree HEAD^{tree} -- --dashed/path/name
>     100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	--dashed/path/name
>     $ mkdir ./--
>     $ >./--/eman
>     $ git add .
>     $ git commit -m second
>     [master 80f8ef9] second
>      0 files changed, 0 insertions(+), 0 deletions(-)
>      create mode 100644 --/eman
>     $ git ls-tree HEAD^{tree} -- --dashed/path
>     100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	--/eman
>     040000 tree 23e59e0c91294c39ac7c5a2e39efb01d878de9a0	--dashed/path

This is similar to the problem I was experiencing.

>     $ exit
> 
> Perhaps the problem repository had a pathname that is exactly -- (in
> addition to --dashed/), and ls-tree emitted everything under --/
> hierarchy?  In other words, your fix to git-svn may be correct and I am
> reading your problem description above incorrectly?

I think so.

> As the command always takes exactly one tree, it could be argued that it
> is not a bug that it does not honour the usual -- convention, even though
> I am tempted to think it is of a very dark shade of gray.  It is certainly
> something that we would have done differently if we were implementing the
> command today.

Well, if somebody had a path in their repo called "--full-name" then it
would certainly be ambiguous and respecting "--" would help.  Something
we should definitely go back and fix if we have time travel[1]

> "Fixing" ls-tree would be trivial to ignore the first "--" if it precedes
> other pathspecs (see below), but the command is a plumbing, and such a
> change will break existing scripts that have relied on the existing
> behaviour since 2005, so I do not think it is worth the risk of causing
> such silent breakages to them.  Besides, with such a "fix", fixing of user
> scripts will become much more cumbersome, as they need to detect the
> version of git and drive ls-tree differently.

I concur completely.  I didn't propose a "fix" to ls-tree for exactly
the reasons you stated.


[1] But if we had time travel we could just release git before any other
SCM and hopefully not have to deal with SVN at all :)

-- 
Eric Wong
