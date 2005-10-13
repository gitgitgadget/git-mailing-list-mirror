From: Peter Hagervall <hager@cs.umu.se>
Subject: [PATCH] Sparse fixes for http-fetch
Date: Thu, 13 Oct 2005 19:42:03 +0200
Message-ID: <20051013174203.GA6860@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 19:50:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ77a-0002jc-LB
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 19:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVJMRmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 13:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVJMRmJ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 13:42:09 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:36034 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S932134AbVJMRmI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 13:42:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id A5A872D71;
	Thu, 13 Oct 2005 19:42:06 +0200 (MEST)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 01053-01-3; Thu, 13 Oct 2005 19:42:03 +0200 (MEST)
Received: from peppar.cs.umu.se (peppar.cs.umu.se [130.239.40.13])
	by mail.cs.umu.se (Postfix) with ESMTP id 6A4E52D6E;
	Thu, 13 Oct 2005 19:42:03 +0200 (MEST)
Received: by peppar.cs.umu.se (Postfix, from userid 12006)
	id 61CDA2E4A; Thu, 13 Oct 2005 19:42:03 +0200 (MEST)
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10084>

This patch cleans out all sparse warnings from http-fetch.c

I'm a bit uncomfortable with adding extra #ifdefs to avoid either
'mixing declaration with code' or 'unused variable' warnings, but I
figured that since those functions are already littered with #ifdefs I
might just get away with it. Comments?

---

 * ANSI:fy a few function definitions
 * Make needlessly global functions static
 * Move variable declarations to beginning of enclosing block

Signed-off-by: Peter Hagervall <hager@cs.umu.se>

---

diff --git a/http-fetch.c b/http-fetch.c
index 0aba891..f2d0e0a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -143,7 +143,7 @@ void process_curl_messages();
 void process_request_queue();
 #endif
 
-struct active_request_slot *get_active_slot()
+static struct active_request_slot *get_active_slot(void)
 {
 	struct active_request_slot *slot = active_queue_head;
 	struct active_request_slot *newslot;
@@ -192,7 +192,7 @@ struct active_request_slot *get_active_s
 	return slot;
 }
 
-int start_active_slot(struct active_request_slot *slot)
+static int start_active_slot(struct active_request_slot *slot)
 {
 #ifdef USE_CURL_MULTI
 	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
@@ -207,7 +207,7 @@ int start_active_slot(struct active_requ
 	return 1;
 }
 
-void run_active_slot(struct active_request_slot *slot)
+static void run_active_slot(struct active_request_slot *slot)
 {
 #ifdef USE_CURL_MULTI
 	int num_transfers;
@@ -255,7 +255,7 @@ void run_active_slot(struct active_reque
 #endif
 }
 
-void start_request(struct transfer_request *request)
+static void start_request(struct transfer_request *request)
 {
 	char *hex = sha1_to_hex(request->sha1);
 	char prevfile[PATH_MAX];
@@ -381,7 +381,7 @@ void start_request(struct transfer_reque
 	request->state = ACTIVE;
 }
 
-void finish_request(struct transfer_request *request)
+static void finish_request(struct transfer_request *request)
 {
 	fchmod(request->local, 0444);
 	close(request->local);
@@ -409,7 +409,7 @@ void finish_request(struct transfer_requ
 		pull_say("got %s\n", sha1_to_hex(request->sha1));
 }
 
-void release_request(struct transfer_request *request)
+static void release_request(struct transfer_request *request)
 {
 	struct transfer_request *entry = request_queue_head;
 
@@ -427,7 +427,7 @@ void release_request(struct transfer_req
 }
 
 #ifdef USE_CURL_MULTI
-void process_curl_messages()
+void process_curl_messages(void)
 {
 	int num_messages;
 	struct active_request_slot *slot;
@@ -479,7 +479,7 @@ void process_curl_messages()
 	}
 }
 
-void process_request_queue()
+void process_request_queue(void)
 {
 	struct transfer_request *request = request_queue_head;
 	int num_transfers;
@@ -875,6 +875,9 @@ static int fetch_object(struct alt_base 
 	char *hex = sha1_to_hex(sha1);
 	int ret;
 	struct transfer_request *request = request_queue_head;
+#ifdef USE_CURL_MULTI
+	int num_transfers;
+#endif
 
 	while (request != NULL && memcmp(request->sha1, sha1, 20))
 		request = request->next;
@@ -887,7 +890,6 @@ static int fetch_object(struct alt_base 
 	}
 
 #ifdef USE_CURL_MULTI
-	int num_transfers;
 	while (request->state == WAITING) {
 		curl_multi_perform(curlm, &num_transfers);
 		if (num_transfers < active_requests) {
@@ -1052,6 +1054,9 @@ int main(int argc, char **argv)
 	char *url;
 	int arg = 1;
 	struct active_request_slot *slot;
+#ifdef USE_CURL_MULTI
+	char *http_max_requests;
+#endif
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
@@ -1082,7 +1087,7 @@ int main(int argc, char **argv)
 	curl_global_init(CURL_GLOBAL_ALL);
 
 #ifdef USE_CURL_MULTI
-	char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
+	http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
 	if (http_max_requests != NULL)
 		max_requests = atoi(http_max_requests);
 	if (max_requests < 1)
