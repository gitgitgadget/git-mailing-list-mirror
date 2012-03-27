From: Jeff King <peff@peff.net>
Subject: Re: Bug? Bad permissions in $PATH breaks Git aliases
Date: Mon, 26 Mar 2012 23:19:53 -0400
Message-ID: <20120327031953.GA17338@sigill.intra.peff.net>
References: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 05:20:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCMx1-0003eI-RW
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 05:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131Ab2C0DT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 23:19:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60359
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756816Ab2C0DT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 23:19:58 -0400
Received: (qmail 28104 invoked by uid 107); 27 Mar 2012 03:20:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 23:20:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 23:19:53 -0400
Content-Disposition: inline
In-Reply-To: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193997>

On Mon, Mar 26, 2012 at 04:48:29PM -0700, James Pickens wrote:

> I'm not sure if this should be considered a bug or not, but I've noticed that
> when my $PATH contains an inaccessible directory, Git fails to execute aliases.
> For example:
> 
> git config alias.l log
> git l
> # works fine
> PATH=boguspath:$PATH
> mkdir boguspath
> chmod 000 boguspath
> git l
> # fatal: cannot exec 'git-l': Permission denied

This seems to come up about once a year. The short of it is that execve
will return EACCESS whether the file exists is not actually executable
by you, or if you have an inaccessible element in your PATH. execvp will
continue the search if it sees EACCESS, but will return EACCESS if it
finds nothing.  So git just sees the EACCESS and doesn't know if you
have bogus entries in your PATH or if there is a permissions problem
with your executable files.

For something like a shell, it's not that big a deal; either way, you
couldn't execute the command in question. For git, it matters more
because we first try to exec an external command, and then fall back to
an alias (because externals take precedence over aliases).

So basically our options are:

  1. Start treating EACCESS silently as ENOENT. The downside is that we
     fail to report the proper error when the file really does have
     permissions problems (we would say "command not found", but that is
     misleading).

  2. Implement our own execvp, differentiating between "path not
     available for looking in" and "we found the command, but there was
     a permissions problem". I think somebody was working on this a few
     months ago (search for "add exeecvp failure diagnostics") but it
     seems to have fizzled.

  3. If we get an EACCESS, remember it, try to do the alias lookup, and
     then if that fails, report the "Permission denied" error (not
     "command not found"). That is following the spirit of what execvp
     does (it will find later entries in the PATH if they are there, but
     otherwise will remember the EACCESS error).

>From what I can tell, dash uses stock execvp, and ends up closest to
(3). Bash seems to have implemented their own path lookup, as it will
distinguish between the two cases as in (2):

  $ mkdir /tmp/foo
  $ chmod 0 /tmp/foo
  $ PATH=/tmp/foo:$PATH
  $ dash -c does-not-exist
  dash: 1: does-not-exist: Permission denied
  $ bash -c does-not-exist
  bash: does-not-exist: command not found

  $ chmod 755 /tmp/foo
  $ >/tmp/foo/does-not-exist
  $ chmod 0 /tmp/foo/does-not-exist
  $ dash -c does-not-exist
  dash: 1: does-not-exist: Permission denied
  $ bash -c does-not-exist
  bash: /tmp/foo/does-not-exist: Permission denied

I think the general feeling last time this came up was "why not just
remove the cruft from your PATH?" But I would personally be OK with
option (3) above, and it is probably not that hard to implement.

-Peff
