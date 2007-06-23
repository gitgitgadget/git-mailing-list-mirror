From: Jim Meyering <jim@meyering.net>
Subject: (resend) [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Sat, 23 Jun 2007 17:13:44 +0200
Message-ID: <87abuq1z6f.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 17:14:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I27K7-00073d-9a
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 17:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758233AbXFWPOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758216AbXFWPOu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 11:14:50 -0400
Received: from postfix1-g20.free.fr ([212.27.60.42]:39863 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758129AbXFWPOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 11:14:49 -0400
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 3072C134D443
	for <git@vger.kernel.org>; Sat, 23 Jun 2007 17:14:45 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 89F385A1E5
	for <git@vger.kernel.org>; Sat, 23 Jun 2007 17:13:44 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 4F76E34611; Sat, 23 Jun 2007 17:13:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50742>

Hi Jun,

Here's a copy of my patch, from here:
http://thread.gmane.org/gmane.comp.version-control.git/48469/focus=48636

Jim

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
