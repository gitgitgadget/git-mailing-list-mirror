Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A20208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 12:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbdHIMCB (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:02:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:33152 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752409AbdHIMCA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:02:00 -0400
Received: (qmail 1877 invoked by uid 109); 9 Aug 2017 12:01:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 12:01:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26470 invoked by uid 111); 9 Aug 2017 12:02:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 08:02:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 08:01:57 -0400
Date:   Wed, 9 Aug 2017 08:01:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] http: drop support for curl < 7.16.0
Message-ID: <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in the previous commit, Git is not well-tested
with old versions of curl (and in fact since v2.12.0 does
not even compile with versions older than 7.19.4). Let's
stop pretending we support curl that old and drop any
now-obslete #ifdefs.

Choosing 7.16.0 is a somewhat arbitrary cutoff, but:

  1. it came out in October of 2006, over 10 years ago.
     Besides being a nice round number, it's a common
     end-of-life support period, even for conservative
     distributions.

  2. that version introduced the curl_multi interface, which
     gives us a lot of bang for the buck in removing #ifdefs

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |  3 +--
 http-push.c              | 23 --------------------
 http-walker.c            | 12 -----------
 http.c                   | 56 +-----------------------------------------------
 http.h                   | 20 +----------------
 remote-curl.c            |  4 ----
 6 files changed, 3 insertions(+), 115 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab6..07e5fab98a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1971,8 +1971,7 @@ http.maxRequests::
 http.minSessions::
 	The number of curl sessions (counted across slots) to be kept across
 	requests. They will not be ended with curl_easy_cleanup() until
-	http_cleanup() is invoked. If USE_CURL_MULTI is not defined, this
-	value will be capped at 1. Defaults to 1.
+	http_cleanup() is invoked. Defaults to 1.
 
 http.postBuffer::
 	Maximum size in bytes of the buffer used by smart HTTP
diff --git a/http-push.c b/http-push.c
index c91f40a610..366af210a9 100644
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
@@ -294,7 +290,6 @@ static void start_mkcol(struct transfer_request *request)
 		FREE_AND_NULL(request->url);
 	}
 }
-#endif
 
 static void start_fetch_packed(struct transfer_request *request)
 {
@@ -596,7 +591,6 @@ static void finish_request(struct transfer_request *request)
 	}
 }
 
-#ifdef USE_CURL_MULTI
 static int is_running_queue;
 static int fill_active_slot(void *unused)
 {
@@ -620,7 +614,6 @@ static int fill_active_slot(void *unused)
 	}
 	return 0;
 }
-#endif
 
 static void get_remote_object_list(unsigned char parent);
 
@@ -649,10 +642,8 @@ static void add_fetch_request(struct object *obj)
 	request->next = request_queue_head;
 	request_queue_head = request;
 
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
-#endif
 }
 
 static int add_send_request(struct object *obj, struct remote_lock *lock)
@@ -687,10 +678,8 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	request->next = request_queue_head;
 	request_queue_head = request;
 
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
 	step_active_slots();
-#endif
 
 	return 1;
 }
@@ -1666,21 +1655,15 @@ static int delete_remote_branch(const char *pattern, int force)
 
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
@@ -1756,10 +1739,6 @@ int cmd_main(int argc, const char **argv)
 		break;
 	}
 
-#ifndef USE_CURL_MULTI
-	die("git-push is not available for http/https repository when not compiled with USE_CURL_MULTI");
-#endif
-
 	if (!repo->url)
 		usage(http_push_usage);
 
@@ -1772,9 +1751,7 @@ int cmd_main(int argc, const char **argv)
 
 	http_init(NULL, repo->url, 1);
 
-#ifdef USE_CURL_MULTI
 	is_running_queue = 0;
-#endif
 
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
diff --git a/http-walker.c b/http-walker.c
index ee049cb13d..b5b8e03b0b 100644
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
index a3675a0eaa..6e5f4ce5f9 100644
--- a/http.c
+++ b/http.c
@@ -20,10 +20,8 @@ ssize_t http_post_buffer = 16 * LARGE_PACKET_MAX;
 
 static int min_curl_sessions = 1;
 static int curl_session_count;
-#ifdef USE_CURL_MULTI
 static int max_requests = -1;
 static CURLM *curlm;
-#endif
 #ifndef NO_CURL_EASY_DUPHANDLE
 static CURL *curl_default;
 #endif
@@ -100,14 +98,6 @@ static int curl_empty_auth = -1;
 
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
@@ -141,7 +131,6 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return size;
 }
 
-#ifndef NO_CURL_IOCTL
 curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
 {
 	struct buffer *buffer = clientp;
@@ -158,7 +147,6 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
 		return CURLIOE_UNKNOWNCMD;
 	}
 }
-#endif
 
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
@@ -206,12 +194,9 @@ static void finish_active_slot(struct active_request_slot *slot)
 
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
@@ -239,7 +224,6 @@ static void process_curl_messages(void)
 		curl_message = curl_multi_info_read(curlm, &num_messages);
 	}
 }
