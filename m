From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 02/17] trailer: process trailers from file and arguments
Date: Thu, 30 Jan 2014 23:02:18 -0500
Message-ID: <CAPig+cSaYfsyx2YmxOqLxxYLhpgqhznwOzP5CpY7jw=p4sGgpw@mail.gmail.com>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.60878.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jan 31 05:02:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W95JW-0005Dc-RW
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 05:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbaAaECU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 23:02:20 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:45360 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788AbaAaECT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 23:02:19 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so21175265ykr.9
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 20:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ilppUShDWjl5BDAbxvNGtHdtBHZr93H6ynTHJ4uRaC0=;
        b=ieZAepkR2iqo1gsI0dqJtbfgiBxkWL/BOko+X9D+FEpZ5LwUjFuluEFF7WZSz5UB43
         FAhyXTxRwgPZ3ASLXTVMW/c9I0kKw6nnI2/73a8EuIsc1cJ/10ABmAiaMWDsDXJcRU4W
         eEPwZhz9vyYLDGsEulzkPGjTcZAr+15E6trQDEGHyr/9h8vrmRk5S2kjWxMTiArNF5Jp
         U6Il/lK4HkyBu+UCMUZv7V0DGz84mmd3flBoIqpB8I5KkQh1GKd2Hjo9vKaSwI8UUXuG
         bz+LS/m0D61yBnSH3efjf2F3DBPt9xSvzlr1DwJ3Dnoi0T3RvQZb0XycrlmOf2HMxkPQ
         4ocg==
X-Received: by 10.236.98.39 with SMTP id u27mr17170690yhf.27.1391140938893;
 Thu, 30 Jan 2014 20:02:18 -0800 (PST)
Received: by 10.170.36.65 with HTTP; Thu, 30 Jan 2014 20:02:18 -0800 (PST)
In-Reply-To: <20140130064921.7504.60878.chriscool@tuxfamily.org>
X-Google-Sender-Auth: HwRMIu_wBzly6BoORUoRaCpJp80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241292>

On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This patch implements the logic that process trailers
> from file and arguments.
>
> At the beginning trailers from file are in their own
> infile_tok doubly linked list, and trailers from
> arguments are in their own arg_tok doubly linked list.
>
> The lists are traversed and when an arg_tok should be
> "applied", it is removed from its list and inserted
> into the infile_tok list.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/trailer.c b/trailer.c
> index aed25e1..e9ccfa5 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -46,3 +46,192 @@ static size_t alnum_len(const char *buf, size_t len)
> +static void apply_arg_if_exist(struct trailer_item *infile_tok,
> +                              struct trailer_item *arg_tok,
> +                              int alnum_len)
> +{
> +       switch (arg_tok->conf->if_exist) {
> +       case EXIST_DO_NOTHING:
> +               free(arg_tok);

This is freeing arg_tok, but isn't it leaking arg_tok->conf, and
conf->name, conf->key, conf->command? Ditto for all the other
free(arg_tok) invocations elsewhere in the file.

 > +               break;
> +       case EXIST_OVERWRITE:
> +               free((char *)infile_tok->value);
> +               infile_tok->value = xstrdup(arg_tok->value);
> +               free(arg_tok);
> +               break;
> +       case EXIST_ADD:
> +               add_arg_to_infile(infile_tok, arg_tok);
> +               break;
> +       case EXIST_ADD_IF_DIFFERENT:
> +               if (check_if_different(infile_tok, arg_tok, alnum_len, 1))
> +                       add_arg_to_infile(infile_tok, arg_tok);
> +               else
> +                       free(arg_tok);
> +               break;
> +       case EXIST_ADD_IF_DIFFERENT_NEIGHBOR:
> +               if (check_if_different(infile_tok, arg_tok, alnum_len, 0))
> +                       add_arg_to_infile(infile_tok, arg_tok);
> +               else
> +                       free(arg_tok);
> +               break;
> +       }
> +}
> +
> +static void process_infile_tok(struct trailer_item *infile_tok,
> +                              struct trailer_item **arg_tok_first,
> +                              enum action_where where)
> +{
> +       struct trailer_item *arg_tok;
> +       struct trailer_item *next_arg;
> +
> +       int tok_alnum_len = alnum_len(infile_tok->token, strlen(infile_tok->token));
> +       for (arg_tok = *arg_tok_first; arg_tok; arg_tok = next_arg) {
> +               next_arg = arg_tok->next;
> +               if (same_token(infile_tok, arg_tok, tok_alnum_len) &&
> +                   arg_tok->conf->where == where) {
> +                       /* Remove arg_tok from list */
> +                       remove_from_list(arg_tok, arg_tok_first);
> +                       /* Apply arg */
> +                       apply_arg_if_exist(infile_tok, arg_tok, tok_alnum_len);

Redundant comments (saying the same thing as the code) can make the
code slightly more difficult to read.

> +                       /*
> +                        * If arg has been added to infile,
> +                        * then we need to process it too now.
> +                        */
> +                       if ((where == WHERE_AFTER ? infile_tok->next : infile_tok->previous) == arg_tok)
> +                               infile_tok = arg_tok;
> +               }
> +       }
> +}
