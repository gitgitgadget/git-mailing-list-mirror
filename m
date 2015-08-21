From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 05/13] ref-filter: implement an `align` atom
Date: Fri, 21 Aug 2015 07:25:14 +0530
Message-ID: <CAOLa=ZSb69ad=EM4qq5XP7jOmY5KXCQ-ZheyVqMsu0qNRLYWiw@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
 <1439923052-7373-6-git-send-email-Karthik.188@gmail.com> <CAPig+cRB86+1D_CrVjoLxopgf-Rd221Q49UP75hTsZSPdN6QrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 03:56:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSbYl-0001w0-4m
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 03:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbbHUBzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 21:55:45 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36711 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbbHUBzo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 21:55:44 -0400
Received: by obkg7 with SMTP id g7so47709783obk.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 18:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4Cye/soMcZ8qZVeyNr12u4aMBpUPGpD60zx93nBZaxI=;
        b=zJ01tKPP8rT0/KlBdFcV8B09Yayw6gg0fiF83AxYRHPNPyZfeafY5yN/DaziDmbbsi
         h301qYxOzWCiC4yPbW6H0yTsn5o1p+Wm5vp+8hKcOHUpwq2Z9dgE9502dJnnLesjwFyV
         zR/lJlabQHtkJZc/JwCWz5WqIBTXjckxh8J5A0TN73GND+YKfBUljE3elAL3zlRa0EAg
         /CDeRN/5zdpTZ041ODXqsfW4Kr/ZeF1+yUkh2S5NhdoXBHsV88zI8YbzDQoTpvOBFy3P
         z1IaAT6YhjAB8gZ2QSBstxoyExLKJKBA95/mRZUQcLamQ+3nx+VJeePdbRLQno3tc55p
         hxHg==
X-Received: by 10.60.50.169 with SMTP id d9mr2622075oeo.9.1440122144290; Thu,
 20 Aug 2015 18:55:44 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 20 Aug 2015 18:55:14 -0700 (PDT)
In-Reply-To: <CAPig+cRB86+1D_CrVjoLxopgf-Rd221Q49UP75hTsZSPdN6QrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276276>

On Fri, Aug 21, 2015 at 1:53 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Aug 18, 2015 at 2:37 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Implement an `align` atom which left-, middle-, or right-aligns the
>> content between %(align:..) and %(end).
>>
>> It is followed by `:<width>,<position>`, where the `<position>` is
>> either left, right or middle and `<width>` is the size of the area
>> into which the content will be placed. If the content between
>> %(align:) and %(end) is more than the width then no alignment is
>> performed. e.g. to align a refname atom to the middle with a total
>> width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".
>>
>> We now have a `handler()` for each atom_value which will be called
>> when that atom_value is being parsed, and similarly an `at_end`
>> function for each state which is to be called when the `end` atom is
>> encountered. Using this implement the `align` atom which aligns the
>> given strbuf by calling `strbuf_utf8_align()` from utf8.c
>>
>> This is done by assigning a 'handler' function to each atom_value and
>> a related 'at_end' function for each state. The align_handler()
>> defined uses strbuf_utf8_align() from utf8.c to perform the alignment.
>>
>> Add documentation and tests for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 74532d3..ecbcc5a 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -626,6 +638,36 @@ static inline char *copy_advance(char *dst, const char *src)
>>         return dst;
>>  }
>>
>> +static void align_handler(struct ref_formatting_state *state)
>> +{
>> +       struct align *align = (struct align *)state->cb_data;
>> +       struct strbuf s = STRBUF_INIT;
>> +
>> +       strbuf_utf8_align(&s, align->position, align->width, state->output.buf);
>> +       strbuf_reset(&state->output);
>> +       strbuf_addbuf(&state->output, &s);
>> +       free(align);
>> +}
>
> Leaking 'strbuf s' here.
>
> Also, this operation can be expressed more concisely as:
>
>     strbuf_utf8_align(&s, ...);
>     strbuf_swap(&state->output, &s);
>     strbuf_release(&s);
>

This seems neater.

> Seeing this is also making me question my earlier suggestion of making
> pop_state() responsible for appending the current state's output to
> the previous state's output. The reason is that if align_handler() is
> responsible for appending to the previous state's output, then all the
> above string handling collapses to the one line:
>
>     strbuf_utf8_align(&state->prev->output, ..., state->output.buf);
>
> which is even simpler, and doesn't involve a temporary strbuf or
> swapping of strbuf contents.
>
> On the other hand, it won't always be the case that all handlers can
> get by with such simple code, and they might end up creating temporary
> strbuf(s) and such anyhow, so I don't feel too strongly about it, and
> it can always be changed at a later date (by someone) if that approach
> ends up being better.

I did try to tell the same on your previous suggestion, maybe I wasn't
clear enough.
But I see pros and cons for both, so with only one modifier atom at the moment,
It's hard to fixate on one method. Maybe we could change it 'if needed' when we
introduce new atoms eventually.

-- 
Regards,
Karthik Nayak
