From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Sparse fixes for http-fetch
Date: Thu, 13 Oct 2005 11:16:34 -0700
Message-ID: <7vd5m92sfx.fsf@assigned-by-dhcp.cox.net>
References: <20051013174203.GA6860@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 20:23:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ7dD-0003iU-2J
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 20:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVJMSQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 14:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVJMSQg
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 14:16:36 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:17393 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932150AbVJMSQf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 14:16:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013181615.VAD776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Oct 2005 14:16:15 -0400
To: Peter Hagervall <hager@cs.umu.se>
In-Reply-To: <20051013174203.GA6860@peppar.cs.umu.se> (Peter Hagervall's
	message of "Thu, 13 Oct 2005 19:42:03 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10086>

Peter Hagervall <hager@cs.umu.se> writes:

> I'm a bit uncomfortable with adding extra #ifdefs to avoid either
> 'mixing declaration with code' or 'unused variable' warnings, but I
> figured that since those functions are already littered with #ifdefs I
> might just get away with it. Comments?

How about something like this on top of what you posted?  There
still is one in main(), but... 

---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
git diff
diff --git a/http-fetch.c b/http-fetch.c
index 26f8130..d549471 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -27,6 +27,8 @@ static int data_received;
 #ifdef USE_CURL_MULTI
 static int max_requests = DEFAULT_MAX_REQUESTS;
 static CURLM *curlm;
+static void process_curl_messages();
+static void process_request_queue();
 #endif
 static CURL *curl_default;
 static struct curl_slist *pragma_header;
@@ -154,11 +156,6 @@ static size_t fwrite_sha1_file(void *ptr
 	return size;
 }
 
-#ifdef USE_CURL_MULTI
-void process_curl_messages();
-void process_request_queue();
-#endif
-
 static struct active_request_slot *get_active_slot(void)
 {
 	struct active_request_slot *slot = active_queue_head;
@@ -443,7 +440,7 @@ static void release_request(struct trans
 }
 
 #ifdef USE_CURL_MULTI
-void process_curl_messages(void)
+static void process_curl_messages(void)
 {
 	int num_messages;
 	struct active_request_slot *slot;
@@ -495,7 +492,7 @@ void process_curl_messages(void)
 	}
 }
 
-void process_request_queue(void)
+static void process_request_queue(void)
 {
 	struct transfer_request *request = request_queue_head;
 	int num_transfers;
@@ -904,9 +901,6 @@ static int fetch_object(struct alt_base 
 	char *hex = sha1_to_hex(sha1);
 	int ret;
 	struct transfer_request *request = request_queue_head;
-#ifdef USE_CURL_MULTI
-	int num_transfers;
-#endif
 
 	while (request != NULL && memcmp(request->sha1, sha1, 20))
 		request = request->next;
@@ -920,6 +914,7 @@ static int fetch_object(struct alt_base 
 
 #ifdef USE_CURL_MULTI
 	while (request->state == WAITING) {
+		int num_transfers;
 		curl_multi_perform(curlm, &num_transfers);
 		if (num_transfers < active_requests) {
 			process_curl_messages();

Compilation finished at Thu Oct 13 11:14:23
