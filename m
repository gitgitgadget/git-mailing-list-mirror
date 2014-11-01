From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-highlight: exit when a pipe is broken
Date: Sat, 1 Nov 2014 00:04:43 -0400
Message-ID: <20141101040443.GB8307@peff.net>
References: <1414753444-68653-1-git-send-email-john@szakmeister.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Sat Nov 01 05:04:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkPvn-0002Ee-7i
	for gcvg-git-2@plane.gmane.org; Sat, 01 Nov 2014 05:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbaKAEEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2014 00:04:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:35613 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753431AbaKAEEq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2014 00:04:46 -0400
Received: (qmail 14923 invoked by uid 102); 1 Nov 2014 04:04:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 31 Oct 2014 23:04:46 -0500
Received: (qmail 18080 invoked by uid 107); 1 Nov 2014 04:04:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Nov 2014 00:04:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Nov 2014 00:04:43 -0400
Content-Disposition: inline
In-Reply-To: <1414753444-68653-1-git-send-email-john@szakmeister.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 31, 2014 at 07:04:04AM -0400, John Szakmeister wrote:

> While using diff-highlight with other tools, I have discovered that Python
> ignores SIGPIPE by default.  Unfortunately, this also means that tools
> attempting to launch a pager under Python--and don't realize this is
> happening--means that the subprocess inherits this setting.  In this case, it
> means diff-highlight will be launched with SIGPIPE being ignored.  Let's work
> with those broken scripts by explicitly setting up a SIGPIPE handler and exiting
> the process.

My first thought was that this should be handled already by 7559a1b
(unblock and unignore SIGPIPE, 2014-09-18), but after re-reading your
message, it sounds like you are using diff-highlight with non-git
programs?

> +# Some scripts may not realize that SIGPIPE is being ignored when launching the
> +# pager--for instance scripts written in Python.  Setting $SIG{PIPE} = 'DEFAULT'
> +# doesn't work in these instances, so we install our own signal handler instead.

Why doesn't $SIG{PIPE} = 'DEFAULT' work? I did some limited testing and
it seemed to work fine for me. Though I simulated the condition with:

  (
    trap '' PIPE
    perl -e '$|=1; print "foo\n"; print STDERR "bar\n"'
  ) | true

which should not ever print "bar".

Is Python doing something more aggressive, like using sigprocmask to
block the signal? I would think setting $SIG{PIPE} would handle that,
but maybe not in some versions of perl. I dunno. Modern perl
signal-handling is weird, as it catches everything and then defers
propagation until a safe point in the script (if you strace the script
above, you can see that it actually gets EPIPE from the write call!)
I've no clue what implications all that has for the case you're
addressing.

> +sub pipe_handler {
> +    exit(0);
> +}

Can we exit 141 here? If we are part of a pipeline to a pager, it should
not matter either way, but I'd rather not lose the exit code if we can
avoid it (in case of running the script standalone).

> +$SIG{PIPE} = \&pipe_handler;

A minor nit, but would:

  $SIG{PIPE} = sub { ... };

be nicer to avoid polluting the function namespace?

-Peff
