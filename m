From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v6 4/6] config: parse http.<url>.<variable> using urlmatch
Date: Wed, 31 Jul 2013 13:51:16 -0700
Message-ID: <9DDDFC61-2946-4828-AD9E-52D2F0154479@gmail.com>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com> <1375298768-7740-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 22:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4dNB-0001Us-Sc
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 22:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760770Ab3GaUvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 16:51:50 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:41675 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab3GaUvt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 16:51:49 -0400
Received: by mail-pd0-f171.google.com with SMTP id bv13so990605pdb.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=FDmAFa6N/0lsMuciYYjmqYSKl+grAA0CrQMeGfhdAuI=;
        b=aeLvNxlFDZuPFShvSoaGzpbAbcXnR+JlZBCx7KFW/TRsVqdQi+ydh0MEZyYXgnjT6a
         k8GkAwvejMiq/9/dtho9yUjRBeBrrLDJHuRkUZVZAcVpPscy9hgwdA6Giw0G3c4Ow8mg
         QxkaIgNAwdznlmeIeo7NWu554u2Zrf4zoYfjbZj6AG48d83qkZEiq6lcqLNtl289O0k/
         Mz6grKT/EHUvAgzimWh7je73V4g2XpCCRVCwznBhu7YT7DTk/VK05E2rJSlawHmocrny
         aFp9BL7Q6r1tljKv69GNDv5MzpCVg+vPEACG441rNZG4nX/CwsyAZq+QP7OrQcg5B7k+
         ILoA==
X-Received: by 10.66.27.43 with SMTP id q11mr154852pag.97.1375303908825;
        Wed, 31 Jul 2013 13:51:48 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wr9sm87658pbc.7.2013.07.31.13.51.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 13:51:47 -0700 (PDT)
In-Reply-To: <1375298768-7740-5-git-send-email-gitster@pobox.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231457>

On Jul 31, 2013, at 12:26, Junio C Hamano wrote:

> From: "Kyle J. McKay" <mackyle@gmail.com>
>
> Use the urlmatch_config_entry() to wrap the underlying
> http_options() two-level variable parser in order to set
> http.<variable> to the value with the most specific URL in the
> configuration.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Needs Peff's Signed-off-by: for the copious amount of text he wrote  
that is included verbatim in the documentation part of the patch.  He  
previously gave it for this purpose.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6e53fc5..60c140f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1513,6 +1513,50 @@ http.useragent::
> 	of common USER_AGENT strings (but not including those like git/ 
> 1.7.1).
> 	Can be overridden by the 'GIT_HTTP_USER_AGENT' environment variable.
>
> +http.<url>.*::
> +	Any of the http.* options above can be applied selectively to some  
> urls.
> +	For a config key to match a URL, each element of the config key is
> +	compared to that of the URL, in the following order:
> ++
> +--
> +. Scheme (e.g., `https` in `https://example.com/`). This field
> +  must match exactly between the config key and the URL.
> +
> +. Host/domain name (e.g., `example.com` in `https://example.com/`).
> +  This field must match exactly between the config key and the URL.
> +
> +. Port number (e.g., `8080` in `http://example.com:8080/`).
> +  This field must match exactly between the config key and the URL.
> +  Omitted port numbers are automatically converted to the correct
> +  default for the scheme before matching.
> +
> +. Path (e.g., `repo.git` in `https://example.com/repo.git`). The
> +  path field of the config key must match the path field of the URL
> +  either exactly or as a prefix of slash-delimited path elements.   
> This means
> +  a config key with path `foo/` matches URL path `foo/bar`.  A  
> prefix can only
> +  match on a slash (`/`) boundary.  Longer matches take precedence  
> (so a config
> +  key with path `foo/bar` is a better match to URL path `foo/bar`  
> than a config
> +  key with just path `foo/`).
> +
> +. User name (e.g., `user` in `https://user@example.com/repo.git`). If
> +  the config key has a user name it must match the user name in the
> +  URL exactly. If the config key does not have a user name, that
> +  config key will match a URL with any user name (including none).

Missing the single line follow-up patch:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0dd5566..f2ed9ef 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1568,7 +1568,8 @@ http.<url>.*::
> . User name (e.g., `user` in `https://user@example.com/repo.git`). If
>   the config key has a user name it must match the user name in the
>   URL exactly. If the config key does not have a user name, that
> -  config key will match a URL with any user name (including none).
> +  config key will match a URL with any user name (including none),
> +  but at a lower precedence than a config key with a user name.
> --



> diff --git a/test-url-normalize.c b/test-url-normalize.c
> new file mode 100644
> index 0000000..81d3da9
> --- /dev/null
> +++ b/test-url-normalize.c
> @@ -0,0 +1,137 @@
> +#ifdef NO_CURL
> +
> +int main()

Need's Ramsey's patch here:

-int main()
+int main(void)

> +static int run_http_options(const char *file,
> +			    const char *opt,
> +			    const struct url_info *info)
> +{
> +	struct strbuf opt_lc;
> +	size_t i, len;
> +	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
> +
> +	memcpy(&config.url, info, sizeof(*info));
> +	config.section = "http";
> +	config.collect_fn = http_options;
> +	config.cascade_fn = git_default_config;
> +	config.cb = NULL;
> +
> +	if (git_config_with_options(urlmatch_config_entry, &config, file,  
> 0))
> +		return 1;
> +
> +	len = strlen(opt);
> +	strbuf_init(&opt_lc, len);
> +	for (i = 0; i < len; ++i) {
> +		strbuf_addch(&opt_lc, tolower(opt[i]));
> +	}
> +
> +	if (!strcmp("sslverify", opt_lc.buf))
> +		printf("%s\n", curl_ssl_verify ? "true" : "false");
> +	else if (!strcmp("sslcert", opt_lc.buf))
> +		printf("%s\n", ssl_cert);
> +#if LIBCURL_VERSION_NUM >= 0x070903
> +	else if (!strcmp("sslkey", opt_lc.buf))
> +		printf("%s\n", ssl_key);
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x070908
> +	else if (!strcmp("sslcapath", opt_lc.buf))
> +		printf("%s\n", ssl_capath);
> +#endif
> +	else if (!strcmp("sslcainfo", opt_lc.buf))
> +		printf("%s\n", ssl_cainfo);
> +	else if (!strcmp("sslcertpasswordprotected", opt_lc.buf))
> +		printf("%s\n", ssl_cert_password_required ? "true" : "false");
> +	else if (!strcmp("ssltry", opt_lc.buf))
> +		printf("%s\n", curl_ssl_try ? "true" : "false");
> +	else if (!strcmp("minsessions", opt_lc.buf))
> +		printf("%d\n", min_curl_sessions);

And here

+#ifdef USE_CURL_MULTI
> +	else if (!strcmp("maxrequests", opt_lc.buf))
> +		printf("%d\n", max_requests);
+#endif
> +	else if (!strcmp("lowspeedlimit", opt_lc.buf))
> +		printf("%ld\n", curl_low_speed_limit);

Otherwise looks good to me.
