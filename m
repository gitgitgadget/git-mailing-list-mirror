From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] pager: do not fork a pager if environment variable
 PAGER is set to NONE
Date: Sun, 16 Apr 2006 04:44:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604160438370.32484@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604151516150.6563@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwtdqef6u.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0604160357460.31461@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4q0udzwg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 04:44:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUxFe-0004xR-Cs
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 04:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWDPCo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 22:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWDPCo1
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 22:44:27 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:65475 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932172AbWDPCo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 22:44:27 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id C0FDB1FA9;
	Sun, 16 Apr 2006 04:44:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id B55251FA8;
	Sun, 16 Apr 2006 04:44:25 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 95E391F9C;
	Sun, 16 Apr 2006 04:44:25 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q0udzwg.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18774>

Hi,

On Sat, 15 Apr 2006, Junio C Hamano wrote:

> A somewhat related topic; I often set PAGER=cat when I do not
> want the --[More]-- prompt and I thing many Emacs users do this.
> It might also be good to detect it and omit piping in such a
> case, but that is independent, so if you are going to do this as
> well, please make it a separate patch.

I was not quite sure if PAGER=cat could be taken as "user does not want 
any pager to be fork()ed", but you are probably right: PAGER=cat means 
that stdout is forwarded to stdout, i.e. we are better off not fork()ing 
and calling "cat":

---
[PATCH] pager: do not fork a pager if PAGER=cat

This helps debugging tremendously.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 pager.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

4a617a436bba9288cec5d3918d02c5b0e652df98
diff --git a/pager.c b/pager.c
index 1364e15..86e93b3 100644
--- a/pager.c
+++ b/pager.c
@@ -5,9 +5,8 @@ #include "cache.h"
  * something different on Windows, for example.
  */
 
-static void run_pager(void)
+static void run_pager(const char *prog)
 {
-	const char *prog = getenv("PAGER");
 	if (!prog)
 		prog = "less";
 	setenv("LESS", "-S", 0);
@@ -16,10 +15,11 @@ static void run_pager(void)
 
 void setup_pager(void)
 {
+	const char *prog = getenv("PAGER");
 	pid_t pid;
 	int fd[2];
 
-	if (!isatty(1))
+	if (!isatty(1) || (prog != NULL && !strcmp(prog, "cat")))
 		return;
 	if (pipe(fd) < 0)
 		return;
@@ -43,6 +43,6 @@ void setup_pager(void)
 	close(fd[0]);
 	close(fd[1]);
 
-	run_pager();
+	run_pager(prog);
 	exit(255);
 }
-- 
1.3.0.rc4.gb6b20-dirty
