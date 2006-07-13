From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 2/5] daemon: if one of the standard fds is missing open it to /dev/null
Date: Thu, 13 Jul 2006 12:10:51 +0200
Message-ID: <E1G0znB-0002IO-61@moooo.ath.cx>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 13 13:55:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0znH-0007Iu-EZ
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 13:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWGMLzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 07:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWGMLzn
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 07:55:43 -0400
Received: from moooo.ath.cx ([85.116.203.178]:15065 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932506AbWGMLzm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 07:55:42 -0400
To: git@vger.kernel.org
In-Reply-To: <E1G0zj7-0001c1-8q@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23830>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 daemon.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index a7636bc..e6b1730 100644
--- a/daemon.c
+++ b/daemon.c
@@ -662,6 +662,24 @@ static int service_loop(int socknum, int
 	}
 }
 
+/* if any standard file descriptor is missing open it to /dev/null */
+static void sanitize_stdfds(void)
+{
+	int devnull = -1, i;
+	struct stat buf;
+	for (i = 0; i < 3; ++i) {
+		if (fstat(i, &buf) != -1)
+			continue;
+		if (devnull == -1 &&
+			(devnull = open("/dev/null", O_RDWR, 0)) == -1)
+			die("open /dev/null failed: %s", strerror(errno));
+		if (dup2(devnull, i) != i)
+			die("dup2 failed: %s", strerror(errno));
+	}
+	if (devnull != -1)
+		close(devnull);
+}
+
 static int serve(int port)
 {
 	int socknum, *socklist;
@@ -773,5 +791,7 @@ int main(int argc, char **argv)
 		return execute(peer);
 	}
 
+	sanitize_stdfds();
+
 	return serve(port);
 }
-- 
1.4.1.gb16f
