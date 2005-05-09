From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Git-aware Darcs: a tutorial
Date: Mon, 09 May 2005 18:29:22 +0200
Message-ID: <7i4qdc8isd.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-users@abridgegame.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 19:22:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVB1i-0003hD-6q
	for gcvg-git@gmane.org; Mon, 09 May 2005 18:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVEIQ3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVEIQ3q
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 12:29:46 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:48124 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S261438AbVEIQ30 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 12:29:26 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr [134.157.168.1])
          by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j49GSxTD032086
          ; Mon, 9 May 2005 18:28:59 +0200 (CEST)
X-Ids: 168
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr [134.157.168.57])
          by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id j49GTNoA019091
          ; Mon, 9 May 2005 18:29:23 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DVB8F-000723-0q; Mon, 09 May 2005 18:29:23 +0200
To: darcs-devel@abridgegame.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2 (shiva.jussieu.fr [134.157.0.168]); Mon, 09 May 2005 18:28:59 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 427F8FCB.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

0. What is Darcs-git

Darcs-git is a branch of Darcs that can work with Git repositories.

Darcs-git is deliberately Darcs, not Git.  All commands either work in
the same way on Git repositories as on Darcs repositories, or they
fail.  If you're a Darcs user, you'll like darcs-git.  If you're a Git
user, you'll probably find it infuriating.

On the other hand, Darcs-git uses stock Git repositories; a Darcs
command either works as-is on a Git repository, or fails.


1. What you can expect

The following should work reasonably well on Git repositories:

  darcs changes
  darcs whatsnew
  darcs pull
  darcs send
  darcs record

The following commands work, but have serious performance problems:

  darcs diff
  darcs changes with a file argument

The following commands should in principle work but haven't been tested:

  darcs add
  darcs remove
  darcs dist
  darcs trackdown

The following commands don't work because I'm lazy::

  darcs push
  darcs unrecord
  darcs unpull
  darcs amend-record
  darcs annotate
  darcs rollback

The following commands only work on native Darcs repositories, either
because they don't make sense on Git repositories, or because there
are perfectly good native Git tools to perform their function:

  darcs initialize
  darcs get/put
  darcs check
  darcs repair
  darcs optimize
  darcs mv
  darcs replace
  darcs resolve
  darcs tag
  darcs setpref

Remote Git repositories are not supported.


2. A tutorial

(0) Build darcs-git

  $ darcs get --partial http://www.pps.jussieu.fr/~jch/software/repos/darcs-git
  $ cd darcs-git
  $ make darcs
  $ make Context.hs
  $ make darcs
  $ cp darcs ~/bin/

(1) Get a copy of the Linux Git repository:

  $ cd /usr/local/src
  $ mkdir linux-2.6
  $ cd linux-2.6
  $ rsync -r rsync://rsync.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git .git
  $ curl http://rsync.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git/HEAD > .git/HEAD

We still need to bring the cache and working directory into a state
that Darcs will be happy with.  While this could in principle be done
with Darcs itself, it will be faster to do it with Git:

  $ read-tree `cat .git/HEAD`
  $ checkout-cache -a
  $ update-cache --refresh

(2) Check what the friendly Linux hackers have been up to:

  $ darcs changes | more
  $ darcs changes -s | more

(3) Create a local clone of the Linux repository:

  $ cd ..
  $ mkdir linux-2.6-local
  $ mkdir linux-2.6-local/.git
  $ ln -s `pwd`/linux-2.6/.git/objects linux-2.6-local/.git
  $ cp linux-2.6/.git/HEAD linux-2.6-local/.git
  $ cd linux-2.6-local
  $ read-tree `cat .git/HEAD`
  $ checkout-cache -a
  $ update-cache --refresh

(4) Commit some work

First, check that Darcs is happy with the new repository.

  $ darcs whatsnew

This should take a few seconds at most; if it takes minutes instead,
try running ``update-cache --refresh''.

Okay, let's add myself to the list of Linux maintainers.

  $ echo 'P:    Juliusz Chroboczek' >> MAINTAINERS

Let's see if Darcs agrees.

  $ darcs whatsnew -s
  $ darcs whatsnew

Everything looks fine, let's record (commit) this patch.

  $ darcs record -a
  $ darcs changes | more
  $ darcs changes -s | more

(5) Send it upstream

If Linus were using Darcs, we could just send him a Darcs patch, which
is a patch-like data structure that contains just enough context
information to allow Darcs to perform a history-sensitive merge:

  $ darcs send ../linux-2.6

However, until Linus switches to Darcs, we're stuck with old-fashioned
patches.

  $ darcs diff -u --patch='.' | mail bill@microsoft.com

Unfortunately, until I've spent some time optimising ``darcs diff'',
the above won't terminate on a repository the size of Linux'.


3. Caveats

There is little input validation.  In particular, if you enter an
e-mail address that doesn't end in ``>'', Darcs will write a commit
that neither Git nor Darcs itself will be able to parse.

Darcs never updates the Git cache.  If you perform many commits using
Darcs, you'll need to manually run ``update-cache --refresh''.

Darcs treats Git merges by reverse-engineering a Darcs merge (thanks
to David Roundy for outlining how that can be done).  In practice,
this means that Darcs will collapse as soon as it sees a nontrivial
Git merge.
