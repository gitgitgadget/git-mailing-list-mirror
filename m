From: pasky@suse.cz
Subject: [PATCH] Fail properly when cloning from invalid HTTP URL
Date: Thu,  7 Aug 2008 02:06:30 +0200
Message-ID: <1218067590-31590-1-git-send-email-pasky@suse.cz>
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Petr Baudis <pasky@suse.cz>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 07 02:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQt2i-0006Y3-Dd
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 02:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbYHGAGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 20:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbYHGAGo
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 20:06:44 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:64441 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752330AbYHGAGn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 20:06:43 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 17FFE89253; Thu,  7 Aug 2008 02:06:30 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.3.392.g292f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91549>

From: Petr Baudis <pasky@suse.cz>

Currently, when cloning from invalid HTTP URL, git clone will possibly
return curl error, then a confusing message about remote HEAD and then
return success and leave an empty repository behind, confusing either
the end-user or the automated service calling it (think repo.or.cz).

This patch changes the error() calls in get_refs_via_curl() to die()s,
akin to the other get_refs_*() functions.

Cc: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Petr Baudis <pasky@suse.cz>
---
 transport.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index 6eb65b8..b88b89b 100644
--- a/transport.c
+++ b/transport.c
@@ -464,16 +464,15 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 		if (results.curl_result != CURLE_OK) {
 			strbuf_release(&buffer);
 			if (missing_target(&results)) {
+				die("%s not found: did you run git update-server-info on the server?", refs_url);
 				return NULL;
 			} else {
-				error("%s", curl_errorstr);
-				return NULL;
+				die("%s download error - %s", refs_url, curl_errorstr);
 			}
 		}
 	} else {
 		strbuf_release(&buffer);
-		error("Unable to start request");
-		return NULL;
+		die("Unable to start HTTP request");
 	}
 
 	data = buffer.buf;
-- 
1.5.6.3.392.g292f1
