From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/5] sha1_name.c: don't waste cycles in the @-parsing loop
Date: Wed, 1 May 2013 12:57:50 -0500
Message-ID: <CAMP44s1j6GdQBjgCdBrG3xvXr_XifCTRZWJAQUrzts-MzFg--g@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 19:58:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbI3-0007ea-1B
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 19:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab3EAR55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 13:57:57 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:49290 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab3EAR5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 13:57:52 -0400
Received: by mail-lb0-f181.google.com with SMTP id 13so1637511lba.26
        for <git@vger.kernel.org>; Wed, 01 May 2013 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=HAdPTJFs5OQFbaiAZg0gJNwwdc6KyuKPeT8NkPCFG+E=;
        b=C+ehpbnZ1kK4S6iIdUFZrNs2DWs7j2DGdld88E8Y0iW/ZaDpa5q9n4BJlEdhGtU7Y4
         8Tw3Errw+QwH122ChkaZodwLKpTOCX8/bKrdSFho8OTvUuFIn7BBIFiaOOHw6ReScf0b
         h/a13a2ld9R6WEkfFh9lYrzUpPRpX9vz5qSkZ6rcPzh19utGF3tHM8f/e7zrGR3TtcHJ
         nznvWh2XEJAOIW5QNyd4cwE0LSTQ9EskmlO1w6EF5QsbCtbTtIn+L+Lz9JihqDWjPkAQ
         /qQG+pAPRZwaPqSXgvfXpGjtBn/YEtf0QLEVDQMRoDRZTe6JR+dp6kzZzA8ysiAqzXx7
         JL8w==
X-Received: by 10.152.3.137 with SMTP id c9mr1339356lac.5.1367431070737; Wed,
 01 May 2013 10:57:50 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 10:57:50 -0700 (PDT)
In-Reply-To: <1367425235-14998-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223107>

On Wed, May 1, 2013 at 11:20 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> The @-parsing loop unnecessarily checks for the sequence "@{" from
> len - 2 unnecessarily.  We can safely check from len - 4: write out a
> comment justifying this.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  sha1_name.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 3820f28..be1d12c 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -445,7 +445,23 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         /* basic@{time or number or -number} format to query ref-log */
>         reflog_len = at = 0;
>         if (len && str[len-1] == '}') {
> -               for (at = len-2; at >= 0; at--) {
> +               /* str = @}
> +                *       ^
> +                *       len - 2; expression is senseless
> +                *
> +                * str = @{}
> +                *       ^
> +                *       len - 3; expression is still senseless
> +                *
> +                * str = @{.}
> +                *       ^
> +                *       len - 4 where . is any character; expression
> +                *       is worth investigating
> +                *
> +                * Therefore, if str ends with }, search three
> +                * characters earlier for @{
> +                */

I think this comment is overkill.

> +               for (at = len - 4; at >= 0; at--) {

The change seems OK to me, but there's no need to explain where you
are starting, and if there's a need:

/* start from where reflogs can start: @{.} */

Does the trick nicely.

>                         if (str[at] == '@' && str[at+1] == '{') {
>                                 if (!upstream_mark(str + at, len - at)) {
>                                         reflog_len = (len-1) - (at+2);
> --

-- 
Felipe Contreras
