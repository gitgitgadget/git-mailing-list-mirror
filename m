From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Tue, 29 Dec 2015 03:12:22 -0500
Message-ID: <20151229081222.GB9254@sigill.intra.peff.net>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com>
 <xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
 <CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
 <xmqqd1tye4i8.fsf@gitster.mtv.corp.google.com>
 <20151223093700.GA13386@sigill.intra.peff.net>
 <567B05F0.5020604@kdbg.org>
 <20151223213140.GB21277@sigill.intra.peff.net>
 <CACsJy8Aqu9wTigWKC1-74qLUimV8PvmbDG1XeqYcbW0ZSMLSTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 09:13:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDpOy-0005S9-5c
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 09:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbbL2IM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 03:12:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:46665 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbbL2IMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 03:12:25 -0500
Received: (qmail 19955 invoked by uid 102); 29 Dec 2015 08:12:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:12:25 -0600
Received: (qmail 20275 invoked by uid 107); 29 Dec 2015 08:12:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 03:12:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 03:12:22 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Aqu9wTigWKC1-74qLUimV8PvmbDG1XeqYcbW0ZSMLSTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283108>

On Thu, Dec 24, 2015 at 04:35:33PM +0700, Duy Nguyen wrote:

> On Thu, Dec 24, 2015 at 4:31 AM, Jeff King <peff@peff.net> wrote:
> >   2. I doubt anybody is actually seeing this in practice anymore. But
> >      maybe I am misunderstanding something in Duy's series that changes
> >      this.
> 
> There are two parts in your patch, one (that you two seemed to focus
> on) about return code with "!" aliases. Another, suppressing SIGPIPE,
> affects more than "!" aliases.

Sorry if I was confusing; most of the examples in my previous message
are about the SIGPIPE thing. I was having trouble triggering the message
in practice, even for externals (because the error message goes to the
pager, too!).

> In my case it's execv_dashed_external(). Non-"!" aliases are now
> forced to use that function.

Thanks, this is the part I was missing.

The outer git wrapper doesn't start the pager, so its stderr still gets
seen by the user. But the _inner_ git-log does start the pager, and then
dies of SIGPIPE.

So yeah, I think we want something like this on top of
nd/clear-gitenv-upon-use-of-alias.

-- >8 --
Subject: [PATCH] run-command: don't warn on SIGPIPE deaths

When git executes a sub-command, we print a warning if the
command dies due to a signal, but make an exception for
"uninteresting" cases like SIGINT and SIGQUIT (since the
user presumably just hit ^C).

We should make a similar exception for SIGPIPE, because it's
an expected and uninteresting return in most cases; it
generally means the user quit the pager before git had
finished generating all output.  This used to be very hard
to trigger in practice, because:

  1. We only complain if we see a real SIGPIPE death, not
     the shell-induced 141 exit code. This means that
     anything we run via the shell does not trigger the
     warning, which includes most non-trivial aliases.

  2. The common case for SIGPIPE is the user quitting the
     pager before git has finished generating all output.
     But if the user triggers a pager with "-p", we redirect
     the git wrapper's stderr to that pager, too.  Since the
     pager is dead, it means that the message goes nowhere.

  3. You can see it if you run your own pager, like
     "git foo | head". But that only happens if "foo" is a
     non-builtin (so it doesn't work with "log", for
     example).

However, it may become more common after 86d26f2, which
teaches alias to re-exec builtins rather than running them
in the same process. This case doesn't trigger (1), as we
don't need a shell to run a git command. It doesn't trigger
(2), because the pager is not started by the original git,
but by the inner re-exec of git. And it doesn't trigger (3),
because builtins are treated more like non-builtins in this
case.

Given how flaky this message already is (e.g., you cannot
even know whether you will see it, as git optimizes out some
shell invocations behind the scenes based on the contents of
the command!), and that it is unlikely to ever provide
useful information, let's suppress it for all cases of
SIGPIPE.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 13fa452..694a6ff 100644
--- a/run-command.c
+++ b/run-command.c
@@ -245,7 +245,7 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 		error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
 		code = WTERMSIG(status);
-		if (code != SIGINT && code != SIGQUIT)
+		if (code != SIGINT && code != SIGQUIT && code != SIGPIPE)
 			error("%s died of signal %d", argv0, code);
 		/*
 		 * This return value is chosen so that code & 0xff
-- 
2.7.0.rc3.367.g09631da
