From: Jeff King <peff@peff.net>
Subject: Re: Effectively tracing project contributions with git
Date: Sat, 12 Sep 2009 14:59:40 -0400
Message-ID: <20090912185940.GA21277@coredump.intra.peff.net>
References: <4AAB9459.3070809@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 21:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXqH-0007D1-Bz
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 21:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbZILS7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754561AbZILS7l
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:59:41 -0400
Received: from peff.net ([208.65.91.99]:54985 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283AbZILS7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:59:41 -0400
Received: (qmail 13742 invoked by uid 107); 12 Sep 2009 19:00:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Sep 2009 15:00:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Sep 2009 14:59:40 -0400
Content-Disposition: inline
In-Reply-To: <4AAB9459.3070809@webdrake.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128286>

On Sat, Sep 12, 2009 at 02:30:17PM +0200, Joseph Wakeling wrote:

> I've recently begun contributing to a FOSS project that has a problem --
> although it has extensive git logs (some being CVS/SVN imports) dating
> back over many years, there has not been maintenance of contribution
> records on a file-by-file basis.
> 
> I'm trying to rectify this and track down who contributed what.
> Unfortunately while I'm used to basic operations with git, I don't know
> it well enough to be confident in how to go about tracing contributions
> in this way.

We can probably help you with the git side of things, but defining "who
contributed what" is kind of a hairy problem. You will need to define
exactly how you want to count contributions.

For example:

> 'git annotate' of course is a nice starting point but of limited use
> because every time someone tweaks a line (and there have been many such
> tweaks in the history of the project) the responsibility of the original
> contributor is replaced by that of the tweaker.

But often the tweaking of the line _does_ make it their own. One of the
metrics often discussed in git is "of the surviving lines in the code,
how many were authored by each person". Which really is the output of
"git blame" (or annotate, which is more or less the same thing). So
people who contribute code that needs a lot of changes or cleanup don't
get as much credit for that code, because their lines got tweaked later.

It's an OK metric if you assume that lines are a good atom of
contribution. That is, if I replace your line, then I remove everything
of value that you added and I should get credit. That is arguably not
the case with something like a style cleanup. Changing:

  if(i = 0; i < n; i++)

to

  if (i = 0; i < n; i++)

to fix whitespace should probably leave authorship with the original
line. But I don't know if you can determine programatically how
significant a change was. In the case of whitespace, "git blame" has an
option to ignore whitespace changes, which probably covers a large
portion of such "trivial change" cases.

> An alternative is to use gitk to trace the history of individual files
> (or paths, as gitk has it).  The problem here is that files have been
> renamed, content has been moved about between different files and so on.

You can use rename detection via --follow and simply count the lines
changed (and by whom) in each commit. Which differs from "git blame"
strategy by counting every change as of value, even if it is a line that
doesn't survive.

But no, that won't handle the movement of some chunk of content from
one file to another. Only "git blame" really looks at code movement on a
smaller-than-file level.

> I'm just hoping that the git community can offer some good advice on
> this, to what extent the process of tracing contributions can be
> automated, and so on.  I'm not expecting anyone to provide a solution
> for me, but suggestions and pointers in the possible right directions
> would be much appreciated.

I think it is less a git problem and more of a "how do you want to
define contribution" problem. The above is just my thinking about it for
a few minutes. Sverre Rabelier (cc'd) did a "git stats" GSoC project
last year, but I don't think I ever looked closely at the results or
what metrics he came up with. But that is probably a good direction to
look in.

-Peff
