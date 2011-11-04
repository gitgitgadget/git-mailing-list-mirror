From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: [PATCH v3 1/3] http.c: Use curl_multi_fdset to select on curl fds instead of just sleeping
Date: Fri,  4 Nov 2011 15:19:25 +0100
Message-ID: <1320416367-28843-2-git-send-email-mika.fischer@zoopnet.de>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
Cc: gitster@pobox.com, daniel@haxx.se, peff@peff.net,
	Mika Fischer <mika.fischer@zoopnet.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 15:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMKd3-0005K4-1P
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 15:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab1KDOUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 10:20:05 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:44612 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab1KDOUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 10:20:04 -0400
Received: from localhost.localdomain (krlh-5f71f726.pool.mediaWays.net [95.113.247.38])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 8F06A249C2BC;
	Fri,  4 Nov 2011 15:20:02 +0100 (CET)
X-Mailer: git-send-email 1.7.8.rc0.35.gd9f16.dirty
In-Reply-To: <1320416367-28843-1-git-send-email-mika.fischer@zoopnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184769>

Instead of sleeping unconditionally for a 50ms, when no data can be read
from the http connection(s), use curl_multi_fdset to obtain the actual
file descriptors of the open connections and use them in the select call.
This way, the 50ms sleep is interrupted when new data arrives.

Signed-off-by: Mika Fischer <mika.fischer@zoopnet.de>
---
 http.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index a4bc770..ae92318 100644
--- a/http.c
+++ b/http.c
@@ -664,14 +664,14 @@ void run_active_slot(struct active_request_slot *slot)
 		}
 
 		if (slot->in_use && !data_received) {
-			max_fd = 0;
+			max_fd = -1;
 			FD_ZERO(&readfds);
 			FD_ZERO(&writefds);
 			FD_ZERO(&excfds);
+			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
 			select_timeout.tv_sec = 0;
 			select_timeout.tv_usec = 50000;
-			select(max_fd, &readfds, &writefds,
-			       &excfds, &select_timeout);
+			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
 #else
-- 
1.7.8.rc0.35.gd9f16.dirty
