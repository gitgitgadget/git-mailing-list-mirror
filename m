Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C391FAFB
	for <e@80x24.org>; Tue,  4 Apr 2017 03:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdDDDIJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 23:08:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:56326 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbdDDDII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 23:08:08 -0400
Received: (qmail 21715 invoked by uid 109); 4 Apr 2017 03:08:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 03:08:06 +0000
Received: (qmail 3357 invoked by uid 111); 4 Apr 2017 03:08:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Apr 2017 23:08:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Apr 2017 23:08:05 -0400
Date:   Mon, 3 Apr 2017 23:08:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170404030804.tv3wfi3cko3ehjtr@sigill.intra.peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 03, 2017 at 10:54:38PM -0400, Jeff King wrote:

> If we declared 7.16.0 as a cutoff, we could unconditionally define
> USE_CURL_MULTI, which gets rid of quite a few messy ifdefs.

That version came out 11 years ago. Here's what that patch would look
like (on top of my other one, but note I missed one older ifdef in the
last one that's included here).

And we could go further. There are a number of ifdefs around 7.19.1 (Nov
2008), 7.22 (Sep 2011). A 5-year cutoff puts us at 7.24. That's getting
close enough that I'd probably start looking at what long-term distros
like RHEL are still shipping and supporting.

-Peff

---
 Documentation/config.txt |  3 +-
 http-push.c              | 23 --------------
 http-walker.c            | 12 --------
 http.c                   | 57 +----------------------------------
 http.h                   | 18 -----------
 remote-curl.c            |  4 ---
 6 files changed, 2 insertions(+), 115 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d5..2b04c1777 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1942,8 +1942,7 @@ http.maxRequests::
 http.minSessions::
 	The number of curl sessions (counted across slots) to be kept across
 	requests. They will not be ended with curl_easy_cleanup() until
-	http_cleanup() is invoked. If USE_CURL_MULTI is not defined, this
-	value will be capped at 1. Defaults to 1.
+	http_cleanup() is invoked. Defaults to 1.
 
 http.postBuffer::
 	Maximum size in bytes of the buffer used by smart HTTP
diff --git a/http-push.c b/http-push.c
index f0e3108f7..40146cdd6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -198,10 +198,8 @@ static void curl_setup_http(CURL *curl, const char *url,
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
 	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-#ifndef NO_CURL_IOCTL
 	curl_easy_setopt(curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
 	curl_easy_setopt(curl, CURLOPT_IOCTLDATA, buffer);
-#endif
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
 	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
@@ -244,8 +242,6 @@ static void process_response(void *callback_data)
 	finish_request(request);
 }
 
-#ifdef USE_CURL_MULTI
-
 static void start_fetch_loose(struct transfer_request *request)
 {
 	struct active_request_slot *slot;
@@ -295,7 +291,6 @@ static void start_mkcol(struct transfer_request *request)
 		request->url = NULL;
 	}
 }
-#endif
 
 static void start_fetch_packed(struct transfer_request *request)
 {
@@ -600,7 +595,6 @@ static void finish_request(struct transfer_request *request)
 	}
 }
 
-#ifdef USE_CURL_MULTI
 static int is_running_queue;
 static int fill_active_slot(void *unused)
 {
@@ -624,7 +618,6 @@ static int fill_active_slot(void *unused)
 	}
 	return 0;
 }
-#endif
 
 static void get_remote_object_list(unsigned char parent);
 
@@ -653,10 +646,8 @@ static void add_fetch_request(struct object *obj)
 	request->next = request_queue_head;
 	request_queue_head = request;
 
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
-#endif
 }
 
 static int add_send_request(struct object *obj, struct remote_lock *lock)
@@ -691,10 +682,8 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	request->next = request_queue_head;
 	request_queue_head = request;
 
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
-#endif
 
 	return 1;
 }
@@ -1673,21 +1662,15 @@ static int delete_remote_branch(const char *pattern, int force)
 
 static void run_request_queue(void)
 {
-#ifdef USE_CURL_MULTI
 	is_running_queue = 1;
 	fill_active_slots();
 	add_fill_function(NULL, fill_active_slot);
-#endif
 	do {
 		finish_all_active_slots();
-#ifdef USE_CURL_MULTI
 		fill_active_slots();
-#endif
 	} while (request_queue_head && !aborted);
 
-#ifdef USE_CURL_MULTI
 	is_running_queue = 0;
-#endif
 }
 
 int cmd_main(int argc, const char **argv)
