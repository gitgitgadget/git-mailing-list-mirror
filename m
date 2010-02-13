From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH v4 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 support
Date: Sat, 13 Feb 2010 15:49:11 +0900
Message-ID: <4B764B67.1020402@dcl.info.waseda.ac.jp>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <7vljeyp1rj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 07:49:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgBom-0005gD-6T
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 07:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab0BMGtP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 01:49:15 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:49891 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab0BMGtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 01:49:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 79603EC0394;
	Sat, 13 Feb 2010 15:49:13 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kbXtU+ikJpKI; Sat, 13 Feb 2010 15:49:12 +0900 (JST)
Received: from [192.168.10.21] (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 9C097EC0390;
	Sat, 13 Feb 2010 15:49:12 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091211 Shredder/3.0
In-Reply-To: <7vljeyp1rj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139776>

On 2010=E5=B9=B402=E6=9C=8813=E6=97=A5 06:44, Junio C Hamano wrote:
> Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>  writes:
>
>> This patch makes git-imap-send CRAM-MD5 authenticate method ready.
>> In theory, CRAM-MD5 authenticate method doesn't depend on SSL.
>> But for easiness of maintainance, this patch uses base64 and md5 stu=
ffs of OpenSSL.
>> So if you want to use CRAM-MD5 authenticate method,
>> you have to build git-imap-send with OpenSSL library.
>>
>> ---
>> v3: Erik noticed that there were some garbage lines in this patch.
>> I removed these. And 2/2 wasn't changed, I'm sending 1/2 only.
>>
>> v4: Based on Junio's indication, I cleaned up some points of imap-se=
nd.c .
>>
>> Cc: Erik Faye-Lund<kusmabite@googlemail.com>
>> Cc: Jakub Narebski<jnareb@gmail.com>
>> Cc: Linus Torvalds<torvalds@linux-foundation.org>
>> Cc: Jeff King<peff@peff.net>
>> Signed-off-by: Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>
>> ---
>
> I actually meant that the comment regarding the history of patch
> iterations should go after the three-dash.  Most notably, we want you=
r
> S-o-b in the commit log.  That is:
>
> ----------------------------------------------------------------
> 	Subject: well thought out summary of what the patch is about
>
> 	Problem description, and rationale to justify the particular
>          solution you chose.
>
>          Signed-off-by: Your Name<your@address.example.com>
> 	---
>
> 	 Comments that may help the reviewers while the patch is
>           going through the review cycle, but would not be useful
>           after this particular version is applied and the commit
>           is shown in "git log" output
>
> 	 diffstat
>
>           diff --git ... patch text ...
> ----------------------------------------------------------------
>

I didn't know that Git has such a convenient feature.
I'll move version specific comments to below of three-dash line.

>> +
>> +	/* challenge must be shorter than challenge_64
>> +	 * because we are decoding base64*/
>
> Just a style thing but
>
> 	/*
>           * We prefer to write our multi-line
>           * comments like this.
>           */
>

OK, I'll modify this comment.

>> +	challenge =3D xcalloc(strlen(challenge_64) + 1, sizeof(char));
>
> Why not xmalloc()?  Does EVP_DecodeBlock() want a zero-filled buffer?
>

Because strlen(challenge_64) is the upper limit of length of challenge.
So tail part of challenge may not be filled by EVP_DecodeBlock(),=20
non-zero filled buffer produces not NULL terminated string.
I've confused once by this problem before.

>> +	EVP_DecodeBlock((unsigned char *)challenge, (unsigned char *)chall=
enge_64, strlen(challenge_64));
>
> Does EVP_DecodeBlock diagnose an error in the input and return an err=
or
> code?  How are you supposed to protect yourself from the server givin=
g you
> a corrupt challenge that does not decode properly?
>

I've forgot processing return value from EVP_DecodeBlock().
I'll fix it.

>> +	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
>> +	HMAC_Update(&hmac, (unsigned char *)challenge, strlen(challenge));
>> +	HMAC_Final(&hmac, hash, NULL);
>
> Is there any clean-up necessary after you are done with hmac?

I've forgot calling HMAC_CTX_cleanup().

> EVP_md5()
> returns a pointer to EVP_MD but how and when is that resource release=
d?

prototype of EVP_md5() is
     const EVP_MD *EVP_md5(void);
EVP_md5() only returns const value. There is no new resource allocation=
=2E
e.g. EVP_md() =3D=3D EVP_md() is true.

>
> By the way, HMAC_Init() seems to be deprecated and kept only for 0.9.=
6b
> compatibility.
>
>      http://www.openssl.org/docs/crypto/hmac.html

The document of OpenSSL doesn't describe HMAC_init_ex() well.
I can't know that what the parameter ENGINE *impl means...
So I'd like to use HMAC_Init(), if it is for compatibility.

>
>> +	hex[32] =3D 0;
>> +	for (i =3D 0; i<  16; i++) {
>> +		hex[2 * i] =3D hexchar((hash[i]>>  4)&  0xf);
>> +		hex[2 * i + 1] =3D hexchar(hash[i]&  0xf);
>> +	}
>> +
>> +	/* length: "<user>  <digest in hex>" */
>> +	resp_len =3D strlen(user) + 1 + strlen(hex) + 1;
>> +	response =3D xcalloc(resp_len, sizeof(char));
>> +	snprintf(response, resp_len, "%s %s", user, hex);
>> +
>> +	response_64 =3D xcalloc(ENCODED_SIZE(resp_len), sizeof(char));
>
> Why not xmalloc()?  Does EVP_EncodeBlock() want a zero-filled buffer?
>

The reason using xcalloc() here is like one of above.
ENCODED_SIZE() calculates upper limit of encoded size.

>> +	EVP_EncodeBlock((unsigned char *)response_64, (unsigned char *)res=
ponse, strlen(response));
>
> I wouldn't worry too much about error response from this function as =
I
> would for EVP_DecodeBlock() I mentioned earlier.

I'll modify it, too.

>
> By the way, I made a couple of small fix-ups to your [2/2] (I think t=
hey
> were just style and unnecessary use of xcalloc()) and queued.

Thanks. Where can I find them?
# But as I mentioned above, use of xcalloc() is necessary.

And again, thanks for your very detailed review!
