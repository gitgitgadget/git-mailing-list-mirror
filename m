From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Replace memcpy with hashcpy when dealing hash copy globally
Date: Sat, 1 Mar 2014 09:58:50 +0700
Message-ID: <CACsJy8Apoz43HPAgdrTHSNgSOcUhv9j258+r0xDJeioY3iogig@mail.gmail.com>
References: <1393636024-17576-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 03:59:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJa97-0004dn-UC
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 03:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbaCAC7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 21:59:21 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33756 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbaCAC7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 21:59:21 -0500
Received: by mail-qg0-f41.google.com with SMTP id i50so4545360qgf.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 18:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yyfSQVJitK1O4/vmeKF01nqz/CX0ItUlCl5Pew5ef2Y=;
        b=Q+CEOc65pD8TumS7NqcC9k3yghABS1/oXGi38dtPPWY1evhNtImDsDkIviXtxUsUvT
         PxFWTcYrlIRKqQIpwPplWPR8dhNhQeVf0ZBG3C/nHNar3L9rNbmuVyjMc9e+5aYlIqdN
         PfE+oNuBHln9Gl1a6RsjskOxEety+FQ6WSMGHEqG4Gq2wRpnFnOHsEN59MSvWSBws06X
         PuG655EvkDjlginLFPOszioPOeikfcfM7LfoShhxtVr/14fmdysoePnyKXVbGVmLt44E
         7nnteDiYNm3nP0eajBZ8fbFGqVCudZMPjKsOXfZZoqGu5VxW8IpcPv6EwtUpm3WgkeE2
         NLSA==
X-Received: by 10.140.39.212 with SMTP id v78mr7881175qgv.77.1393642760313;
 Fri, 28 Feb 2014 18:59:20 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 18:58:50 -0800 (PST)
In-Reply-To: <1393636024-17576-1-git-send-email-sunheehnus@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243039>

On Sat, Mar 1, 2014 at 8:07 AM, Sun He <sunheehnus@gmail.com> wrote:
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>  Find the potential places with memcpy by the bash command:
>    $ find . | xargs grep "memcpy.*\(.*20.*\)"
>
>  Helped-by: Michael Haggerty<mhagger@alum.mit.edu>

You may want to put this Helped-by before "---" because it's supposed
to end up in the final commit. The patch looks straightforward,
except..

> diff --git a/ppc/sha1.c b/ppc/sha1.c
> index ec6a192..8a87fea 100644
> --- a/ppc/sha1.c
> +++ b/ppc/sha1.c
> @@ -9,6 +9,7 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include "sha1.h"
> +#include "cache.h"
>
>  extern void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
>                           unsigned int nblocks);
> @@ -67,6 +68,6 @@ int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c)
>                 memset(&c->buf.b[cnt], 0, 56 - cnt);
>         c->buf.l[7] = c->len;
>         ppc_sha1_core(c->hash, c->buf.b, 1);
> -       memcpy(hash, c->hash, 20);
> +       hashcpy(hash, c->hash);
>         return 0;
>  }

cache.h (actually git-compat-util.h that cache.h includes) messes
around with system headers by defining this and that macro. The
general rule is if cache.h or git-compat-util.h is included, it's the
first #include, and system includes will be always in
git-compat-util.h (grep '^#include' shows this). Maybe it's best to
leave this memcpy alone (and if you do, state so in the commit message
with the reason).
-- 
Duy
