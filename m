From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 06/13] ref-filter: introduce format_ref_array_item()
Date: Sun, 30 Aug 2015 12:09:36 +0530
Message-ID: <CAOLa=ZTiVS=3M8ckr2Ouz_46h7zaHBcRyxqHMbhGEAt3uWNaCQ@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-7-git-send-email-Karthik.188@gmail.com> <CAPig+cT2ySwYtTjv7Xe3uv35OH8Bhdyj3m_eqyJjMe_mB6Xj=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 08:40:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVwHm-0002su-UN
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 08:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbbH3GkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 02:40:08 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34864 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbH3GkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 02:40:06 -0400
Received: by obbwr7 with SMTP id wr7so70188396obb.2
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 23:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UcVxWNxVU5bLarIQZoED7QEwrGTtKStIqC2+HFibfoc=;
        b=PxGVFCSn8DyoGP9IWdp/2JanMdCkd7qTEq7nMj3VYDk9SyT+h2D1mlzoJaG+r5FtYm
         Zrq1Wo66ndpBDdg2cyMXRgKATuj9uFtfYIAREBjB52HpWYIYcimkUqER2GNcVH8Wk2gv
         67TasT3pJr/16wer+SUzh1+WHpNKpGIDErKwKEq2bYZyy8dleqbXGG1TY4JYtu9Aa3Py
         UCxtE3OvB/qv0AHLfSE0Q8x9TgepMIsbuC0i5j7H/Ch0hV9DPx1Q+Y/FzG6um79NZ9sS
         L/TwtG6T5p4F5YDszvGmlZHCxBMfnlznJ2bXRxbMUDE+tusDUyxRKy76tgcoESeooPyQ
         zZVw==
X-Received: by 10.182.196.101 with SMTP id il5mr5869obc.41.1440916806125; Sat,
 29 Aug 2015 23:40:06 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sat, 29 Aug 2015 23:39:36 -0700 (PDT)
In-Reply-To: <CAPig+cT2ySwYtTjv7Xe3uv35OH8Bhdyj3m_eqyJjMe_mB6Xj=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276803>

On Sun, Aug 30, 2015 at 9:12 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Create format_ref_array_item() out of show_ref_array_item(). This will
>> store the output format for the given ref_array_item into the provided
>> strbuf. Make show_ref_array_item() a wrapper around this to print the
>> given ref_array_item with linefeed.
>
> Perhaps you could explain why this change is a good idea, such as that
> a future patch, for <fill-in-the-blank> reason, will need the
> formatting capability of format_ref_array_item() but not the printing
> with newline done by show_ref_array_item().
>

Yeah sure.

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 5d4f93d..1e6754a 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -153,6 +153,27 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>         return at;
>>  }
>>
>> +static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
>> +{
>> +       switch (quote_style) {
>> +       case QUOTE_NONE:
>> +               strbuf_addstr(s, str);
>> +               break;
>> +       case QUOTE_SHELL:
>> +               sq_quote_buf(s, str);
>> +               break;
>> +       case QUOTE_PERL:
>> +               perl_quote_buf(s, str);
>> +               break;
>> +       case QUOTE_PYTHON:
>> +               python_quote_buf(s, str);
>> +               break;
>> +       case QUOTE_TCL:
>> +               tcl_quote_buf(s, str);
>> +               break;
>> +       }
>> +}
>
> This code was already relocated once in patch 4/13, and is now being
> relocated again in 6/13. If you instead place the code at the final
> desired location in 4/13, then this patch will become less noisy.
>

Will do.

> More below.
>
>>  static void push_stack_element(struct ref_formatting_stack **stack)
>>  {
>>         struct ref_formatting_stack *s = xcalloc(1, sizeof(struct ref_formatting_stack));
>> @@ -665,27 +686,6 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
>>         new->cb_data = atomv->align;
>>  }
>>
>> -static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
>> -{
>> -       switch (quote_style) {
>> -       case QUOTE_NONE:
>> -               strbuf_addstr(s, str);
>> -               break;
>> -       case QUOTE_SHELL:
>> -               sq_quote_buf(s, str);
>> -               break;
>> -       case QUOTE_PERL:
>> -               perl_quote_buf(s, str);
>> -               break;
>> -       case QUOTE_PYTHON:
>> -               python_quote_buf(s, str);
>> -               break;
>> -       case QUOTE_TCL:
>> -               tcl_quote_buf(s, str);
>> -               break;
>> -       }
>> -}
>> -
>>  static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
>>  {
>>         /*
>> @@ -1478,10 +1478,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>>         }
>>         if (state.stack->prev)
>>                 die(_("format: `end` atom missing"));
>> -       final_buf = &state.stack->output;
>> -       fwrite(final_buf->buf, 1, final_buf->len, stdout);
>> +       strbuf_addbuf(out, &state.stack->output);
>>         pop_stack_element(&state.stack);
>> -       putchar('\n');
>> +}
>> +
>> +void show_ref_array_item(struct ref_array_item *item, const char *format, unsigned int quote_style)
>> +{
>> +       struct strbuf out = STRBUF_INIT;
>> +       format_ref_array_item(&out, item, format, quote_style);
>> +       fwrite(out.buf, out.len, 1, stdout);
>> +       printf("\n");
>
> putchar('\n');

Thanks for the review.

-- 
Regards,
Karthik Nayak