@@ -1763,10 +1746,6 @@ int cmd_main(int argc, const char **argv)
 		break;
 	}
 
-#ifndef USE_CURL_MULTI
-	die("git-push is not available for http/https repository when not compiled with USE_CURL_MULTI");
-#endif
-
 	if (!repo->url)
 		usage(http_push_usage);
 
@@ -1779,9 +1758,7 @@ int cmd_main(int argc, const char **argv)
 
 	http_init(NULL, repo->url, 1);
 
-#ifdef USE_CURL_MULTI
 	is_running_queue = 0;
-#endif
 
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
diff --git a/http-walker.c b/http-walker.c
index ee049cb13..b5b8e03b0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -119,7 +119,6 @@ static void release_object_request(struct object_request *obj_req)
 	free(obj_req);
 }
 
-#ifdef USE_CURL_MULTI
 static int fill_active_slot(struct walker *walker)
 {
 	struct object_request *obj_req;
@@ -138,7 +137,6 @@ static int fill_active_slot(struct walker *walker)
 	}
 	return 0;
 }
-#endif
 
 static void prefetch(struct walker *walker, unsigned char *sha1)
 {
@@ -155,10 +153,8 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 	http_is_verbose = walker->get_verbosely;
 	list_add_tail(&newreq->node, &object_queue_head);
 
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
-#endif
 }
 
 static int is_alternate_allowed(const char *url)
@@ -346,11 +342,9 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	 * wait for them to arrive and return to processing this request's
 	 * curl message
 	 */
-#ifdef USE_CURL_MULTI
 	while (cdata->got_alternates == 0) {
 		step_active_slots();
 	}
-#endif
 
 	/* Nothing to do if they've already been fetched */
 	if (cdata->got_alternates == 1)
@@ -493,12 +487,8 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		return 0;
 	}
 
-#ifdef USE_CURL_MULTI
 	while (obj_req->state == WAITING)
 		step_active_slots();
-#else
-	start_object_request(walker, obj_req);
-#endif
 
 	/*
 	 * obj_req->req might change when fetching alternates in the callback
@@ -618,9 +608,7 @@ struct walker *get_http_walker(const char *url)
 	walker->cleanup = cleanup;
 	walker->data = data;
 
-#ifdef USE_CURL_MULTI
 	add_fill_function(walker, (int (*)(void *)) fill_active_slot);
-#endif
 
 	return walker;
 }
diff --git a/http.c b/http.c
index e9918f184..d4f8601ba 100644
--- a/http.c
+++ b/http.c
@@ -19,10 +19,8 @@ size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
 
 static int min_curl_sessions = 1;
 static int curl_session_count;
-#ifdef USE_CURL_MULTI
 static int max_requests = -1;
 static CURLM *curlm;
-#endif
 #ifndef NO_CURL_EASY_DUPHANDLE
 static CURL *curl_default;
 #endif
@@ -99,14 +97,6 @@ static int curl_empty_auth = -1;
 
 enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
 
-#if LIBCURL_VERSION_NUM >= 0x071700
-/* Use CURLOPT_KEYPASSWD as is */
-#elif LIBCURL_VERSION_NUM >= 0x070903
-#define CURLOPT_KEYPASSWD CURLOPT_SSLKEYPASSWD
-#else
-#define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
-#endif
-
 static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
 static unsigned long http_auth_methods = CURLAUTH_ANY;
@@ -140,7 +130,6 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return size;
 }
 
-#ifndef NO_CURL_IOCTL
 curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
 {
 	struct buffer *buffer = clientp;
@@ -157,7 +146,6 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
 		return CURLIOE_UNKNOWNCMD;
 	}
 }
-#endif
 
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
@@ -205,12 +193,9 @@ static void finish_active_slot(struct active_request_slot *slot)
 
 static void xmulti_remove_handle(struct active_request_slot *slot)
 {
-#ifdef USE_CURL_MULTI
 	curl_multi_remove_handle(curlm, slot->curl);
-#endif
 }
 
