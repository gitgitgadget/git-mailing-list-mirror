From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] remote-curl: fix large pushes with GSSAPI
Date: Wed, 30 Oct 2013 04:45:10 -0400
Message-ID: <20131030084510.GO11317@sigill.intra.peff.net>
References: <1383014197-11607-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 09:45:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbRP0-0001pn-12
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 09:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401Ab3J3IpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 04:45:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:58331 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750703Ab3J3IpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 04:45:13 -0400
Received: (qmail 19306 invoked by uid 102); 30 Oct 2013 08:45:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 03:45:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 04:45:10 -0400
Content-Disposition: inline
In-Reply-To: <1383014197-11607-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237004>

On Tue, Oct 29, 2013 at 02:36:37AM +0000, brian m. carlson wrote:

>  	if (large_request) {
> +		long authtype = 0;
> +

Minor nit, but this will produce an unused variable warning if the code
in the #if below doesn't get compiled. I don't know how much we care.

> +#if LIBCURL_VERSION_NUM >= 0x070a08
> +		slot = get_active_slot();
> +		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL, &authtype);
> +		if (authtype & CURLAUTH_GSSNEGOTIATE)
> +			needs_100_continue = 1;
> +#endif

I didn't notice this in the last round, but this is somewhat of an abuse
of get_active_slot. It is intended to give you a new, pristine curl slot
that you can use to make a request, and it is yours until you call
finish_active_slot. You're not supposed to look at it after that.

However, we do reuse the curl handles. And in the case of rpc case, we
are only doing one request at a time, so the handle you get is
guaranteed to be the last one used.  So it works in practice, but it
would break if the curl handle code breaks any of these assumptions.

I think the clean way to do it would be to teach the slot code to pull
out the available auth methods, and pass them up through the call chain.
Like this on top of your patch:

diff --git a/http.c b/http.c
index 0ddb164..32fa998 100644
--- a/http.c
+++ b/http.c
@@ -761,6 +761,12 @@ void finish_active_slot(struct active_request_slot *slot)
 	if (slot->results != NULL) {
 		slot->results->curl_result = slot->curl_result;
 		slot->results->http_code = slot->http_code;
+#if LIBCURL_VERSION_NUM >= 0x070a08
+		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
+				  &slot->results->authtype);
+#else
+		slot->results->authtype = 0;
+#endif
 	}
 
 	/* Run callback if appropriate */
diff --git a/http.h b/http.h
index d77c1b5..4b32b9b 100644
--- a/http.h
+++ b/http.h
@@ -54,6 +54,7 @@
 struct slot_results {
 	CURLcode curl_result;
 	long http_code;
+	long authtype;
 };
 
 struct active_request_slot {
diff --git a/remote-curl.c b/remote-curl.c
index eaa286c..d026f05 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -383,25 +383,29 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 	return size;
 }
 
-static int run_slot(struct active_request_slot *slot)
+static int run_slot(struct active_request_slot *slot,
+		    struct slot_results *results)
 {
 	int err;
-	struct slot_results results;
+	struct slot_results results_buf;
 
-	slot->results = &results;
+	if (!results)
+		results = &results_buf;
+
+	slot->results = results;
 	slot->curl_result = curl_easy_perform(slot->curl);
 	finish_active_slot(slot);
 
-	err = handle_curl_result(&results);
+	err = handle_curl_result(results);
 	if (err != HTTP_OK && err != HTTP_REAUTH) {
 		error("RPC failed; result=%d, HTTP code = %ld",
-		      results.curl_result, results.http_code);
+		      results->curl_result, results->http_code);
 	}
 
 	return err;
 }
 
-static int probe_rpc(struct rpc_state *rpc)
+static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 {
 	struct active_request_slot *slot;
 	struct curl_slist *headers = NULL;
@@ -423,7 +427,7 @@ static int probe_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
 
-	err = run_slot(slot);
+	err = run_slot(slot, results);
 
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
@@ -462,20 +466,16 @@ static int post_rpc(struct rpc_state *rpc)
 	}
 
 	if (large_request) {
-		long authtype = 0;
+		struct slot_results results;
 
 		do {
-			err = probe_rpc(rpc);
+			err = probe_rpc(rpc, &results);
 		} while (err == HTTP_REAUTH);
 		if (err != HTTP_OK)
 			return -1;
 
-#if LIBCURL_VERSION_NUM >= 0x070a08
-		slot = get_active_slot();
-		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL, &authtype);
-		if (authtype & CURLAUTH_GSSNEGOTIATE)
+		if (results.authtype & CURLAUTH_GSSNEGOTIATE)
 			needs_100_continue = 1;
-#endif
 	}
 
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
@@ -572,7 +572,7 @@ retry:
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
 
-	err = run_slot(slot);
+	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request)
 		goto retry;
 	if (err != HTTP_OK)

That's note tested beyond compiling, but I think it should work. Feel
free to squash it into your patch, or if you'd like, I can split out the
refactoring steps with a commit message for you.

-Peff
