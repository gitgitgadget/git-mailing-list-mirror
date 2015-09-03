From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Thu, 3 Sep 2015 21:33:36 +0530
Message-ID: <CAOLa=ZS05Ysvfz9gf59wkdAqiSGcwVd25CvRV-DFFj9qPf_PyA@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-8-git-send-email-Karthik.188@gmail.com> <CAPig+cRJG7t1M-FyrB84UG4Ar_NBW3J+wFvFeLg599sAEAweHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:04:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXWzn-0007ld-F9
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933548AbbICQEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:04:09 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34932 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390AbbICQEG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:04:06 -0400
Received: by obuk4 with SMTP id k4so36403867obu.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=krxb4BPIOw2AUf/eL8eokxmLIm8KVDIfvws3/FNWHuE=;
        b=hZOaZFZZrwXRoLnz0FrbWdbEOXx+0z4JrMCLqCC8fLP9aNndC8u1PudHiuZbBjjFl9
         n8haiSo0Yk9J45TIXeV4ZUPwLyAJTCQaFIkb9bPaJ5a3f8kjTFmljsN0WJGONcUgKj61
         dR18zkJnAq5r0LeMwS67IEJ4TfEjBzs92F/2KuTaCrQbHbGDVb/7NOAReTgHcJuplvM+
         lAxNW9eDGoO7gajKVvT8UnCwUX2TgMhZzWcMkOW4V6YxVwva/RBZG5vqv2nkKLj17crO
         iC9JrWaO8neiFM8cphAxeQlhgmwrmqnhnk441d0pAxRl1Z2xbsGRBGuKDVzlGX3/Y6fW
         MRiA==
X-Received: by 10.182.171.35 with SMTP id ar3mr25817310obc.57.1441296245334;
 Thu, 03 Sep 2015 09:04:05 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 3 Sep 2015 09:03:36 -0700 (PDT)
In-Reply-To: <CAPig+cRJG7t1M-FyrB84UG4Ar_NBW3J+wFvFeLg599sAEAweHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277217>

On Thu, Sep 3, 2015 at 8:09 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Sep 1, 2015 at 2:26 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> In 'tag.c' we can print N lines from the annotation of the tag using
>> the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
>> modify it to support appending of N lines from the annotation of tags
>> to the given strbuf.
>>
>> Implement %(contents:lines=X) where X lines of the given object are
>> obtained.
>>
>> Add documentation and test for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  struct atom_value {
>>         const char *s;
>> -       struct align align;
>> +       union {
>> +               struct align align;
>> +               struct contents contents;
>> +       } u;
>>         void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
>>         unsigned long ul; /* used for sorting when not FIELD_STR */
>>  };
>> @@ -226,7 +235,7 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
>>         push_stack_element(&state->stack);
>>         new = state->stack;
>>         new->at_end = align_handler;
>> -       new->cb_data = &atomv->align;
>> +       new->cb_data = &atomv->u.align;
>
> You could declare atom_value with the union from the start, even if it
> has only a single member ('align', at first). Doing so would make this
> patch less noisy and wouldn't distract the reader with these seemingly
> unrelated changes.
>

Will do.

>>  }
>>
>>  static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
>> @@ -624,6 +633,33 @@ static void find_subpos(const char *buf, unsigned long sz,
>>         *nonsiglen = *sig - buf;
>>  }
>>
>> +/*
>> + * If 'lines' is greater than 0, append that many lines from the given
>> + * 'buf' of length 'size' to the given strbuf.
>> + */
>> +static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
>> +{
>> +       int i;
>> +       const char *sp, *eol;
>> +       size_t len;
>> +
>> +       if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
>> +               size += 2;
>
> Aside from the +2 which Matthieu already questioned, this code has a
> much more serious problem. strstr() assumes that 'buf' is
> NUL-terminated, however, the fact that buf's size is also being passed
> to the function, implies that it may not be NUL-terminated.
> Consequently, strstr() could zip well past the end of 'buf', trying to
> consult memory not part of 'buf', which is a violation of the C
> standard. Even with the band-aid (sp <= buf + size) which tries to
> detect this situation, it's still a violation, and could crash if
> strstr() attempts to consult memory which hasn't even been allocated
> to the process or is otherwise protected in some fashion.
>
> It's possible that 'buf' may actually always be NUL-terminated, but
> this code does not convey that fact. If it is known to be
> NUL-terminated, then it is safe to use strstr(), however, that should
> be shown more clearly either by revising the code or adding an
> appropriate comment.
>

Although it is NUL terminated, you do have a point, I hope you checked out
Matthieu's suggestion of removing that snippet of code and calculating size
in the function call itself.

>> +       sp = buf;
>> +
>> +       for (i = 0; i < lines && sp < buf + size; i++) {
>> +               if (i)
>> +                       strbuf_addstr(out, "\n    ");
>> +               eol = memchr(sp, '\n', size - (sp - buf));
>> +               len = eol ? eol - sp : size - (sp - buf);
>> +               strbuf_add(out, sp, len);
>> +               if (!eol)
>> +                       break;
>> +               sp = eol + 1;
>> +       }
>> +}
>> @@ -663,6 +701,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>>                         v->s = xmemdupz(sigpos, siglen);
>>                 else if (!strcmp(name, "contents"))
>>                         v->s = xstrdup(subpos);
>> +               else if (skip_prefix(name, "contents:lines=", &valp)) {
>> +                       struct strbuf s = STRBUF_INIT;
>> +                       if (strtoul_ui(valp, 10, &v->u.contents.lines))
>> +                               die(_("positive width expected contents:lines=%s"), valp);
>
> This error message is still too tightly coupled to %(align:), from
> which it was copied. "width"?
>

Will change it, thanks.

-- 
Regards,
Karthik Nayak