-#ifdef USE_CURL_MULTI
 static void process_curl_messages(void)
 {
 	int num_messages;
@@ -238,7 +223,6 @@ static void process_curl_messages(void)
 		curl_message = curl_multi_info_read(curlm, &num_messages);
 	}
 }
-#endif
 
 static int http_options(const char *var, const char *value, void *cb)
 {
@@ -268,18 +252,14 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp("http.minsessions", var)) {
 		min_curl_sessions = git_config_int(var, value);
-#ifndef USE_CURL_MULTI
 		if (min_curl_sessions > 1)
 			min_curl_sessions = 1;
-#endif
 		return 0;
 	}
-#ifdef USE_CURL_MULTI
 	if (!strcmp("http.maxrequests", var)) {
 		max_requests = git_config_int(var, value);
 		return 0;
 	}
-#endif
 	if (!strcmp("http.lowspeedlimit", var)) {
 		curl_low_speed_limit = (long)git_config_int(var, value);
 		return 0;
@@ -494,7 +474,7 @@ static void set_curl_keepalive(CURL *c)
 	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
 }
 
-#elif LIBCURL_VERSION_NUM >= 0x071000
+#else
 static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 {
 	int ka = 1;
@@ -516,13 +496,6 @@ static void set_curl_keepalive(CURL *c)
 	curl_easy_setopt(c, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);
 }
 
-#else
-static void set_curl_keepalive(CURL *c)
-{
-	/* not supported on older curl versions */
-}
-#endif
-
 static void redact_sensitive_header(struct strbuf *header)
 {
 	const char *sensitive_header;
@@ -876,7 +849,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	no_pragma_header = curl_slist_append(http_copy_default_headers(),
 		"Pragma:");
 
-#ifdef USE_CURL_MULTI
 	{
 		char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
 		if (http_max_requests != NULL)
@@ -886,7 +858,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	curlm = curl_multi_init();
 	if (!curlm)
 		die("curl_multi_init failed");
-#endif
 
 	if (getenv("GIT_SSL_NO_VERIFY"))
 		curl_ssl_verify = 0;
@@ -909,10 +880,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		curl_ssl_verify = 1;
 
 	curl_session_count = 0;
-#ifdef USE_CURL_MULTI
 	if (max_requests < 1)
 		max_requests = DEFAULT_MAX_REQUESTS;
-#endif
 
 	if (getenv("GIT_CURL_FTP_NO_EPSV"))
 		curl_ftp_no_epsv = 1;
@@ -949,9 +918,7 @@ void http_cleanup(void)
 	curl_easy_cleanup(curl_default);
 #endif
 
-#ifdef USE_CURL_MULTI
 	curl_multi_cleanup(curlm);
-#endif
 	curl_global_cleanup();
 
 	curl_slist_free_all(extra_http_headers);
@@ -996,7 +963,6 @@ struct active_request_slot *get_active_slot(void)
 	struct active_request_slot *slot = active_queue_head;
 	struct active_request_slot *newslot;
 
-#ifdef USE_CURL_MULTI
 	int num_transfers;
 
 	/* Wait for a slot to open up if the queue is full */
@@ -1005,7 +971,6 @@ struct active_request_slot *get_active_slot(void)
 		if (num_transfers < active_requests)
 			process_curl_messages();
 	}
-#endif
 
 	while (slot != NULL && slot->in_use)
 		slot = slot->next;
@@ -1076,7 +1041,6 @@ struct active_request_slot *get_active_slot(void)
 
 int start_active_slot(struct active_request_slot *slot)
 {
-#ifdef USE_CURL_MULTI
 	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
 	int num_transfers;
 
@@ -1094,11 +1058,9 @@ int start_active_slot(struct active_request_slot *slot)
 	 * something.
 	 */
 	curl_multi_perform(curlm, &num_transfers);
-#endif
 	return 1;
 }
 
-#ifdef USE_CURL_MULTI
 struct fill_chain {
 	void *data;
 	int (*fill)(void *);
@@ -1157,11 +1119,9 @@ void step_active_slots(void)
 		fill_active_slots();
 	}
 }
