From: Jeff King <peff@peff.net>
Subject: Re: Checking out on a different+partial directory
Date: Sat, 22 May 2010 01:48:52 -0400
Message-ID: <20100522054852.GB29118@coredump.intra.peff.net>
References: <19441.8259.634019.348195@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sat May 22 07:57:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFhho-0003mZ-4z
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 07:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab0EVFs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 01:48:56 -0400
Received: from peff.net ([208.65.91.99]:50365 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829Ab0EVFs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 01:48:56 -0400
Received: (qmail 5505 invoked by uid 107); 22 May 2010 05:48:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 22 May 2010 01:48:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 22 May 2010 01:48:52 -0400
Content-Disposition: inline
In-Reply-To: <19441.8259.634019.348195@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147507>

On Mon, May 17, 2010 at 06:53:55AM -0400, Eli Barzilay wrote:

> Say that I have a repository at /some/dir, and a tree that contains
> most of its files at /another/dir (the second is a build directory,
> made with `git archive', so some files removed due to export-ignore
> attributes and some built files are present).
> 
> Is there a convenient way to make /some/dir usable as a repository?

Did you mean /another/dir? /some/dir is already a repository as per your
description above (is it a bare repository or a regular one?).

> Two things that I tried are
> 
>   git --work-tree=/another/dir reset --hard master
> 
> which one time, but then failed with "fatal: unable to read tree...",
> and another is

I would have thought that worked, assuming you were in /some/dir. And
oddly, _some_ stuff works. I tried:

  mkdir repo && cd repo && git init
  echo content >file && git add . && git commit -m file
  git archive --format=tar --prefix=work/ HEAD | tar -C .. -xf -

to create the situation. Running

  cd repo
  git --work-tree=$PWD/../work diff-files
  git --work-tree=$PWD/../work diff

works as expected (the first one notices stat-dirtiness, and the second
shows an empty diff). But then I get:

  $ git --work-tree=$PWD/../work reset --hard
  fatal: unable to read tree ea394696ee1f7f5b55ca0d97d37748933cf39095

So there is clearly a bug. I'll investigate.

>   cp -a /some/dir/.git /another/dir
>   cd /another/dir
>   git reset --hard master
> 
> which looks like it can suffer from the same problem.

That should work, too.

> (It would be especially nice if there's a way to have only different
> files touched in /another/dir.)

Only different files will be rewritten, but git will have to read all of
the files to determine their sha1 (usually it avoids this by checking
stat info, but obviously your exported files will not match the stat
info in the /another/dir's index).

-Peff
