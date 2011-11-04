From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: [PATCH v3 2/3] http.c: Use timeout suggested by curl instead of fixed 50ms timeout
Date: Fri,  4 Nov 2011 15:19:26 +0100
Message-ID: <1320416367-28843-3-git-send-email-mika.fischer@zoopnet.de>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
Cc: gitster@pobox.com, daniel@haxx.se, peff@peff.net,
	Mika Fischer <mika.fischer@zoopnet.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 15:20:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMKd4-0005K4-Lv
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 15:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519Ab1KDOUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 10:20:06 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:44618 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab1KDOUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 10:20:04 -0400
Received: from localhost.localdomain (krlh-5f71f726.pool.mediaWays.net [95.113.247.38])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id E3166249C2BE;
	Fri,  4 Nov 2011 15:20:02 +0100 (CET)
X-Mailer: git-send-email 1.7.8.rc0.35.gd9f16.dirty
In-Reply-To: <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184771>

Recent versions of curl can suggest a period of time the library user
should sleep and try again, when curl is blocked on reading or writing
(or connecting). Use this timeout instead of always sleeping for 50ms.

Signed-off-by: Mika Fischer <mika.fischer@zoopnet.de>
---
 http.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index ae92318..e91a2ab 100644
--- a/http.c
+++ b/http.c
@@ -649,6 +649,9 @@ void run_active_slot(struct active_request_slot *slot)
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
+#if LIBCURL_VERSION_NUM >= 0x070f04
+	long curl_timeout;
+#endif
 	int finished = 0;
 
 	slot->finished = &finished;
@@ -664,13 +667,28 @@ void run_active_slot(struct active_request_slot *slot)
 		}
 
 		if (slot->in_use && !data_received) {
+#if LIBCURL_VERSION_NUM >= 0x070f04
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
+#else
+			select_timeout.tv_sec  = 0;
+			select_timeout.tv_usec = 50000;
+#endif
+
 			max_fd = -1;
 			FD_ZERO(&readfds);
 			FD_ZERO(&writefds);
 			FD_ZERO(&excfds);
 			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
-			select_timeout.tv_sec = 0;
-			select_timeout.tv_usec = 50000;
+
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
-- 
1.7.8.rc0.35.gd9f16.dirty
