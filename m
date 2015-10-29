From: Atousa Duprat <atousa.p@gmail.com>
Subject: Re: git fsck failure on OS X with files >= 4 GiB
Date: Thu, 29 Oct 2015 09:02:49 -0700
Message-ID: <CA+izobtdwszVrYsnKU=_ytLuNbPGyRe_7kXqyrQO7u5Lo+OdPg@mail.gmail.com>
References: <CAG3jReJn2Pz6-bXLw6baOZaE1BHYiC+1-zN0eagigfG3umWpJA@mail.gmail.com>
	<CAEDE8505fXAwVXx=EZwxPHvXpMByzpnXJ9LBgfx3U6VUaFbPHw@mail.gmail.com>
	<CAG3jRe+23sy1k9QNdpdn3GF3nbzPMmYO=TM=SufEq83OtwNxbA@mail.gmail.com>
	<CAEDE853n2HR-SK9_sGn8n3j0xoTb3eQa86UvdW0DBrc+Z1sDrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Rafael_Esp=C3=ADndola?= <rafael.espindola@gmail.com>,
	Filipe Cabecinhas <filcab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 17:03:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrpfF-00040h-M9
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 17:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372AbbJ2QCx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2015 12:02:53 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35954 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbbJ2QCw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2015 12:02:52 -0400
Received: by ioll68 with SMTP id l68so51059149iol.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=S18dvCj8MNUgIbe+uGXF37+7hRSUsdCg0LSMfiK7hMM=;
        b=jP6qN59OZCzJt3uVRXHDhmEPAk6kMY9QTjN4zQkY4QVg67nHlkPY3IElDTf2z4q3I3
         8H+k32k6cKzgtETmB/QOPYAaMyoGAwabubNaHcN4+h6pZQpTxpbZCpRGKoQ40VsYkHxg
         1Y34VYv5cjauQkXmgfbU+54eCFTyhFij9NgHx95tO1zDhN+MyHzcq0G0aCsEQ8uEc9O0
         d3AHhl5MC0kkGcK5bVPKLw0kF72gmWMYP3OnaOi6qwadiqFwbC4pdd5RlTtCv8FRchxx
         B7Ty77Aaw8zhtuIdvPNEmieM1W8hzoD3/en2wummT7grZ6NkNOoX+8LwFPCNa/SLJXWr
         H2hA==
X-Received: by 10.107.4.3 with SMTP id 3mr4933417ioe.195.1446134570240; Thu,
 29 Oct 2015 09:02:50 -0700 (PDT)
Received: by 10.37.91.198 with HTTP; Thu, 29 Oct 2015 09:02:49 -0700 (PDT)
In-Reply-To: <CAEDE853n2HR-SK9_sGn8n3j0xoTb3eQa86UvdW0DBrc+Z1sDrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280444>

Here is a solution that avoids problems with OS-specific
implementations of SHA_Update() by limiting the size of each update
request to 1GiB and calling the function repeatedly in a loop.

Atousa

--

[PATCH] Limit the size of the data block passed to SHA1_Update()

This avoids issues where OS-specific implementations use
a 32-bit integer to specify block size.  Limit currently
set to 1GiB.
---
 cache.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 79066e5..c305985 100644
--- a/cache.h
+++ b/cache.h
@@ -14,10 +14,28 @@
 #ifndef git_SHA_CTX
 #define git_SHA_CTX SHA_CTX
 #define git_SHA1_Init SHA1_Init
-#define git_SHA1_Update SHA1_Update
 #define git_SHA1_Final SHA1_Final
 #endif

+#define SHA1_MAX_BLOCK_SIZE (1024*1024*1024)
+
+static inline int git_SHA1_Update(SHA_CTX *c, const void *data, size_t=
 len)
