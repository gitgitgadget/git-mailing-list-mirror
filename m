Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62264C433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 19:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383941AbiEMTuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383954AbiEMTum (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 15:50:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152EB2AC60
        for <git@vger.kernel.org>; Fri, 13 May 2022 12:50:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 540951A7047;
        Fri, 13 May 2022 15:50:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zK5CjJ9j/NHFU+stIJiS9cFDFesVa6hv8s4VT7
        zKFmA=; b=kLM0X5hO3NncJGzpHAEA1TTBH5OveC8guxnCtsCa5WZIS4y6FV+SyT
        sZOaMY3niAM0m7Y1uY0/ejK8LzScWVeyaX51RGY7Kvbo+3J/AfQgJP4PHi9vtmoU
        LFbMKiZs9yvNI6OzFghu9aWWzk8p+y7l/amwafoV4aq1Ownrd4deg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48AF51A7046;
        Fri, 13 May 2022 15:50:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E92141A7045;
        Fri, 13 May 2022 15:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon.Richter@hogyros.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] Rename proxy_authmethods -> authmethods
References: <20220513070416.37235-1-Simon.Richter@hogyros.de>
        <20220513070416.37235-2-Simon.Richter@hogyros.de>
Date:   Fri, 13 May 2022 12:50:31 -0700
In-Reply-To: <20220513070416.37235-2-Simon.Richter@hogyros.de> (Simon
        Richter's message of "Fri, 13 May 2022 09:04:14 +0200")
Message-ID: <xmqq7d6p9pq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F32463FA-D2F5-11EC-A82F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon.Richter@hogyros.de writes:

> From: Simon Richter <Simon.Richter@hogyros.de>
>
> Curl also allows specifying a list of acceptable auth methods for the
> request itself, so this isn't specific to proxy authentication.

While that is true, given that it is ONLY used to sanity check the
http_proxy_authmethod variable and use CURLOPT_PROXYAUTH thing, the
above alone is not a good excuse to rename this array.

I haven't read the later patches, but I would imagine that this is
so that you'd create another consumer that is about authentication
method that is not for the proxyauth.  And if that is the case, the
proposed log message for this change should explicitly say so to
justify this change.

    We are about to reuse this table of authmethods to parse the
    non-proxy authentication in a later step in this series.  Let's
    rename it to just "authmethod[]".

appended as the second paragraph after the above might be sufficient.

Two things that comes to mind:

 * In general, an array whose elements are accessed individually is
   better named in singular, i.e. "type thing[]", not "type
   things[]" (an exception is when the most prevalent use of the
   array is to pass it as a whole to functions as a bag of things,
   instead of accessing individual element).  This is because it is
   more natural to see the zeroth thing to be spelled "thing[0]",
   and not "things[0]".  If we are renaming this array anyway, it
   may make sense to rename it to authmethod[].

 * If the reason why this rename is warranted is because there will
   be another user of this table that maps a string name to its
   corresponding CURLAUTH_* constant, it would probably make sense
   to extract a helper function out of this loop to do just that,
   something along the lines of ...

   static int parse_authmethod(const char *name, long *auth_param)
   {
       int i;

       for (i = 0; i < ARRAY_SIZE(authmethod); i++)
           if (!strcmp(name, authmethod[i].name)) {
		*auth_param = authmethod[i].curlauth_param;
                return i;
           }
       return -1;
   }

   Then the existing code can become

   if (http_proxy_authmethod) {
        long auth_param;

	if (parse_authmethod(http_proxy_authmethod, &auth_param) < 0) {
	    warning("unsupported ... %s: using anyauth", http_proxy_authmethod);
            auth_param = CURLAUTH_ANY;
	}
	curl_easy_setopt(result, CURLOPT_PROXYAUTH, auth_param);
   }

   It is probably OK to do so in the same patch as renaming of the
   table, but the focus of the step will then become "factor out
   parsing of authmethod from string to CURLAUTH_* constants" and
   the patch should be retitled accordingly.  Then you do not have
   to justify the rename of the table based on the future plan.

> Subject: Re: [PATCH 1/3] Rename proxy_authmethods -> authmethods

The title of a patch in this project follows certain convention.
cf. Documentation/SubmittingPatches.

    Subject: [PATCH 1/n] http: factor out parsing of authmethod

    In order to support CURLOPT_PROXYAUTH, there is a code to parse
    the name of an authentication method given as a string into one
    of the CURLAUTH_* constant.  The next step of this series wants
    to reuse the same parser to support CURLOPT_HTTPAUTH in a
    similar way.

    Factor out the loop into a separate helper function.  Since the
    table of authentication methods no longer is only for proxy
    authentication, drop "proxy" prefix from its name while we are
    at it.

or something like that, perhaps.

> Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> ---
>  http.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/http.c b/http.c
> index 229da4d148..318dc5daea 100644
> --- a/http.c
> +++ b/http.c
> @@ -79,7 +79,7 @@ static int proxy_ssl_cert_password_required;
>  static struct {
>  	const char *name;
>  	long curlauth_param;
> -} proxy_authmethods[] = {
> +} authmethods[] = {
>  	{ "basic", CURLAUTH_BASIC },
>  	{ "digest", CURLAUTH_DIGEST },
>  	{ "negotiate", CURLAUTH_GSSNEGOTIATE },
> @@ -470,14 +470,14 @@ static void init_curl_proxy_auth(CURL *result)
>  
>  	if (http_proxy_authmethod) {
>  		int i;
> -		for (i = 0; i < ARRAY_SIZE(proxy_authmethods); i++) {
> -			if (!strcmp(http_proxy_authmethod, proxy_authmethods[i].name)) {
> +		for (i = 0; i < ARRAY_SIZE(authmethods); i++) {
> +			if (!strcmp(http_proxy_authmethod, authmethods[i].name)) {
>  				curl_easy_setopt(result, CURLOPT_PROXYAUTH,
> -						proxy_authmethods[i].curlauth_param);
> +						authmethods[i].curlauth_param);
>  				break;
>  			}
>  		}
> -		if (i == ARRAY_SIZE(proxy_authmethods)) {
> +		if (i == ARRAY_SIZE(authmethods)) {
>  			warning("unsupported proxy authentication method %s: using anyauth",
>  					http_proxy_authmethod);
>  			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
