From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] http-push: don't always prompt for password (Was
 Re: [ANNOUNCE] Git 1.7.8.rc0)
Date: Wed, 02 Nov 2011 15:08:08 +0100
Message-ID: <4EB14EC8.2070400@drmicha.warpmail.net>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org> <4EAEAE13.50101@atlas-elektronik.com> <4EAFC18A.1070502@atlas-elektronik.com> <7vmxcfn23i.fsf@alter.siamese.dyndns.org> <4EB104EA.2040001@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 15:08:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLbUH-0000Nr-M4
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 15:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664Ab1KBOIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 10:08:12 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59483 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753673Ab1KBOIL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 10:08:11 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1755B2068D;
	Wed,  2 Nov 2011 10:08:11 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 02 Nov 2011 10:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Ez6AMYgI32aIaFjbNyEQ7C
	JLgLM=; b=KDDWcfAtRuGO3StjaSH/cOMxbPw/vUdwJut1dNEoTAXDqq9ykEKh/e
	sn85Dr8F4kldrGFInQ3AizLN6X0T8kRJnjzrWAd86hbgLW14xDJ/DPwzOnjWHSpN
	+XlQkZlK82ay+YUIvspbrzYXER9uU39dfuQ8HimDmfrgmcuO4sNIc=
X-Sasl-enc: 9s5uwct1dYEGGWe4chVUJVqm2q6uAEhszh0o9P996I50 1320242890
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3BE414833A4;
	Wed,  2 Nov 2011 10:08:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <4EB104EA.2040001@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184632>

Stefan N=C3=A4we venit, vidit, dixit 02.11.2011 09:52:
> Am 01.11.2011 19:12, schrieb Junio C Hamano:
>>
>> There are only handful of commits that even remotely touch http rela=
ted
>> codepath between v1.7.7 and v1.7.8-rc0:
>>
>>   * deba493 http_init: accept separate URL parameter
>>
>>   This could change the URL string given to http_auth_init().
>>
>>   * 070b4dd http: use hostname in credential description
>>
>>   This only changes the prompt string; as far as I understand it, th=
e
>>   condition the password is prompted in the callsites of git_getpass=
()
>>   has not changed.
>>
>>   * 6cdf022 remote-curl: Fix warning after HTTP failure
>>   * be22d92 http: avoid empty error messages for some curl errors
>>   * 8abc508 http: remove extra newline in error message
>>   * 8d677ed http: retry authentication failures for all http request=
s
>>   * 28d0c10 remote-curl: don't retry auth failures with dumb protoco=
l
>>
>>   These shouldn't affect anything wrt prompting, unless you are some=
how
>>   internally reauthenticating.
>>
>> Could you try reverting deba493 and retest, and then if the behaviou=
r is
>> the same "need ENTER", further revert 070b4dd and retest?
>=20
> I did a little more testing.
> This WIP makes it work for me (i.e. "need ENTER" is gone, works with
> and without .netrc, with 'https://host/repo.git' and=20
> 'https://user@host...' URL). Needs testing, of course.
>=20
> ---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---
> diff --git a/http.c b/http.c
> index a4bc770..008ad72 100644
> --- a/http.c
> +++ b/http.c
> @@ -279,8 +279,6 @@ static CURL *get_curl_handle(void)
>         curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
>  #endif
>=20
> -       init_curl_http_auth(result);
> -
>         if (ssl_cert !=3D NULL)
>                 curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
>         if (has_cert_password())
> @@ -846,7 +844,7 @@ static int http_request(const char *url, void *re=
sult, int target, int options)
>                 else if (missing_target(&results))
>                         ret =3D HTTP_MISSING_TARGET;
>                 else if (results.http_code =3D=3D 401) {
> -                       if (user_name) {
> +                       if (user_name && user_pass) {
>                                 ret =3D HTTP_NOAUTH;
>                         } else {
>                                 /*
> @@ -855,7 +853,8 @@ static int http_request(const char *url, void *re=
sult, int target, int options)
>                                  * but that is non-portable.  Using g=
it_getpass() can at least be stubbed
>                                  * on other platforms with a differen=
t implementation if/when necessary.
>                                  */
> -                               user_name =3D xstrdup(git_getpass_wit=
h_description("Username", description));
> +                               if (!user_name)
> +                                       user_name =3D xstrdup(git_get=
pass_with_description("Username", description));
>                                 init_curl_http_auth(slot->curl);
>                                 ret =3D HTTP_REAUTH;
>                         }
> ---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---
>=20
>=20
> Regards,
>   Stefan
Thanks!

Tested-by: Michael J Gruber <git@drmicha.warpmail.net>

More specifically, I ran our test suite (next plus Stefan's patch), and
tested

https://user@host with .netrc and with askpass
https://host with .netrc

The latter fails with askpass because we ask
Password for 'host'
and not
Password for 'user@host'
but that is true both with and without the patch. (I thought we had
changed that, but I guess it's cooking.)

Michael
