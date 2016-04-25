From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Mon, 25 Apr 2016 11:43:37 -0700
Message-ID: <xmqq7fflleau.fsf@gitster.mtv.corp.google.com>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:43:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aulU3-0003QB-09
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 20:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933384AbcDYSnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 14:43:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932487AbcDYSnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 14:43:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64C7514856;
	Mon, 25 Apr 2016 14:43:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X1bqRISHjABEriTj8ZyCOmQQrmw=; b=mFPe6k
	WUgm0brlxKONoPKuMzLxZl3TmdXHDKnnTDovXiZKqsH4tyOfdPa2wZWELew/JX0M
	68fYpECxUoJYwUypBKM38DKiWOFs1FA3qmzimlMNwFW7GP2qqttVHVKyeZK3xHtB
	++HnqwJjgLNx4TKJAP8JKHMba14/6h5yyecwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VJbGAdFhovRQDtww4ipftX2IUVoZq8Io
	OFrUALMtsXX5hKs1gnoOcaQ0/FLovCDwYXIif51KapY+zFd80tHDUsVqr3SnZYnO
	lzLK1eK2Mtj4t9Hx3Wcsk02THzWsTsMi7ZXBe4X7v6pdDW2EKtJfEy7OUlJ7PjLg
	/setw0I1Fe4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D04214855;
	Mon, 25 Apr 2016 14:43:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46E6714850;
	Mon, 25 Apr 2016 14:43:39 -0400 (EDT)
In-Reply-To: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 25 Apr 2016 15:13:08 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A04D96FA-0B15-11E6-B3B2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292543>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> To make communication for `git fetch`, `git ls-remote` and friends extra
> secure, we introduce a way to send custom HTTP headers with all
> requests.

I think an ability to send custom headers may be a good addition and
have no problem with it, but I tend to agree with Shawn that its log
message that advertises it as if it has anything to do with security
is probably a bad idea in both ways (i.e. it isn't very secure, and
the usefulness of the feature is not limited to security).

> This allows us, for example, to send an extra token that the server
> tests for. The server could use this token e.g. to ensure that only
> certain operations or refs are allowed, or allow the token to be used
> only once.
>
> This feature can be used like this:
>
> 	git -c http.extraheader='Secret: sssh!' fetch $URL $REF
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>


> Published-As: https://github.com/dscho/git/releases/tag/extra-http-headers-v1

Move this after "---".

> ---

This obviously needs documentation updates and tests, no?

