From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 02/11] ref-filter: introduce ref_formatting_state
Date: Fri, 7 Aug 2015 17:07:57 +0530
Message-ID: <CAOLa=ZSRFcfQqjphdSYkWDry8QibKL78Ev=XnfPRxc3PJ17Dog@mail.gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
 <1438692188-14367-1-git-send-email-Karthik.188@gmail.com> <1438692188-14367-2-git-send-email-Karthik.188@gmail.com>
 <CAPig+cQftyjKFi0Qkg_ZVEJ9A+zGSAmFtHwQ-8hCnf8xtU_PEA@mail.gmail.com>
 <CAOLa=ZSp3aL0Z5YP5xmzdW7H92yU3EA+MJjLYA29QyoZTD5RiA@mail.gmail.com> <CAPig+cTt__tphEqFuyeOiTadOL9cAi51RLd3z6rr3nM-8Qp6Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 13:38:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNfyq-0004ub-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 13:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbbHGLi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 07:38:29 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:32782 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbHGLi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 07:38:28 -0400
Received: by obdeg2 with SMTP id eg2so77178130obd.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yLL4M9Aprfm+7SE6duakTLqL5oMrLHW1Z12WI1Gitm8=;
        b=mLkDW9T71Rz3ZmMUcQvLWPhkitIE0NNQMPvQeaetnVC+WX11p3Kd2APapvcnpJC7Hc
         KfJMcFQyF5BZQAuPAutcaoGf+kMfYy51WFtPSXIA7HdEVeSdkzin3hQ1kPSO5RhVvA+R
         61KjlEDtegvW4gITbnWRgMqZijRRzxaQ2eD8vULLTM2IqAMEiX6Em9mqyed6mR+Hpe5K
         QbcRP1JC4a7OzzLHJy2tL3y1vrRtXwMXohyX513JmiNRkD5ZPu45BEhh1cgXmAy8CJWW
         IlK2tElbH2S2d9HX3JQ/zxG2RyXFe3uJYf6FhJ+oHEy1XmneqnZZGBvdckUCLhF243KW
         WzHw==
X-Received: by 10.60.62.105 with SMTP id x9mr6120147oer.1.1438947507149; Fri,
 07 Aug 2015 04:38:27 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 7 Aug 2015 04:37:57 -0700 (PDT)
In-Reply-To: <CAPig+cTt__tphEqFuyeOiTadOL9cAi51RLd3z6rr3nM-8Qp6Aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275466>

On Fri, Aug 7, 2015 at 10:13 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Aug 6, 2015 at 11:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Fri, Aug 7, 2015 at 5:49 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Aug 4, 2015 at 8:42 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> +static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *final)
>>>> +{
>>>> +       /* More formatting options to be evetually added */
>>>> +       strbuf_addbuf(final, state->output);
>>>> +       strbuf_release(state->output);
>>>
>>> I guess the idea here is that you intend state->output to be re-used
>>> and it is convenient to "clear" it here rather than making that the
>>> responsibility of each caller. For re-use, it is more typical to use
>>> strbuf_reset() than strbuf_release() (though Junio may disagree[1]).
>>
>> it seems like a smarter way to around this without much overhead But it
>> was more of to release it as its no longer required unless another modifier atom
>> is encountered. Is it worth keeping hoping for another modifier atom eventually,
>> and release it at the end like you suggested below?
>
> If I understand your question correctly, it sounds like you're asking
> about a memory micro-optimization. From an architectural standpoint,
> it's cleaner for the entity which allocates a resource to also release
> it. In this case, show_ref_array_item() allocates the strbuf, thus it
> should be the one to release it.
>
> And, although we shouldn't be worrying about micro-optimizations at
> this point, if it were to be an issue, resetting the strbuf via
> strbuf_reset(), which doesn't involve slow memory
> deallocation/reallocation, is likely to be a winner over repeated
> strbuf_release().
>

Exactly what I was asking, thanks for explaining :D

>>>> +       memset(&state, 0, sizeof(state));
>>>> +       state.quote_style = quote_style;
>>>> +       state.output = &value;
>>>
>>> It feels strange to assign a local variable reference to state.output,
>>> and there's no obvious reason why you should need to do so. I would
>>> have instead expected ref_format_state to be declared as:
>>>
>>>     struct ref_formatting_state {
>>>        int quote_style;
>>>        struct strbuf output;
>>>     };
>>>
>>> and initialized as so:
>>>
>>>     memset(&state, 0, sizeof(state));
>>>     state.quote_style = quote_style;
>>>     strbuf_init(&state.output, 0);
>>
>> This looks neater, thanks. It'll go along with the previous patch.
>>
>>> (In fact, the memset() isn't even necessary here since you're
>>> initializing all fields explicitly, though perhaps you want the
>>> memset() because a future patch adds more fields which are not
>>> initialized explicitly?)
>>
>> Yea the memset is needed for bit fields evnetually added in the future.
>
> Perhaps move the memset() to the first patch which actually requires
> it, where it won't be (effectively) dead code, as it becomes here once
> you make the above change.
>

But why would I need it there, we need to only memset() the ref_formatting_state
which is introduced here. Also here it helps in setting the strbuf
within ref_formatting_state
to {0, 0, 0}.

>>>>         for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>>>> -               struct atom_value *atomv;
>>>> +               struct atom_value *atomv = NULL;
>>>
>>> What is this change about?
>>
>> To remove the warning about atomv being unassigned before usage.
>
> Hmm, where were you seeing that warning? The first use of 'atomv'
> following its declaration is in the get_ref_atom_value() below, and
> (as far as the compiler knows) that should be setting its value.
>

I'll check this out.

>>>>                 ep = strchr(sp, ')');
>>>> -               if (cp < sp)
>>>> -                       emit(cp, sp, &output);
>>>> +               if (cp < sp) {
>>>> +                       emit(cp, sp, &state);
>>>> +                       apply_formatting_state(&state, &final_buf);
>>>> +               }
>>>>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>>>> -               print_value(atomv, quote_style, &output);
>>>> +               process_formatting_state(atomv, &state);
>>>> +               print_value(atomv, &state);
>>>> +               apply_formatting_state(&state, &final_buf);
>>>>         }
>>>>         if (*cp) {
>>>>                 sp = cp + strlen(cp);
>>>> -               emit(cp, sp, &output);
>>>> +               emit(cp, sp, &state);
>>>> +               apply_formatting_state(&state, &final_buf);
>>>
>>> I'm getting the feeling that these functions
>>> (process_formatting_state, print_value, emit, apply_formatting_state)
>>> are becoming misnamed (again) with the latest structural changes (but
>>> perhaps I haven't read far enough into the series yet?).
>>>
>>> process_formatting_state() is rather generic.
>>
>> perhaps set_formatting_state()?
>
> I don't know. I don't have a proper high-level overview of the
> functionality yet to say if that is a good name or not (which is one
> reason I didn't suggest an alternative).
>

Ah! okay.

>>> print_value() and emit() both imply outputting something, but neither
>>> does so anymore.
>>
>> I think I'll append a "to_state" to each of them.
>
> Meh. print_value() might be better named format_value(). emit() might
> become append_literal() or append_non_atom() or something.
>

Ill think about this, thanks :)

>>> apply_formatting_state() seems to be more about finalizing the
>>> already-formatted output.
>>
>> perform_state_formatting()? perhaps.
>
> Dunno.

That's okay, I'll think about it.


-- 
Regards,
Karthik Nayak
