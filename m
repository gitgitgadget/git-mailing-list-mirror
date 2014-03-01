From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH] Replace memcpy with hashcpy when dealing hash copy globally
Date: Sat, 1 Mar 2014 22:53:36 +0800
Message-ID: <CAJr59C37x9pdjcpo_4MrRm8Zk+So2JUj3TjBOGH+Bj-La=RTwQ@mail.gmail.com>
References: <1393636024-17576-1-git-send-email-sunheehnus@gmail.com>
	<CACsJy8Apoz43HPAgdrTHSNgSOcUhv9j258+r0xDJeioY3iogig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 15:54:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJlIh-0001vj-Di
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 15:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbaCAOxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 09:53:39 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43084 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbaCAOxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 09:53:38 -0500
Received: by mail-wi0-f174.google.com with SMTP id f8so1801298wiw.7
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 06:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=kwIhN/Zp17xsLpD9W1ef5fj2Lysgf9pCfpjlQ5/6Bnw=;
        b=hLwD8XUjLnXAnW5SJ/SfAlSHUqHzXC4N02TW0DNNifuX4+Wb3dbdMgNZ9NtxVTvF9C
         r6bheSfECEGnaqhXIK+JMRHkMZ4XhsRDPSojtdosJW1QjYgff/WW8YsHz25QKdtZCsdm
         60p9z6I4R5dzIcFIx5Yz8ln5z2Cn+fOMPN5j0qnC58wFYfqHdOoJX7LXFSIE3R/DYGsm
         geZ3Os1eXPryAwK9aB5e5fgXoUFIu8QhMCAn/BHMNmL+odkMfAijQiyZonvux/972qRe
         A4abxXv2L35uCmJurBKGGqj3AT9MEwVakJdlteP2ReMr6Gc9HW1Lx4x0+5eAI5AVtWS2
         xYkA==
X-Received: by 10.180.205.130 with SMTP id lg2mr7796603wic.59.1393685616627;
 Sat, 01 Mar 2014 06:53:36 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Sat, 1 Mar 2014 06:53:36 -0800 (PST)
In-Reply-To: <CACsJy8Apoz43HPAgdrTHSNgSOcUhv9j258+r0xDJeioY3iogig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243098>

2014-03-01 10:58 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
> On Sat, Mar 1, 2014 at 8:07 AM, Sun He <sunheehnus@gmail.com> wrote:
>> Signed-off-by: Sun He <sunheehnus@gmail.com>
>> ---
>>  Find the potential places with memcpy by the bash command:
>>    $ find . | xargs grep "memcpy.*\(.*20.*\)"
>>
>>  Helped-by: Michael Haggerty<mhagger@alum.mit.edu>
>
> You may want to put this Helped-by before "---" because it's supposed
> to end up in the final commit. The patch looks straightforward,
> except..
>

Yeah, got it.
Thanks.

>> diff --git a/ppc/sha1.c b/ppc/sha1.c
>> index ec6a192..8a87fea 100644
>> --- a/ppc/sha1.c
>> +++ b/ppc/sha1.c
>> @@ -9,6 +9,7 @@
>>  #include <stdio.h>
>>  #include <string.h>
>>  #include "sha1.h"
>> +#include "cache.h"
>>
>>  extern void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
>>                           unsigned int nblocks);
>> @@ -67,6 +68,6 @@ int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c)
>>                 memset(&c->buf.b[cnt], 0, 56 - cnt);
>>         c->buf.l[7] = c->len;
>>         ppc_sha1_core(c->hash, c->buf.b, 1);
>> -       memcpy(hash, c->hash, 20);
>> +       hashcpy(hash, c->hash);
>>         return 0;
>>  }
>
> cache.h (actually git-compat-util.h that cache.h includes) messes
> around with system headers by defining this and that macro. The
> general rule is if cache.h or git-compat-util.h is included, it's the
> first #include, and system includes will be always in
> git-compat-util.h (grep '^#include' shows this). Maybe it's best to
> leave this memcpy alone (and if you do, state so in the commit message
> with the reason).

Yap, after I parsed all the sourcecode

I have find out all the files that cache.h git-compat-util.h and
builtin.h are not the first #include

==> test-sigchain.c <==
#include "sigchain.h"
==> sigchain.c <==
#include "sigchain.h"

And I checked "sigchain.h", that it includes very little information.
It didn't import any potential errors. But I think it should be placed
after "cache.h" to match the consistence of the general rule.

> --
> Duy
