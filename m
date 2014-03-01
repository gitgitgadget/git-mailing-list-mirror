From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH] Replace memcpy with hashcpy when dealing hash copy globally
Date: Sat, 1 Mar 2014 22:53:45 +0800
Message-ID: <CAJr59C2oi9Oi=SJMZigw4SnXnRmVG5wQOpWL2eeVv_u1bfKvmg@mail.gmail.com>
References: <1393636024-17576-1-git-send-email-sunheehnus@gmail.com>
	<CACsJy8Apoz43HPAgdrTHSNgSOcUhv9j258+r0xDJeioY3iogig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 15:54:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJlIp-0001zy-Pu
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 15:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbaCAOyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 09:54:03 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:47058 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbaCAOxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 09:53:47 -0500
Received: by mail-wg0-f50.google.com with SMTP id l18so1524633wgh.33
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 06:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=kp+e0cwvzUBpdky4Xz5JfEAKs1xgpOzhhyW0s9U0IBs=;
        b=qaQHf0G2fk5U0rgxLdNe1w191xMc60h2ZhiXG5HJOsObhS3f7VYiq5wRKWFAo027No
         Lp0Q2TzMD3XjThg7PVSgstxRYftP7es6DPlH9K8QJ4OyE873EoyQ/onr2InOuyj+DxoD
         C35naRGGiEKFbuKAbd0crmWH7y6jyJdy7Z5i7MbSF0fPq8sZDvasZ2q7/QHujnr6FkCn
         su0eUDJn0e10rvk6tC4p2+YO8FhXiv1Ummb+09FYu9/or4ttBlDCKwdxsWJV5gIyDZPZ
         sAXWTaErirzwjYbdYB8zsB9ZY4TN9gl3ER5vv4kklIJpQtkg3nowACVvcjuWAk1R3YeI
         2Aeg==
X-Received: by 10.180.189.139 with SMTP id gi11mr7840688wic.53.1393685625773;
 Sat, 01 Mar 2014 06:53:45 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Sat, 1 Mar 2014 06:53:45 -0800 (PST)
In-Reply-To: <CACsJy8Apoz43HPAgdrTHSNgSOcUhv9j258+r0xDJeioY3iogig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243099>

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

Yap, I should follow the general rule. My fault.
Thanks.

What's more,

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
