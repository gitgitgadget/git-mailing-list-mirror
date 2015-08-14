From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv4] http: add support for specifying the SSL version
Date: Fri, 14 Aug 2015 13:57:42 -0400
Message-ID: <CAPig+cSUR4CEbg3HobZPHyWfGFoGzctP7BbTswg8vyXjGmma6Q@mail.gmail.com>
References: <1439570135-17324-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 19:58:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQJEq-0002q8-MF
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 19:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbbHNR5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 13:57:45 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:32941 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933067AbbHNR5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 13:57:43 -0400
Received: by ykll84 with SMTP id l84so12098994ykl.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NPEpwB3NBLD94THcl9QT6WNBIa4DaP75Jan53dDTVxY=;
        b=irGCMLZ4LnvnWEv0Mp6kzp5bkrNHfmNwXysKUjlHNmvrf87C/5Hiq2llYj0yX73O+5
         lfUPJP4WaCHhHUODL2YjfcP+JKscb4JRtlGmM/80JXNJ6i6yANzhcJtmp3O9h2naol0Q
         XTNwtO4w2VZ39fth7+bNCWQ1lcqG5pImddrqIZUdn2OusGiTzRRvv1U3UYHmm76C1qtl
         1bGyMG4dywPq4Px8Vv6oD1d8oKXtNvfyjeRh2pe5RBq8I6LX02rwTiU4r4ZSWupr9lo4
         5/G8CTBDBvgF/IBVRWV+/7nrqkuJ9QeVMTEEKcvQzwGX7Wjd0+VBtp0aQLvmwZO3kJh+
         VosQ==
X-Received: by 10.170.172.84 with SMTP id o81mr17082056ykd.69.1439575062744;
 Fri, 14 Aug 2015 10:57:42 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 14 Aug 2015 10:57:42 -0700 (PDT)
In-Reply-To: <1439570135-17324-1-git-send-email-gitter.spiros@gmail.com>
X-Google-Sender-Auth: U4-jxKN4n9digD37uJeT0p1Y6Xw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275920>

On Fri, Aug 14, 2015 at 12:35 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Teach git about a new option, "http.sslVersion", which permits one to
> specify the SSL version  to use when negotiating SSL connections.  The
> setting can be overridden by the GIT_SSL_VERSION environment
> variable.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the fourth revision of the patch. Changes from previous
>
> - Used only ARRAY_SIZE for walking sslversions (Eric, Junio)
> - Fixed some problems of style: spurious blanks in if stm, wrapped warning

Thanks, this is looking better. A few very minor style-related
comments below (most or all of which were mentioned previously, I
think)...

> diff --git a/http.c b/http.c
> index e9c6fdd..83118b5 100644
> --- a/http.c
> +++ b/http.c
> @@ -364,9 +380,22 @@ static CURL *get_curl_handle(void)
>         if (http_proactive_auth)
>                 init_curl_http_auth(result);
>
> +       if (getenv("GIT_SSL_VERSION"))
> +               ssl_version = getenv("GIT_SSL_VERSION");
> +       if (ssl_version != NULL && *ssl_version) {

In this codebase, it is customary to omit the "!= NULL", so:

    if (ssl_version && *ssl_version) {

> +               int i;
> +               for ( i = 0; i < ARRAY_SIZE(sslversions); i++ ) {

Style: Drop space after open '(' and before close ')' in 'for' loop:

    for (i = 0; i < ARRAY_SIZE(sslversions); i++) {

> +                       if (!strcmp(ssl_version,sslversions[i].name)) {

Style: Insert space after comma.

> +                               curl_easy_setopt(result, CURLOPT_SSLVERSION,
> +                                       sslversions[i].ssl_version);
> +                               break;
> +                       }
> +               }
> +               if (i == ARRAY_SIZE(sslversions)) warning("unsupported ssl version %s: using default",ssl_version);

warning() call should be on its own line.

Style: Insert space after comma.

> +       }
> +
>         if (getenv("GIT_SSL_CIPHER_LIST"))
>                 ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
> -
>         if (ssl_cipherlist != NULL && *ssl_cipherlist)
>                 curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
>                                 ssl_cipherlist);
> --
> 2.5.0.235.gb9bd8dc
