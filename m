From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Sat, 25 Jul 2015 09:44:19 +0530
Message-ID: <CAOLa=ZRBwErMLhcg=STymECrfGG3WQpfFvPXzDCcjBTQb9JmCA@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-2-git-send-email-Karthik.188@gmail.com> <xmqqwpxpjk6p.fsf@gitster.dls.corp.google.com>
 <xmqqpp3hjh3r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 06:15:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIqs6-00077e-Bf
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jul 2015 06:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbbGYEOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2015 00:14:49 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34387 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbbGYEOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2015 00:14:49 -0400
Received: by obre1 with SMTP id e1so27733933obr.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 21:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HWBhlxEz/wfyGqccaOe5j/9zms78MLs8DoUSiudxsao=;
        b=IU6EvBV+ZDO/oFGi9VvrCmMYTicGYEBS130FEpOtSgCUMh5wwU1/gHPzegIIX/LUaG
         XWhboInubwLHqwjQZlhEJXGhnjgAR3hBKuEQvAMGmODfX94GtFt/LLCE866HgG0nz3HM
         WT/wHFZStLLSBz5c3xNtgaSmOzClQWaRMZ2gbYdOjcVW9w8p9oQeotlyxVMZLyBjR8nf
         bBB8dIk7rznEC9ztktPJGBP0GMPdtwIW8Sql2DlnMR2XuR/Xji/mZL8k4ikSFlkJycLl
         6bNJjvZEhaKm0kxRYtM0NsrLLANi98vwKIOApjaDh69x7sNE0TLTmTqBnXmpAXWtmhO1
         c1Og==
X-Received: by 10.60.42.230 with SMTP id r6mr19005405oel.9.1437797688314; Fri,
 24 Jul 2015 21:14:48 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 24 Jul 2015 21:14:19 -0700 (PDT)
In-Reply-To: <xmqqpp3hjh3r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274610>

On Sat, Jul 25, 2015 at 4:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> -    if (!ref->value) {
>>> -            populate_value(ref);
>>> +    /*
>>> +     * If the atom is a pseudo_atom then we re-populate the value
>>> +     * into the ref_formatting_state stucture.
>>> +     */
>>> +    if (!ref->value || ref->value[atom].pseudo_atom) {
>>> +            populate_value(state, ref);
>>>              fill_missing_values(ref->value);
>>
> I am not sure why you need to do this.  populate_value() and
> fill_missing_values() are fairly heavy-weight operations that are
> expected to grab everything necessary from scratch, and that is why
> we ensure that we do not call them more than once for each "ref"
> with by guarding the calls with "if (!ref->value)".
>
> This change is breaking that basic arrangement, and worse yet, it
> forces us re-read everything about that ref, leaking old ref->value.
>
> Why could this be a good idea?
>

This was required as populate_value() would fill the 'state'  but the 'state'
being a static variable would be lost before printing and hence we would
not have the correct values of the 'state' when printing.

> I think populate_value() should not take state; that is the root
> cause of this mistake.

Yes! agreed. atomv should be a better candidate to hold the formatting values.

>
> The flow should be:
>
>     - verify_format() looks at the format string and enumerates all
>       atoms that will ever be used in the output by calling
>       parse_atom() and letting it to fill used_atom[];
>
>     - when ref->value is not yet populated, populate_value() is
>       called, just once.  This uses the enumeration in used_atom[]
>       and stores computed value to refs->value[atom];
>
>     - show_ref() repeatedly calls find_next() to find the next
>       reference to %(...), emits everything before it, and then
>       uses the atom value (i.e. ref->value[atom]).
>
> I would expect that the atom value for pseudos like color and align
> to be parsed and stored in ref->value in populate_value() when it is
> called for the first time for each ref _just once_.
>
> "color:blue" may choose to store "blue" as v->s, and "align:4" may
> choose to do "v->ul = 4".
>
> And the code that uses these values should look more like:
>
>         for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>                 struct atom_value *atomv;
>
>                 ep = strchr(sp, ')');
>                 if (cp < sp)
>                         emit(cp, sp);
>                 get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>                 if (atomv->is_pseudo)
>                         apply_pseudo_state(&state, atomv);
>                 else
>                         print_value(&state, atomv);
>         }
>
> where apply_pseudo_state() would switch on what kind of pseudo the
> atom is and update the state accordingly, i.e. the "state" munging
> code you added to populate_value() in this patch.

This makes more sense, and avoids the repetitive call to populate_value().
Will implement this.
Thanks

-- 
Regards,
Karthik Nayak
