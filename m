From: Jeff King <peff@peff.net>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Thu, 14 Jan 2010 14:52:34 -0500
Message-ID: <20100114195234.GA26684@coredump.intra.peff.net>
References: <4B4F6000.4070005@sofistes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marko Poutiainen <regs@sofistes.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 20:52:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVVkH-0006kV-Vu
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 20:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298Ab0ANTwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 14:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757397Ab0ANTwh
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 14:52:37 -0500
Received: from peff.net ([208.65.91.99]:38622 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756882Ab0ANTwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 14:52:36 -0500
Received: (qmail 13288 invoked by uid 107); 14 Jan 2010 19:57:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 Jan 2010 14:57:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2010 14:52:34 -0500
Content-Disposition: inline
In-Reply-To: <4B4F6000.4070005@sofistes.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137017>

On Thu, Jan 14, 2010 at 08:18:40PM +0200, Marko Poutiainen wrote:

> It seems that that there is a bug related to how Git handles the add
> command with wildcards if the wildcard also matches a file that is ignored.
> 
> E.g (I activate the *.[ao] rule when editing .git/info/exclude):
> 
> mep@Blackbird:~$ cd /tmp
> mep@Blackbird:/tmp$ mkdir git
> mep@Blackbird:/tmp$ cd git
> mep@Blackbird:/tmp/git$ git init
> Initialized empty Git repository in /tmp/git/.git/
> mep@Blackbird:/tmp/git$ nano -w .git/info/exclude
> mep@Blackbird:/tmp/git$ touch a.o a.c a.h
> mep@Blackbird:/tmp/git$ git add a.*
> The following paths are ignored by one of your .gitignore files:
> a.o
> Use -f if you really want to add them.
> fatal: no files added

It's not a bug. That is working as designed. If "git add" encounters a
problem with any of the files you gave it on the command line (and
remember, the shell expands the wildcard, so git literally sees the
three files on the command line) then it aborts the entire operation.

Now whether that is useful behavior in this case, I don't know. If you
were truly manually specifying the files, then it would probably not be
a big deal to simply remove the offending file. But there is no way to
use the shell wildcard and get the behavior you want (not even a "git
add --really-ignore-my-ignores a.*").

I don't think it would be right to silently ignore them, because it may
be the sign of an error. It could be downgraded to a warning, like:

  $ git add *.a
  warning: a.o is ignored, not adding

The downside would be that somebody who really _did_ want to add such a
file but forgot to use "-f" is going to be less likely to notice it, as
the command does not barf. So maybe such behavior should be triggered
with a command-line option. I dunno.

-Peff
