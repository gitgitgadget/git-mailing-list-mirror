From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Sun, 1 Nov 2015 03:30:08 -0500
Message-ID: <CAPig+cSLoC-O1YneUVRjBpZzHLmASmRQx_+8b2dsk34ReU-ovw@mail.gmail.com>
References: <CAPig+cRRjCDhdT-DvGtZqns1mMxygnxi=ZnRKzg+H_do7oRpqQ@mail.gmail.com>
	<1446359536-25829-1-git-send-email-apahlevan@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	rsbecker@nexbridge.com, Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: Atousa Pahlevan Duprat <atousa.p@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 09:31:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zso2h-0001yt-Ri
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 09:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbbKAIaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 03:30:55 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36514 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbbKAIaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 03:30:09 -0500
Received: by vkex70 with SMTP id x70so69481566vke.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mCSoBRVJxo6wDRwwLxipi/CzZpadko4mRen2cMZsOkE=;
        b=Eqs5H265VrmpMW1QYv1rMql9msgTJXwSUnLSyL37Ogx82O+KN2320bI7VpgSATx3gN
         ipePPkWhmkwpQJnNlokRJHLkHQxMdk0E55mLb96tNFyVEcPkgJPJods1BcV6bpE+NAlj
         6KvatrS9M/q6E1N1WUim+kpGJqQIIE/oylgTvOy4xUz5ISirkEXd+dpUWmIhR7EgXWxn
         dUFEcBypyqxiB/8U3jwGbyd1ufqtQGsZxniRUAsCvgFkm5DfIEqmf6jOf9T89VVnqkaZ
         jw/9449cJxLnrmCrcsZuDnz7UEfnSq+ZaaohrmA5VOPtJjYMdoIxLJrSHCkQw/Q/RMKT
         RDNA==
X-Received: by 10.31.163.85 with SMTP id m82mr10047847vke.19.1446366608957;
 Sun, 01 Nov 2015 01:30:08 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 01:30:08 -0700 (PDT)
In-Reply-To: <1446359536-25829-1-git-send-email-apahlevan@ieee.org>
X-Google-Sender-Auth: rHueBWqQCcdFWekJyJOfwzzANDU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280613>

On Sun, Nov 1, 2015 at 1:32 AM,  <atousa.p@gmail.com> wrote:
> Some implementations of SHA_Updates have inherent limits
> on the max chunk size. SHA1_MAX_BLOCK_SIZE can be defined
> to set the max chunk size supported, if required.  This is
> enabled for OSX CommonCrypto library and set to 1GiB.
>
> Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
> ---
> diff --git a/compat/sha1_chunked.c b/compat/sha1_chunked.c
> new file mode 100644
> index 0000000..bf62b1b
> --- /dev/null
> +++ b/compat/sha1_chunked.c
> @@ -0,0 +1,21 @@
> +#include "cache.h"
> +
> +#ifdef SHA1_MAX_BLOCK_SIZE

This file is only compiled when SHA1_MAX_BLOCK_SIZE is defined, so
does this #ifdef serve a purpose?

> +int git_SHA1_Update(SHA_CTX *c, const void *data, size_t len)
> +{
> +       size_t nr;
> +       size_t total = 0;
> +       char *cdata = (char*)data;

Nit: This could be 'const char *'.

> +       while (len > 0) {
> +               nr = len;
> +               if (nr > SHA1_MAX_BLOCK_SIZE)
> +                       nr = SHA1_MAX_BLOCK_SIZE;
> +               SHA1_Update(c, cdata, nr);
> +               total += nr;
> +               cdata += nr;
> +               len -= nr;
> +       }
> +       return total;
> +}
> +#endif
