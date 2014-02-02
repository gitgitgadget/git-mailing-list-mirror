From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 11/17] trailer: add new_trailer_item() function
Date: Sun, 2 Feb 2014 05:10:20 -0500
Message-ID: <CAPig+cQ6J1nEJhecmS_T8L5mxJj9WcSBQ7hFA=XKcDChGHNSnQ@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.42810.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Feb 02 11:10:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9u0o-0002cL-4e
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 11:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbaBBKKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 05:10:22 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:60317 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbaBBKKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 05:10:21 -0500
Received: by mail-yk0-f175.google.com with SMTP id q200so33059449ykb.6
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 02:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6hNmjlL+jU5xvhMGz6EmJxY14fbhADAy7dVR793k1gc=;
        b=maP1Gayvc/uH8IVUg+vfAP6PBxWDgwMN5GB6Qgxk2hU4Dgf0Wjc4oj/XEwlPZwRa3s
         Ypm3UlhO/jRGNwM+CWcSmBEYxW3BVMjgNzU4tDNtVsqxqtau5tGITml7U39vZAdYGXAR
         SQgIEeZwUoS/86PnMF5z8WPBkN3R3ENzTCcPhYs8n2orwFZtouXWT3MHiteyEuK9GBHt
         nGDw8mZX/XgL3tnBN45dkIPnOvQft+RirT80it52Q4yAAQQM/RrYiwsek/0LphlAi4Vh
         L7ZT+js6GmqJ0/UO35bAoaQI1905pnmlh2ztsA/ViGEDiRN/bADJQSZ9NIkdFmOx9HA1
         swtg==
X-Received: by 10.236.228.137 with SMTP id f9mr28376399yhq.44.1391335820913;
 Sun, 02 Feb 2014 02:10:20 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Sun, 2 Feb 2014 02:10:20 -0800 (PST)
In-Reply-To: <20140130064921.7504.42810.chriscool@tuxfamily.org>
X-Google-Sender-Auth: 7R9WZlEIf0AQwLj_BOC3CX5N5xk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241355>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This is a small refactoring to prepare for the next steps.

Since this is all brand new code, wouldn't it make more sense to
structure it in this fashion in the first place when introduced in
patch 4/17? It's not clear why it should be introduced with poorer
structure and then later cleaned up.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  trailer.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/trailer.c b/trailer.c
> index 73a65e0..430ff39 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -399,11 +399,27 @@ static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tr
>         }
>  }
>
> +static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
> +                                            const char* tok, const char* val)
> +{
> +       struct trailer_item *new = xcalloc(sizeof(struct trailer_item), 1);
> +       new->value = val;
> +
> +       if (conf_item) {
> +               new->conf = conf_item->conf;
> +               new->token = xstrdup(conf_item->conf->key);
> +       } else {
> +               new->conf = xcalloc(sizeof(struct conf_info), 1);
> +               new->token = tok;
> +       }
> +
> +       return new;
> +}
> +
>  static struct trailer_item *create_trailer_item(const char *string)
>  {
>         struct strbuf tok = STRBUF_INIT;
>         struct strbuf val = STRBUF_INIT;
> -       struct trailer_item *new;
>         struct trailer_item *item;
>         int tok_alnum_len;
>
> @@ -415,21 +431,12 @@ static struct trailer_item *create_trailer_item(const char *string)
>         for (item = first_conf_item; item; item = item->next) {
>                 if (!strncasecmp(tok.buf, item->conf->key, tok_alnum_len) ||
>                     !strncasecmp(tok.buf, item->conf->name, tok_alnum_len)) {
> -                       new = xcalloc(sizeof(struct trailer_item), 1);
> -                       new->conf = item->conf;
> -                       new->token = xstrdup(item->conf->key);
> -                       new->value = strbuf_detach(&val, NULL);
>                         strbuf_release(&tok);
> -                       return new;
> +                       return new_trailer_item(item, NULL, strbuf_detach(&val, NULL));
>                 }
>         }
>
> -       new = xcalloc(sizeof(struct trailer_item), 1);
> -       new->conf = xcalloc(sizeof(struct conf_info), 1);
> -       new->token = strbuf_detach(&tok, NULL);
> -       new->value = strbuf_detach(&val, NULL);
> -
> -       return new;
> +       return new_trailer_item(NULL, strbuf_detach(&tok, NULL), strbuf_detach(&val, NULL));;
>  }
>
>  static void add_trailer_item(struct trailer_item **first,
> --
> 1.8.5.2.201.gacc5987
>
>
