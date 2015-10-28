From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Wed, 28 Oct 2015 14:54:04 -0400
Message-ID: <CAPig+cQhUgFLe+8JLwC4vc1upNT7YXO0JdWgXDhSGn+5xGwaSA@mail.gmail.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-2-git-send-email-k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 19:54:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrVrQ-0000Pv-AB
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 19:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbbJ1SyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 14:54:07 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33805 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722AbbJ1SyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 14:54:05 -0400
Received: by vkgs66 with SMTP id s66so11569436vkg.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8xL2UuxPDP0ueEbsjkn3u3xNhUd1JBZblhme+cb5XOE=;
        b=hTSZfkSN03Qnx7/9XKOVD8wUW1xrcNNxKTOpetN5PSjCiB4MVECPTe/q6XWej/7ogP
         oUnSDpfYQLzX0h6Nc9f4mkH2Io4dxk2T/9WPJovJI9/q3wAquw/wbrardQMtRiJhjhQ4
         g9qVM/mL90UFY1r8C77/0SyqvrBKiAOq7PFoccYfZPj2SoYoo3RzR4Nxz85ysNiiyyfN
         dzJkCPWBW5wxTeNTDQuPT/q/s60VMDaewRAGT5Z3ZBzfYGr7BaSO8m+hmPcVGaIeaItF
         hXk3CJajWWzjLkp4ju23Xh3Cbu9/nKMEQ0Zi7i4vgTl7Vka2SCmSV5dWhS0aDD7lZ9T9
         24Cw==
X-Received: by 10.31.52.80 with SMTP id b77mr3429393vka.45.1446058444080; Wed,
 28 Oct 2015 11:54:04 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Wed, 28 Oct 2015 11:54:04 -0700 (PDT)
In-Reply-To: <1446025245-10128-2-git-send-email-k.franke@science-computing.de>
X-Google-Sender-Auth: gF0zjipHO3405voMT1a_oPLHkVY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280389>

In addition to Junio's review comments...

On Wednesday, October 28, 2015, Knut Franke
<k.franke@science-computing.de> wrote:
> CURLAUTH_ANY does not work with proxies which answer unauthenticated requests
> with a 307 redirect to an error page instead of a 407 listing supported
> authentication methods. Therefore, allow the authentication method to be set
> using the environment variable GIT_HTTP_PROXY_AUTHMETHOD or configuration
> variables http.proxyAuthmethod and remote.<name>.proxyAuthmethod (in analogy
> to http.proxy and remote.<name>.proxy).
>
> The following values are supported:
>
> * anyauth (default)
> * basic
> * digest
> * negotiate
> * ntlm
>
> Signed-off-by: Knut Franke <k.franke@science-computing.de>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 391a0c3..f2644d1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1597,6 +1597,29 @@ http.proxy::
>         `curl(1)`).  This can be overridden on a per-remote basis; see
>         remote.<name>.proxy
>
> +http.proxyAuthmethod::

Should this be typed as "proxyAuthMethod"?

> +       Set the method with which to authenticate against the HTTP proxy. This only
> +    takes effect if the configured proxy URI contains a user name part (i.e. is
> +    of the form 'user@host' or 'user@host:port'). This can be overridden on a
> +    per-remote basis; see `remote.<name>.proxyAuthmethod`. Both can be
> +    overridden by the 'GIT_HTTP_PROXY_AUTHMETHOD' environment variable.
> +    Possible values are:
> ++
> +--
> +* `anyauth` - Automatically pick a suitable authentication method. It is
> +  assumed that the proxy answers an unauthenticated request with a 407
> +  status code and one or more Proxy-authenticate headers with supported
> +  authentication methods. This is the default.
> +* `basic` - HTTP Basic authentication
> +* `digest` - HTTP Digest authentication; this prevents the password from being
> +  transmitted to the proxy in clear text
> +* `negotiate` - GSS-Negotiate authentication (compare the --negotiate option
> +  of `curl(1)`)
> +* `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
> +--

I think you can drop the unnecessary '--' lines here and above.

> ++
> +

No need for the extra unnecessary "+" line and empty line.

> +
>  http.cookieFile::
>         File containing previously stored cookie lines which should be used
>         in the Git http session, if they match the server. The file format
> diff --git a/http.c b/http.c
> index 7da76ed..4756bab 100644
> --- a/http.c
> +++ b/http.c
> @@ -305,6 +324,37 @@ static void init_curl_http_auth(CURL *result)
> +static void init_curl_proxy_auth(CURL *result)
> +{
> +       copy_from_env(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");
> +
> +       if (http_proxy_authmethod) {
> +               int i;
> +               for (i = 0; i < ARRAY_SIZE(http_proxy_authmethods); i++) {
> +                       if (!strcmp(http_proxy_authmethod, http_proxy_authmethods[i].name)) {
> +                               curl_easy_setopt(result, CURLOPT_PROXYAUTH,
> +                                               http_proxy_authmethods[i].curlauth_param);
> +                               break;
> +                       }
> +               }
> +               if (i == ARRAY_SIZE(http_proxy_authmethods)) {
> +                       warning("unsupported proxy authentication method %s: using default",
> +                             http_proxy_authmethod);

Does the user know what "default" means here? Does it mean
CURLAUTH_ANY? If so, do you need to invoke curl_easy_setopt(...,
CURLAUTH_ANY) as you do below when http_proxy is NULL?

> +               }
> +       }
> +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> +       else
> +               curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +#endif
> +}
> +
>  static int has_cert_password(void)
>  {
>         if (ssl_cert == NULL || ssl_cert_password_required != 1)
> @@ -466,9 +516,7 @@ static CURL *get_curl_handle(void)
>         if (curl_http_proxy) {
>                 curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>         }
> -#if LIBCURL_VERSION_NUM >= 0x070a07
> -       curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> -#endif
> +       init_curl_proxy_auth(result);
>
>         set_curl_keepalive(result);
>
> diff --git a/remote.c b/remote.c
> index 1101f82..426c6d8 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -427,6 +427,9 @@ static int handle_config(const char *key, const char *value, void *cb)
>         } else if (!strcmp(subkey, ".proxy")) {
>                 return git_config_string((const char **)&remote->http_proxy,
>                                          key, value);
> +       } else if (!strcmp(subkey, ".proxyAuthmethod")) {

In documentation, write "proxyAuthMethod", but in code use
"proxyauthmethod" string literal.

> +               return git_config_string((const char **)&remote->http_proxy_authmethod,
> +                                        key, value);
>         } else if (!strcmp(subkey, ".vcs")) {
>                 return git_config_string(&remote->foreign_vcs, key, value);
>         }
> diff --git a/remote.h b/remote.h
> index 312b7ca..a221c5a 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -54,6 +54,7 @@ struct remote {
>          * for curl remotes only
>          */
>         char *http_proxy;
> +       char *http_proxy_authmethod;
>  };
>
>  struct remote *remote_get(const char *name);
> --
> 2.3.7
