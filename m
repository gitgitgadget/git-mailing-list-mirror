From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: [PATCH 2/2] http.c: Use timeout suggested by curl instead of fixed 50ms timeout
Date: Wed,  2 Nov 2011 21:21:28 +0100
Message-ID: <1320265288-12647-3-git-send-email-mika.fischer@zoopnet.de>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
Cc: gitster@pobox.com, daniel@haxx.se,
	Mika Fischer <mika.fischer@zoopnet.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 21:22:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLhKQ-0004YW-NM
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 21:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab1KBUWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 16:22:25 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:35249 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab1KBUWY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 16:22:24 -0400
Received: from localhost.localdomain (ip-109-43-0-1.web.vodafone.de [109.43.0.1])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 93E7126E4300;
	Wed,  2 Nov 2011 21:22:19 +0100 (CET)
X-Mailer: git-send-email 1.7.8.rc0.33.g09c6f.dirty
In-Reply-To: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184666>

Recent versions of curl can suggest a period of time the library user
should sleep and try again, when curl is blocked on reading or writing
(or connecting). Use this timeout instead of always sleeping for 50ms.
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
1.7.8.rc0.33.g09c6f.dirty
