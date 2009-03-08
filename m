From: Jeff King <peff@peff.net>
Subject: Re: import files w/ history
Date: Sat, 7 Mar 2009 19:10:21 -0500
Message-ID: <20090308001021.GA26167@coredump.intra.peff.net>
References: <slrngqqa4l.1t4t.csaba-ml@beastie.creo.hu> <20090303130046.GA7867@coredump.intra.peff.net> <slrngr299k.1t4t.csaba-ml@beastie.creo.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Csaba Henk <csaba-ml@creo.hu>
X-From: git-owner@vger.kernel.org Sun Mar 08 01:13:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg6dX-0003sG-6o
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 01:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbZCHAKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 19:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbZCHAKf
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 19:10:35 -0500
Received: from peff.net ([208.65.91.99]:33074 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbZCHAKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 19:10:35 -0500
Received: (qmail 18122 invoked by uid 107); 8 Mar 2009 00:10:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 19:10:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 19:10:21 -0500
Content-Disposition: inline
In-Reply-To: <slrngr299k.1t4t.csaba-ml@beastie.creo.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112597>

On Fri, Mar 06, 2009 at 01:29:38PM +0000, Csaba Henk wrote:

> $ git filter-branch --commit-filter '
>    if [ $# -lt 3 ] || git diff --stat $3 $1 | grep -q 'sys/dev/disk/vn/vn\.c'
>    then
>      git commit-tree "$@"
>    else
>      skip_commit "$@"
>    fi' HEAD

Wow, I'll bet that was slow to run. And it's not really what you want.

You are picking commits that changed a particular file, and then
including the _whole_ tree. Remember that commits really record a tree
state; we only think of them as "changes" because they point to a prior
commit with its own tree state. So you are just selecting some subset of
the states, but not cutting down the tree in each state.

What you really want to do is say:

  - for every commit, narrow the tree to _just_ the one file

  - if there were no changes in the narrowed tree, just throw out the
    commit

You can use an --index-filter to do the former, and a --commit-filter to
do the latter (or just use --prune-empty, which is a shorthand).

Another poster had a similar problem, and you can see the right
filter-branch recipe there:

  http://article.gmane.org/gmane.comp.version-control.git/111991

>   *  *  *
> 
> OK, I then tried to do more RTFM and be more clever and efficient, and
> find a way to specify directly those commits which affect vn.c. As "git
> rev-list" can be invoked like "git rev-list <commit> <path>", and the
> synopsis of "git filter-branch" is like
> 
>  git filter-branch [options] [--] [<rev-list options>...]
> 
> I then gave a try to:
> 
> $ git filter-branch --  master sys/dev/disk/vn/vn.c
> 
> but no dice -- I got:
> 
>   fatal: ambiguous argument 'sys/dev/disk/vn/vn.c': unknown revision or
>   path not in the working tree.
>   Use '--' to separate paths from revisions
>   Could not get the commits
> 
> Any idea?

I think you need an extra '--' to separate the paths from the revisions
in the rev-list arguments:

  git filter-branch -- master -- sys/dev/disk/vn/vn.c

but even that doesn't quite do what you want. It limits the commits that
are shown, similar to your first attempt above, but it doesn't cut down
the tree itself (OTOH, limiting by path rather than using --prune-empty
is likely to run faster, since you won't even look at commits that are
uninteresting. However, it may change the shape of your history with
respect to branching and merging).

-Peff
