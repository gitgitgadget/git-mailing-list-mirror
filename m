From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 01/11] ref-filter: introduce 'ref_formatting_state'
Date: Mon, 27 Jul 2015 20:58:30 +0530
Message-ID: <CAOLa=ZRRw9RCRTL1UaeDMoc683P370eCPD1VcVhMKhju_jfnNg@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <vpqmvyhai1k.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 17:29:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJkKw-0003gh-5o
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 17:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbbG0P3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 11:29:01 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33388 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbbG0P3A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 11:29:00 -0400
Received: by obdeg2 with SMTP id eg2so62195297obd.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GTo6Mu9UDVooo68MSYKRuyZgszaPi16AlYETx1z54CI=;
        b=g1uTStti3n1ezV+f7k/Ez+CPILobcmKJBWteoSoq7rzbKUhcSGulnUSIeYQGtak5xu
         qWy9X+6rdcjXbjRezHUhj+LOPMrHOldpYUqgWqckzjvw1C7C0lx7gweP5vNOiNURPA7+
         2dqfB1xUoYxxPsWCYnux0PKpbw83YHZSrkRXDjyF5y6St6ns3ZoVDnjsh6ynzbcMNJ9F
         fnPwthXVvA2nPByi/nCcCnHpsc7k2ViZD5ZYDtpLbxg6JvAZaudbbg1ogaBoW75GM9lD
         72XXfI8QP8GLItkbir75FoTVCuVQsykaQO4A8yB1UbkD46Y5/aRVY/GNEr0SJFEqUF00
         YJVg==
X-Received: by 10.182.60.130 with SMTP id h2mr16470522obr.42.1438010939640;
 Mon, 27 Jul 2015 08:28:59 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 08:28:30 -0700 (PDT)
In-Reply-To: <vpqmvyhai1k.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274683>

On Mon, Jul 27, 2015 at 6:12 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void ref_formatting(struct ref_formatting_state *state,
>> +                        struct atom_value *v, struct strbuf *value)
>>  {
>> -     struct strbuf sb = STRBUF_INIT;
>> -     switch (quote_style) {
>> +     strbuf_addf(value, "%s", v->s);
>> +}
>
> You're taking 'state' as argument, but you're not using it in the
> function for now. Perhaps add a temporary comment like:
>
> static void ref_formatting(...)
> {
>         /* Formatting according to 'state' will be applied here */
>         strbuf_addf(...)
> }
>
> Or perhaps it's OK like this.

I thought it'd be OK since it doesn't have any adverse effect, but I added
the comment you suggested nonetheless.

>
>> -static void print_value(struct atom_value *v, int quote_style)
>> +static void print_value(struct ref_formatting_state *state, struct atom_value *v)
>
> Changing the position of the v parameter makes the patch a bit harder to
> read. I would have written in this order:
>
> static void print_value(struct atom_value *v, struct ref_formatting_state *state)
>
> So the patch reads as "encapsulate quote_style in a struct" more
> straightforwardly.
>

I need to be more careful about things like this, thanks.

>> @@ -1257,6 +1269,10 @@ static void emit(const char *cp, const char *ep)
>>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>>  {
>>       const char *cp, *sp, *ep;
>> +     struct ref_formatting_state state;
>
> I still found it a bit hard to read, and I would have appreciated a
> comment here, like
>
>         /*
>          * Some (pseudo) atom have no immediate side effect, but only
>          * affect the next atom. Store the relevant information from
>          * these atoms in the 'state' variable for use when displaying
>          * the next atom.
>          */
>

This seems good, will add this.

> With this in mind, it becomes more obvious that you also need to reset
> the state after using it, which you forgot to do. See:
>
> $ ./git for-each-ref --format '%(padright:30)|%(refname)|%(refname)|' refs/tags/v2.4.\*
> |refs/tags/v2.4.0              |refs/tags/v2.4.0              |
> |refs/tags/v2.4.0-rc0          |refs/tags/v2.4.0-rc0          |
> |refs/tags/v2.4.0-rc1          |refs/tags/v2.4.0-rc1          |
> |refs/tags/v2.4.0-rc2          |refs/tags/v2.4.0-rc2          |
> |refs/tags/v2.4.0-rc3          |refs/tags/v2.4.0-rc3          |
> |refs/tags/v2.4.1              |refs/tags/v2.4.1              |
> |refs/tags/v2.4.2              |refs/tags/v2.4.2              |
> |refs/tags/v2.4.3              |refs/tags/v2.4.3              |
> |refs/tags/v2.4.4              |refs/tags/v2.4.4              |
> |refs/tags/v2.4.5              |refs/tags/v2.4.5              |
> |refs/tags/v2.4.6              |refs/tags/v2.4.6              |
>
> I think only the first column should have padding, not the second. You
> can fix this with a patch like this:
>
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1431,6 +1431,14 @@ static void apply_pseudo_state(struct ref_formatting_state *state,
>                 state->ifexists = v->s;
>  }
>
> +static void reset_formatting_state(struct ref_formatting_state *state)
> +{
> +       int quote_style = state->quote_style;
> +       memset(state, 0, sizeof(*state));
> +       state->quote_style = quote_style;
> +}
> +
> +
>  /*
>   * If 'lines' is greater than 0, print that many lines from the given
>   * object_id 'oid'.
> @@ -1492,8 +1500,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>                 if (atomv->pseudo_atom)
>                         apply_pseudo_state(&state, atomv);
> -               else
> +               else {
>                         print_value(&state, atomv);
> +                       reset_formatting_state(&state);
> +               }
> +
>         }
>         if (*cp) {
>                 sp = cp + strlen(cp);
>

If you saw the last patch series, i had them reset individually, I
missed that by mistake.
But what you're doing seems good, will integrate this. thanks :D

-- 
Regards,
Karthik Nayak
