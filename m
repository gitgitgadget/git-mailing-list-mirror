From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/9] http: update base URLs when we see redirects
Date: Sun, 29 Sep 2013 15:26:45 -0400
Message-ID: <CAPig+cQVQ6iY8onvb--88W0XHofC815NZHTb=L744hANtT8mVQ@mail.gmail.com>
References: <20130928082956.GA22610@sigill.intra.peff.net>
	<20130928083405.GA2782@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, "Kyle J. McKay" <mackyle@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 29 21:27:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQMdu-0000Pq-LZ
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 21:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921Ab3I2T0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 15:26:48 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:41839 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab3I2T0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 15:26:47 -0400
Received: by mail-la0-f50.google.com with SMTP id gx14so3677930lab.23
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jhSsAt5TToVNyRUhJ74KO1niaZDD0uIE4E+eLnlpZTk=;
        b=jedCiwtXnrcBsSWaC6n1hHS/nuLhobmT4a+d4yFM72zMjaCt1b5WuTLOaH0SZbDXDf
         /tPmYlRj5G/0QfeJeeWXE1gkL06l7D7LfdbIq077PGsiYH8q7wCBH77e4EbCugS6BDFr
         xPgl0Tu1PM516naxNvdG2x/qdKahx0GJCdx1RxtYKoIOFzD71z8Vbh8c2G5UrboLMOv0
         L4oyPwqJ/wBGj5QKzMW3gANsi8KKrgIQrDvaay4ozYISN96g6psWcMFezSa2DkuyECox
         dLOSHJKwuQJXDRRbMrTqAdhXchmBa81wCqn49X6GT+UgfMufd3nnbVGDjIaJ9Ck3q6ZQ
         E27g==
X-Received: by 10.152.170.166 with SMTP id an6mr16383898lac.20.1380482805923;
 Sun, 29 Sep 2013 12:26:45 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 29 Sep 2013 12:26:45 -0700 (PDT)
In-Reply-To: <20130928083405.GA2782@sigill.intra.peff.net>
X-Google-Sender-Auth: ZoUUYYpsPDqavflaDhEZgzF9bFI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235604>

On Sat, Sep 28, 2013 at 4:34 AM, Jeff King <peff@peff.net> wrote:
> diff --git a/http.c b/http.c
> index 65a0048..8775b5c 100644
> --- a/http.c
> +++ b/http.c
> @@ -921,11 +921,71 @@ static int http_request_reauth(const char *url,
> +static int update_url_from_redirect(struct strbuf *base,
> +                                   const char *asked,
> +                                   const struct strbuf *got)
> +{
> +       const char *tail;
> +       size_t tail_len;
> +
> +       if (!strcmp(asked, got->buf))
> +               return 0;
> +
> +       if (strncmp(asked, base->buf, base->len))
> +               die("BUG: update_url_from_redirect: %s is not a superset of %s",
> +                   asked, base->buf);

Is there something non-obvious going on here? die(...,base->buf) takes
advantage of the terminating NUL promised by strbuf, but then
strncmp(...,base->buf,base->len) is used rather than the simpler
strcmp(...,base->buf).

> +       tail = asked + base->len;
> +       tail_len = strlen(tail);
> +
> +       if (got->len < tail_len ||
> +           strcmp(tail, got->buf + got->len - tail_len))
> +               return 0; /* insane redirect scheme */
> +
> +       strbuf_reset(base);
> +       strbuf_add(base, got->buf, got->len - tail_len);
> +       return 1;
> +}
