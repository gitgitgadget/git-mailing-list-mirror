From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH 2/2] Check for IO errors after running a command
Date: Mon, 25 Jun 2007 21:54:54 +0200
Message-ID: <871wfzvmgh.fsf@rho.meyering.net>
References: <87abuq1z6f.fsf@rho.meyering.net>
	<7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
	<alpine.LFD.0.98.0706241010480.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 21:54:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ueI-0001Zt-5i
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 21:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbXFYTy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 15:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbXFYTy4
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 15:54:56 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:35328 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885AbXFYTy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 15:54:56 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id F23675A2D2
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 21:54:54 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id BF45D2BBF7; Mon, 25 Jun 2007 21:54:54 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0706241010480.3593@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 24 Jun 2007 10\:29\:33 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50917>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> This is trying to implement the strict IO error checks that Jim Meyering
> suggested, but explicitly limits it to just regular files. If a pipe gets
> closed on us, we shouldn't complain about it.
...
> Hmm? I'm not saying this is the only way to do this, but I think this is
> at least likely to be obviously just an improvement, and it leaves room
> for further tweaking of the logic if Jim or others find other cases that
> should be handled.
...
> +	/* Check for ENOSPC and EIO errors.. */
> +	if (!fstat(fileno(stdout), &st) && S_ISREG(st.st_mode)) {
> +		if (ferror(stdout))
> +			die("write failure on standard output");
> +		if (fflush(stdout) || fclose(stdout))
> +			die("write failure on standard output: %s", strerror(errno));
> +	}
> +	exit(0);

Here is a patch relative to "next", to restore some of the
functionality that was provided by my initially-proposed change.

>From 379aee16596d29b83c95068964c349399b9b9f47 Mon Sep 17 00:00:00 2001
From: Jim Meyering <jim@meyering.net>
Date: Mon, 25 Jun 2007 18:54:12 +0200
Subject: [PATCH] When detecting write failure, print strerror when possible.

Do not call "die" solely on the basis of ferror.
Instead, call both ferror and fclose, and *then* decide whether/how to die.

Without this patch, some commands unnecessarily omit strerror(errno)
when they fail:

    $ ./git-ls-tree HEAD > /dev/full
    fatal: write failure on standard output

With the patch, git reports the desired ENOSPC diagnostic:

    fatal: write failure on standard output: No space left on device

FWIW, this version of close_stream is similar to the one
I included in another recent patch, but, is slightly cleaner.
Also, rather than returning zero or EOF, this one simply returns
zero or nonzero.

* git.c (close_stream): New function.
(run_command): Don't die solely because of ferror.  Use close_stream.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index b949cbb..b00bb1c 100644
--- a/git.c
+++ b/git.c
@@ -246,6 +246,21 @@ struct cmd_struct {
 	int option;
 };

+static int
+close_stream(FILE *stream)
+{
+	int prev_fail = ferror(stream);
+	int fclose_fail = fclose(stream);
+
+	/* If there was a previous failure, but fclose succeeded,
+	   clear errno, since ferror does not set it, and its value
+	   may be unrelated to the ferror-reported failure.  */
+	if (prev_fail && !fclose_fail)
+		errno = 0;
+
+	return prev_fail || fclose_fail;
+}
+
 static int run_command(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status;
@@ -274,10 +289,13 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 		return 0;

 	/* Check for ENOSPC and EIO errors.. */
-	if (ferror(stdout))
-		die("write failure on standard output");
-	if (fflush(stdout) || fclose(stdout))
-		die("write failure on standard output: %s", strerror(errno));
+	if (close_stream(stdout)) {
+		if (errno == 0)
+			die("write failure on standard output");
+		else
+			die("write failure on standard output: %s",
+			    strerror(errno));
+	}

 	return 0;
 }