>  http-push.c   | 10 +++++-----
>  http.c        | 28 +++++++++++++++++++++++++---
>  http.h        |  1 +
>  remote-curl.c |  4 ++--
>  4 files changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index bd60668..04eef17 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -211,7 +211,7 @@ static void curl_setup_http(CURL *curl, const char *url,
>  static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	struct curl_slist *dav_headers = NULL;
> +	struct curl_slist *dav_headers = http_get_default_headers();
>  
>  	if (options & DAV_HEADER_IF) {
>  		strbuf_addf(&buf, "If: (<%s>)", lock->token);
> @@ -417,7 +417,7 @@ static void start_put(struct transfer_request *request)
>  static void start_move(struct transfer_request *request)
>  {
>  	struct active_request_slot *slot;
> -	struct curl_slist *dav_headers = NULL;
> +	struct curl_slist *dav_headers = http_get_default_headers();
>  
>  	slot = get_active_slot();
>  	slot->callback_func = process_response;
> @@ -845,7 +845,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
>  	char *ep;
>  	char timeout_header[25];
>  	struct remote_lock *lock = NULL;
> -	struct curl_slist *dav_headers = NULL;
> +	struct curl_slist *dav_headers = http_get_default_headers();
>  	struct xml_ctx ctx;
>  	char *escaped;
>  
> @@ -1126,7 +1126,7 @@ static void remote_ls(const char *path, int flags,
>  	struct slot_results results;
>  	struct strbuf in_buffer = STRBUF_INIT;
>  	struct buffer out_buffer = { STRBUF_INIT, 0 };
> -	struct curl_slist *dav_headers = NULL;
> +	struct curl_slist *dav_headers = http_get_default_headers();
>  	struct xml_ctx ctx;
>  	struct remote_ls_ctx ls;
>  
> @@ -1204,7 +1204,7 @@ static int locking_available(void)
>  	struct slot_results results;
>  	struct strbuf in_buffer = STRBUF_INIT;
>  	struct buffer out_buffer = { STRBUF_INIT, 0 };
> -	struct curl_slist *dav_headers = NULL;
> +	struct curl_slist *dav_headers = http_get_default_headers();
>  	struct xml_ctx ctx;
>  	int lock_flags = 0;
>  	char *escaped;
> diff --git a/http.c b/http.c
> index 4304b80..02d7147 100644
> --- a/http.c
> +++ b/http.c
> @@ -114,6 +114,7 @@ static unsigned long http_auth_methods = CURLAUTH_ANY;
>  
>  static struct curl_slist *pragma_header;
>  static struct curl_slist *no_pragma_header;
> +static struct curl_slist *extra_http_headers;
>  
>  static struct active_request_slot *active_queue_head;
>  
> @@ -323,6 +324,12 @@ static int http_options(const char *var, const char *value, void *cb)
>  #endif
>  	}
>  
> +	if (!strcmp("http.extraheader", var)) {
> +		extra_http_headers =
> +			curl_slist_append(extra_http_headers, value);
> +		return 0;
> +	}
> +
>  	/* Fall back on the default ones */
>  	return git_default_config(var, value, cb);
>  }
> @@ -678,8 +685,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	if (remote)
>  		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
>  
> -	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
> -	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
> +	pragma_header = curl_slist_append(http_get_default_headers(),
> +		"Pragma: no-cache");
> +	no_pragma_header = curl_slist_append(http_get_default_headers(),
> +		"Pragma:");
>  
>  #ifdef USE_CURL_MULTI
>  	{
> @@ -765,6 +774,9 @@ void http_cleanup(void)
>  #endif
>  	curl_global_cleanup();
>  
> +	curl_slist_free_all(extra_http_headers);
> +	extra_http_headers = NULL;
> +
>  	curl_slist_free_all(pragma_header);
>  	pragma_header = NULL;
>  
> @@ -1163,6 +1175,16 @@ int run_one_slot(struct active_request_slot *slot,
>  	return handle_curl_result(results);
>  }
>  
> +struct curl_slist *http_get_default_headers()
> +{
> +	struct curl_slist *headers = NULL, *h;
> +
> +	for (h = extra_http_headers; h; h = h->next)
> +		headers = curl_slist_append(headers, h->data);
> +
> +	return headers;
> +}
> +
>  static CURLcode curlinfo_strbuf(CURL *curl, CURLINFO info, struct strbuf *buf)
>  {
>  	char *ptr;
> @@ -1380,7 +1402,7 @@ static int http_request(const char *url,
>  {
>  	struct active_request_slot *slot;
>  	struct slot_results results;
> -	struct curl_slist *headers = NULL;
> +	struct curl_slist *headers = http_get_default_headers();
>  	struct strbuf buf = STRBUF_INIT;
>  	const char *accept_language;
>  	int ret;
> diff --git a/http.h b/http.h
> index 4ef4bbd..b0927de 100644
> --- a/http.h
> +++ b/http.h
> @@ -106,6 +106,7 @@ extern void step_active_slots(void);
>  extern void http_init(struct remote *remote, const char *url,
>  		      int proactive_auth);
>  extern void http_cleanup(void);
> +extern struct curl_slist *http_get_default_headers();
>  
>  extern long int git_curl_ipresolve;
>  extern int active_requests;
> diff --git a/remote-curl.c b/remote-curl.c
> index 15e48e2..86ba787 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -474,7 +474,7 @@ static int run_slot(struct active_request_slot *slot,
>  static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>  {
>  	struct active_request_slot *slot;
> -	struct curl_slist *headers = NULL;
> +	struct curl_slist *headers = http_get_default_headers();
>  	struct strbuf buf = STRBUF_INIT;
>  	int err;
>  
> @@ -503,7 +503,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>  static int post_rpc(struct rpc_state *rpc)
>  {
>  	struct active_request_slot *slot;
> -	struct curl_slist *headers = NULL;
> +	struct curl_slist *headers = http_get_default_headers();
>  	int use_gzip = rpc->gzip_request;
>  	char *gzip_body = NULL;
>  	size_t gzip_size = 0;
