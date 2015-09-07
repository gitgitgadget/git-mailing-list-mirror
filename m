From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Mon, 7 Sep 2015 19:26:01 +0530
Message-ID: <CAOLa=ZQFZRKY_hHEVQQ6CuYC9XNWHJFYg1CFZCGUr-68phDMHQ@mail.gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com> <xmqqh9n6agcf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 15:56:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYwuR-0004ii-1F
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 15:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbbIGN4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 09:56:32 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35414 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbbIGN4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 09:56:31 -0400
Received: by obuk4 with SMTP id k4so62740278obu.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e+BnV/KZwZx/Wn+VCAxtBt4a1bnd4rK8FivOBsEfEIk=;
        b=qDh4HIJriQ9Uj+WxSXDiOl46LfBSy1vnWS1CuH7bL0Mcpe6O/wDg18bppcXc/HVhTv
         lCZDxvYVKr9awmCMOrWXHcL6jv7IccNMCeX3OoyozsIB2ss/dKge00zaqPoFMX+5lCPq
         6c227DMyX2Rm6KwEhwTt7H9+79+vYfXG56xYGHyzt1tec+a34tTF1S6H0LeOaTfczgGk
         7j8dg2Xvp7YETHorEFXIbeI8X4LnTN+s9ZrBsJ/SqVTE82jCRDt7+gtG2SefEnTD9NRW
         ieWv+ftTfs1JBs1OWZ6TxOMWvncc++lX5U5OsyF/kVCqnlt9xSWnpHHGJLptGq8n39AO
         8uHQ==
X-Received: by 10.182.171.35 with SMTP id ar3mr14461873obc.57.1441634190581;
 Mon, 07 Sep 2015 06:56:30 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 7 Sep 2015 06:56:01 -0700 (PDT)
In-Reply-To: <xmqqh9n6agcf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277463>

On Mon, Sep 7, 2015 at 12:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index d039f40..c5154bb 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -128,13 +128,14 @@ color::
>>       are described in `color.branch.*`.
>>
>>  align::
>> -     Left-, middle-, or right-align the content between %(align:..)
>> +     Left-, middle-, or right-align the content between %(align:...)
>>       and %(end). Followed by `:<width>,<position>`, where the
>>       `<position>` is either left, right or middle and `<width>` is
>>       the total length of the content with alignment. If the
>>       contents length is more than the width then no alignment is
>>       performed. If used with '--quote' everything in between
>> -     %(align:..)  and %(end) is quoted.
>> +     %(align:...) and %(end) is quoted, but if nested then only the
>> +     topmost level performs quoting.
>
> I am not sure if the description of quote belongs to "align".  Isn't
> the general rule at the endgame when there are more opening things
> that would buffer its effect up to the corresponding %(end):
>
>  - Some atoms like %(align) and %(if) always require a matching
>    %(end).  We call them "opening atoms" and sometimes denote them
>    as %($open).
>
>  - When a scripting language specific quoting is in effect, except
>    for opening atoms, replacement from every %(atom) is quoted when
>    and only when it appears at the top-level (that is, when it
>    appears outside %($open)...%(end)).
>
>  - When a scripting language specific quoting is in effect,
>    everything between a top-level opening atom and its matching
>    %(end) is evaluated according to the semantics of the opening
>    atom and its result is quoted.
>
> To put the third item above in a different way, a matching
> %($open)...  %(end) pair behaves as if it is a single normal atom,
> from the point of view of the quoting rule.  All top-level atoms are
> invidivually quoted, whether they are normal atoms or open/end pairs.
> And that rule is not limited to %(align).
>
> I am flexible with the terminology, but the point is that I think
> the quoting rules are better be specified _outside_ the description
> of a particular atom, but as a general rule.
>

I definitely agree, but like Matthieu said, corrently we have only
one such atom and it makes sense to note this behaviour under that.
When we get %(if) to work we could move this over to a more general
section?

>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index 9fa1400..f55dfda 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -43,8 +43,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
>>
>>       if (!format) {
>>               if (filter->lines)
>> -                     format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
>> -                                                filter->lines);
>> +                     format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) "
>> +                                                "%%(contents:lines=%d)", filter->lines);
>
> This line still looks overlong.  Would it help to stop spelling this
> as a double "a = b = overlong expression" assignment?
>

I'm not sure, I get what you mean.

>>       /*
>>        * Perform quote formatting when the stack element is that of
>> -      * a modifier atom and right above the first stack element.
>> +      * a supporting atom. If nested then perform quote formatting
>> +      * only on the topmost supporting atom.
>>        */
>>       if (!state->stack->prev->prev) {
>>               quote_formatting(&s, current->output.buf, state->quote_style);
>> @@ -261,6 +262,22 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
>>       pop_stack_element(&state->stack);
>>  }
>>
>> +static int match_atom_name(const char *name, const char *atom_name, const char **val)
>> +{
>> +     const char *body;
>> +
>> +     if (!skip_prefix(name, atom_name, &body))
>> +             return 0; /* doesn't even begin with "atom_name" */
>> +     if (!body[0] || !body[1]) {
>> +             *val = NULL; /* %(atom_name) and no customization */
>> +             return 1;
>> +     }
>
> This if condition is puzzling.  !body[0] would mean the name was
> exactly atom_name, which is what you want to catch.
>
> But the other part does not make any sense to me.  what does
> (body[0] != '\0' && !body[1]) mean?  atom_name asked for was "align"
> and name was "aligna"?  That is not "%(align) and no customization".
>

The idea was to ensure that the atom doesn't end at the ':'.

>> +     if (body[0] != ':')
>> +             return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
>
> This one makes sense to me.
>
>> +     *val = body + 1; /* "atomname:val" */
>
> Spell that "atom_name:val" perhaps?

Yeah will do.

-- 
Regards,
Karthik Nayak
