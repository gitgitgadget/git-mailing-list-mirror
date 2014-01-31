From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 04/17] trailer: process command line trailer arguments
Date: Fri, 31 Jan 2014 11:30:17 -0500
Message-ID: <CAPig+cS98QTH-CxpRtXUqf0jYPC5wEGcb-PEqdk8CQAtbxBkhQ@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.55916.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jan 31 17:30:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Gz2-0007Ui-9N
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 17:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbaAaQaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 11:30:19 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:42588 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbaAaQaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 11:30:18 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so24838351ykr.9
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 08:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OW78/Ia+A5RrAKsOmrMQtPqKQp9KkxMfYHM9/b0cC9I=;
        b=gmFWZ8cYhVP/af8MCmrCMy6DY/XGFHYum+Y2DYhzT6MLQ5xmiE/Cr8KXM2E9YHaVTd
         KdT0I5hbR2fOe3jIo4hmIh5KKuMeZ1hMnf5N7MdrPtCXji2J1qX2CmAbofIJB5l6/acn
         t4qV1uthItTfSYuNi5wRXm0V4RFQ14iXaBnFkHFpP6ZDornVBxb6l2PNyal48Eaas8GR
         n1rDLQbXY0iAJHCp5pdjG7Gll9+vy+7Dy+FwTB8W85dMx8aISN7+csrP1XjGbB7tdbTa
         mkK1sayBQr4/w/DQjUAtxS5rgdqbmquHy+L95pweoOjZp6MygK0p7z6Jkdhgs+TifWik
         EgcA==
X-Received: by 10.236.22.38 with SMTP id s26mr210254yhs.145.1391185817498;
 Fri, 31 Jan 2014 08:30:17 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Fri, 31 Jan 2014 08:30:17 -0800 (PST)
In-Reply-To: <20140130064921.7504.55916.chriscool@tuxfamily.org>
X-Google-Sender-Auth: BTZidQID3FW4JZEQkmaZ5Ou-QU4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241303>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This patch parses the trailer command line arguments
> and put the result into an arg_tok doubly linked
> list.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/trailer.c b/trailer.c
> index d979a0f..f48fd94 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -362,3 +362,80 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
>         }
>         return 0;
>  }
> +
> +static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
> +{
> +       char *end = strchr(trailer, '=');

This can be 'const char *'.

> +       if (!end)
> +               end = strchr(trailer, ':');
> +       if (end) {
> +               strbuf_add(tok, trailer, end - trailer);
> +               strbuf_trim(tok);
> +               strbuf_addstr(val, end + 1);
> +               strbuf_trim(val);
> +       } else {
> +               strbuf_addstr(tok, trailer);
> +               strbuf_trim(tok);
> +       }
> +}
> +
> +static struct trailer_item *create_trailer_item(const char *string)
> +{
> +       struct strbuf tok = STRBUF_INIT;
> +       struct strbuf val = STRBUF_INIT;
> +       struct trailer_item *new;
> +       struct trailer_item *item;
> +       int tok_alnum_len;
> +
> +       parse_trailer(&tok, &val, string);
> +
> +       tok_alnum_len = alnum_len(tok.buf, tok.len);
> +
> +       /* Lookup if the token matches something in the config */
> +       for (item = first_conf_item; item; item = item->next) {
> +               if (!strncasecmp(tok.buf, item->conf->key, tok_alnum_len) ||
> +                   !strncasecmp(tok.buf, item->conf->name, tok_alnum_len)) {
> +                       new = xcalloc(sizeof(struct trailer_item), 1);

sizeof(*new) would be more future-proof.

> +                       new->conf = item->conf;
> +                       new->token = xstrdup(item->conf->key);
> +                       new->value = strbuf_detach(&val, NULL);
> +                       strbuf_release(&tok);
> +                       return new;
> +               }
> +       }
> +
> +       new = xcalloc(sizeof(struct trailer_item), 1);

Ditto.

> +       new->conf = xcalloc(sizeof(struct conf_info), 1);
> +       new->token = strbuf_detach(&tok, NULL);
> +       new->value = strbuf_detach(&val, NULL);
> +
> +       return new;
> +}
