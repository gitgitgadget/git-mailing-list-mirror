From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Tue, 29 May 2007 22:11:09 +0200
Message-ID: <87veebs84i.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<20070528154630.GA9176@fiberbit.xs4all.nl>
	<87646cx13d.fsf@rho.meyering.net>
	<7v4plwd6f0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 29 22:11:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht82N-00069H-PP
	for gcvg-git@gmane.org; Tue, 29 May 2007 22:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762554AbXE2ULN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 16:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764014AbXE2ULM
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 16:11:12 -0400
Received: from mx.meyering.net ([82.230.74.64]:59267 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762554AbXE2ULL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 16:11:11 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id C12015560F; Tue, 29 May 2007 22:11:09 +0200 (CEST)
In-Reply-To: <7v4plwd6f0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon\, 28 May 2007 13\:44\:51 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48707>

Junio C Hamano <junkio@cox.net> wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> Subject: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
>> ...
...
> I do not think anybody has much objection about the change to
> handle_internal_command() in git.c you made.  Earlier we relied
> on exit(3) to close still open filehandles (while ignoring
> errors), and you made the close explicit in order to detect
> errors.

Hi Junio,

> But "to be consistent" above is not a very good justification.

I know that well, now, especially after all of my fruitless
justification on this list.

> In the presense of shells that give "annoying" behaviour (we
> have to remember that not everybody have enough privilege,
> expertise, or motivation to update /bin/sh or install their own
> copy in $HOME/bin/sh), "EPIPE is different from other errors" is
> a more practical point of view, I'd have to say.  IOW, it is not
> clear if it is a good thing "to be consistent" to begin with.

In case you haven't seen it in the rest of this thread, the version of
bash you use does not change git's EPIPE-handling behavior.  Using stock
bash-3.0 or bash-2.05b, you will get "Broken pipe" messages from some
scripts, but those are from bash, when it delivers the SIGPIPE signal,
and not from any application like git.  The EPIPE-handling behavior can
come into play only when SIGPIPE is *ignored*.

> I would have appreciated if this were two separate patches.  I
> think the EPIPE one is an independent issue.  We could even make
> it a configuration option to ignore EPIPE ;-)

Ok.  Even though I'm still convinced that ignoring EPIPE is no longer
justified, I've hamstrung my patch to do what people here want.

Note that I've also changed it not to print strerror(errno) when the
ferror(stdout) test is triggered.  In that case, errno may well be
irrelevant.  The ugliness of this addition is pretty striking, compared
to what I'm used to.  FWIW, I would have liked to handle closing stdout
here with the same one-liner I use in coreutils: atexit (close_stdout);
but that requires autoconf/automake/gnulib infrastructure.

-----------------------------
From 42e3a6f676e9ae4e9640bc2ff36b7ab0b061a60e Mon Sep 17 00:00:00 2001
From: Jim Meyering <jim@meyering.net>
Date: Sat, 26 May 2007 13:43:07 +0200
Subject: [PATCH] Don't ignore write failure from git-diff, git-log, etc.

Currently, when git-diff writes to a full device or gets an I/O error,
it fails to detect the write error:

    $ git-diff |wc -c
    3984
    $ git-diff > /dev/full && echo ignored write failure
    ignored write failure

git-log does the same thing:

    $ git-log -n1 > /dev/full && echo ignored write failure
    ignored write failure

Each and every git command should report such a failure.
Some already do, but with the patch below, they all do, and we
won't have to rely on code in each command's implementation to
perform the right incantation.

    $ ./git-log -n1 > /dev/full
    fatal: write failure on standard output: No space left on device
    [Exit 128]
    $ ./git-diff > /dev/full
    fatal: write failure on standard output: No space left on device
    [Exit 128]

You can demonstrate this with git's own --version output, too:
(but git --help detects the failure without this patch)

    $ ./git --version > /dev/full
    fatal: write failure on standard output: No space left on device
    [Exit 128]

Note that the fcntl test (for whether the fileno may be closed) is
required in order to avoid EBADF upon closing an already-closed stdout,
as would happen for each git command that already closes stdout; I think
update-index was the one I noticed in the failure of t5400, before I
added that test.

Also, to be consistent with e.g., write_or_die, do not
diagnose EPIPE write failures.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 29b55a1..8258885 100644
--- a/git.c
+++ b/git.c
@@ -308,6 +308,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
 		const char *prefix;
+		int status;
 		if (strcmp(p->cmd, cmd))
 			continue;

@@ -321,7 +322,23 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 			die("%s must be run in a work tree", cmd);
 		trace_argv_printf(argv, argc, "trace: built-in: git");

-		exit(p->fn(argc, argv, prefix));
+		status = p->fn(argc, argv, prefix);
+
+		/* Close stdout if necessary, and diagnose any failure
+		   other than EPIPE.  */
+		if (fcntl(fileno (stdout), F_GETFD) >= 0) {
+			errno = 0;
+			if ((ferror(stdout) || fclose(stdout))
+			    && errno != EPIPE) {
+				if (errno == 0)
+					die("write failure on standard output");
+				else
+					die("write failure on standard output"
+					    ": %s", strerror(errno));
+			}
+		}
+
+		exit(status);
 	}
 }

--
1.5.2.73.g18bece
