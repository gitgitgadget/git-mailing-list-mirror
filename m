From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy authentication
Date: Wed, 4 Nov 2015 14:41:13 -0500
Message-ID: <CAPig+cS9PtibBQYAPXmG1GEBAMfd741FApYo8YnsNeVzw-Wt-A@mail.gmail.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446628405-8070-1-git-send-email-k.franke@science-computing.de>
	<1446628405-8070-3-git-send-email-k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:41:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu3wC-0000eb-VV
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 20:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030796AbbKDTlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 14:41:21 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34297 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030439AbbKDTlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 14:41:14 -0500
Received: by ykdr3 with SMTP id r3so91285827ykd.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 11:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OYhmsGu29kDn8XcNxrkS8Y3J7Cnc7AlYsg1dbp7dJYE=;
        b=aBEbrYQVvb6cI5jQzP1CDUeohxvC/MNcDZoIWaBKgHE5KVh00zijWzFGEm9HDyxsiM
         uMU+pOrdyvYa1cNFY7KWG5JCWcCUZStB3M1vvGOgGKVVcF5hAQJ200/gSWPACF3G3U6z
         2x2s6GtGHBHfhszJ78TcPsYnQl3m4G4HLmDTITCclnN392nAMUT9QH9sI7F4QGXEHU3g
         DN/WG/8lBFkgbtL8ktt5WcQs67VKEXwhoAh1OgDl8uz4Lgxr7yIYUL74xAgN5B29Nnni
         /6bmaAFnDJtN0P831nqOt42FGXO2/qvZ0qSv47wKOvagZhgBwbWyrMyvXGpStKLHMs7W
         O1nQ==
X-Received: by 10.31.56.15 with SMTP id f15mr3605835vka.84.1446666073860; Wed,
 04 Nov 2015 11:41:13 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Wed, 4 Nov 2015 11:41:13 -0800 (PST)
In-Reply-To: <1446628405-8070-3-git-send-email-k.franke@science-computing.de>
X-Google-Sender-Auth: 99abpgrp-cNglHb3I183J_KWBCY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280868>

On Wednesday, November 4, 2015, Knut Franke
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
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1593,9 +1593,13 @@ help.htmlPath::
>
>  http.proxy::
>         Override the HTTP proxy, normally configured using the 'http_proxy',
> -       'https_proxy', and 'all_proxy' environment variables (see
> -       `curl(1)`).  This can be overridden on a per-remote basis; see
> -       remote.<name>.proxy
> +       'https_proxy', and 'all_proxy' environment variables (see `curl(1)`). In
> +       addition to the syntax understood by curl, it is possible to specify a
> +       proxy string with a user name but no password, in which case git will
> +       attempt to acquire one in the same way it does for other credentials. See
> +       linkgit:gitcredentials[7] for more information. The syntax thus is
> +       '[protocol://][user[:password]@]proxyhost[:port]'. This can be overridden
> +       on a per-remote basis; see remote.<name>.proxy

s/$/./ maybe?

>  http.proxyAuthMethod::
>         Set the method with which to authenticate against the HTTP proxy. This
> diff --git a/http.c b/http.c
> @@ -337,6 +342,24 @@ static void var_override(const char **var, char *value)
>
>  static void init_curl_proxy_auth(CURL *result)
>  {
> +       if (proxy_auth.username) {
> +               struct strbuf s = STRBUF_INIT;
> +               if (!proxy_auth.password)
> +                       credential_fill(&proxy_auth);
> +#if LIBCURL_VERSION_NUM >= 0x071301
> +               curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
> +                       proxy_auth.username);
> +               curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
> +                       proxy_auth.password);

The strbuf does not get released in this #if branch, but since no
content was added, it doesn't need to be released, thus nothing is
leaked. Good.

Does the compiler warn about unused variable 's' in this #if branch?

> +#else
> +               strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
> +               strbuf_addch(&s, ':');
> +               strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
> +               curl_proxyuserpwd = strbuf_detach(&s, NULL);
> +               curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);

And this branch detaches content from the strbuf, and that memory is
released later in http_cleanup(), so also nothing is leaked, thus all
is good.

> +#endif
> +       }
> +
>         var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));
>
>  #if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
