From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sat, 19 Jul 2008 19:06:55 +0200
Message-ID: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>
Cc: Fredrik Tolf <fredrik@dolda2000.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 19:32:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKGIQ-0002NI-4v
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 19:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbYGSRbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 13:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754360AbYGSRbj
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 13:31:39 -0400
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:49719 "EHLO
	nerv.dolda2000.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbYGSRbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 13:31:38 -0400
X-Greylist: delayed 1470 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jul 2008 13:31:37 EDT
Received: from nerv.dolda2000.com (fredrik@localhost [127.0.0.1])
	by nerv.dolda2000.com (8.13.8/8.13.8/Debian-3) with ESMTP id m6JH6uKd006973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jul 2008 19:06:56 +0200
Received: (from fredrik@localhost)
	by nerv.dolda2000.com (8.13.8/8.13.8/Submit) id m6JH6te9006972;
	Sat, 19 Jul 2008 19:06:55 +0200
X-Mailer: git-send-email 1.5.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (nerv.dolda2000.com [127.0.0.1]); Sat, 19 Jul 2008 19:06:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89116>

OpenSSH has the nice feature that it sets the IP TOS value of its
connection depending on usage. When used in interactive mode, it
is set to Minimize-Delay, and other wise to Maximize-Throughput. Its
usage by Git is best served by Maximize-Throughput, for obvious
reasons.

However, it seems to use a DWIM heuristic for detecting interactive
mode. The current implementation enters interactive mode if either
a PTY is allocated or X11 forwarding is enabled, and even though Git
SSH:ing does not allocate a PTY, X11 forwarding is often turned on
by default. By removing the DISPLAY env variable before forking, SSH
can thus be forced into non-interactive mode, without any obvious
ill effects.

Signed-off-by: Fredrik Tolf <fredrik@dolda2000.com>
---
 connect.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index 574f42f..54888d3 100644
--- a/connect.c
+++ b/connect.c
@@ -607,6 +607,13 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 			*arg++ = port;
 		}
 		*arg++ = host;
+		/* Remove the X11 DISPLAY from the environment, to
+		 * make SSH run non-interactively */
+		const char *env[] = {
+			"DISPLAY",
+			NULL
+		};
+		conn->env = env;
 	}
 	else {
 		/* remove these from the environment */
-- 
1.5.6.2
