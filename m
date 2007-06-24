From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Check for IO errors after running a command
Date: Sun, 24 Jun 2007 10:29:33 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706241010480.3593@woody.linux-foundation.org>
References: <87abuq1z6f.fsf@rho.meyering.net> <7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 19:30:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Vup-00083s-5h
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 19:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbXFXRaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 13:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbXFXRaV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 13:30:21 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42330 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751438AbXFXRaU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 13:30:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5OHTdPU026727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2007 10:29:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5OHTXHZ018191;
	Sun, 24 Jun 2007 10:29:34 -0700
In-Reply-To: <alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.062 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50806>



This is trying to implement the strict IO error checks that Jim Meyering 
suggested, but explicitly limits it to just regular files. If a pipe gets 
closed on us, we shouldn't complain about it.

[ Side note: feel free to change the S_ISREG() to a !S_ISFIFO(). That 
  would allow easier testing with /dev/full, which tends to be a character 
  special device. That said, I think sockets and pipes are generally 
  interchangeable, which is why I limited it to just regular files. ]

If the subcommand already returned an error, that takes precedence (and we 
assume that the subcommand already printed out any relevant messages 
relating to it)

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Hmm? I'm not saying this is the only way to do this, but I think this is 
at least likely to be obviously just an improvement, and it leaves room 
for further tweaking of the logic if Jim or others find other cases that 
should be handled.

Side note: I think I made a mistake in making the run_command() a NORETURN 
function and putting the exit() into it. It's probably better to instead 
just make it return "int", and make the caller do

	exit(run_command(...));

and that makes it much prettier to have "run_command()" just return early 
if an error happens (or doesn't happen).

For example, then we could just do

	status = p->fn(...);
	if (status)
		return status;
	/* Somebody closed stdout? */
	if (fstat(fileno(stdout), &st))
		return 0;
	/* Ignore write errors for pipes and sockets.. */
	if (S_ISFIFO(st.st_mode) || S_ISSOCK(st.st_mode))
		return 0;

which makes it easy to explain what's going on, and avoids having any deep 
indentation at all.

I dunno. This passes all the tests, but it's not like we currently test 
for ENOSPC/EIO anyway, or even can do that. If we _just_ disable the thing 
for pipes/sockets, we could add a test using /dev/full.

I did check that changing it to !S_ISFIFO() gets the right behaviour, and 
"git log | head" doesn't complain, while "git log > /dev/full" does. So 
this has gotten some very rudimentary testing, but not in the exact form 
I'm actually sending it out.

 git.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 6c728e4..db0118a 100644
--- a/git.c
+++ b/git.c
@@ -224,6 +224,8 @@ struct cmd_struct {
 
 static NORETURN void run_command(struct cmd_struct *p, int argc, const char **argv)
 {
+	int status;
+	struct stat st;
 	const char *prefix;
 
 	prefix = NULL;
@@ -237,7 +239,18 @@ static NORETURN void run_command(struct cmd_struct *p, int argc, const char **ar
 	}
 	trace_argv_printf(argv, argc, "trace: built-in: git");
 
-	exit(p->fn(argc, argv, prefix));
+	status = p->fn(argc, argv, prefix);
+	if (status)
+		exit(status);
+
+	/* Check for ENOSPC and EIO errors.. */
+	if (!fstat(fileno(stdout), &st) && S_ISREG(st.st_mode)) {
+		if (ferror(stdout))
+			die("write failure on standard output");
+		if (fflush(stdout) || fclose(stdout))
+			die("write failure on standard output: %s", strerror(errno));
+	}
+	exit(0);
 }
 
 static void handle_internal_command(int argc, const char **argv)
