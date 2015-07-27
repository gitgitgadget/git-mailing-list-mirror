From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 02/11] ref-filter: make `color` use `ref_formatting_state`
Date: Mon, 27 Jul 2015 22:46:40 +0530
Message-ID: <CAOLa=ZQ6tO+n+V=iVZQi0+UOPDQvfGSNjxCyOTZCOFic-1wHaw@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-2-git-send-email-Karthik.188@gmail.com>
 <vpqlhe192d5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 19:17:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJm1b-0002KK-Df
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 19:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbG0RRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 13:17:11 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33444 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbbG0RRK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 13:17:10 -0400
Received: by obdeg2 with SMTP id eg2so64675319obd.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tDpWbH3PLmvJY/HQRWjXfTV3eIjScP4hQsuYqbLSNOQ=;
        b=uhWm5zEDjGngDzah5oNiplP7MljG7dDsRtmghFwIGLwjN8vpFeCPv1InapZL2lWlrM
         AwdU1/t7+z4odF+P6wX7k8Akty/sCMe2hOI9DWr+W7qJSAyNhXrHVOkFsWIwQZJ9w3Qq
         TOqmFykyXwDycbnZGl0MV8+EWCa3J/l2uFT4cSqWpmnif0VbFuElZEbdcweEjzZW/BOO
         QHQtEygpMK2B5lT6aBQ02+uYmWw1k2p1uWTu7AMrecGDZea7bmS5kglssh4/EbiY4eH8
         ZofPweG69gH878Npq1DRiNglILBwyWwUB31WR0Bsr9Iy0Ah1QyDIcDSS32EuwJuvZpBg
         yqvg==
X-Received: by 10.60.42.230 with SMTP id r6mr30621088oel.9.1438017429648; Mon,
 27 Jul 2015 10:17:09 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 10:16:40 -0700 (PDT)
In-Reply-To: <vpqlhe192d5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274692>

On Mon, Jul 27, 2015 at 6:36 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1195,6 +1197,11 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>>  static void ref_formatting(struct ref_formatting_state *state,
>>                          struct atom_value *v, struct strbuf *value)
>>  {
>> +     if (state->color) {
>> +             strbuf_addstr(value, state->color);
>> +             free(state->color);
>> +             state->color = NULL;
>> +     }
>>       strbuf_addf(value, "%s", v->s);
>>  }
>>
>> @@ -1266,6 +1273,13 @@ static void emit(const char *cp, const char *ep)
>>       }
>>  }
>>
>> +static void apply_pseudo_state(struct ref_formatting_state *state,
>> +                            struct atom_value *v)
>> +{
>> +     if (v->color)
>> +             state->color = (char *)v->s;
>> +}
>> +
>>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>>  {
>>       const char *cp, *sp, *ep;
>
> It's not clear enough in the code and history that these these two
> functions are symmetrical.
>
> You can find better names. 'apply_pseudo_state' seems wrong it two ways:
> it does not _apply_ the state, but it stores it. And it's a "pseudo-atom
> related state", but not a "pseudo-state".
>
> How about
>
> ref_formatting -> apply_formatting_state
> apply_pseudo_state -> store_formatting_state
>
> ?

Yes, your suggested naming scheme is better. Ill adopt this.

>
> Actually, I would even call these functions right from
> show_ref_array_item, so that the result look like this:
>
>                 if (atomv->pseudo_atom)
>                         store_formatting_state(&state, atomv);
>                 else {
>                         apply_formatting_state(&state, atomv);
>                         reset_formatting_state(&state);
>                         print_value(&state, atomv);
>                 }

This would eliminate that extra strbuf in print_value() wouldn't it,
but this would also mean
that we replace the value in atomv to hold the new formatted value.
Sounds good to me.
Thanks :)

>
> In the history, if you are to introduce a dumb version of ref_formatting
> in PATCH 1, I think you should also introduce a dumb (actually, totally
> empty) version of apply_pseudo_state. Then, further patches would just
> add a few lines in each function, and ...
>
>> @@ -1281,7 +1295,10 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>>               if (cp < sp)
>>                       emit(cp, sp);
>>               get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>> -             print_value(&state, atomv);
>> +             if (atomv->pseudo_atom)
>> +                     apply_pseudo_state(&state, atomv);
>> +             else
>> +                     print_value(&state, atomv);
>>       }
>
> ... this hunk would belong to PATCH 1.
>

I'll add a placeholder for this in the PATCH 1. Thanks :D

-- 
Regards,
Karthik Nayak
