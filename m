From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: always use any proxy auth method available
Date: Fri, 26 Jun 2015 12:24:42 -0700
Message-ID: <xmqqfv5etgqt.fsf@gitster.dls.corp.google.com>
References: <FCAB894186380D42A07AFFFA5A1282B8F1EC65FD@EXMBNJE2.ad.twosigma.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "'git\@vger.kernel.org'" <git@vger.kernel.org>,
	'Nelson Benitez Leon' <nbenitezl@gmail.com>
To: Enrique Tobis <Enrique.Tobis@twosigma.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 21:25:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ZFR-0006RF-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 21:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbbFZTYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 15:24:55 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38458 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbbFZTYs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 15:24:48 -0400
Received: by igrv9 with SMTP id v9so7501879igr.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hlMrueIOMyKASghbWN8PrKMtrvFgPDrgKUsmWgIvt0E=;
        b=aGomQEuM43Ak1hqBnM9/3t19FTUvFqj3yaMZZbYiR2uC8DVhwpx2UuedT7u0szXRUG
         R3mwwzro4WlJUTEIueoYImvwJ0r4NsscbpO+6qbiuBCREcpjW9ZMAXKh+EIO6dbTN9fq
         rZOHVgLGLAH+XZx3hZcKIYd2/UOso6/7aVMdJfFhUD92PcgpG61iSh7OtIbygQ05KIOp
         thsI0ilTpFoASuJFtpaCoq3kNOFjtvKWiDJIsmwjGfE4GMez2xDKK/7YkNjKYRB0EKu9
         UpAITFPQFPKuzP5phAh8AG2+h9pHVViizbzdzFzu2xCoH+oJhHhivnB1NQ+6qvnnnksT
         l5xw==
X-Received: by 10.42.99.70 with SMTP id v6mr4791189icn.1.1435346687124;
        Fri, 26 Jun 2015 12:24:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id w4sm1411078igl.22.2015.06.26.12.24.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 12:24:46 -0700 (PDT)
In-Reply-To: <FCAB894186380D42A07AFFFA5A1282B8F1EC65FD@EXMBNJE2.ad.twosigma.com>
	(Enrique Tobis's message of "Fri, 26 Jun 2015 18:19:04 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272815>

Enrique Tobis <Enrique.Tobis@twosigma.com> writes:

Thanks.  I wonder why this was addressed me directly (i.e. I am not
an area expert, and I haven't seen this patch discussed here and
reviewed by other people), but anyway...

> By default, libcurl honors some environment variables that specify a
> proxy (e.g. http_proxy, https_proxy). Also by default, libcurl will
> only try to authenticate with a proxy using the Basic method. 

OK, that is a statement of two facts.

What's missing here is what they relate to this change.  Are these
two good things that we want to keep?  Are these bad things we need
to tweak out by changing our software?  Or some combination?  Some
third key information that is left untold?

> This
> change makes libcurl always try the most secure proxy authentication
> method available. As a consequence, you can use environment variables
> to instruct git to use a proxy that uses an authentication method
> different from Basic (e.g. Negotiate).

That is a worthy goal, but the description of the current problem
seems lacking.  Perhaps you meant something like this:

	We use CURLOPT_PROXYAUTH to ask for the most secure
        authentication method with proxy only when we have
        curl_http_proxy set, by http.proxy or remote.*.proxy
        configuration variables.  However, libcurl also allows users
        to use http proxies by setting some environment variables,
        and by default the authentication with the proxy uses Basic
        auth (unless specified with CURLOPT_PROXYAUTH, that is).

	By always using CURLOPT_PROXYAUTH to ask for the most secure
	authentication method, even when we are not aware that we
	are using proxy (because there is no configuration that
	tells us so), we can allow users to tell libcurl to use
	a proxy with more secure method without setting http.proxy
        or remote.*.proxy configuration variables.

But I am just guessing; as I said, I am not an expert in this area
of the code.

> Signed-off-by: Enrique A. Tobis <etobis@twosigma.com>
> ---
>  http.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/http.c b/http.c
> index f0c5bbc..e9c6fdd 100644
> --- a/http.c
> +++ b/http.c
> @@ -416,10 +416,10 @@ static CURL *get_curl_handle(void)
>  
>  	if (curl_http_proxy) {
>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +	}
>  #if LIBCURL_VERSION_NUM >= 0x070a07

The authoritative source of truth:

  https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions

matches this version number, so there is nothing wrong per-se on
this line, but it makes me wonder why we didn't do

	#ifdef CURLOPT_PROXYAUTH

instead.  That's not something that should be changed with this
change, though.

> -		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +	curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);

>  #endif
> -	}
>  
>  	set_curl_keepalive(result);

Assuming that I guessed your justification for this change corretly
in the earlier part of this message, I think the change makes sense.

Thanks.