-#endif
 
 void run_active_slot(struct active_request_slot *slot)
 {
-#ifdef USE_CURL_MULTI
 	fd_set readfds;
 	fd_set writefds;
 	fd_set excfds;
@@ -1174,7 +1134,6 @@ void run_active_slot(struct active_request_slot *slot)
 		step_active_slots();
 
 		if (slot->in_use) {
-#if LIBCURL_VERSION_NUM >= 0x070f04
 			long curl_timeout;
 			curl_multi_timeout(curlm, &curl_timeout);
 			if (curl_timeout == 0) {
@@ -1186,10 +1145,6 @@ void run_active_slot(struct active_request_slot *slot)
 				select_timeout.tv_sec  =  curl_timeout / 1000;
 				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
 			}
-#else
-			select_timeout.tv_sec  = 0;
-			select_timeout.tv_usec = 50000;
-#endif
 
 			max_fd = -1;
 			FD_ZERO(&readfds);
@@ -1212,12 +1167,6 @@ void run_active_slot(struct active_request_slot *slot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
-#else
-	while (slot->in_use) {
-		slot->curl_result = curl_easy_perform(slot->curl);
-		finish_active_slot(slot);
-	}
-#endif
 }
 
 static void release_active_slot(struct active_request_slot *slot)
@@ -1231,9 +1180,7 @@ static void release_active_slot(struct active_request_slot *slot)
 			curl_session_count--;
 		}
 	}
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
-#endif
 }
 
 void finish_all_active_slots(void)
@@ -1344,12 +1291,10 @@ static int handle_curl_result(struct slot_results *results)
 	} else {
 		if (results->http_connectcode == 407)
 			credential_reject(&proxy_auth);
-#if LIBCURL_VERSION_NUM >= 0x070c00
 		if (!curl_errorstr[0])
 			strlcpy(curl_errorstr,
 				curl_easy_strerror(results->curl_result),
 				sizeof(curl_errorstr));
-#endif
 		return HTTP_ERROR;
 	}
 }
diff --git a/http.h b/http.h
index d1de11a3d..4054af685 100644
--- a/http.h
+++ b/http.h
@@ -10,26 +10,12 @@
 #include "remote.h"
 #include "url.h"
 
-/*
- * We detect based on the cURL version if multi-transfer is
- * usable in this implementation and define this symbol accordingly.
- * This shouldn't be set by the Makefile or by the user (e.g. via CFLAGS).
- */
-#undef USE_CURL_MULTI
-
-#if LIBCURL_VERSION_NUM >= 0x071000
-#define USE_CURL_MULTI
 #define DEFAULT_MAX_REQUESTS 5
-#endif
 
 #if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)
 #define NO_CURL_EASY_DUPHANDLE
 #endif
 
-#if LIBCURL_VERSION_NUM < 0x070c03
-#define NO_CURL_IOCTL
-#endif
-
 /*
  * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
  * and the constants were known as CURLFTPSSL_*
@@ -67,9 +53,7 @@ struct buffer {
 extern size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 extern size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 extern size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
-#ifndef NO_CURL_IOCTL
 extern curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
-#endif
 
 /* Slot lifecycle functions */
 extern struct active_request_slot *get_active_slot(void);
@@ -86,11 +70,9 @@ extern void finish_all_active_slots(void);
 int run_one_slot(struct active_request_slot *slot,
 		 struct slot_results *results);
 
-#ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
 extern void add_fill_function(void *data, int (*fill)(void *));
 extern void step_active_slots(void);
-#endif
 
 extern void http_init(struct remote *remote, const char *url,
 		      int proactive_auth);
diff --git a/remote-curl.c b/remote-curl.c
index c792942f0..4997cc193 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -434,7 +434,6 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	return avail;
 }
 
-#ifndef NO_CURL_IOCTL
 static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 {
 	struct rpc_state *rpc = clientp;
@@ -455,7 +454,6 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 		return CURLIOE_UNKNOWNCMD;
 	}
 }
-#endif
 
 static size_t rpc_in(char *ptr, size_t eltsize,
 		size_t nmemb, void *buffer_)
@@ -595,10 +593,8 @@ static int post_rpc(struct rpc_state *rpc)
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
-#ifndef NO_CURL_IOCTL
 		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, rpc_ioctl);
 		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, rpc);
-#endif
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (chunked)\n", rpc->service_name);
 			fflush(stderr);
