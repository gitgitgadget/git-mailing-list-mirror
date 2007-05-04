From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] http.h: make fill_active_slots a function pointer
Date: Fri,  4 May 2007 12:49:25 +0200
Message-ID: <11782757672551-git-send-email-skimo@liacs.nl>
References: <11782757671754-git-send-email-skimo@liacs.nl>
Cc: Sven Verdoolaege <skimo@liacs.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 13:29:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjvz3-0003fl-Rz
	for gcvg-git@gmane.org; Fri, 04 May 2007 13:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbXEDL3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 07:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754986AbXEDL3j
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 07:29:39 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:42111 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754089AbXEDL3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 07:29:38 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l44AnSA5026168;
	Fri, 4 May 2007 12:49:33 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id E7AB03C010; Fri,  4 May 2007 12:49:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11782757671754-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46168>

From: Sven Verdoolaege <skimo@kotnet.org>

This allows us to use the methods provided by http.c
from within libgit, in particular config.c.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 http-fetch.c |    5 ++++-
 http-push.c  |    5 ++++-
 http.h       |    2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 09baedc..53fb2a9 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -317,7 +317,7 @@ static void release_object_request(struct object_request *obj_req)
 }
 
 #ifdef USE_CURL_MULTI
-void fill_active_slots(void)
+static void fetch_fill_active_slots(void)
 {
 	struct object_request *obj_req = object_queue_head;
 	struct active_request_slot *slot = active_queue_head;
@@ -1031,6 +1031,9 @@ int main(int argc, const char **argv)
 	}
 	url = argv[arg];
 
+#ifdef USE_CURL_MULTI
+	fill_active_slots = fetch_fill_active_slots;
+#endif
 	http_init();
 
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
diff --git a/http-push.c b/http-push.c
index e3f7675..d4c850b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -794,7 +794,7 @@ static void finish_request(struct transfer_request *request)
 }
 
 #ifdef USE_CURL_MULTI
-void fill_active_slots(void)
+static void push_fill_active_slots(void)
 {
 	struct transfer_request *request = request_queue_head;
 	struct transfer_request *next;
@@ -2355,6 +2355,9 @@ int main(int argc, char **argv)
 
 	memset(remote_dir_exists, -1, 256);
 
+#ifdef USE_CURL_MULTI
+	fill_active_slots = push_fill_active_slots;
+#endif
 	http_init();
 
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
diff --git a/http.h b/http.h
index 69b6b66..7a41cde 100644
--- a/http.h
+++ b/http.h
@@ -69,7 +69,7 @@ extern void finish_all_active_slots(void);
 extern void release_active_slot(struct active_request_slot *slot);
 
 #ifdef USE_CURL_MULTI
-extern void fill_active_slots(void);
+extern void (*fill_active_slots)(void);
 extern void step_active_slots(void);
 #endif
 
-- 
1.5.2.rc1.25.g889f-dirty
