From: Jeff King <peff@peff.net>
Subject: Re: git stash data loss
Date: Fri, 27 Jul 2012 09:29:53 -0400
Message-ID: <20120727132953.GA8263@sigill.intra.peff.net>
References: <55831343358368@web1e.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Aleksandr Pryimak <tramsmm-mirror@yandex.ru>
X-From: git-owner@vger.kernel.org Fri Jul 27 15:30:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SukcM-00074g-TP
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 15:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab2G0NaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 09:30:02 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38821 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053Ab2G0NaB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 09:30:01 -0400
Received: (qmail 19649 invoked by uid 107); 27 Jul 2012 13:30:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jul 2012 09:30:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jul 2012 09:29:53 -0400
Content-Disposition: inline
In-Reply-To: <55831343358368@web1e.yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202353>

On Fri, Jul 27, 2012 at 07:06:08AM +0400, Aleksandr Pryimak wrote:

> I also recreated it
> 
> aleksandr@beast:/tmp/test$ git init
> Initialized empty Git repository in /tmp/test/.git/
> aleksandr@beast:/tmp/test$ touch x
> aleksandr@beast:/tmp/test$ git add x
> aleksandr@beast:/tmp/test$ git commit -m "Initial"
> [master (root-commit) d3569a0] Initial
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 x

OK, so we have "x" as a tracked file.

> aleksandr@beast:/tmp/test$ rm x
> aleksandr@beast:/tmp/test$ mkdir x/
> aleksandr@beast:/tmp/test$ ls
> x

And then we remove it in favor of a directory. Note that git does not
track directories directly, only files inside them. So from git's
perspective, the working tree has no content in it at all.

> aleksandr@beast:/tmp/test$ git stash
> Saved working directory and index state WIP on master: d3569a0 Initial
> HEAD is now at d3569a0 Initial

And now we stash it. That will stash the working tree removal of x. It
will not stash anything about the new directory x, because it has no
content inside it.

> aleksandr@beast:/tmp/test$ ls
> x
> aleksandr@beast:/tmp/test$ git stash pop
> Removing x
> # On branch master
> # Changes not staged for commit:
> #   (use "git add/rm <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #	deleted:    x
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> Dropped refs/stash@{0} (c500443ae16cf0d846b195cb97eb388dec5f440e)
> aleksandr@beast:/tmp/test$ ls

And your stash pop restores the deletion of "x". It does _not_ reinstate
the directory "x", because as I stated above, that is not part of the
stash.

So what is the data loss? That the "mkdir x" was lost? That has nothing
to do with stash, but rather the fact that git does not track empty
directories. You could see the same thing with:
 
  mkdir x && git commit -a

which will not record your mkdir at all. In other words, this is by
design.

If we put actual files inside "x", which git does track, then they would
be part of the stash, and should be properly retained. But they're not:

  $ rm x && mkdir x && echo foo >x/file

Now we have some precious contents in the form of "x/file". They are
untracked by git, but git should be careful about removing them.

  $ git stash
  Saved working directory and index state WIP on master: 2d32d3a initial
  HEAD is now at 2d32d3a initial
  $ ls -l x
  -rw-r--r-- 1 peff peff 0 Jul 27 09:19 x
  $ git stash show --raw
  :100644 000000 e69de29... 0000000... D  x

Now this _is_ data loss. Stash blows away untracked files inside the
directory, but does not record them in the resulting stash. And that
should be fixed.

With "-u", I'd expect stash to include the untracked file x/foo in the
stash. Without "-u", I'd expect stash to fail, since it would be
deleting untracked files.

-Peff
