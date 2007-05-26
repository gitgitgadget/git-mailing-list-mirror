From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Sat, 26 May 2007 13:45:42 +0200
Message-ID: <87bqg724gp.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 13:46:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hruin-0007kk-VJ
	for gcvg-git@gmane.org; Sat, 26 May 2007 13:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbXEZLpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 07:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbXEZLpo
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 07:45:44 -0400
Received: from mx.meyering.net ([82.230.74.64]:59513 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbXEZLpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 07:45:43 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 1D2352BC8E; Sat, 26 May 2007 13:45:42 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48469>

Currently, when git-diff writes to a full device or gets an I/O error,
it fails to detect the write error:

    $ git-diff |wc -c
    3984
    $ git-diff > /dev/full && echo ignored write failure
    ignored write failure

git-log does the same thing:

    $ git-log -n1 > /dev/full && echo ignored write failure
    ignored write failure

Each git command should report such a failure.
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

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 29b55a1..a7d6515 100644
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
+		if (0 <= fcntl(fileno (stdout), F_GETFD)
+		    && (ferror(stdout) || fclose(stdout)))
+			die("write failure on standard output: %s",
+			    strerror(errno));
+
+		exit(status);
 	}
 }

--
1.5.2.73.g18bece
