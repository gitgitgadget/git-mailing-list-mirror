From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 3/5] Improve pack list response handling
Date: Fri, 18 Nov 2005 11:03:11 -0800
Message-ID: <20051118190311.GH3968@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 18 20:03:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdBW1-0006dG-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 20:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbVKRTDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 14:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKRTDO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 14:03:14 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:8021 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750776AbVKRTDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 14:03:12 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAIJ3BFP026728
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 11:03:11 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAIJ3Bru026726
	for git@vger.kernel.org; Fri, 18 Nov 2005 11:03:11 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12245>

Better response handling for pack list requests - a 404 means we do have
the list but it happens to be empty.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

applies-to: 8e27b8361908dda4ea5955f5ffe332b8cf09c0ec
20223d677b9d7291080acae9f9943aee90ee12ca
diff --git a/http-fetch.c b/http-fetch.c
index 53a7dbf..4353173 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -637,10 +637,18 @@ static int fetch_indices(struct alt_base
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (slot->curl_result != CURLE_OK) {
-			free(buffer.buffer);
-			return error("%s", curl_errorstr);
+			if (slot->http_code == 404) {
+				repo->got_indices = 1;
+				free(buffer.buffer);
+				return 0;
+			} else {
+				repo->got_indices = 0;
+				free(buffer.buffer);
+				return error("%s", curl_errorstr);
+			}
 		}
 	} else {
+		repo->got_indices = 0;
 		free(buffer.buffer);
 		return error("Unable to start request");
 	}
---
0.99.9.GIT
