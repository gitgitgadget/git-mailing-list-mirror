From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Mon, 28 May 2007 20:19:34 +0200
Message-ID: <87646cx13d.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<20070528154630.GA9176@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon May 28 20:19:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsjom-0003vJ-EL
	for gcvg-git@gmane.org; Mon, 28 May 2007 20:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbXE1STg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 14:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbXE1STg
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 14:19:36 -0400
Received: from mx.meyering.net ([82.230.74.64]:41658 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbXE1STf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 14:19:35 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 0C1422CAB7; Mon, 28 May 2007 20:19:34 +0200 (CEST)
In-Reply-To: <20070528154630.GA9176@fiberbit.xs4all.nl> (Marco Roeland's message of "Mon\, 28 May 2007 17\:46\:30 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48633>

Marco Roeland <marco.roeland@xs4all.nl> wrote:
> The if statement with 'fcntl' is missing a brace, it should be:
>
> +		if ((fcntl(fileno (stdout), F_GETFD) >= 0)
> +		    && (ferror(stdout) || fclose(stdout)))

Thank you.
That was a stale patch (from before I compiled/tested, obviously).
I intended this:

		if (fcntl(fileno (stdout), F_GETFD) >= 0
		    && (ferror(stdout) || fclose(stdout)))

Here's the correct one:

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

Also, to be consistent, don't ignore EPIPE write failures.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git.c             |   11 ++++++++++-
 merge-recursive.c |    3 ---
 write_or_die.c    |    4 ----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/git.c b/git.c
index 29b55a1..7b45a73 100644
--- a/git.c
+++ b/git.c
@@ -308,6 +308,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
 		const char *prefix;
+		int status;
 		if (strcmp(p->cmd, cmd))
 			continue;

@@ -321,7 +322,15 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 			die("%s must be run in a work tree", cmd);
 		trace_argv_printf(argv, argc, "trace: built-in: git");

-		exit(p->fn(argc, argv, prefix));
+		status = p->fn(argc, argv, prefix);
+
+		/* Close stdout if necessary, and diagnose any failure.  */
+		if (fcntl(fileno (stdout), F_GETFD) >= 0
+		    && (ferror(stdout) || fclose(stdout)))
+			die("write failure on standard output: %s",
+			    strerror(errno));
+
+		exit(status);
 	}
 }

diff --git a/merge-recursive.c b/merge-recursive.c
index 8f72b2c..bfa4335 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -523,9 +523,6 @@ static void flush_buffer(int fd, const char *buf, unsigned long size)
 	while (size > 0) {
 		long ret = write_in_full(fd, buf, size);
 		if (ret < 0) {
-			/* Ignore epipe */
-			if (errno == EPIPE)
-				break;
 			die("merge-recursive: %s", strerror(errno));
 		} else if (!ret) {
 			die("merge-recursive: disk full?");
diff --git a/write_or_die.c b/write_or_die.c
index 5c4bc85..fadfcaa 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -41,8 +41,6 @@ int write_in_full(int fd, const void *buf, size_t count)
 void write_or_die(int fd, const void *buf, size_t count)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		if (errno == EPIPE)
-			exit(0);
 		die("write error (%s)", strerror(errno));
 	}
 }
@@ -50,8 +48,6 @@ void write_or_die(int fd, const void *buf, size_t count)
 int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		if (errno == EPIPE)
-			exit(0);
 		fprintf(stderr, "%s: write error (%s)\n",
 			msg, strerror(errno));
 		return 0;
