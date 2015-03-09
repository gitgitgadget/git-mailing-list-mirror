From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] help.c: use SHELL_PATH instead of hard-coded
 "/bin/sh"
Date: Mon, 9 Mar 2015 03:20:40 -0400
Message-ID: <20150309072040.GA28148@peff.net>
References: <38be9195b966a027cb050e5a1b47526@74d39fa044aa309eaea14b9f57fe79c>
 <0ebc0373b21c75fa88adb5aefd098e9@74d39fa044aa309eaea14b9f57fe79c>
 <xmqq61acsz7k.fsf@gitster.dls.corp.google.com>
 <C611A125-D641-46E6-A5AD-1010D70582F0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 08:20:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUrzc-0002P8-77
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 08:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbbCIHUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 03:20:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:59041 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752057AbbCIHUn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 03:20:43 -0400
Received: (qmail 8087 invoked by uid 102); 9 Mar 2015 07:20:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 02:20:43 -0500
Received: (qmail 4441 invoked by uid 107); 9 Mar 2015 07:20:50 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Mar 2015 03:20:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Mar 2015 03:20:40 -0400
Content-Disposition: inline
In-Reply-To: <C611A125-D641-46E6-A5AD-1010D70582F0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265132>

On Sun, Mar 08, 2015 at 11:32:22PM -0700, Kyle J. McKay wrote:

> >It is a common convention to make the first argument the command
> >name without its path, and this change breaks that convention.
> 
> Hmpf.  I present these for your consideration:
> 
> $ sh -c 'echo $0'
> sh
> $ /bin/sh -c 'echo $0'
> /bin/sh
> $ cd /etc
> $ ../bin/sh -c 'echo $0'
> ../bin/sh
> 
> I always thought it was the actual argument used to invoke the item.  If the
> item is in the PATH and was invoked with a bare word then arg0 would be just
> the bare word or possibly the actual full pathname as found in PATH.
> Whereas if it's invoked with a path (relative or absolute) that would passed
> instead.

Yes, you are correct. When there is a full path, that typically gets
passed instead (unless you are trying to convey something specific to
the program, like telling bash "pretend to be POSIX sh"; that's usually
done with a symlink, but the caller might want to override it).

If we were starting from scratch, I would say that SHELL_PATH is
supposed to be a replacement POSIX shell, and so we should call:

  execl(SHELL_PATH, "sh", "-c", ...);

to tell shells like bash to operate in POSIX mode.

However, that is _not_ what we currently do with run-command's
use_shell directive. There we put SHELL_PATH as argv[0], and run:

  execv(argv[0], argv);

I doubt it matters much in practice (after all, these are just "-c"
snippets, not whole scripts). But it's possible that by passing "-c" we
would introduce bugs (e.g., if somebody has a really complicated inline
alias, and sets SHELL_PATH to /path/to/bash, they'll get full-on bash
with the current code).

> I also have no objection to changing it to:
> 
> >-	execl("/bin/sh", "sh", "-c", shell_cmd.buf, (char *)NULL);
> >+	execl(SHELL_PATH, basename(SHELL_PATH), "-c", shell_cmd.buf, (char
> >*)NULL);
> 
> just to maintain the current behavior.

If we want to maintain consistency with the rest of our uses of
run-command, it would be just your original:

  execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, NULL);

That makes the most sense to me, unless we are changing run-command's
behavior, too. 

There's no point in calling basename(). Shells like bash which
behave differently when called as "sh" are smart enough to check the
basename themselves (this would matter, e.g., if you set SHELL_PATH to
"/path/to/my/sh" and that was actually a symlink to bash).

-Peff
