From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/2] Fix XML parser leaks in http-push
Date: Tue, 11 Dec 2007 22:19:56 +0100
Message-ID: <1197407997-22945-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 22:20:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2CWe-0002PV-L9
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbXLKVUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbXLKVUB
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:20:01 -0500
Received: from smtp28.orange.fr ([80.12.242.99]:45609 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbXLKVT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:19:59 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2802.orange.fr (SMTP Server) with ESMTP id D3BF48000093
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 22:19:57 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2802.orange.fr (SMTP Server) with ESMTP id 9CB94800009F;
	Tue, 11 Dec 2007 22:19:57 +0100 (CET)
X-ME-UUID: 20071211211957641.9CB94800009F@mwinf2802.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J2CWD-0005yR-3O; Tue, 11 Dec 2007 22:19:57 +0100
X-Mailer: git-send-email 1.5.3.7.1161.g4a58-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67945>

XML_Parser were never freed. While at it, move the parser initialization to
right before it is needed.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-push.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/http-push.c b/http-push.c
index a4a9d1c..f5ba850 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1189,8 +1189,6 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	char *ep;
 	char timeout_header[25];
 	struct remote_lock *lock = NULL;
-	XML_Parser parser = XML_ParserCreate(NULL);
-	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
 
@@ -1250,6 +1248,8 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result == CURLE_OK) {
+			XML_Parser parser = XML_ParserCreate(NULL);
+			enum XML_Status result;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
 			ctx.cdata = NULL;
@@ -1268,6 +1268,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 						XML_GetErrorCode(parser)));
 				lock->timeout = -1;
 			}
+			XML_ParserFree(parser);
 		}
 	} else {
 		fprintf(stderr, "Unable to start LOCK request\n");
@@ -1428,8 +1429,6 @@ static void remote_ls(const char *path, int flags,
 	struct slot_results results;
 	struct strbuf in_buffer = STRBUF_INIT;
 	struct buffer out_buffer = { 0, STRBUF_INIT };
-	XML_Parser parser = XML_ParserCreate(NULL);
-	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
 	struct remote_ls_ctx ls;
@@ -1463,6 +1462,8 @@ static void remote_ls(const char *path, int flags,
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result == CURLE_OK) {
+			XML_Parser parser = XML_ParserCreate(NULL);
+			enum XML_Status result;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
 			ctx.cdata = NULL;
@@ -1481,6 +1482,7 @@ static void remote_ls(const char *path, int flags,
 					XML_ErrorString(
 						XML_GetErrorCode(parser)));
 			}
+			XML_ParserFree(parser);
 		}
 	} else {
 		fprintf(stderr, "Unable to start PROPFIND request\n");
@@ -1512,8 +1514,6 @@ static int locking_available(void)
 	struct slot_results results;
 	struct strbuf in_buffer = STRBUF_INIT;
 	struct buffer out_buffer = { 0, STRBUF_INIT };
-	XML_Parser parser = XML_ParserCreate(NULL);
-	enum XML_Status result;
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
 	int lock_flags = 0;
@@ -1538,6 +1538,8 @@ static int locking_available(void)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result == CURLE_OK) {
+			XML_Parser parser = XML_ParserCreate(NULL);
+			enum XML_Status result;
 			ctx.name = xcalloc(10, 1);
 			ctx.len = 0;
 			ctx.cdata = NULL;
@@ -1556,6 +1558,7 @@ static int locking_available(void)
 						XML_GetErrorCode(parser)));
 				lock_flags = 0;
 			}
+			XML_ParserFree(parser);
 		}
 	} else {
 		fprintf(stderr, "Unable to start PROPFIND request\n");
-- 
1.5.3.7
