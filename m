From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 02/11] ref-filter: introduce ref_formatting_state
Date: Fri, 7 Aug 2015 09:23:04 +0530
Message-ID: <CAOLa=ZSp3aL0Z5YP5xmzdW7H92yU3EA+MJjLYA29QyoZTD5RiA@mail.gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
 <1438692188-14367-1-git-send-email-Karthik.188@gmail.com> <1438692188-14367-2-git-send-email-Karthik.188@gmail.com>
 <CAPig+cQftyjKFi0Qkg_ZVEJ9A+zGSAmFtHwQ-8hCnf8xtU_PEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 05:53:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNYiy-0003Qr-0E
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 05:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbbHGDxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 23:53:36 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36712 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbbHGDxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 23:53:35 -0400
Received: by obnw1 with SMTP id w1so70691417obn.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9HuG/OUnAIcAkV/0m/1tszxfYk4D1CKqyjaTLXNMutE=;
        b=ttp09PDfTrig370GXxk+oUj6f6NLKOqIcJkkuZXf9ZpQY1faGJtgReAmA8U81iZPHY
         h/Ya18xaKVHYWyg8w5/y/qOJ0n1Z4WDctyCXjJqIyvVmK5mmUef8n288tcbDUAZPagcP
         MZHVOg2DIOIlDl1POKLNQfz5s47hoZ4H5xceOFa+69EC/sRpKAzhhIZucVgqqVXQsq66
         1hupCcOrR+qfiK8FXcQewCQIEXgQoHTx6XE0q5J28JGvL85RUXUhNQgXugTWnaaB1Vu5
         Xuj5/o40gMgp58ML/+GeATL9prwuJ6co3CIu3tCD5iwgHv6ezBv5wCCsn2tMcoX2oMlK
         VvdQ==
X-Received: by 10.60.42.230 with SMTP id r6mr4973638oel.9.1438919614077; Thu,
 06 Aug 2015 20:53:34 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 6 Aug 2015 20:53:04 -0700 (PDT)
In-Reply-To: <CAPig+cQftyjKFi0Qkg_ZVEJ9A+zGSAmFtHwQ-8hCnf8xtU_PEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275458>

On Fri, Aug 7, 2015 at 5:49 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Aug 4, 2015 at 8:42 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce a ref_formatting_state which will eventually hold the values
>> of modifier atoms. Implement this within ref-filter.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> +static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *final)
>> +{
>> +       /* More formatting options to be evetually added */
>> +       strbuf_addbuf(final, state->output);
>> +       strbuf_release(state->output);
>
> I guess the idea here is that you intend state->output to be re-used
> and it is convenient to "clear" it here rather than making that the
> responsibility of each caller. For re-use, it is more typical to use
> strbuf_reset() than strbuf_release() (though Junio may disagree[1]).
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/273094
>

it seems like a smarter way to around this without much overhead But it
was more of to release it as its no longer required unless another modifier atom
is encountered. Is it worth keeping hoping for another modifier atom eventually,
and release it at the end like you suggested below?

>> +}
>> +
>>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>>  {
>>         const char *cp, *sp, *ep;
>> -       struct strbuf output = STRBUF_INIT;
>> +       struct strbuf value = STRBUF_INIT;
>> +       struct strbuf final_buf = STRBUF_INIT;
>> +       struct ref_formatting_state state;
>>         int i;
>>
>> +       memset(&state, 0, sizeof(state));
>> +       state.quote_style = quote_style;
>> +       state.output = &value;
>
> It feels strange to assign a local variable reference to state.output,
> and there's no obvious reason why you should need to do so. I would
> have instead expected ref_format_state to be declared as:
>
>     struct ref_formatting_state {
>        int quote_style;
>        struct strbuf output;
>     };
>
> and initialized as so:
>
>     memset(&state, 0, sizeof(state));
>     state.quote_style = quote_style;
>     strbuf_init(&state.output, 0);
>

This looks neater, thanks. It'll go along with the previous patch.

> (In fact, the memset() isn't even necessary here since you're
> initializing all fields explicitly, though perhaps you want the
> memset() because a future patch adds more fields which are not
> initialized explicitly?)
>

Yea the memset is needed for bit fields evnetually added in the future.

> This still allows re-use via strbuf_reset() mentioned above.
>
> And, of course, you'd want to strbuf_release() it at the end of this
> function where you're already releasing final_buf.
>

Addressed this above.

>>         for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>> -               struct atom_value *atomv;
>> +               struct atom_value *atomv = NULL;
>
> What is this change about?
>

To remove the warning about atomv being unassigned before usage.

>>                 ep = strchr(sp, ')');
>> -               if (cp < sp)
>> -                       emit(cp, sp, &output);
>> +               if (cp < sp) {
>> +                       emit(cp, sp, &state);
>> +                       apply_formatting_state(&state, &final_buf);
>> +               }
>>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>> -               print_value(atomv, quote_style, &output);
>> +               process_formatting_state(atomv, &state);
>> +               print_value(atomv, &state);
>> +               apply_formatting_state(&state, &final_buf);
>>         }
>>         if (*cp) {
>>                 sp = cp + strlen(cp);
>> -               emit(cp, sp, &output);
>> +               emit(cp, sp, &state);
>> +               apply_formatting_state(&state, &final_buf);
>
> I'm getting the feeling that these functions
> (process_formatting_state, print_value, emit, apply_formatting_state)
> are becoming misnamed (again) with the latest structural changes (but
> perhaps I haven't read far enough into the series yet?).
>
> process_formatting_state() is rather generic.
>

perhaps set_formatting_state()?

> print_value() and emit() both imply outputting something, but neither
> does so anymore.
>

I think I'll append a "to_state" to each of them.

> apply_formatting_state() seems to be more about finalizing the
> already-formatted output.

perform_state_formatting()? perhaps.

-- 
Regards,
Karthik Nayak
