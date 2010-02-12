From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH v3 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 support
Date: Fri, 12 Feb 2010 20:23:12 +0900
Message-ID: <4B753A20.5060006@dcl.info.waseda.ac.jp>
References: <40aa078e1002110655n120b14b9y242a57d0e1bd3e96@mail.gmail.com> <1265900785-12044-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <7vaavf4iso.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 12:24:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nftdb-0000AK-3t
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 12:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab0BLLYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 06:24:36 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:58017 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab0BLLYf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 06:24:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 70BF8EBB448;
	Fri, 12 Feb 2010 20:24:34 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vKA-V8dqQMRA; Fri, 12 Feb 2010 20:24:34 +0900 (JST)
Received: from [192.168.10.21] (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 16EE2EBB445;
	Fri, 12 Feb 2010 20:24:34 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091211 Shredder/3.0
In-Reply-To: <7vaavf4iso.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139684>

On 2010=E5=B9=B402=E6=9C=8812=E6=97=A5 05:30, Junio C Hamano wrote:
> Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>  writes:
>
>> This patch makes git-imap-send CRAM-MD5 authenticate method ready.
>> In theory, CRAM-MD5 authenticate method doesn't depend on SSL,
>> but for easy of maintainance, this patch uses base64 and md5 stuffs =
of OpenSSL.
>> So if you want to use CRAM-MD5 authenticate method,
>> you have to build git-imap-send with OpenSSL library.
>
> Except for some grammer and length of the third line this description
> looks good.  It concisely explains the design decision.

Thanks, I'll separate and fix the third line.

>
>> v3: Erik's noticed that there were some garbage lines in this patch.
>> I removed these. And 2/2 wasn't changed, I'm sending 1/2 only.
>
> Please put these two lines below three-dash lines.  People reading "g=
it
> log" output 6 months from now won't know nor care what v2 looked like=
=2E

Do you mean like this?

    ---
    v3: Erik's noticed that there were some garbage lines in this patch=
=2E
    I removed these. And 2/2 wasn't changed, I'm sending 1/2 only.

Sorry, I don't know well about custom of Git.

>
>> diff --git a/imap-send.c b/imap-send.c
>> index ba72fa4..caa4e1b 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -25,10 +25,16 @@
>>   #include "cache.h"
>>   #include "exec_cmd.h"
>>   #include "run-command.h"
>> +
>>   #ifdef NO_OPENSSL
>>   typedef void *SSL;
>> +#else
>> +#include<openssl/evp.h>
>> +#include<openssl/hmac.h>
>>   #endif
>>
>> +static int login;
>> +
>
> Does this variable have a meaning?  login what?
>
>   - "login attempted--if we have failed, the authenticator is wrong--=
-no
>     point retrying"?
>
>   - "login attempt succeeded and we are now authenticated"?  "logged_=
in"
>     would be a better name if this is the case.
>
> Something else?

This is remnant of my dirty code. I removed it.

>
>> @@ -526,8 +548,9 @@ static struct imap_cmd *v_issue_imap_cmd(struct =
imap_store *ctx,
>>   		get_cmd_result(ctx, NULL);
>>
>>   	bufl =3D nfsnprintf(buf, sizeof(buf), cmd->cb.data ? CAP(LITERALP=
LUS) ?
>> -			   "%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
>> -			   cmd->tag, cmd->cmd, cmd->cb.dlen);
>> +			  "%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
>> +			  cmd->tag, cmd->cmd, cmd->cb.dlen);
>> +
>
> What did you change here?  Indentation?

It is accidentally indentation, removed.

>
>> @@ -949,6 +972,72 @@ static void imap_close_store(struct store *ctx)
>>   	free(ctx);
>>   }
>>
>> +/*
>> + * hexchar() and cram() functions are
>> + * based on ones of isync project ... http://isync.sf.net/
>> + * Thanks!
>> + */
>> +static char hexchar(unsigned int b)
>> +{
>> +	return b<  10 ? '0' + b : 'a' + (b - 10);
>> +}
>> +
>
> Do you need the above helper function outside "#ifndef NO_OPENSSL" bl=
ock?