-#endif
 
 static int http_options(const char *var, const char *value, void *cb)
 {
@@ -269,18 +253,14 @@ static int http_options(const char *var, const char *value, void *cb)
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
@@ -497,7 +477,7 @@ static void set_curl_keepalive(CURL *c)
 	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
 }
 
-#elif LIBCURL_VERSION_NUM >= 0x071000
+#else
 static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 {
 	int ka = 1;
@@ -518,12 +498,6 @@ static void set_curl_keepalive(CURL *c)
 {
 	curl_easy_setopt(c, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);
 }
-
-#else
-static void set_curl_keepalive(CURL *c)
-{
-	/* not supported on older curl versions */
-}
 #endif
 
 static void redact_sensitive_header(struct strbuf *header)
@@ -888,7 +862,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	no_pragma_header = curl_slist_append(http_copy_default_headers(),
 		"Pragma:");
 
-#ifdef USE_CURL_MULTI
 	{
 		char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
 		if (http_max_requests != NULL)
@@ -898,7 +871,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	curlm = curl_multi_init();
 	if (!curlm)
 		die("curl_multi_init failed");
-#endif
 
 	if (getenv("GIT_SSL_NO_VERIFY"))
 		curl_ssl_verify = 0;
@@ -921,10 +893,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		curl_ssl_verify = 1;
 
 	curl_session_count = 0;
-#ifdef USE_CURL_MULTI
 	if (max_requests < 1)
 		max_requests = DEFAULT_MAX_REQUESTS;
-#endif
 
 	if (getenv("GIT_CURL_FTP_NO_EPSV"))
 		curl_ftp_no_epsv = 1;
@@ -961,9 +931,7 @@ void http_cleanup(void)
 	curl_easy_cleanup(curl_default);
 #endif
 
-#ifdef USE_CURL_MULTI
 	curl_multi_cleanup(curlm);
-#endif
 	curl_global_cleanup();
 
 	curl_slist_free_all(extra_http_headers);
@@ -1005,7 +973,6 @@ struct active_request_slot *get_active_slot(void)
 	struct active_request_slot *slot = active_queue_head;
 	struct active_request_slot *newslot;
 
-#ifdef USE_CURL_MULTI
 	int num_transfers;
 
 	/* Wait for a slot to open up if the queue is full */
@@ -1014,7 +981,6 @@ struct active_request_slot *get_active_slot(void)
 		if (num_transfers < active_requests)
 			process_curl_messages();
 	}
-#endif
 
 	while (slot != NULL && slot->in_use)
 		slot = slot->next;
@@ -1085,7 +1051,6 @@ struct active_request_slot *get_active_slot(void)
 
 int start_active_slot(struct active_request_slot *slot)
 {
-#ifdef USE_CURL_MULTI
 	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
 	int num_transfers;
 
@@ -1103,11 +1068,9 @@ int start_active_slot(struct active_request_slot *slot)
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
@@ -1166,11 +1129,9 @@ void step_active_slots(void)
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
@@ -1183,7 +1144,6 @@ void run_active_slot(struct active_request_slot *slot)
 		step_active_slots();
 
 		if (slot->in_use) {
-#if LIBCURL_VERSION_NUM >= 0x070f04
 			long curl_timeout;
 			curl_multi_timeout(curlm, &curl_timeout);
 			if (curl_timeout == 0) {
@@ -1195,10 +1155,6 @@ void run_active_slot(struct active_request_slot *slot)
 				select_timeout.tv_sec  =  curl_timeout / 1000;
 				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
 			}
-#else
-			select_timeout.tv_sec  = 0;
-			select_timeout.tv_usec = 50000;
-#endif
 
 			max_fd = -1;
 			FD_ZERO(&readfds);
@@ -1221,12 +1177,6 @@ void run_active_slot(struct active_request_slot *slot)
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
@@ -1240,9 +1190,7 @@ static void release_active_slot(struct active_request_slot *slot)
 			curl_session_count--;
 		}
 	}
-#ifdef USE_CURL_MULTI
 	fill_active_slots();
-#endif
 }
 
 void finish_all_active_slots(void)
@@ -1353,12 +1301,10 @@ static int handle_curl_result(struct slot_results *results)
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
index 90b20a711a..57e97c128d 100644
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
 
-#if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)
+#if LIBCURL_VERSION_NUM == 0x071000
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
index 23e2a1f3ac..333cca33b6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -435,7 +435,6 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	return avail;
 }
 
-#ifndef NO_CURL_IOCTL
 static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 {
 	struct rpc_state *rpc = clientp;
@@ -456,7 +455,6 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 		return CURLIOE_UNKNOWNCMD;
 	}
 }
-#endif
 
 static size_t rpc_in(char *ptr, size_t eltsize,
 		size_t nmemb, void *buffer_)
@@ -602,10 +600,8 @@ static int post_rpc(struct rpc_state *rpc)
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
-- 
2.14.0.609.gd2d1f7ddf

