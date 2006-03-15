From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Fix broken slot reuse when fetching alternates
Date: Wed, 15 Mar 2006 08:59:52 -0800
Message-ID: <20060315165952.GK3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 15 18:00:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJZLx-00023V-Cy
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 18:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbWCOQ76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 11:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbWCOQ76
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 11:59:58 -0500
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:59402 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1752106AbWCOQ75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 11:59:57 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2FGxqU0026853
	for <git@vger.kernel.org>; Wed, 15 Mar 2006 08:59:53 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2FGxq8i026851
	for git@vger.kernel.org; Wed, 15 Mar 2006 08:59:52 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17612>

When fetching alternates, http-fetch may reuse the slot to fetch non-http
alternates if http-alternates does not exist.  When doing so, it now needs
to update the slot's finished status so run_active_slot waits for the
non-http alternates request to finish.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

e0e27549c5cbc85639f7d329a8a900ca7243130c
diff --git a/http-fetch.c b/http-fetch.c
index 8fd9de0..7de818b 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -468,9 +468,13 @@ static void process_alternates_response(
 					 alt_req->url);
 			active_requests++;
 			slot->in_use = 1;
+			if (slot->finished != NULL)
+				(*slot->finished) = 0;
 			if (!start_active_slot(slot)) {
 				got_alternates = -1;
 				slot->in_use = 0;
+				if (slot->finished != NULL)
+					(*slot->finished) = 1;
 			}
 			return;
 		}
-- 
1.2.4.gea75-dirty
