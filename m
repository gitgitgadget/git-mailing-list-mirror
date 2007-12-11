From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/2 for master] Fix XML parser leaks in http-push
Date: Tue, 11 Dec 2007 23:50:21 +0100
Message-ID: <1197413421-4759-1-git-send-email-mh@glandium.org>
References: <7v4peodfkb.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:53:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2DyI-0001O9-Md
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 23:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911AbXLKWu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 17:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756250AbXLKWu1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 17:50:27 -0500
Received: from smtp28.orange.fr ([80.12.242.101]:29548 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758144AbXLKWuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 17:50:24 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2821.orange.fr (SMTP Server) with ESMTP id 7FFF87000095
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 23:50:22 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2821.orange.fr (SMTP Server) with ESMTP id 4C5A87000090;
	Tue, 11 Dec 2007 23:50:22 +0100 (CET)
X-ME-UUID: 20071211225022312.4C5A87000090@mwinf2821.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J2Dvh-0001FA-It; Tue, 11 Dec 2007 23:50:21 +0100
X-Mailer: git-send-email 1.5.3.7.1164.ga23bb-dirty
In-Reply-To: <7v4peodfkb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67963>

XML_Parser were never freed. While at it, move the parser initialization to
right before it is needed.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 Same, on top of master.

 http-push.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/http-push.c b/http-push.c
index 78283b4..fffbe9c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1275,8 +1275,6 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	char *ep;
 	char timeout_header[25];
 	struct remote_lock *lock = NULL;
-	XML_Parser parser = XML_ParserCreate(NULL);
-	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
 
@@ -1345,6 +1343,8 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result == CURLE_OK) {
+			XML_Parser parser = XML_ParserCreate(NULL);
+			enum XML_Status result;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
 			ctx.cdata = NULL;
@@ -1363,6 +1363,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 						XML_GetErrorCode(parser)));
 				lock->timeout = -1;
 			}
+			XML_ParserFree(parser);
 		}
 	} else {
 		fprintf(stderr, "Unable to start LOCK request\n");
@@ -1525,8 +1526,6 @@ static void remote_ls(const char *path, int flags,
 	struct buffer out_buffer;
 	char *in_data;
 	char *out_data;
-	XML_Parser parser = XML_ParserCreate(NULL);
-	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
 	struct remote_ls_ctx ls;
@@ -1569,6 +1568,8 @@ static void remote_ls(const char *path, int flags,
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result == CURLE_OK) {
+			XML_Parser parser = XML_ParserCreate(NULL);
+			enum XML_Status result;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
 			ctx.cdata = NULL;
@@ -1587,6 +1588,7 @@ static void remote_ls(const char *path, int flags,
 					XML_ErrorString(
 						XML_GetErrorCode(parser)));
 			}
+			XML_ParserFree(parser);
 		}
 	} else {
 		fprintf(stderr, "Unable to start PROPFIND request\n");
@@ -1620,8 +1622,6 @@ static int locking_available(void)
 	struct buffer out_buffer;
 	char *in_data;
 	char *out_data;
-	XML_Parser parser = XML_ParserCreate(NULL);
-	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
 	int lock_flags = 0;
@@ -1658,6 +1658,8 @@ static int locking_available(void)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result == CURLE_OK) {
+			XML_Parser parser = XML_ParserCreate(NULL);
+			enum XML_Status result;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
 			ctx.cdata = NULL;
@@ -1676,6 +1678,7 @@ static int locking_available(void)
 						XML_GetErrorCode(parser)));
 				lock_flags = 0;
 			}
+			XML_ParserFree(parser);
 		}
 	} else {
 		fprintf(stderr, "Unable to start PROPFIND request\n");
-- 
1.5.3.7.1164.ga23bb-dirty
