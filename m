From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: [PATCH] http.c: Use curl_multi_fdset to select on curl fds instead of just sleeping
Date: Sat, 29 Oct 2011 17:20:21 +0200
Message-ID: <1319901621-482-1-git-send-email-mika.fischer@zoopnet.de>
Cc: Mika Fischer <mika.fischer@zoopnet.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 17:20:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKAiE-0007NG-3o
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 17:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933323Ab1J2PU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Oct 2011 11:20:28 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:42981 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753Ab1J2PU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2011 11:20:28 -0400
Received: from ford.Speedport_W_723V_Typ_A (p5B39E0B3.dip.t-dialin.net [91.57.224.179])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 0497426E42FD;
	Sat, 29 Oct 2011 17:20:25 +0200 (CEST)
X-Mailer: git-send-email 1.7.7.1.489.g1fee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184455>

Previously, when nothing could be read from the connections curl had
open, git would just sleep unconditionally for 50ms. This patch changes
this behavior and instead obtains the recommended timeout and the actual
file descriptors from curl. This should eliminate time spent sleeping when
data could actually be read/written on the socket.

Signed-off-by: Mika Fischer <mika.fischer@zoopnet.de>
---
 http.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index a4bc770..12180f3 100644
--- a/http.c
+++ b/http.c
@@ -649,6 +649,7 @@ void run_active_slot(struct active_request_slot *slot)
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
+	long int curl_timeout;
 	int finished = 0;
 
 	slot->finished = &finished;
@@ -664,14 +665,24 @@ void run_active_slot(struct active_request_slot *slot)
 		}
 
 		if (slot->in_use && !data_received) {
-			max_fd = 0;
+			curl_multi_timeout(curlm, &curl_timeout);
+			if (curl_timeout == 0) {
+				continue;
+			} else if (curl_timeout == -1) {
+				select_timeout.tv_sec  = 0;
+				select_timeout.tv_usec = 50000;
+			} else {
+				select_timeout.tv_sec  =  curl_timeout / 1000;
+				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
+			}
+
+			max_fd = -1;
 			FD_ZERO(&readfds);
 			FD_ZERO(&writefds);
 			FD_ZERO(&excfds);
-			select_timeout.tv_sec = 0;
-			select_timeout.tv_usec = 50000;
-			select(max_fd, &readfds, &writefds,
-			       &excfds, &select_timeout);
+			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
+
+			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
 #else
-- 
1.7.7.1.489.g1fee
