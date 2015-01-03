From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Sat, 3 Jan 2015 17:45:09 +0000
Message-ID: <20150103174509.GA1025060@vauxhall.crustytoothpaste.net>
References: <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
 <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <20150103111922.GB27793@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Cc: git@vger.kernel.org,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 03 18:45:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7SlT-0007ui-PF
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 18:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbbACRpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2015 12:45:18 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56612 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053AbbACRpR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jan 2015 12:45:17 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3A44B2808F;
	Sat,  3 Jan 2015 17:45:15 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20150103111922.GB27793@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261997>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2015 at 06:19:23AM -0500, Jeff King wrote:
>This pattern gets repeated in several places. Now that
>http_passwordless_auth is a global, can we handle it automatically for
>the callers, as below (which, aside from compiling, is completely
>untested by me)?

This looks good (although I haven't tested it).

>Note that this is in a slightly different boat than credential_fill.
>Ideally we would also handle picking up credentials on behalf of the
>callers of get_curl_handle/handle_curl_result. But that may involve
>significant work and/or prompting the user, which we _must_ avoid if we
>do not know if we are going to retry the request (and only the caller
>knows that for sure). However, in the case of http_passwordless_auth, we
>are just setting a flag, so it's OK to do it preemptively.

Right.  We already prompt the user for a username and password in that=20
case, so we already have the credentials that we need.

>diff --git a/http.c b/http.c
>index 040f362..2bbcdf1 100644
>--- a/http.c
>+++ b/http.c
>@@ -62,6 +62,8 @@ static const char *user_agent;
>
> static struct credential cert_auth =3D CREDENTIAL_INIT;
> static int ssl_cert_password_required;
>+/* Should we allow non-password-based authentication (e.g. GSSAPI)? */
>+static int http_passwordless_auth =3D 1;
>
> static struct curl_slist *pragma_header;
> static struct curl_slist *no_pragma_header;
>@@ -318,7 +320,12 @@ static CURL *get_curl_handle(void)
> 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
> #endif
> #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
>-	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
>+	{
>+		int flags =3D CURLAUTH_ANY;

I think this needs to be unsigned long or it can cause undefined=20
behavior, since libcurl uses unsigned long in the flags.  I'll fix that=20
up when I reroll.  I'll need your sign-off since it will essentially be=20
your work.

>+		if (!http_passwordless_auth)
>+			flags &=3D ~CURLAUTH_GSSNEGOTIATE;
>+		curl_easy_setopt(result, CURLOPT_HTTPAUTH, flags);
>+	}
> #endif
>
> 	if (http_proactive_auth)
>@@ -870,6 +877,7 @@ int handle_curl_result(struct slot_results *results)
> 			credential_reject(&http_auth);
> 			return HTTP_NOAUTH;
> 		} else {
>+			http_passwordless_auth =3D 0;
> 			return HTTP_REAUTH;
> 		}
> 	} else {
>
>
>Note that you could probably drop http_passwordless_auth completely, and
>just keep a:
>
>  static int http_auth_methods =3D CURLAUTH_ANY;
>
>and then drop CURLAUTH_GSSNEGOTIATE from it instead of setting the
>passwordless_auth flag to 0 (again, it happens in one place, so I don't
>know that it needs an extra layer of abstraction).

This does seem to handle both cases well.  It also has the pleasant=20
side effect of being static.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUqCqlAAoJEL9TXYEfUvaLFSoQAJAilDE7VNs0dDrEHzaTFKes
Fg2bKKPQ03doEHxM5zZkINU4kTre1naelP6Zw3RiGZwlzrLdUNCCvWSefl3HAoLJ
W41ynXOqIGcBc4LyzODwvdqKk2Na4dtqUd229Eat/eFw/kL93+9NZVdai/OAGwVf
p0e9m4ry1pvWw6QUCXNlOQu+6sxupfdHaEs60hJnbusOlcMOI5ExTiNPTYYc+wL5
I1Rz6CH82ASZX30/8/UJA8SkcJHlRlI0AMkz2sq434PIiA92J4nBL9nVX5pvKnHy
xHT612IOun6FBrsLrUoxqzoeJXnTz5AJoysYB07N8WyBYn2KlaEjc4zW1BcVFcg1
fxtpA/MVvnw34vCpSlIDsdVkH0nHrf0f4KWgFthN/yugpxGfzfiXpSDy0SKG1Nsp
+gsC5O0AwUHf/5zWvnp7b2XYeZam9LTOB1oRSYsXrPg4+Z01aztxQCYPx9NVLxdE
oNuoe2/9kdAY4slhmsHkw+h8PsooVrffKRhuMPVUsGQ37TC9eglsrl6pGMftiK1S
WvqoqqxouS6cJMEaMm2g5Hj0uQP6AGdjF2TLFXv9G/zq+8eZZpztkhM3i6LxVfvu
FpQe9qxC20cpduA2TB+oOXJjh26S0mrT93lQPtkqiVg4utF+htSdexDtmai4+mpz
n8TpfNfi0NZx4K1VS2sA
=yxGG
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
