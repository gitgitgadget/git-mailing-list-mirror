From: Jeff King <peff@peff.net>
Subject: Re: git-svn died of signal 11 (was "3 failures on test t9100
 (svn)")
Date: Wed, 3 Mar 2010 12:31:31 -0500
Message-ID: <20100303173131.GB10168@coredump.intra.peff.net>
References: <20100302194518.GA12942@vidovic>
 <20100302212806.GA21413@coredump.intra.peff.net>
 <20100303005804.GA17120@vidovic>
 <20100303092213.GA12909@vidovic.wsb>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Mar 03 18:31:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmsQ6-0003mF-7w
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 18:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679Ab0CCRbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 12:31:33 -0500
Received: from peff.net ([208.65.91.99]:37909 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664Ab0CCRbc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 12:31:32 -0500
Received: (qmail 13218 invoked by uid 107); 3 Mar 2010 17:31:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Mar 2010 12:31:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Mar 2010 12:31:31 -0500
Content-Disposition: inline
In-Reply-To: <20100303092213.GA12909@vidovic.wsb>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141460>

On Wed, Mar 03, 2010 at 10:22:13AM +0100, Nicolas Sebrecht wrote:

>   $ cd okawix
>   $ cat .git/config
>   <...>
>   [svn-remote "svn"]
>     url = https://okawix.svn.sourceforge.net/svnroot/okawix
>     fetch = :refs/remotes/git-svn
> 
>   $ git svn fetch
> [...]
>   error: git-svn died of signal 11

I was able to clone this repository just fine with "git svn clone"
(which should internally just be doing that same fetch). But since it is
a segfault, and since you are having problems with some repositories and
not others, it may be a problem with uninitialized data or similar.

And the fact that you are getting a perl program to segfault means it is
probably not the perl program's fault, but a problem with perl itself or
an XS module loaded by perl (like, say, the SVN module).

Do you have valgrind installed? Have you tried running

  valgrind perl /usr/libexec/git-core/git-svn fetch

(you may need to tweak the libexeec path depending on your git install).
That should at least correctly identify the source of the segfault (you
can try it with gdb, too, but often segfaults are caused by memory
problems that happened much earlier, so valgrind will give you a more
accurate answer).

> > I'll do more investigations at work tomorrow. I've already tried to add
> > the "-d" flag in git-svn and it didn't help neither: git looked like in
> > an infinite loop. Odd, odd, odd.
> 
> Adding the -d option to the shebang of git-svn doesn't help. I've
> stopped the process after 24 minutes running.  I have no more
> information with the -w option set.

What's it doing for 24 minutes? Is it actually chewing on cpu, or is it
blocking on I/O? Have you tried running it under strace?

-Peff
