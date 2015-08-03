From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 02/11] ref-filter: introduce ref_formatting_state
Date: Tue, 4 Aug 2015 03:33:26 +0530
Message-ID: <CAOLa=ZStMApJoOfu5Hs_rE+-dKN+FSjcAqKkbAUomt0pnqEdTQ@mail.gmail.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
 <1438620861-25219-2-git-send-email-Karthik.188@gmail.com> <xmqqzj286r46.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:04:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMNq2-0000HF-Pt
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 00:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbbHCWD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 18:03:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35501 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbbHCWD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 18:03:56 -0400
Received: by obbop1 with SMTP id op1so109816017obb.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nJi3M1vRax8qzpqJDN7rA6YKrowQi74qpHt1a+dM/y8=;
        b=LHYXFu+TShvUJ0ZYCajLVsh1oz/hoaujBcoLkv0iFrQRmjxXNYW1YQEbbW4p7aMvFY
         BG/0tphMZ7rmoDWwkas6PYAPei5tSsQGQBHHi63mx48sfdTtjs210Z0SupSQOZqojBXw
         2Yd/u0BqkHUi34EaiscDPm1bpPQ9RsVrjVH91YUl7RcRbpVYH/30EfxyF/755LchqW1l
         kR3XZVaEyTzeuoMOZVjh7sEhur73dc1Gfn8c+QY3Bu5lNZUFkWHVFzqIETPoQJ4+7/eO
         OGn7J6uwHciVVvIDadHXvYA27IqRUT+jmJcPMnH45Ybgo3ZDeYagvJul1iwkiqpmY4s+
         b+bA==
X-Received: by 10.182.29.68 with SMTP id i4mr214689obh.57.1438639436183; Mon,
 03 Aug 2015 15:03:56 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 3 Aug 2015 15:03:26 -0700 (PDT)
In-Reply-To: <xmqqzj286r46.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275214>

On Tue, Aug 4, 2015 at 2:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Introduce a ref_formatting_state which will eventually hold the values
>> of modifier atoms. Implement this within ref-filter.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  ref-filter.c | 49 +++++++++++++++++++++++++++++++++++++------------
>>  ref-filter.h |  4 ++++
>>  2 files changed, 41 insertions(+), 12 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index febdc45..c4c7064 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1190,9 +1190,10 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>>       qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
>>  }
>>
>> -static void print_value(struct atom_value *v, int quote_style, struct strbuf *output)
>> +static void print_value(struct atom_value *v, struct ref_formatting_state *state,
>> +                     struct strbuf *output)
>>  {
>
> I expect that the state would eventually become a stack of states
> (i.e. the topmost one passed around, each having a pointer to the
> previous level) in order to implement that "divert" mechanism for
> (possibly nested) if ... end construct.
>

Makes sense :)

> With that in mind, I suspect that state->output should be "where the
> current level would output to", i.e. no need to pass state and
> output around separately.
>

Will do!

>> +static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *value,
>> +                                struct strbuf *format)
>> +{
>
> The name "format" feels quite misleading; the readers would expect
> that you would use it in "strbuf_addf(format, value)", but that is
> not what is going on here.
>

will change it to final i guess.

>> @@ -1275,12 +1299,13 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>>               if (color_parse("reset", color) < 0)
>>                       die("BUG: couldn't parse 'reset' as a color");
>>               resetv.s = color;
>> -             print_value(&resetv, quote_style, &output);
>> +             print_value(&resetv, &state, &value);
>> +             apply_formatting_state(&state, &value, &final_buf);
>>       }
>> -     for (i = 0; i < output.len; i++)
>> -             printf("%c", output.buf[i]);
>> +     for (i = 0; i < final_buf.len; i++)
>> +             printf("%c", final_buf.buf[i]);
>>       putchar('\n');
>> -     strbuf_release(&output);
>> +     strbuf_release(&final_buf);
>>  }
>>
>>  /*  If no sorting option is given, use refname to sort as default */
>> diff --git a/ref-filter.h b/ref-filter.h
>> index 6bf27d8..b64677f 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -16,6 +16,10 @@
>>  #define FILTER_REFS_INCLUDE_BROKEN 0x1
>>  #define FILTER_REFS_ALL 0x2
>>
>> +struct ref_formatting_state {
>> +     int quote_style;
>> +};
>> +
>>  struct atom_value {
>>       const char *s;
>>       unsigned long ul; /* used for sorting when not FIELD_STR */



-- 
Regards,
Karthik Nayak
