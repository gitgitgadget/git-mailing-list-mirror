From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 1/2] daemon: send more error messages to the syslog
Date: Mon, 25 Feb 2008 14:25:20 +0100
Message-ID: <47C2C1C0.5070903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 14:26:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTdLH-0008G2-JH
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 14:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbYBYNZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 08:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbYBYNZ0
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 08:25:26 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29199 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbYBYNZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 08:25:25 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JTdK3-0006C5-OI; Mon, 25 Feb 2008 14:24:47 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4492D4E4; Mon, 25 Feb 2008 14:25:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75026>

There were a number of die() calls before the syslog was opened; hence,
these error messages would have been sent to /dev/null in detached mode.
Now we install the daemon-specific die routine before any error message is
generated so that these messages go to the syslog.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 daemon.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/daemon.c b/daemon.c
index 41a60af..dd0177f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1149,6 +1149,11 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}

+	if (log_syslog) {
+		openlog("git-daemon", 0, LOG_DAEMON);
+		set_die_routine(daemon_die);
+	}
+
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");

@@ -1176,11 +1181,6 @@ int main(int argc, char **argv)
 		}
 	}

-	if (log_syslog) {
-		openlog("git-daemon", 0, LOG_DAEMON);
-		set_die_routine(daemon_die);
-	}
-
 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");

-- 
1.5.4.3.229.g5c72
