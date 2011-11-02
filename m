From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: [PATCH] http.c: Use curl_multi_fdset to select on curl fds instead of just sleeping
Date: Wed,  2 Nov 2011 11:45:34 +0100
Message-ID: <1320230734-5933-1-git-send-email-mika.fischer@zoopnet.de>
Cc: Mika Fischer <mika.fischer@zoopnet.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 11:45:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLYKH-0003JT-Cr
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 11:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab1KBKpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 06:45:40 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:37619 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab1KBKpk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 06:45:40 -0400
Received: from localhost.localdomain (pD9E9BFF2.dip.t-dialin.net [217.233.191.242])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 16ED426E42FD;
	Wed,  2 Nov 2011 11:45:39 +0100 (CET)
X-Mailer: git-send-email 1.7.7.1.489.g1fee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184626>

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
