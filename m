From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Fri, 4 Jan 2013 07:47:56 -0500
Message-ID: <20130104124756.GA402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bart Trojanowski <bart@jukie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 13:48:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tr6hj-00027m-EW
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 13:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab3ADMsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 07:48:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42845 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469Ab3ADMsI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 07:48:08 -0500
Received: (qmail 17864 invoked by uid 107); 4 Jan 2013 12:49:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Jan 2013 07:49:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2013 07:47:56 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212630>

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

This patch squelches the message, and let's git exit
silently (with the same exit code that a shell would use in
case of a signal).

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
I have two reservations with this patch:

  1. We are ignoring SIGPIPE all the time. For an alias that is calling
     "log", that is fine. But if pack-objects dies on the server side,
     seeing that it died from SIGPIPE is useful data, and we are
     squelching that. Maybe callers of run-command should have to pass
     an "ignore SIGPIPE" flag?

  2. The die_errno in handle_alias is definitely wrong. Even if we want
     to print a message for signal death, showing errno is bogus unless
     the return value was -1. But is it the right thing to just pass the
     negative value straight to exit()? It works, but it is depending on
     the fact that (unsigned char)(ret & 0xff) behaves in a certain way
     (i.e., that we are on a twos-complement platform, and -13 becomes
     141). That is not strictly portable, but it is probably fine in
     practice. I'd worry more about exit() doing something weird on
     Windows.

 git.c         | 2 +-
 run-command.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index d33f9b3..07edb8a 100644
--- a/git.c
+++ b/git.c
@@ -175,7 +175,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			alias_argv[argc] = NULL;
 
 			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
-			if (ret >= 0)   /* normal exit */
+			if (ret != -1)  /* normal exit */
 				exit(ret);
 
 			die_errno("While expanding alias '%s': '%s'",
diff --git a/run-command.c b/run-command.c
index 757f263..01a4c9b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -242,7 +242,7 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 		error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
 		code = WTERMSIG(status);
-		if (code != SIGINT && code != SIGQUIT)
+		if (code != SIGINT && code != SIGQUIT && code != SIGPIPE)
 			error("%s died of signal %d", argv0, code);
 		/*
 		 * This return value is chosen so that code & 0xff
-- 
1.8.1.rc1.16.g6d46841
