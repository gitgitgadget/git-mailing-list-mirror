From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 01/17] Add data structures and basic functions for
 commit trailers
Date: Thu, 30 Jan 2014 04:10:10 -0500
Message-ID: <CAPig+cSbF8hGuVtZfTFtqgeX1HBYfhMbEL-whzzRP3sEax0N9A@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.87498.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jan 30 10:10:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8ndf-00014Y-5Z
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 10:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbaA3JKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 04:10:14 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:63807 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbaA3JKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 04:10:11 -0500
Received: by mail-yk0-f177.google.com with SMTP id 19so14532889ykq.8
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 01:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HLwkhl32XLFYuS/dZCGPAB2AmydsZlv8IgUonnUwNf8=;
        b=hq6VFU3p7kyKAv+Wuh+MSIDxgEe2V9irbFdEg7jaouoWTnjaJGg5QYX7kVFu6SiYsy
         KmIGIF3A/lSlEdGQaeoOIJOkc+mvu9tD6n/ooVr/sA/qMDBHU8NEmCOBIc+kggylyESX
         ApFC1aotMscy167NzZZWTtFIOXETCQN1DwpEKGxs6rpsvMTjNTbJjwarrQQLYKGFYjvU
         3xOGI4EAWWZeWZegFDpc+8H6L8VnEGm12kf5rIrg8JaU57XM/+7MIEJlVIR730yWbNQ1
         jNJsJM0iq0EWP+cnzWQobMcBBJjzzfwzYcie5f2HLHJs6Q/DRAmVJDEMv8PY5tkyptdN
         d+HQ==
X-Received: by 10.236.129.198 with SMTP id h46mr12399070yhi.17.1391073010642;
 Thu, 30 Jan 2014 01:10:10 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Thu, 30 Jan 2014 01:10:10 -0800 (PST)
In-Reply-To: <20140130064921.7504.87498.chriscool@tuxfamily.org>
X-Google-Sender-Auth: 4vhJtR2nRYVkzZ30cqfBqkszyHE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241261>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> We will use a doubly linked list to store all information
> about trailers and their configuration.
>
> This way we can easily remove or add trailers to or from
> trailer lists while traversing the lists in either direction.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/trailer.c b/trailer.c
> new file mode 100644
> index 0000000..aed25e1
> --- /dev/null
> +++ b/trailer.c
> @@ -0,0 +1,48 @@
> +#include "cache.h"
> +/*
> + * Copyright (c) 2013 Christian Couder <chriscool@tuxfamily.org>
> + */
> +
> +static int same_token(struct trailer_item *a, struct trailer_item *b, int alnum_len)
> +{
> +       return !strncasecmp(a->token, b->token, alnum_len);
> +}

Maybe these functions defined in the header should all be 'static
inline' rather than just 'static'? Making them inline would be
consistent with functions defined in other git headers.

> +
> +static int same_value(struct trailer_item *a, struct trailer_item *b)
> +{
> +       return !strcasecmp(a->value, b->value);
> +}
> +
> +static int same_trailer(struct trailer_item *a, struct trailer_item *b, int alnum_len)
> +{
> +       return same_token(a, b, alnum_len) && same_value(a, b);
> +}
> +
> +/* Get the length of buf from its beginning until its last alphanumeric character */
> +static size_t alnum_len(const char *buf, size_t len)
> +{
> +       while (--len >= 0 && !isalnum(buf[len]));

'len' has type size_t, which is unsigned, so the conditional '--len >=
0' will always be true (which will result in a crash if 'buf' contains
no alphanumerics).

> +       return len + 1;
> +}
> --
> 1.8.5.2.201.gacc5987
