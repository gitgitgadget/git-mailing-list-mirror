From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] http: add support for specifying an SSL cipher list
Date: Thu, 07 May 2015 13:51:32 -0700
Message-ID: <xmqqegmsnmaz.fsf@gitster.dls.corp.google.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
	<1431022630-7005-1-git-send-email-lars@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lars Kellogg-Stedman <lars@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 07 22:51:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqSlg-0000m9-S6
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 22:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbbEGUvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 16:51:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751279AbbEGUvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 16:51:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FD734FE7F;
	Thu,  7 May 2015 16:51:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JRMIUxXkPZP5MOfQyuBapBjvSVI=; b=TT/X4t
	BMSigwwpWebUEbWAcypPvvmcgH2DooSpElCOJlXIUV8DSB50t2KramXtX+P1tpZ+
	Esd/hHel9xscMBzLJW1ZfCBBO6mYjP3oEoB1AMAIHDmA/GBk0tDMeAXzDS9HBtno
	goYbhuL5O4gzVRczWFt/q80Bwil6FnOOuMO6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RGwzrql9btX/YkXnU0D71XWPHHBv7n4q
	Dx50jHviQ3cFZXyRJ9AyycAxBrb+NQymlUQUSd6j274Q/+TasrZQU4QU4rqqWUvE
	hHZJ7L6jJh1UELTbAz51O+7JThoOhfSzwSXT2XZMBBO9WhevnWg6dUA0hulPohEG
	qhpSq/L9Q6g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84A6B4FE7E;
	Thu,  7 May 2015 16:51:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECB8A4FE79;
	Thu,  7 May 2015 16:51:33 -0400 (EDT)
In-Reply-To: <1431022630-7005-1-git-send-email-lars@redhat.com> (Lars
	Kellogg-Stedman's message of "Thu, 7 May 2015 14:17:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8893768-F4FA-11E4-AC21-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268587>

Lars Kellogg-Stedman <lars@redhat.com> writes:

> Teach git about a new option, "http.sslCipherList", which permits one to
> specify a list of ciphers to use when negotiating SSL connections.  The
> setting can be overwridden by the GIT_SSL_CIPHER_LIST environment
> variable.
>
> Signed-off-by: Lars Kellogg-Stedman <lars@redhat.com>
> ---
>
> This addresses (I hope!) comments from Junio and Ray, and also resolves some
> whitespace issues present in the earlier version of the patch.

Sounds good.

>  Documentation/config.txt | 13 +++++++++++++
>  http.c                   | 14 ++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2e5ceaf..b982d66 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1560,6 +1560,19 @@ http.saveCookies::
>  	If set, store cookies received during requests to the file specified by
>  	http.cookieFile. Has no effect if http.cookieFile is unset.
>  
> +http.sslCipherList::
> +	A list of SSL ciphers to use when negotiating an SSL connection.
> +	The available ciphers depend on whether libcurl was built against
> +	NSS or OpenSSL and the particular configuration of the crypto
> +	library in use.  Internally this sets the CURLOPT_SSL_CIPHER_LIST
> +	option; see the libcurl documentation for that option for more
> +	details on the format of this list.
> +
> +	Can be overridden by the 'GIT_SSL_CIPHER_LIST' environment variable.
> +	To force git to use libcurl's default cipher list and ignore any
> +	explicit http.sslCipherList option, set GIT_SSL_CIPHER_LIST to the
> +	empty string.
> +

This will not format well, I am afraid.  The second and subsequent
paragraphs in a description of an enumerated item need to lose the
initial indentation and the empty line that breaks paragraph need
to be replaced with a single '+' (plus).  See "color::" in the same
document for an example.

We chose to use AsciiDoc primarily because its marked-up source is
easily read as a plain text files, but it is unfortunately somewhat
finicky around here.

>  http.sslVerify::
>  	Whether to verify the SSL certificate when fetching or pushing
>  	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
> diff --git a/http.c b/http.c
> index 4b179f6..b617546 100644
> --- a/http.c
> +++ b/http.c
> @@ -36,6 +36,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
>  static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
>  static const char *ssl_cert;
> +static const char *ssl_cipherlist;
>  #if LIBCURL_VERSION_NUM >= 0x070903
>  static const char *ssl_key;
>  #endif
> @@ -187,6 +188,9 @@ static int http_options(const char *var, const char *value, void *cb)
>  		curl_ssl_verify = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp("http.sslcipherlist", var)) {
> +		return git_config_string(&ssl_cipherlist, var, value);
> +	}
>  	if (!strcmp("http.sslcert", var))
>  		return git_config_string(&ssl_cert, var, value);
>  #if LIBCURL_VERSION_NUM >= 0x070903
> @@ -361,6 +365,16 @@ static CURL *get_curl_handle(void)
>  	if (http_proactive_auth)
>  		init_curl_http_auth(result);
>  
> +	if (getenv("GIT_SSL_CIPHER_LIST"))
> +		ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
> +
> +	/* See http://curl.haxx.se/libcurl/c/CURLOPT_SSL_CIPHER_LIST.html
> +	 * for details on the format of and available values for
> +	 * CURLOPT_SSL_CIPHER_LIST. */

I see Eric already commented on multi-line comment and what he said
is correct, but as an in-code comment, I do not see much value in
this---anybody who is _reading_ code would know to look up
CURLOPT_SSL_CIPHER_LIST in cURL documentation, I would expect (and
of course this will not be shown to the end user).

> +	if (ssl_cipherlist != NULL && ssl_cipherlist[0] != '\0')
> +		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
> +				ssl_cipherlist);
> +
>  	if (ssl_cert != NULL)
>  		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
>  	if (has_cert_password())
