From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Wed, 23 Dec 2015 04:37:00 -0500
Message-ID: <20151223093700.GA13386@sigill.intra.peff.net>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com>
 <xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
 <CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
 <xmqqd1tye4i8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 10:37:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBfrZ-0005Oa-MD
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 10:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbbLWJhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 04:37:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:45538 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752773AbbLWJhD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 04:37:03 -0500
Received: (qmail 1654 invoked by uid 102); 23 Dec 2015 09:37:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Dec 2015 03:37:03 -0600
Received: (qmail 6371 invoked by uid 107); 23 Dec 2015 09:37:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Dec 2015 04:37:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Dec 2015 04:37:00 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd1tye4i8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282929>

On Tue, Dec 22, 2015 at 10:13:03AM -0800, Junio C Hamano wrote:

> > Another by the way, this "forcing aliases as external commands" now
> > shows something like "error: git-log died of signal 13" when the pager
> > exits early, for an alias like "l1 = log --oneline".
> 
> ... and we do not show that when we directly call "git log" is...?
> 
> We do signal this with non-zero exit status like so:
> 
> 	$ GIT_PAGER=true git log --oneline ; echo $?
>         141
> 
> and it is not surprising that the one that is catching the exit
> status of what was spawned and reporting "signal 13".

This sounded very familiar. Apparently I've been running with the patch
below for almost 3 years and never got around to re-examining it.

The original discussion is in:

  http://thread.gmane.org/gmane.comp.version-control.git/212630

Having skimmed through the arguments there, and given that we applied
the patch from the middle of the thread, I think this is a good change.

-- >8 --
Date: Fri, 4 Jan 2013 07:19:35 -0500
Subject: [PATCH] avoid SIGPIPE warnings for aliases

When git executes an alias that specifies an external
command, it will complain if the alias dies due to a signal.
This is usually a good thing, as signal deaths are
unexpected. However, SIGPIPE is not unexpected for many
commands which produce a lot of output; it is intended that
the user closing the pager would kill them them via SIGPIPE.

As a result, the user might see annoying messages in a
scenario like this:

  $ cat ~/.gitconfig
  [alias]
  lgbase = log --some-options
  lg = !git lgbase --more-options
  lg2 = !git lgbase --other-options

  $ git lg -p
  [user hits 'q' to exit pager]
  error: git lgbase --more-options died of signal 13
  fatal: While expanding alias 'lg': 'git lgbase --more-options': Success

Many users won't see this, because we execute the external
command with the shell, and a POSIX shell will silently
rewrite the signal-death exit code into 128+signal, and we
will treat it like a normal exit code. However, this does
not always happen:

  1. If the sub-command does not have shell metacharacters,
     we will skip the shell and exec it directly, getting
     the signal code.

  2. Some shells do not do this rewriting; for example,
     setting SHELL_PATH set to zsh will reveal this problem.

This patch squelches the message, and lets git exit silently
(with the same exit code that a shell would use in case of a
signal).

The first line of the message comes from run-command's
wait_or_whine. To silence that message, we remain quiet
anytime we see SIGPIPE.

The second line comes from handle_alias itself. It calls
die_errno whenever run_command returns a negative value.
However, only -1 indicates a syscall error where errno has
something useful (note that it says the useless "success"
above). Instead, we treat negative returns from run_command
(except for -1) as a normal code to be passed to exit.

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c         | 2 +-
 run-command.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 6ed824c..34a18a3 100644
--- a/git.c
+++ b/git.c
@@ -252,7 +252,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			alias_argv[argc] = NULL;
 
 			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
-			if (ret >= 0)   /* normal exit */
+			if (ret != -1)  /* normal exit */
 				exit(ret);
 
 			die_errno("While expanding alias '%s': '%s'",
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
2.7.0.rc2.368.g1cbb535
