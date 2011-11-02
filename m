From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: [PATCH 1/2] http.c: Use curl_multi_fdset to select on curl fds instead of just sleeping
Date: Wed,  2 Nov 2011 21:21:27 +0100
Message-ID: <1320265288-12647-2-git-send-email-mika.fischer@zoopnet.de>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
Cc: gitster@pobox.com, daniel@haxx.se,
	Mika Fischer <mika.fischer@zoopnet.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 21:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLhKK-0004VX-WD
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 21:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461Ab1KBUWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 16:22:20 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:35245 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab1KBUWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 16:22:20 -0400
Received: from localhost.localdomain (ip-109-43-0-1.web.vodafone.de [109.43.0.1])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 8DC4026E42FD;
	Wed,  2 Nov 2011 21:22:06 +0100 (CET)
X-Mailer: git-send-email 1.7.8.rc0.33.g09c6f.dirty
In-Reply-To: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184665>

Instead of sleeping unconditionally for a 50ms, when no data can be read
from the http connection(s), use curl_multi_fdset to obtain the actual
file descriptors of the open connections and use them in the select call.
This way, the 50ms sleep is interrupted when new data arrives.
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
1.7.8.rc0.33.g09c6f.dirty
