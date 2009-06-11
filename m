From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Thu, 11 Jun 2009 19:00:43 -0400
Message-ID: <ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 01:03:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEtIi-0005xj-Er
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 01:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763561AbZFKXAq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 19:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763007AbZFKXAp
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 19:00:45 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:34618 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763665AbZFKXAn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2009 19:00:43 -0400
Received: by fxm12 with SMTP id 12so296352fxm.37
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 16:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=kErCj0NIQlqNFxDqZWG0RUlUW5pqypMb5YDDRB/hndo=;
        b=yCYhTHnxF+18R+aRq6am7esKOC2iF7LfIM112k8fQhzUGautckDdNQ9DmnRiHzOhji
         4Fbo2It6EQHmz9NAZH9BaWl/EEaBEcAzY+sQGPezdvwD4DmJK0M25N9sR+H+kOWgfW3F
         cpsj8wNNuASfh3FF+UrfSomiHlvd9ywEBknU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=fOVsouNa6B9/gHfAWGpZ+T9ESAfrXSi1SpOLmaPSHZn5RTgDR50xdTFX16Ocyz8DU+
         bpmnIx/L++nM7Y6yx9sZh2xFlevbde6QVG4GeCxlC1/qWgc0JHvof1l0XFBcPRWiHj4U
         mDzptNmXsdTilGzARxhJN51kaiWieG+HMsVx8=
Received: by 10.223.126.69 with SMTP id b5mr2449556fas.107.1244761243483; Thu, 
	11 Jun 2009 16:00:43 -0700 (PDT)
In-Reply-To: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121372>

Any other thoughts, one way or the other?  Adding proper SSL/PKI
support would really help git adoption in the corporate world.  I am
willing to make any changes necessary to get this into git.git.

~ Mark

On Wed, May 27, 2009 at 11:16 PM, Mark Lodato<lodatom@gmail.com> wrote:
> If an SSL client certificate is enabled (via http.sslcert or
> GIT_SSL_CERT), prompt for the certificate password rather than
> defaulting to OpenSSL's password prompt. =C2=A0This causes the prompt=
 to only
> appear once each run. =C2=A0Previously, OpenSSL prompted the user *ma=
ny*
> times, causing git to be unusable over HTTPS with client-side
> certificates.
>
> Note that the password is stored in memory in the clear while the
> program is running. =C2=A0This may be a security problem if git crash=
es and
> core dumps.
>
> The user is always prompted, even if the certificate is not encrypted=
=2E
> This should be fine; unencrypted certificates are rare and a security
> risk anyway.
>
> Signed-off-by: Mark Lodato <lodatom@gmail.com>
> ---
>
> See http://osdir.com/ml/git/2009-02/msg03402.html for a discussion of
> this topic and an example showing how horrible the current password
> prompts are.
>
> The next patch adds an option to disable this feature. =C2=A0I split =
it into
> two commits in case the configuration option is not wanted.
>
> I did not create any tests because the existing http.sslcert option h=
as
> no tests to begin with.
>
> I would really like to use git over HTTPS with client certs, but the
> current situation is just unusable. =C2=A0So, I'm hoping this gets in=
cluded
> in git.git at some point. =C2=A0I would be happy to hear any comments=
 people
> have about this patch series. =C2=A0Thanks!
>
>
> =C2=A0http.c | =C2=A0 40 +++++++++++++++++++++++++++++++++++++++-
> =C2=A01 files changed, 39 insertions(+), 1 deletions(-)
>
> diff --git a/http.c b/http.c
> index 2e3d649..1fc3444 100644
> --- a/http.c
> +++ b/http.c
> @@ -26,6 +26,8 @@ static long curl_low_speed_time =3D -1;
> =C2=A0static int curl_ftp_no_epsv;
> =C2=A0static const char *curl_http_proxy;
> =C2=A0static char *user_name, *user_pass;
> +static char *ssl_cert_password;
> +static int ssl_cert_password_required;
>
> =C2=A0static struct curl_slist *pragma_header;
>
> @@ -167,6 +169,22 @@ static void init_curl_http_auth(CURL *result)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> +static int has_cert_password(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (ssl_cert_password !=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> + =C2=A0 =C2=A0 =C2=A0 if (ssl_cert =3D=3D NULL || ssl_cert_password_=
required !=3D 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 /* Only prompt the user once. */
> + =C2=A0 =C2=A0 =C2=A0 ssl_cert_password_required =3D -1;
> + =C2=A0 =C2=A0 =C2=A0 ssl_cert_password =3D getpass("Certificate Pas=
sword: ");
> + =C2=A0 =C2=A0 =C2=A0 if (ssl_cert_password !=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssl_cert_password =
=3D xstrdup(ssl_cert_password);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> + =C2=A0 =C2=A0 =C2=A0 } else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> =C2=A0static CURL *get_curl_handle(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CURL *result =3D curl_easy_init();
> @@ -189,6 +207,16 @@ static CURL *get_curl_handle(void)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ssl_cert !=3D NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curl_easy_seto=
pt(result, CURLOPT_SSLCERT, ssl_cert);
> + =C2=A0 =C2=A0 =C2=A0 if (has_cert_password())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(r=
esult,
> +#if LIBCURL_VERSION_NUM >=3D 0x071700
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CURLOPT_KEYPASSWD,
> +#elif LIBCURL_VERSION_NUM >=3D 0x070903
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CURLOPT_SSLKEYPASSWD,
> +#else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CURLOPT_SSLCERTPASSWD,
> +#endif
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssl_cert_password);
> =C2=A0#if LIBCURL_VERSION_NUM >=3D 0x070902
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ssl_key !=3D NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curl_easy_seto=
pt(result, CURLOPT_SSLKEY, ssl_key);
> @@ -329,8 +357,11 @@ void http_init(struct remote *remote)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (getenv("GIT_CURL_FTP_NO_EPSV"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curl_ftp_no_ep=
sv =3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 if (remote && remote->url && remote->url[0])
> + =C2=A0 =C2=A0 =C2=A0 if (remote && remote->url && remote->url[0]) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http_auth_init=
(remote->url[0]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(rem=
ote->url[0], "https://"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ssl_cert_password_required =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0#ifndef NO_CURL_EASY_DUPHANDLE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0curl_default =3D get_curl_handle();
> @@ -370,6 +401,13 @@ void http_cleanup(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free((void *)c=
url_http_proxy);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curl_http_prox=
y =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ssl_cert_password !=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(ssl_cert_pa=
ssword, 0, strlen(ssl_cert_password));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(ssl_cert_pass=
word);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ssl_cert_password =
=3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 ssl_cert_password_required =3D 0;
> =C2=A0}
>
> =C2=A0struct active_request_slot *get_active_slot(void)
> --
> 1.6.3.1
>
>
