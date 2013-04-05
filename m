From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/7] sha1_file, link: write link objects to the database
Date: Fri, 5 Apr 2013 12:41:21 +0530
Message-ID: <CALkWK0k=XYPJXEEx8CMYRx_k0d9Z=b_W=wGGvbZsXJEe8K99EA@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com> <1365100243-13676-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 05 09:12:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UO0p9-0005DX-4K
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 09:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161751Ab3DEHME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 03:12:04 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:57607 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161749Ab3DEHMC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 03:12:02 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so4031847iee.11
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Q+N0M+SEL4xY/oVbp7hfUlHdP8OYO215Qzh1jJ9LwxQ=;
        b=J4h6NOQpRg5jgOOGbA7HT4qxjo7or4yWdyp7xbC9Lb5FLcPY8dz4porMcH8L7ssWEg
         yyr8vayg37nCrNx3G9ppOY3Xsl0qoBMwRsTT6iAgcTPxeYb4EQ2PhzNSCf8G1w/t/zPN
         DSd+Tkfd4lvb338UUWnqYUouotlTS5y0hlB/cFQNnDHPzpQkcVUepJN162man2yl29MN
         wv7AN7PDbEuauoJjo2sYScEl2i9yTmzX86jDTWAFYy2LguIxQ+EKEocq+necc84j6tOd
         94KjoXfDpkWoFDQDg+UCC2NvBxexFxFKLyFqYrgq8YdWMEYYILjagcW6BXxVFIyXnC3b
         sypQ==
X-Received: by 10.50.119.102 with SMTP id kt6mr906390igb.12.1365145921448;
 Fri, 05 Apr 2013 00:12:01 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 5 Apr 2013 00:11:21 -0700 (PDT)
In-Reply-To: <1365100243-13676-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220153>

Ramkumar Ramachandra wrote:
> diff --git a/link.c b/link.c
> index bb20a51..349646d 100644
> --- a/link.c
> +++ b/link.c
> @@ -20,8 +20,30 @@ struct link *lookup_link(const unsigned char *sha1)
>
>  int parse_link_buffer(struct link *item, void *buffer, unsigned long size)
>  {
> +       char *bufptr = buffer;
> +       char *tail = buffer + size;
> +       char *eol;
> +
>         if (item->object.parsed)
>                 return 0;
>         item->object.parsed = 1;
> +       while (bufptr < tail) {
> +               eol = strchr(bufptr, '\n');
> +               *eol = '\0';
> +               if (!prefixcmp(bufptr, "upstream_url = "))
> +                       item->upstream_url = xstrdup(bufptr + 15);
> +               else if (!prefixcmp(bufptr, "checkout_rev = "))
> +                       item->checkout_rev = xstrdup(bufptr + 15);
> +               else if (!prefixcmp(bufptr, "ref_name = "))
> +                       item->ref_name = xstrdup(bufptr + 11);
> +               else if (!prefixcmp(bufptr, "floating = "))
> +                       item->floating = atoi(bufptr + 11);
> +               else if (!prefixcmp(bufptr, "statthrough = "))
> +                       item->statthrough = atoi(bufptr + 14);
> +               else
> +                       return error("Parse error in link buffer");
> +
> +               bufptr = eol + 1;
> +       }
>         return 0;
>  }

This needs to be replaced by a .git/config parser.  However, I can't
use the parser from config.c as-it-is, because it expects a section
like [core] to be present.  So, we have to refactor it to optionally
parse section-less configs.
