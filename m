From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 02/11] ref-filter: introduce ref_formatting_state
Date: Fri, 7 Aug 2015 00:43:02 -0400
Message-ID: <CAPig+cTt__tphEqFuyeOiTadOL9cAi51RLd3z6rr3nM-8Qp6Aw@mail.gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
	<1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
	<1438692188-14367-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cQftyjKFi0Qkg_ZVEJ9A+zGSAmFtHwQ-8hCnf8xtU_PEA@mail.gmail.com>
	<CAOLa=ZSp3aL0Z5YP5xmzdW7H92yU3EA+MJjLYA29QyoZTD5RiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 06:43:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNZUs-0002vC-56
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 06:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbbHGEnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 00:43:05 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33742 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbbHGEnD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 00:43:03 -0400
Received: by ykoo205 with SMTP id o205so80456997yko.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 21:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=q5POOiq+JLJabAlpchwcXqNAVXyWN3k7H+n2sYjdix8=;
        b=D63ENzD5zVaNRyZmbOmJA+rNCDrqHIuWcUXMF3w7UNPOR6tcOajo7aramaMr5BEAjZ
         XWJVgsG81mBxp1CYziitm+DKSB9URVFBqvqt7EGt8ohcffguvg0YgGgUiyXuwWJhFtKK
         t/tj6EwnAB4O/Pcvro+py3QmP14gB/i7VQhPiRacUm2E34xxQUX2XlMv4u00klkFBRWc
         xSrJfcg5BATQLGzwtCY1m478X4W9SCZKnHWDKfdCT6T38n3ADnIWs13SkCOXRBtyzLos
         xqxlnHwtcKeC7ahwsv8ccATadBvW1HFTBxMcqIRuBLvKLaI/SWWZ3oGYsnRL63MJUOA1
         meXg==
X-Received: by 10.129.76.140 with SMTP id z134mr5799945ywa.17.1438922582728;
 Thu, 06 Aug 2015 21:43:02 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 21:43:02 -0700 (PDT)
In-Reply-To: <CAOLa=ZSp3aL0Z5YP5xmzdW7H92yU3EA+MJjLYA29QyoZTD5RiA@mail.gmail.com>
X-Google-Sender-Auth: Np_-sVIil0PNP6OYUGHhN_0b9m8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275460>

On Thu, Aug 6, 2015 at 11:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Fri, Aug 7, 2015 at 5:49 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Aug 4, 2015 at 8:42 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> +static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *final)
>>> +{
>>> +       /* More formatting options to be evetually added */
>>> +       strbuf_addbuf(final, state->output);
>>> +       strbuf_release(state->output);
>>
>> I guess the idea here is that you intend state->output to be re-used
>> and it is convenient to "clear" it here rather than making that the
>> responsibility of each caller. For re-use, it is more typical to use
>> strbuf_reset() than strbuf_release() (though Junio may disagree[1]).
>
> it seems like a smarter way to around this without much overhead But it
> was more of to release it as its no longer required unless another modifier atom
> is encountered. Is it worth keeping hoping for another modifier atom eventually,
> and release it at the end like you suggested below?

If I understand your question correctly, it sounds like you're asking
about a memory micro-optimization. From an architectural standpoint,
it's cleaner for the entity which allocates a resource to also release
it. In this case, show_ref_array_item() allocates the strbuf, thus it
should be the one to release it.

And, although we shouldn't be worrying about micro-optimizations at
this point, if it were to be an issue, resetting the strbuf via
strbuf_reset(), which doesn't involve slow memory
deallocation/reallocation, is likely to be a winner over repeated
strbuf_release().

>>> +       memset(&state, 0, sizeof(state));
>>> +       state.quote_style = quote_style;
>>> +       state.output = &value;
>>
>> It feels strange to assign a local variable reference to state.output,
>> and there's no obvious reason why you should need to do so. I would
>> have instead expected ref_format_state to be declared as:
>>
>>     struct ref_formatting_state {
>>        int quote_style;
>>        struct strbuf output;
>>     };
>>
>> and initialized as so:
>>
>>     memset(&state, 0, sizeof(state));
>>     state.quote_style = quote_style;
>>     strbuf_init(&state.output, 0);
>
> This looks neater, thanks. It'll go along with the previous patch.
>
>> (In fact, the memset() isn't even necessary here since you're
>> initializing all fields explicitly, though perhaps you want the
>> memset() because a future patch adds more fields which are not
>> initialized explicitly?)
>
> Yea the memset is needed for bit fields evnetually added in the future.

Perhaps move the memset() to the first patch which actually requires
it, where it won't be (effectively) dead code, as it becomes here once
you make the above change.

>>>         for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>>> -               struct atom_value *atomv;
>>> +               struct atom_value *atomv = NULL;
>>
>> What is this change about?
>
> To remove the warning about atomv being unassigned before usage.

Hmm, where were you seeing that warning? The first use of 'atomv'
following its declaration is in the get_ref_atom_value() below, and
(as far as the compiler knows) that should be setting its value.

>>>                 ep = strchr(sp, ')');
>>> -               if (cp < sp)
>>> -                       emit(cp, sp, &output);
>>> +               if (cp < sp) {
>>> +                       emit(cp, sp, &state);
>>> +                       apply_formatting_state(&state, &final_buf);
>>> +               }
>>>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>>> -               print_value(atomv, quote_style, &output);
>>> +               process_formatting_state(atomv, &state);
>>> +               print_value(atomv, &state);
>>> +               apply_formatting_state(&state, &final_buf);
>>>         }
>>>         if (*cp) {
>>>                 sp = cp + strlen(cp);
>>> -               emit(cp, sp, &output);
>>> +               emit(cp, sp, &state);
>>> +               apply_formatting_state(&state, &final_buf);
>>
>> I'm getting the feeling that these functions
>> (process_formatting_state, print_value, emit, apply_formatting_state)
>> are becoming misnamed (again) with the latest structural changes (but
>> perhaps I haven't read far enough into the series yet?).
>>
>> process_formatting_state() is rather generic.
>
> perhaps set_formatting_state()?

I don't know. I don't have a proper high-level overview of the
functionality yet to say if that is a good name or not (which is one
reason I didn't suggest an alternative).

>> print_value() and emit() both imply outputting something, but neither
>> does so anymore.
>
> I think I'll append a "to_state" to each of them.

Meh. print_value() might be better named format_value(). emit() might
become append_literal() or append_non_atom() or something.

>> apply_formatting_state() seems to be more about finalizing the
>> already-formatted output.
>
> perform_state_formatting()? perhaps.

Dunno.
