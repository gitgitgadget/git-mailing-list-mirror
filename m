From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/5] Properly cleanup in http_cleanup so builtin-fetch does not segfault
Date: Sat, 15 Sep 2007 03:23:00 -0400
Message-ID: <20070915072300.GA20346@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 09:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWRzl-0003al-5r
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 09:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbXIOHXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 03:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbXIOHXH
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 03:23:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35933 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbXIOHXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 03:23:06 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWRzY-0006hg-MK; Sat, 15 Sep 2007 03:23:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7691520FBAE; Sat, 15 Sep 2007 03:23:00 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58224>

Junio and I both noticed that the new builtin-fetch was segfaulting
immediately on http/https/ftp style URLs (those that went through
libcurl and the commit walker).  Although the builtin-fetch changes
in this area were really just minor refactorings there was one major
change made: we invoked http_init(), http_cleanup() then http_init()
again in the same process.

When we call curl_easy_cleanup() on each active_request_slot we
are telling libcurl we did not want that buffer to be used again.
Unfortunately we did not also deallocate the active_request_slot
itself nor did we NULL out active_queue_head.  This lead us to
attempt to reuse these cleaned up libcurl handles when we later tried
to invoke http_init() a second time to reactivate the curl library.
The next file get operation then immediately segfaulted on most
versions of libcurl.

Properly freeing our own buffers and clearing the list causes us to
reinitialize the curl buffers again if/when we need to use libcurl
from within this same process.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index a95483b..87ebf7b 100644
--- a/http.c
+++ b/http.c
@@ -276,6 +276,7 @@ void http_cleanup(void)
 #endif
 
 	while (slot != NULL) {
+		struct active_request_slot *next = slot->next;
 #ifdef USE_CURL_MULTI
 		if (slot->in_use) {
 			curl_easy_getinfo(slot->curl,
@@ -287,8 +288,10 @@ void http_cleanup(void)
 #endif
 		if (slot->curl != NULL)
 			curl_easy_cleanup(slot->curl);
-		slot = slot->next;
+		free(slot);
+		slot = next;
 	}
+	active_queue_head = NULL;
 
 #ifndef NO_CURL_EASY_DUPHANDLE
 	curl_easy_cleanup(curl_default);
@@ -300,7 +303,7 @@ void http_cleanup(void)
 	curl_global_cleanup();
 
 	curl_slist_free_all(pragma_header);
-        pragma_header = NULL;
+	pragma_header = NULL;
 }
 
 struct active_request_slot *get_active_slot(void)
-- 
1.5.3.1.84.gaf82-dirty
