From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 06/13] ref-filter: introduce format_ref_array_item()
Date: Sat, 29 Aug 2015 23:42:19 -0400
Message-ID: <CAPig+cT2ySwYtTjv7Xe3uv35OH8Bhdyj3m_eqyJjMe_mB6Xj=w@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 05:42:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVtVl-0004Dx-1n
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 05:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbbH3DmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 23:42:21 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35036 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbH3DmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 23:42:20 -0400
Received: by ykbu129 with SMTP id u129so18086244ykb.2
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 20:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Q3iTNfXHPLKAWFNmrMND0DtDm5a7jasqGfogPQNPE2c=;
        b=AmwSAc75zbiXvm0/7D+AEvCrJpYm+eCqjtUoFCLe67d9GokQerBr41NXPvTwVEJnkJ
         mP9at5YoOUqIYlBzPDVJEDNqczDa8TASazSBMBENkIpt9iKGdeVOWbhhHhIHAUvLwJ8b
         33tGfDsY3rAtxrCCNQlKZba6kepb83kz4ivpGQHgU2ct+Z3MbSRUsixoHcv6dijGsKtG
         uJSjVWDweGDZxsh62IAL9UXKMPuQK/Nc2p9GIyh3bM0a92ar6nCY2Vm6or/PcqLoCyxf
         ZKF5eRdbCFfqpkE5vmb7S4KRbLfuO/fEn1fU3SR2ZtZeV9Rynf6qPUplAI1BTvoQY+0g
         TvdQ==
X-Received: by 10.129.83.136 with SMTP id h130mr16227736ywb.95.1440906139578;
 Sat, 29 Aug 2015 20:42:19 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sat, 29 Aug 2015 20:42:19 -0700 (PDT)
In-Reply-To: <1440857537-13968-7-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: TjwamCQFjO1Vuh_VwBKC11tEUF0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276800>

On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Create format_ref_array_item() out of show_ref_array_item(). This will
> store the output format for the given ref_array_item into the provided
> strbuf. Make show_ref_array_item() a wrapper around this to print the
> given ref_array_item with linefeed.

Perhaps you could explain why this change is a good idea, such as that
a future patch, for <fill-in-the-blank> reason, will need the
formatting capability of format_ref_array_item() but not the printing
with newline done by show_ref_array_item().

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 5d4f93d..1e6754a 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -153,6 +153,27 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>         return at;
>  }
>
> +static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
> +{
> +       switch (quote_style) {
> +       case QUOTE_NONE:
> +               strbuf_addstr(s, str);
> +               break;
> +       case QUOTE_SHELL:
> +               sq_quote_buf(s, str);
> +               break;
> +       case QUOTE_PERL:
> +               perl_quote_buf(s, str);
> +               break;
> +       case QUOTE_PYTHON:
> +               python_quote_buf(s, str);
> +               break;
> +       case QUOTE_TCL:
> +               tcl_quote_buf(s, str);
> +               break;
> +       }
> +}

This code was already relocated once in patch 4/13, and is now being
relocated again in 6/13. If you instead place the code at the final
desired location in 4/13, then this patch will become less noisy.

More below.

>  static void push_stack_element(struct ref_formatting_stack **stack)
>  {
>         struct ref_formatting_stack *s = xcalloc(1, sizeof(struct ref_formatting_stack));
> @@ -665,27 +686,6 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
>         new->cb_data = atomv->align;
>  }
>
> -static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
> -{
> -       switch (quote_style) {
> -       case QUOTE_NONE:
> -               strbuf_addstr(s, str);
> -               break;
> -       case QUOTE_SHELL:
> -               sq_quote_buf(s, str);
> -               break;
> -       case QUOTE_PERL:
> -               perl_quote_buf(s, str);
> -               break;
> -       case QUOTE_PYTHON:
> -               python_quote_buf(s, str);
> -               break;
> -       case QUOTE_TCL:
> -               tcl_quote_buf(s, str);
> -               break;
> -       }
> -}
> -
>  static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
>  {
>         /*
> @@ -1478,10 +1478,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>         }
>         if (state.stack->prev)
>                 die(_("format: `end` atom missing"));
> -       final_buf = &state.stack->output;
> -       fwrite(final_buf->buf, 1, final_buf->len, stdout);
> +       strbuf_addbuf(out, &state.stack->output);
>         pop_stack_element(&state.stack);
> -       putchar('\n');
> +}
> +
> +void show_ref_array_item(struct ref_array_item *item, const char *format, unsigned int quote_style)
> +{
> +       struct strbuf out = STRBUF_INIT;
> +       format_ref_array_item(&out, item, format, quote_style);
> +       fwrite(out.buf, out.len, 1, stdout);
> +       printf("\n");

putchar('\n');

> +       strbuf_release(&out);
>  }
>
>  /*  If no sorting option is given, use refname to sort as default */
