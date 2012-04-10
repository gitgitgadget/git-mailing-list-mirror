From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] test-subprocess: fix segfault without arguments
Date: Tue, 10 Apr 2012 21:07:34 +0200
Message-ID: <4F8484F6.8000206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 21:07:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHgPm-0006c9-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 21:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759023Ab2DJTHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 15:07:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:34926 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758983Ab2DJTHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 15:07:37 -0400
Received: from [192.168.2.105] (p4FFD8505.dip.t-dialin.net [79.253.133.5])
	by india601.server4you.de (Postfix) with ESMTPSA id 743F32F806E;
	Tue, 10 Apr 2012 21:07:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195121>

Check if we even have a parameter before checking its value.  Running
this command without any arguments may not make a lot of sense, but
reacting with a segmentation fault is unduly harsh.

While we're at it, avoid casting argv by declaring it const right away.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 test-subprocess.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test-subprocess.c b/test-subprocess.c
index 8926bc5..f2d4c0d 100644
--- a/test-subprocess.c
+++ b/test-subprocess.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
 	struct child_process cp;
 	int nogit = 0;
@@ -9,12 +9,12 @@ int main(int argc, char **argv)
 	setup_git_directory_gently(&nogit);
 	if (nogit)
 		die("No git repo found");
-	if (!strcmp(argv[1], "--setup-work-tree")) {
+	if (argc > 1 && !strcmp(argv[1], "--setup-work-tree")) {
 		setup_work_tree();
 		argv++;
 	}
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
-	cp.argv = (const char **)argv+1;
+	cp.argv = argv + 1;
 	return run_command(&cp);
 }
-- 
1.7.10
