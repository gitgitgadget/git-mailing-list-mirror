From: Jeff King <peff@peff.net>
Subject: [PATCH] run-command: encode signal death as a positive integer
Date: Sat, 5 Jan 2013 09:49:49 -0500
Message-ID: <20130105144949.GA24479@sigill.intra.peff.net>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vsj6gsi7v.fsf@alter.siamese.dyndns.org>
 <20130105140316.GA7272@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Bart Trojanowski <bart@jukie.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 15:50:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrV4k-0000NU-Hb
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 15:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757Ab3AEOty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 09:49:54 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44362 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755729Ab3AEOtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 09:49:52 -0500
Received: (qmail 27527 invoked by uid 107); 5 Jan 2013 14:51:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 Jan 2013 09:51:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2013 09:49:49 -0500
Content-Disposition: inline
In-Reply-To: <20130105140316.GA7272@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212694>

On Sat, Jan 05, 2013 at 09:03:16AM -0500, Jeff King wrote:

> In fact, I really wonder if this code from wait_or_whine is actually
> correct:
> 
>   code = WTERMSIG(status);
>   /*
>    * This return value is chosen so that code & 0xff
>    * mimics the exit code that a POSIX shell would report for
>    * a program that died from this signal.
>    */
>   code -= 128;

After looking at it some more, it is correct, but I think we could make
life slightly easier for callers. See the patch below.  I've tried to
re-state the somewhat rambling argument from my previous email;
hopefully it makes sense.

-- >8 --
Subject: [PATCH] run-command: encode signal death as a positive integer

When a sub-command dies due to a signal, we encode the
signal number into the numeric exit status as "signal -
128". This is easy to identify (versus a regular positive
error code), and when cast to an unsigned integer (e.g., by
feeding it to exit), matches what a POSIX shell would return
when reporting a signal death in $? or through its own exit
code.

So we have a negative value inside the code, but once it
passes across an exit() barrier, it looks positive (and any
code we receive from a sub-shell will have the positive
form). E.g., death by SIGPIPE (signal 13) will look like
-115 to us in inside git, but will end up as 141 when we
call exit() with it. And a program killed by SIGPIPE but run
via the shell will come to us with an exit code of 141.

Unfortunately, this means that when the "use_shell" option
is set, we need to be on the lookout for _both_ forms. We
might or might not have actually invoked the shell (because
we optimize out some useless shell calls). If we didn't invoke
the shell, we will will see the sub-process's signal death
directly, and run-command converts it into a negative value.
But if we did invoke the shell, we will see the shell's
128+signal exit status. To be thorough, we would need to
check both, or cast the value to an unsigned char (after
checking that it is not -1, which is a magic error value).

Fortunately, most callsites do not care at all whether the
exit was from a code or from a signal; they merely check for
a non-zero status, and sometimes propagate the error via
exit(). But for the callers that do care, we can make life
slightly easier by just using the consistent positive form.

This actually fixes two minor bugs:

  1. In launch_editor, we check whether the editor died from
     SIGINT or SIGQUIT. But we checked only the negative
     form, meaning that we would fail to notice a signal
     death exit code which was propagated through the shell.

  2. In handle_alias, we assume that a negative return value
     from run_command means that errno tells us something
     interesting (like a fork failure, or ENOENT).
     Otherwise, we simply propagate the exit code. Negative
     signal death codes confuse us, and we print a useless
     "unable to run alias 'foo': Success" message. By
     encoding signal deaths using the positive form, the
     existing code just propagates it as it would a normal
     non-zero exit code.

The downside is that callers of run_command can no longer
differentiate between a signal received directly by the
sub-process, and one propagated. However, no caller
currently cares, and since we already optimize out some
calls to the shell under the hood, that distinction is not
something that should be relied upon by callers.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-run-command.txt | 6 ++----
 editor.c                                    | 2 +-
 run-command.c                               | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index f18b4f4..5d7d7f2 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -55,10 +55,8 @@ The functions above do the following:
   non-zero.
 
 . If the program terminated due to a signal, then the return value is the
-  signal number - 128, ie. it is negative and so indicates an unusual
-  condition; a diagnostic is printed. This return value can be passed to
-  exit(2), which will report the same code to the parent process that a
-  POSIX shell's $? would report for a program that died from the signal.
+  signal number + 128, ie. the same value that a POSIX shell's $? would
+  report.  A diagnostic is printed.
 
 
 `start_async`::
diff --git a/editor.c b/editor.c
index 065a7ab..27bdecd 100644
--- a/editor.c
+++ b/editor.c
@@ -51,7 +51,7 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
-		sig = ret + 128;
+		sig = ret - 128;
 		sigchain_pop(SIGINT);
 		sigchain_pop(SIGQUIT);
 		if (sig == SIGINT || sig == SIGQUIT)
diff --git a/run-command.c b/run-command.c
index 757f263..cfb7274 100644
--- a/run-command.c
+++ b/run-command.c
@@ -249,7 +249,7 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 		 * mimics the exit code that a POSIX shell would report for
 		 * a program that died from this signal.
 		 */
-		code -= 128;
+		code += 128;
 	} else if (WIFEXITED(status)) {
 		code = WEXITSTATUS(status);
 		/*
-- 
1.8.1.rc1.16.g6d46841