Clearly not... I moved it to inside of #ifdef ... #endif block.

>
>> +#ifndef NO_OPENSSL
>> +
>> +static char *cram(const char *challenge_64, const char *user, const=
 char *pass)
>> +{
>> +	int i;
>> +	HMAC_CTX hmac;
>> +	char hash[16], hex[33], challenge[256], response[256];
>> +	char *response_64;
>> +
>> +	memset(challenge, 0, 256);
>> +	EVP_DecodeBlock((unsigned char *)challenge, (unsigned char *)chall=
enge_64, strlen(challenge_64));
>
> In this codepath, is there anything that guarantees that the decoded
> result is short enough to fit in challenge[256]?

I was too optimistic, my next patch
caliculate exact size of these buffer.

>
>> +	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
>> +	HMAC_Update(&hmac, (unsigned char *)challenge, strlen(challenge));
>> +	HMAC_Final(&hmac, (unsigned char *)hash, NULL);
>
> Hmph, if challenge needs to be always casted to (unsigned char*), per=
haps
> is it better declared as such?  (not rhetorical---doing so might need=
 cast
> in other calls but I am too lazy to check myself so instead I am aski=
ng).

If I declare them as unsigned char *,
then another casting for strlen() required. And these are more than
current casting(current casts:6, calling strlen:7).

>
>> +	hex[32] =3D 0;
>> +	for (i =3D 0; i<  16; i++) {
>> +		hex[2 * i] =3D hexchar((hash[i]>>  4)&  0xf);
>> +		hex[2 * i + 1] =3D hexchar(hash[i]&  0xf);
>> +	}
>> +
>> +	memset(response, 0, 256);
>> +	snprintf(response, 256, "%s %s", user, hex);
>
> "hex" would be of a limited and known length, but username could be o=
verly
> long, no?  Is it Ok to truncate that silently using snprintf while
> creating response (not rhetorical---your caller may be barfing on ove=
rlong
> user name, but I am too lazy to check, so instead I am asking)?
>

Exact calculation of required length of buffer is possible,
I implemented.

>> +	response_64 =3D calloc(256 , sizeof(char));
>
> Do you need to allocate this, or just have the caller supply a pointe=
r
> into an array on its stack as an argument to this function?

Calculating size of response_64 before calling cram() is possible.
But doing ENCODED_SIZE(strlen(user) + 1 + strlen(hex) + 1) is not
read for readability, I think.
# Please think that ENCODED_SIZE(n) is maximum required buffer size
# encoding n bytes by base64.

>
>> +	EVP_EncodeBlock((unsigned char *)response_64, (unsigned char *)res=
ponse, strlen(response));
>
> Again, is there anything that guarantees response would fit after enc=
oding
> in respose_64 in this codepath?
>
>> +	return response_64;
>
>> +#else
>> +
>> +static char *cram(const char *challenge_64 __used, const char *user=
 __used, const char *pass __used)
>
> Does everybody understand __used annotation these days, or just gcc?

This was custom of perf of linux kernel, and improper for Git, I remove=
d=20
these.

>
>> +{
>> +	fprintf(stderr, "If you want to use CRAM-MD5 authenticate method,"
>> +		"you have to build git-imap-send with OpenSSL library\n");
>> +	exit(0);
>
> Should this exit with "success"?

Cleary not...

>
>> +static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *c=
md, const char *prompt)
>> +{
>> +	int ret;
>> +	char *response;
>> +
>> +	response =3D cram(prompt, server.user, server.pass);
>> +	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(respon=
se));
>> +	if (ret !=3D strlen(response)) {
>> +		fprintf(stderr, "IMAP error: sending response failed\n");
>> +		return -1;
>
> Perhaps 'return error("message fmt without LF at the end", args...);'=
?

I didn't know error(), I'll use it.

Thanks for your detailed review!
I'll send v4 later.
