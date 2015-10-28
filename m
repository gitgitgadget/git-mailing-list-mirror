From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy authentication
Date: Wed, 28 Oct 2015 14:58:06 -0400
Message-ID: <CAPig+cRK-EPpH4dUMpYBcjR22Wqw4RnNTYeBvw-M7h=CTFGviQ@mail.gmail.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-3-git-send-email-k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 19:58:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrVvN-00041P-I8
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 19:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbbJ1S6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 14:58:09 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33476 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964988AbbJ1S6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 14:58:07 -0400
Received: by vkgy127 with SMTP id y127so11723978vkg.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3xRqiB1Go1uoShEmII8dMcpPin1OVPEW1OIUY/KjBQY=;
        b=kSvatHFO0jbfZHHtLiuX+1bnKFBUvjTQwQhHnlji/kO+tbKO7MvAHKoaB16o3q4Gud
         ph01yoZ3Tq9pNZGzCKoSBlJy6XKGxueXL0s0w2d3TnLaVIt/FWkYS5qMHpa5Nv5T1NqR
         dH27aA+1wjcgCZaqQEGJBy7UpuIXFQEHVr29Uz1pGQhr0+ChTb6veQOmdixBrMZdeFBT
         Yt7JQQDjozQM3odpvM7TYm1raZiNHNCM6oQpZzPjrcjiU7aMMJ51lNgrAlv9xe1MR0D2
         mfsjuTmKZw6lHfGx62q3gRHMLw5rCcLhjr9xH6Nka1hCFh8QUwGrrAZNJnWG1hk+RING
         On5g==
X-Received: by 10.31.163.85 with SMTP id m82mr20336499vke.19.1446058686659;
 Wed, 28 Oct 2015 11:58:06 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Wed, 28 Oct 2015 11:58:06 -0700 (PDT)
In-Reply-To: <1446025245-10128-3-git-send-email-k.franke@science-computing.de>
X-Google-Sender-Auth: H4RhZdmZRoYar3abyTVI6OQgdSE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280391>

On Wednesday, October 28, 2015, Knut Franke
<k.franke@science-computing.de> wrote:
> Currently, the only way to pass proxy credentials to curl is by including them
> in the proxy URL. Usually, this means they will end up on disk unencrypted, one
> way or another (by inclusion in ~/.gitconfig, shell profile or history). Since
> proxy authentication often uses a domain user, credentials can be security
> sensitive; therefore, a safer way of passing credentials is desirable.
>
> If the configured proxy contains a username but not a password, query the
> credential API for one. Also, make sure we approve/reject proxy credentials
> properly.
>
> For consistency reasons, add parsing of http_proxy/https_proxy/all_proxy
> environment variables, which would otherwise be evaluated as a fallback by curl.
> Without this, we would have different semantics for git configuration and
> environment variables.
>
> Signed-off-by: Knut Franke <k.franke@science-computing.de>
> ---
> diff --git a/http.c b/http.c
> index 4756bab..11bebe1 100644
> --- a/http.c
> +++ b/http.c
> @@ -79,6 +79,7 @@ static struct {
>         // curl(1) and is not included in CURLAUTH_ANY, so we leave it out
>         // here, too
>  };
> +struct credential http_proxy_auth = CREDENTIAL_INIT;

s/^/static/

>  static const char *curl_cookie_file;
>  static int curl_save_cookies;
>  struct credential http_auth = CREDENTIAL_INIT;
> @@ -176,6 +177,9 @@ static void finish_active_slot(struct active_request_slot *slot)
>  #else
>                 slot->results->auth_avail = 0;
>  #endif
> +
> +               curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
> +                       &slot->results->http_connectcode);
>         }
>
>         /* Run callback if appropriate */
> @@ -333,6 +337,25 @@ static void copy_from_env(const char **var, const char *envname)
>
>  static void init_curl_proxy_auth(CURL *result)
>  {
> +       if (http_proxy_auth.username) {
> +               if (!http_proxy_auth.password) {
> +                       credential_fill(&http_proxy_auth);
> +               }

Style: drop unnecessary braces

> +#if LIBCURL_VERSION_NUM >= 0x071301
> +               curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
> +                       http_proxy_auth.username);
> +               curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
> +                       http_proxy_auth.password);
> +#else
> +               struct strbuf up = STRBUF_INIT;

Minor: It took me a moment to figure out that "up" meant
user-password. I wonder if a simpler name such as 's' would suffice?

> +               strbuf_reset(&up);

Unnecessary strbuf_reset().

> +               strbuf_addstr_urlencode(&up, http_proxy_auth.username, 1);
> +               strbuf_addch(&up, ':');
> +               strbuf_addstr_urlencode(&up, http_proxy_auth.password, 1);
> +               curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, up.buf);

Leaking 'up'. Insert strbuf_release(&up) here.

> +#endif
> +       }
> +
>         copy_from_env(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");
>
>         if (http_proxy_authmethod) {
> @@ -513,8 +536,36 @@ static CURL *get_curl_handle(void)
>                 curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
>  #endif
>
> +       /*
> +        * curl also examines these variables as a fallback; but we need to query
> +        * them here in order to decide whether to prompt for missing password (cf.
> +        * init_curl_proxy_auth()).
> +        */
> +       if (!curl_http_proxy) {
> +               if (!strcmp(http_auth.protocol, "https")) {
> +                       copy_from_env(&curl_http_proxy, "HTTPS_PROXY");
> +                       copy_from_env(&curl_http_proxy, "https_proxy");
> +               } else {
> +                       copy_from_env(&curl_http_proxy, "http_proxy");

To the casual reader, it's not obvious why you check upper- and
lowercase versions of the other environment variables but not this
one.

> +               }
> +               if (!curl_http_proxy) {
> +                       copy_from_env(&curl_http_proxy, "ALL_PROXY");
> +                       copy_from_env(&curl_http_proxy, "all_proxy");
> +               }

If this sort of upper- and lowercase environment variable name
checking is indeed desirable, I wonder if it would make sense to fold
that functionality into the helper function.

> +       }
> +
>         if (curl_http_proxy) {
> -               curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +               if (strstr(curl_http_proxy, "://"))
> +                       credential_from_url(&http_proxy_auth, curl_http_proxy);
> +               else {
> +                       struct strbuf url = STRBUF_INIT;
> +                       strbuf_reset(&url);

Unnecessary strbuf_reset().

> +                       strbuf_addstr(&url, "http://");
> +                       strbuf_addstr(&url, curl_http_proxy);

strbuf_addf(&url, "http://%s", curl_http_proxy) might be more straightforward.

> +                       credential_from_url(&http_proxy_auth, url.buf);

Leaking 'url' here. Insert strbuf_release(&url).

> +               }
> +
> +               curl_easy_setopt(result, CURLOPT_PROXY, http_proxy_auth.host);
>         }
>         init_curl_proxy_auth(result);