+{
+ size_t nr;
+ size_t total =3D 0;
+ char *cdata =3D (char*)data;
+ while(len > 0) {
+ nr =3D len;
+ if(nr > SHA1_MAX_BLOCK_SIZE)
+ nr =3D SHA1_MAX_BLOCK_SIZE;
+ SHA1_Update(c, cdata, nr);
+ total +=3D nr;
+ cdata +=3D nr;
+ len -=3D nr;
+ }
+ return total;
+}
+
 #include <zlib.h>
 typedef struct git_zstream {
  z_stream z;
--=20
2.4.9 (Apple Git-60)


On Thu, Oct 29, 2015 at 8:15 AM, Filipe Cabecinhas <filcab@gmail.com> w=
rote:
> Defining BLK_SHA1 =3D YesPlease (when calling make) should just chang=
e
> the SHA functions, instead of completely removing OpenSSL or
> CommonCrypto.
>
> Regards,
>   Filipe
>
>
> On Thu, Oct 29, 2015 at 3:46 AM, Rafael Esp=C3=ADndola
> <rafael.espindola@gmail.com> wrote:
>> Awesome, building with
>>
>> NO_OPENSSL =3D 1
>> NO_GETTEXT =3D 1
>>
>> produces a working git :-)
>>
>> Cheers,
>> Rafael
>>
>>
>> On 28 October 2015 at 23:37, Filipe Cabecinhas <filcab@gmail.com> wr=
ote:
>>> I did some debugging, and it seems CC_SHA1_Update (used by
>>> write_sha1_file_prepare if APPLE_COMMON_CRYPTO is defined in the Ma=
kefile)
>>> takes a uint32_t as a "length" parameter, which explains why it sto=
ps
>>> working at 4GiB (UINT_MAX+1).
>>>
>>> In the OS X 10.11 SDK header CommonCrypto/CommonDigest.h, we have:
>>>
>>> typedef uint32_t CC_LONG;       /* 32 bit unsigned integer */
>>> //...
>>> extern int CC_SHA1_Update(CC_SHA1_CTX *c, const void *data, CC_LONG=
 len)
>>>
>>> A possible fix would be to either call SHA1_Update with a maximum o=
f
>>> UINT_MAX, looping if necessary. Or have a compatibility SHA1_Update=
 for OS X
>>> which can handle data longer than UINT_MAX.
>>>
>>> I'm not sure what the git maintainers would prefer.
>>>
>>> Regards,
>>>
>>>   Filipe
>>>
>>> On Wed, Oct 28, 2015 at 4:10 PM, Rafael Esp=C3=ADndola
>>> <rafael.espindola@gmail.com> wrote:
>>>>
>>>> I first noticed this with "2.4.9 (Apple Git-60)", but it reproduce=
s
>>>> with git built from 37023ba381b6d251d7140a997b39b566dbc63c42.
>>>>
>>>> Create two files with just 0s:
>>>>
>>>> -rw-r--r--  1 espindola  staff  4294967296 28 Oct 11:09 exactly-4g=
ib
>>>> -rw-r--r--  1 espindola  staff  4294967295 28 Oct 11:09 one-less-t=
han-4gib
>>>>
>>>>
>>>> and run
>>>>
>>>> git init
>>>> git add one-less-than-4gib
>>>> git commit -m bar
>>>> git fsck
>>>> git add exactly-4gib
>>>> git commit -m bar
>>>> git fsck
>>>>
>>>> The first fsck will run with no problems, but the second one fails=
:
>>>>
>>>> error: packed cfdaf54c9ccfd8f5e4cee562f7d5f92df13d3106 from
>>>> .git/objects/pack/pack-ff08480fd7f767b6bd0aeb559f0f5dea2245b0b3.pa=
ck
>>>> is corrupt
>>>>
>>>> Using the very same revision on freebsd doesn't cause any errors.
>>>>
>>>> Cheers,
>>>> Rafael
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Atousa Pahlevan, PhD
M.Math. University of Waterloo, Canada
Ph.D. Department of Computer Science, University of Victoria, Canada
Voice: 415-341-6206
Email: apahlevan@ieee.org
Website: www.apahlevan.org
