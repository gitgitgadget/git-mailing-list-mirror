From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 5/7] run_command: encode deadly signal number in the return value
Date: Sat,  4 Jul 2009 21:26:41 +0200
Message-ID: <195a33e7de20a4b52df8cb8861998fbbbed0b311.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
 <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org>
 <d63e9230d57698a058c8a550709155e5e3222348.1246734159.git.j6t@kdbg.org>
 <4fe5ad61e7500735d1bbc12c98a863dd3499ea31.1246734159.git.j6t@kdbg.org>
 <ea2d8110ea70b8698bb3674ca4482db64053d841.1246734159.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 21:27:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNAtk-00052P-HS
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 21:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbZGDT1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 15:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbZGDT1d
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 15:27:33 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17683 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbZGDT1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 15:27:31 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7100B10018;
	Sat,  4 Jul 2009 21:27:34 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id EF29842785;
	Sat,  4 Jul 2009 21:27:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
In-Reply-To: <ea2d8110ea70b8698bb3674ca4482db64053d841.1246734159.git.j6t@kdbg.org>
In-Reply-To: <cover.1246734159.git.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122725>

We now write the signal number in the error message if the program
terminated by a signal. The negative return value is constructed such that
after truncation to 8 bits it looks like a POSIX shell's $?:

   $ echo 0000 | { git upload-pack .; echo $? >&2; } | :
   error: git-upload-pack died of signal 13
   141

Previously, the exit code was 255 instead of 141.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 run-command.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index 4b3fda0..146a8ea 100644
--- a/run-command.c
+++ b/run-command.c
@@ -248,7 +248,14 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 	} else if (waiting != pid) {
 		error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
-		error("%s died of signal", argv0);
+		code = WTERMSIG(status);
+		error("%s died of signal %d", argv0, code);
+		/*
+		 * This return value is chosen so that code & 0xff
+		 * mimics the exit code that a POSIX shell would report for
+		 * a program that died from this signal.
+		 */
+		code -= 128;
 	} else if (WIFEXITED(status)) {
 		code = WEXITSTATUS(status);
 		/*
-- 
1.6.3.17.g1665f
