From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 2/2] run-command: dup_devnull(): guard against syscalls failing
Date: Fri, 12 Jul 2013 10:58:36 +0200
Message-ID: <0f1e919ab5886d00d6956499cf5ed3e064033f11.1373618940.git.trast@inf.ethz.ch>
References: <cover.1373618940.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Dale R. Worley" <worley@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 12 10:59:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxZBv-0003YV-04
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 10:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497Ab3GLI6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 04:58:50 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:23325 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757503Ab3GLI6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 04:58:42 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Jul
 2013 10:58:36 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Jul
 2013 10:58:37 +0200
X-Mailer: git-send-email 1.8.3.2.998.g1d087bc
In-Reply-To: <cover.1373618940.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230188>

dup_devnull() did not check the return values of open() and dup2().
Fix this omission.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 run-command.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index aece872..1b7f88e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -76,7 +76,10 @@ static inline void close_pair(int fd[2])
 static inline void dup_devnull(int to)
 {
 	int fd = open("/dev/null", O_RDWR);
-	dup2(fd, to);
+	if (fd < 0)
+		die_errno(_("open /dev/null failed"));
+	if (dup2(fd, to) < 0)
+		die_errno(_("dup2(%d,%d) failed"), fd, to);
 	close(fd);
 }
 #endif
-- 
1.8.3.2.998.g1d087bc
