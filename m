From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Tue, 10 Nov 2015 20:22:37 -0500
Message-ID: <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
References: <56428A6A.5010406@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 02:22:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwK7j-00037h-GY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 02:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbbKKBWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 20:22:47 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33660 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbbKKBWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 20:22:37 -0500
Received: by ykdv3 with SMTP id v3so26698882ykd.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 17:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2xMP6LxyMbIsG8fxWorB0hbT0aYyUwA2hvXfKtkGCxA=;
        b=SOJImujy/RNlzyxPYYSsSBfF4EYWPgYD9oPbs7JLLgLZPSEwdxWNptuCwGX7EiCU55
         tB8zg/6ffVY7DhO8AYRkgSC0Ak689HQ1N6YAax0L1rWPsVwAluzRLqlhoPIUMjC34pms
         WIrEfoeQx9Ak2+pQRxy4EII3AjvSqFBInD4QtTb6Dd39WKqp9pP8/JhRFPJXX/tAKy4G
         xYe+j7k/XsoRC2IwEKq4V0JtUuqJBnJ8cyAm0vWiRQ0+Bj7dbL2aG++6NsBXwGOwzYRD
         LdRVhu2N7aqQJheUGC+pSGNB0YoVEF+P6Fme3euSbKerDZ0/5O4SI7H3TWrm6SjG9l8j
         ggEA==
X-Received: by 10.13.205.70 with SMTP id p67mr6968970ywd.249.1447204957075;
 Tue, 10 Nov 2015 17:22:37 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Tue, 10 Nov 2015 17:22:37 -0800 (PST)
In-Reply-To: <56428A6A.5010406@ramsayjones.plus.com>
X-Google-Sender-Auth: l3AW0KHQ8k1H8xmEQZU84RyMiwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281141>

On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> Commit f8117f55 ("http: use off_t to store partial file size",
> 02-11-2015) changed the type of some variables from long to off_t.
> The 32-bit build, which enables the large filesystem interface
> (_FILE_OFFSET_BITS == 64), defines the off_t type as a 64-bit
> integer, whereas long is a 32-bit integer. This results in a couple
> of printf format warnings.
>
> In order to suppress the warnings, change the format specifier to use
> the PRIuMAX macro and cast the off_t argument to uintmax_t. (See also
> the http_opt_request_remainder() function, which uses the same
> solution).

I just ran across the problem when building 'next' on my Mac and was
about to investigate, so am happy to find that the work has already
been done. Thanks.

My machine is 64-bit, though, so perhaps it's misleading to
characterize this as a fix for 32-bit builds. In particular, off_t is
'long long' on this machine, so it complains about the "long" format
specifier.

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> diff --git a/http.c b/http.c
> index 42f29ce..2532976 100644
> --- a/http.c
> +++ b/http.c
> @@ -1617,8 +1617,8 @@ struct http_pack_request *new_http_pack_request(
>         if (prev_posn>0) {
>                 if (http_is_verbose)
>                         fprintf(stderr,
> -                               "Resuming fetch of pack %s at byte %ld\n",
> -                               sha1_to_hex(target->sha1), prev_posn);
> +                               "Resuming fetch of pack %s at byte %"PRIuMAX"\n",
> +                               sha1_to_hex(target->sha1), (uintmax_t)prev_posn);
>                 http_opt_request_remainder(preq->slot->curl, prev_posn);
>         }
>
> @@ -1772,8 +1772,8 @@ struct http_object_request *new_http_object_request(const char *base_url,
>         if (prev_posn>0) {
>                 if (http_is_verbose)
>                         fprintf(stderr,
> -                               "Resuming fetch of object %s at byte %ld\n",
> -                               hex, prev_posn);
> +                               "Resuming fetch of object %s at byte %"PRIuMAX"\n",
> +                               hex, (uintmax_t)prev_posn);
>                 http_opt_request_remainder(freq->slot->curl, prev_posn);
>         }
>
> --
> 2.6.0
