From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH] pager: do not fork a pager if environment variable PAGER
 is set to NONE
Date: Sat, 15 Apr 2006 15:16:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604151516150.6563@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 15 15:16:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUkdp-0007tJ-UH
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 15:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWDONQi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 09:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWDONQi
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 09:16:38 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6117 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030239AbWDONQh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 09:16:37 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 4BEF3BBD
	for <git@vger.kernel.org>; Sat, 15 Apr 2006 15:16:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 401D3BB3
	for <git@vger.kernel.org>; Sat, 15 Apr 2006 15:16:36 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 234B2B69
	for <git@vger.kernel.org>; Sat, 15 Apr 2006 15:16:36 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18749>


This helps debugging tremendously.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 pager.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

a91a9371e117555a03cfe7d24515787fb13005b6
diff --git a/pager.c b/pager.c
index 1364e15..1136adf 100644
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
+	if (!isatty(1) || (prog != NULL && !strcmp(prog, "NONE")))
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
1.3.0.rc4.g667c
