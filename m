From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 2.1/5] daemon: if one of the standard fds is missing open it to /dev/null
Date: Thu, 13 Jul 2006 18:32:11 +0200
Message-ID: <E1G146l-0006jI-G8@moooo.ath.cx>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx> <E1G0znB-0002IO-61@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 13 18:32:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G146r-0000se-Kk
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 18:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWGMQcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 12:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWGMQcO
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 12:32:14 -0400
Received: from moooo.ath.cx ([85.116.203.178]:25277 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1030194AbWGMQcN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 12:32:13 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E1G0znB-0002IO-61@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23842>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
fixed sanitize_stdfds
---
 daemon.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index a7636bc..01ccda3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -662,6 +662,18 @@ static int service_loop(int socknum, int
 	}
 }
 
+/* if any standard file descriptor is missing open it to /dev/null */
+static void sanitize_stdfds(void)
+{
+	int fd = open("/dev/null", O_RDWR, 0);
+	while (fd != -1 && fd < 2)
+		fd = dup(fd);
+	if (fd == -1)
+		die("open /dev/null or dup failed: %s", strerror(errno));
+	if (fd > 2)
+		close(fd);
+}
+
 static int serve(int port)
 {
 	int socknum, *socklist;
@@ -773,5 +785,7 @@ int main(int argc, char **argv)
 		return execute(peer);
 	}
 
+	sanitize_stdfds();
+
 	return serve(port);
 }
-- 
1.4.1.g8b4b
