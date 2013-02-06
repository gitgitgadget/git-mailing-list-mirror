From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Wed, 06 Feb 2013 11:24:41 +0100
Message-ID: <51122F69.9060704@elegosoft.com>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:37:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U32Nt-0008Gg-Bq
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 11:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab3BFKhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 05:37:22 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:60939 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947Ab3BFKhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 05:37:21 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2013 05:37:21 EST
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id D45F2DE0B0;
	Wed,  6 Feb 2013 11:30:12 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YhXNF850WSZM; Wed,  6 Feb 2013 11:30:12 +0100 (CET)
Received: from [192.168.1.233] (g225084251.adsl.alicedsl.de [92.225.84.251])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 6E3BADE0AF;
	Wed,  6 Feb 2013 11:30:12 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130109 Thunderbird/17.0.2
In-Reply-To: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215571>

On 01/31/2013 11:09 PM, Junio C Hamano wrote:

>  
> -static int http_request_reauth(const char *url, void *result, int target,
> +static int http_request_reauth(const char *url,
> +			       struct strbuf *type,
> +			       void *result, int target,
>  			       int options)
>  {
> -	int ret = http_request(url, result, target, options);
> +	int ret = http_request(url, type, result, target, options);
>  	if (ret != HTTP_REAUTH)
>  		return ret;
> -	return http_request(url, result, target, options);
> +	return http_request(url, type, result, target, options);
>  }

This needs something like

diff --git a/http.c b/http.c
index d868d8b..da43be3 100644
--- a/http.c
+++ b/http.c
@@ -860,6 +860,8 @@ static int http_request_reauth(const char *url,
        int ret = http_request(url, type, result, target, options);
        if (ret != HTTP_REAUTH)
                return ret;
+       if (type)
+               strbuf_reset(type);
        return http_request(url, type, result, target, options);
 }

on top. Otherwise we get

"text/plainapplication/x-git-receive-pack-advertisement"

when doing HTTP auth.

Thanks.

> -int http_get_strbuf(const char *url, struct strbuf *result, int options)
> +int http_get_strbuf(const char *url,
> +		    struct strbuf *type,
> +		    struct strbuf *result, int options)
>  {
> -	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
> +	return http_request_reauth(url, type, result,
> +				   HTTP_REQUEST_STRBUF, options);
>  }
>  
>  /*
> @@ -878,7 +891,7 @@ static int http_get_file(const char *url, const char *filename, int options)
>  		goto cleanup;
>  	}
>  
> -	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
> +	ret = http_request_reauth(url, NULL, result, HTTP_REQUEST_FILE, options);
>  	fclose(result);
>  
>  	if ((ret == HTTP_OK) && move_temp_to_file(tmpfile.buf, filename))
> @@ -904,7 +917,7 @@ int http_fetch_ref(const char *base, struct ref *ref)
>  	int ret = -1;
>  
>  	url = quote_ref_url(base, ref->name);
> -	if (http_get_strbuf(url, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
> +	if (http_get_strbuf(url, NULL, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
>  		strbuf_rtrim(&buffer);
>  		if (buffer.len == 40)
>  			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
> @@ -997,7 +1010,7 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
>  	strbuf_addstr(&buf, "objects/info/packs");
>  	url = strbuf_detach(&buf, NULL);
>  
> -	ret = http_get_strbuf(url, &buf, HTTP_NO_CACHE);
> +	ret = http_get_strbuf(url, NULL, &buf, HTTP_NO_CACHE);
>  	if (ret != HTTP_OK)
>  		goto cleanup;
>  
> diff --git a/http.h b/http.h
> index 0a80d30..25d1931 100644
> --- a/http.h
> +++ b/http.h
> @@ -132,7 +132,7 @@ extern char *get_remote_object_url(const char *url, const char *hex,
>   *
>   * If the result pointer is NULL, a HTTP HEAD request is made instead of GET.
>   */
> -int http_get_strbuf(const char *url, struct strbuf *result, int options);
> +int http_get_strbuf(const char *url, struct strbuf *content_type, struct strbuf *result, int options);
>  
>  /*
>   * Prints an error message using error() containing url and curl_errorstr,
> diff --git a/remote-curl.c b/remote-curl.c
> index 9a8b123..e6f3b63 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -92,6 +92,8 @@ static void free_discovery(struct discovery *d)
>  
>  static struct discovery* discover_refs(const char *service)
>  {
> +	struct strbuf exp = STRBUF_INIT;
> +	struct strbuf type = STRBUF_INIT;
>  	struct strbuf buffer = STRBUF_INIT;
>  	struct discovery *last = last_discovery;
>  	char *refs_url;
> @@ -113,7 +115,7 @@ static struct discovery* discover_refs(const char *service)
>  	}
>  	refs_url = strbuf_detach(&buffer, NULL);
>  
> -	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
> +	http_ret = http_get_strbuf(refs_url, &type, &buffer, HTTP_NO_CACHE);
>  	switch (http_ret) {
>  	case HTTP_OK:
>  		break;
> @@ -133,16 +135,19 @@ static struct discovery* discover_refs(const char *service)
>  	last->buf = last->buf_alloc;
>  
>  	if (maybe_smart && 5 <= last->len && last->buf[4] == '#') {
> -		/* smart HTTP response; validate that the service
> +		/*
> +		 * smart HTTP response; validate that the service
>  		 * pkt-line matches our request.
>  		 */
> -		struct strbuf exp = STRBUF_INIT;
> -
> +		strbuf_addf(&exp, "application/x-%s-advertisement", service);
> +		if (strbuf_cmp(&exp, &type))
> +			die("invalid content-type %s", type.buf);
>  		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
>  			die("%s has invalid packet header", refs_url);
>  		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')
>  			strbuf_setlen(&buffer, buffer.len - 1);
>  
> +		strbuf_reset(&exp);
>  		strbuf_addf(&exp, "# service=%s", service);
>  		if (strbuf_cmp(&exp, &buffer))
>  			die("invalid server response; got '%s'", buffer.buf);
> @@ -160,6 +165,8 @@ static struct discovery* discover_refs(const char *service)
>  	}
>  
>  	free(refs_url);
> +	strbuf_release(&exp);
> +	strbuf_release(&type);
>  	strbuf_release(&buffer);
>  	last_discovery = last;
>  	return last;
