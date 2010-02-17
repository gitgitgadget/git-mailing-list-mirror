From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH v4 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 support
Date: Wed, 17 Feb 2010 18:17:43 +0900
Message-ID: <4B7BB437.1060608@dcl.info.waseda.ac.jp>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <7vljeyp1rj.fsf@alter.siamese.dyndns.org> <4B764B67.1020402@dcl.info.waseda.ac.jp> <7vsk95sht6.fsf@alter.siamese.dyndns.org> <7v8watg04g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 10:18:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhg36-0000Tw-5f
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 10:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245Ab0BQJSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 04:18:12 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:57943 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab0BQJSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 04:18:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id C226DEDAE13;
	Wed, 17 Feb 2010 18:18:07 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cg5CeiA0FLeP; Wed, 17 Feb 2010 18:18:06 +0900 (JST)
Received: from [192.168.10.21] (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id B03B9EDAE0F;
	Wed, 17 Feb 2010 18:18:06 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091211 Shredder/3.0
In-Reply-To: <7v8watg04g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140221>

On 2010=E5=B9=B402=E6=9C=8816=E6=97=A5 15:34, Junio C Hamano wrote:
>
> So here is a replacement version to see if I remember all the points
> raised in the thread.
>
>   * Use of HMAC_Init() is kept, so people with ancient OpenSSL can us=
e it;
>
>   * Lose "overallocate with xcalloc() and use strlen() to see how lon=
g the
>     result is" pattern; EVP_DecodeBlock() and EVP_EncodeBlock() shoul=
d be
>     returning the length anyway, so use that directly;
>
>   * Comment style fixes;
>
>   * Lose "fprintf() then exit()"; die() instead; and
>
>   * Call HMAC_CTX_cleanup() when done;
>
> I didn't check the validity of the last one at all.  Please see if th=
ere
> is any funnies.

Thanks for your repairing.

I tested it and found one point have to be repaired,

     response_64 =3D xmalloc(ENCODED_SIZE(resp_len));
should be,
     response_64 =3D xmalloc(ENCODED_SIZE(resp_len) + 1);
for '\0'. This was the problem in my previous patch.
I noticed it by your indication, thanks.

And it seems that rest part of this patch doesn't contain problem.

I prepared the patch to repair this point.
I'll send it later. If you like it, please use.

>
> -- >8 --
> Subject: imap-send: support CRAM-MD5 authentication
>
> CRAM-MD5 authentication ought to be independent from SSL, but NO_OPEN=
SSL
> build will not support this because the base64 and md5 code are used =
from
> the OpenSSL library in this implementation.
>
> Signed-off-by: Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>
> Signed-off-by: Junio C Hamano<gitster@pobox.com>
>
> ---
>   Documentation/git-imap-send.txt |    4 +
>   imap-send.c                     |  146 ++++++++++++++++++++++++++++=
+++++++----
>   2 files changed, 135 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap=
-send.txt
> index 57db955..6cafbe2 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -71,6 +71,10 @@ imap.preformattedHTML::
>   	option causes Thunderbird to send the patch as a plain/text,
>   	format=3Dfixed email.  Default is `false`.
>
> +imap.authMethod::
> +	Specify authenticate method for authentication with IMAP server.
> +	Current supported method is 'CRAM-MD5' only.
> +
>   Examples
>   ~~~~~~~~
>
> diff --git a/imap-send.c b/imap-send.c
> index ba72fa4..bf1cd73 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -27,6 +27,9 @@
>   #include "run-command.h"
>   #ifdef NO_OPENSSL
>   typedef void *SSL;
> +#else
> +#include<openssl/evp.h>
> +#include<openssl/hmac.h>
>   #endif
>
>   struct store_conf {
> @@ -140,6 +143,20 @@ struct imap_server_conf {
>   	int use_ssl;
>   	int ssl_verify;
>   	int use_html;
> +	char *auth_method;
> +};
> +
> +static struct imap_server_conf server =3D {
> +	NULL,	/* name */
> +	NULL,	/* tunnel */
> +	NULL,	/* host */
> +	0,	/* port */
> +	NULL,	/* user */
> +	NULL,	/* pass */
> +	0,   	/* use_ssl */
> +	1,   	/* ssl_verify */
> +	0,   	/* use_html */
> +	NULL,	/* auth_method */
>   };
>
>   struct imap_store_conf {
> @@ -214,6 +231,7 @@ enum CAPABILITY {
>   	LITERALPLUS,
>   	NAMESPACE,
>   	STARTTLS,
> +	AUTH_CRAM_MD5,
>   };
>
>   static const char *cap_list[] =3D {
> @@ -222,6 +240,7 @@ static const char *cap_list[] =3D {
>   	"LITERAL+",
>   	"NAMESPACE",
>   	"STARTTLS",
> +	"AUTH=3DCRAM-MD5",
>   };
>
>   #define RESP_OK    0
> @@ -949,6 +968,87 @@ static void imap_close_store(struct store *ctx)
>   	free(ctx);
>   }
>
> +#ifndef NO_OPENSSL
> +
> +/*
> + * hexchar() and cram() functions are based on the code from the isy=
nc
> + * project (http://isync.sf.net/).
> + */
> +static char hexchar(unsigned int b)
> +{
> +	return b<  10 ? '0' + b : 'a' + (b - 10);
> +}
> +
> +#define ENCODED_SIZE(n) (4*((n+2)/3))
> +static char *cram(const char *challenge_64, const char *user, const =
char *pass)
> +{
> +	int i, resp_len, encoded_len, decoded_len;
> +	HMAC_CTX hmac;
> +	unsigned char hash[16];
> +	char hex[33];
> +	char *response, *response_64, *challenge;
> +
> +	/*
> +	 * length of challenge_64 (i.e. base-64 encoded string) is a good
> +	 * enough upper bound for challenge (decoded result).
> +	 */
> +	encoded_len =3D strlen(challenge_64);
> +	challenge =3D xmalloc(encoded_len);
> +	decoded_len =3D EVP_DecodeBlock((unsigned char *)challenge,
> +				      (unsigned char *)challenge_64, encoded_len);
> +	if (decoded_len<  0)
> +		die("invalid challenge %s", challenge_64);
> +	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
> +	HMAC_Update(&hmac, (unsigned char *)challenge, decoded_len);
> +	HMAC_Final(&hmac, hash, NULL);
> +	HMAC_CTX_cleanup(&hmac);
> +
> +	hex[32] =3D 0;
> +	for (i =3D 0; i<  16; i++) {
> +		hex[2 * i] =3D hexchar((hash[i]>>  4)&  0xf);
> +		hex[2 * i + 1] =3D hexchar(hash[i]&  0xf);
> +	}
> +
> +	/* response: "<user>  <digest in hex>" */
> +	resp_len =3D strlen(user) + 1 + strlen(hex) + 1;
> +	response =3D xmalloc(resp_len);
> +	sprintf(response, "%s %s", user, hex);
> +
> +	response_64 =3D xmalloc(ENCODED_SIZE(resp_len));
> +	encoded_len =3D EVP_EncodeBlock((unsigned char *)response_64,
> +				      (unsigned char *)response, resp_len);
> +	if (encoded_len<  0)
> +		die("EVP_EncodeBlock error");
> +	response_64[encoded_len] =3D '\0';
> +	return (char *)response_64;
> +}
> +
> +#else
> +
> +static char *cram(const char *challenge_64, const char *user, const =
char *pass)
> +{
> +	die("If you want to use CRAM-MD5 authenticate method, "
> +	    "you have to build git-imap-send with OpenSSL library.");
> +}
> +
> +#endif
> +
> +static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cm=
d, const char *prompt)
> +{
> +	int ret;
> +	char *response;
> +
> +	response =3D cram(prompt, server.user, server.pass);
> +
> +	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(respons=
e));
> +	if (ret !=3D strlen(response))
> +		return error("IMAP error: sending response failed\n");
> +
> +	free(response);
> +
> +	return 0;
> +}
> +
>   static struct store *imap_open_store(struct imap_server_conf *srvc)
>   {
>   	struct imap_store *ctx;
> @@ -1130,9 +1230,34 @@ static struct store *imap_open_store(struct im=
ap_server_conf *srvc)
>   		if (!imap->buf.sock.ssl)
>   			imap_warn("*** IMAP Warning *** Password is being "
>   				  "sent in the clear\n");
> -		if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->=
pass) !=3D RESP_OK) {
> -			fprintf(stderr, "IMAP error: LOGIN failed\n");
> -			goto bail;
> +
> +		if (srvc->auth_method) {
> +			struct imap_cmd_cb cb;
> +
> +			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
> +				if (!CAP(AUTH_CRAM_MD5)) {
> +					fprintf(stderr, "You specified"
> +						"CRAM-MD5 as authentication method, "
> +						"but %s doesn't support it.\n", srvc->host);
> +					goto bail;
> +				}
> +				/* CRAM-MD5 */
> +
> +				memset(&cb, 0, sizeof(cb));
> +				cb.cont =3D auth_cram_md5;
> +				if (imap_exec(ctx,&cb, "AUTHENTICATE CRAM-MD5") !=3D RESP_OK) {
> +					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
> +					goto bail;
> +				}
> +			} else {
> +				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host=
);
> +				goto bail;
> +			}
> +		} else {
> +			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc-=
>pass) !=3D RESP_OK) {
> +				fprintf(stderr, "IMAP error: LOGIN failed\n");
> +				goto bail;
> +			}
>   		}
>   	} /* !preauth */
>
> @@ -1310,18 +1435,6 @@ static int split_msg(struct msg_data *all_msgs=
, struct msg_data *msg, int *ofs)
>   	return 1;
>   }
>
> -static struct imap_server_conf server =3D {
> -	NULL,	/* name */
> -	NULL,	/* tunnel */
> -	NULL,	/* host */
> -	0,	/* port */
> -	NULL,	/* user */
> -	NULL,	/* pass */
> -	0,   	/* use_ssl */
> -	1,   	/* ssl_verify */
> -	0,   	/* use_html */
> -};
> -
>   static char *imap_folder;
>
>   static int git_imap_config(const char *key, const char *val, void *=
cb)
> @@ -1361,6 +1474,9 @@ static int git_imap_config(const char *key, con=
st char *val, void *cb)
>   		server.port =3D git_config_int(key, val);
>   	else if (!strcmp("tunnel", key))
>   		server.tunnel =3D xstrdup(val);
> +	else if (!strcmp("authmethod", key))
> +		server.auth_method =3D xstrdup(val);
> +
>   	return 0;
>   }
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
