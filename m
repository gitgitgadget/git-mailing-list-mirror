From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/15] ref-filter: use parsing functions
Date: Sat, 9 Jan 2016 14:30:22 +0530
Message-ID: <CAOLa=ZQzSgNftM_gTKAo9SmZVm0DrXTRoaZHAniEh+qvB0syoQ@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <CAPig+cRjXHmBnnmHbbibeV-gcvwMFQc7-5ce4s2OHu+wQwMy4Q@mail.gmail.com>
 <CAOLa=ZSi0c61G8oXsCC0UfprDhf3hESaqKw8eGNRZJ7MTvNY4g@mail.gmail.com>
 <xmqqvb7544de.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSzPeqsObgno8q0hpbAGUgZgFJ5x8Oj7YtA7_uPLvG0Pw@mail.gmail.com>
 <xmqqd1td3wqk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 10:01:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHpOP-0007qk-Uz
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 10:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbcAIJAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 04:00:54 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35502 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbcAIJAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 04:00:53 -0500
Received: by mail-vk0-f65.google.com with SMTP id i129so3625872vkb.2
        for <git@vger.kernel.org>; Sat, 09 Jan 2016 01:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cFGvfvwAcK+BvOF2xay3t2ff4BXsbYCn/iBTq/zLnr4=;
        b=sG5Q/IoWcklXj8F5IjmZhrp7thnRJsJ48PiZGVRflEf+GDvJb3cZfcc19Laa68SKZx
         UYWXArHowp9gOJwlavakOhy44kAfqyft2Vz1fkengZHBxlAECCAZAHGJ3kDNzzaKFsNe
         DhhunennSbJA+6S02WRGsS2l04daktQ9sYE4rmHaQFWJMOSHzDDZnOZKOxUFcixPpyQa
         3URCqg/smV9goNpBRGc97lGCOvBAmd5B1xLPlLJFAqedPTdJlvwoAmKjAlKqPIZVL7Zb
         ZjbxNRomXWknO51lQ/XQwf0mP42Aag0TQOsA6WfO/YwB1k3UT9rI7hfwRZq/NWYYidbF
         tu6w==
X-Received: by 10.31.155.23 with SMTP id d23mr72093735vke.146.1452330052371;
 Sat, 09 Jan 2016 01:00:52 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Sat, 9 Jan 2016 01:00:22 -0800 (PST)
In-Reply-To: <xmqqd1td3wqk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283599>

On Fri, Jan 8, 2016 at 2:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> So we something like this for the parsing function:
>>
>>  int parse_ref_filter_atom(const char *atom, const char *ep)
>>  {
>>         const char *sp;
>> +       char *arg;
>
> I think this and the new parameter to .parser() function should be
> "const char *".
>

Yes. Will do that.

>> @@ -141,6 +143,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>                 const char *formatp = strchr(sp, ':');
>>                 if (!formatp || ep < formatp)
>>                         formatp = ep;
>> +               arg = (char *)formatp;
>>                 if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
>>                         break;
>
> And this part can just use arg without formatp.  The original is a
> bit sloppy and will keep looking for a colon past ep, but we already
> know between sp and ep there is no NUL, so we could do this:
>
>                 arg = memchr(sp, ':', ep - sp);
>                 if ((!arg || len == arg - sp) &&
>                     !memcmp(valid_atom[i].name, sp, len))
>                         break;
>

This even removes the need for formatp. Thanks

>> @@ -154,6 +157,13 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>         REALLOC_ARRAY(used_atom, used_atom_cnt);
>>         used_atom[at].name = xmemdupz(atom, ep - atom);
>>         used_atom[at].type = valid_atom[i].cmp_type;
>> +       if (arg != ep)
>> +               arg = xstrndup(arg + 1, ep - arg - 1);
>> +       else
>> +               arg = NULL;
>
> Why even copy?  The original that used match_atom_name() borrowed
> part of existing string via (const char **val), so you know whatever
> used that &buf you grabbed out of match_atom_name() should only be
> reading the values not writing into the memory, no?
>

I totally missed that we could use the existing used_atom[at].name
to get the argument. Thanks

> That is why I think arg should be "const char *".
>
> As the above memchr() alrady took care of "we didn't find a colon"
> case, we only need to do this here, I think:
>
>         if (arg)
>                 arg = used_atom[at].name + (arg - atom);
>
> and without later free().
>
          if (arg)
                  arg = used_atom[at].name + (arg - atom) + 1;

'+ 1' to skip over the colon perhaps?

> Alternatively, we could add an int field to elements of used_atom[]
> array that says what byte-offset in the used_atom[].name the atom
> arguments start (if any).  Then .parser() does not have to take the
> parameter separately [*1*].
>
> [Footnote]
>
> *1* Thinking about it more, perhaps used_atom[].type should be
> removed and instead used_atom[].atom should be a pointer into the
> valid_atom[] array.  Then any reference to used_atom[].type will
> become used_atom[].atom->cmp_type, which is much nicer for two
> reasons: (1) one less useless copy (2) one less field that has a
> name "type" that is overly generic.
>
> That does not remove the need for recording where the atom argument
> is, though, in used_atom[].  We could add a bit "has_deref" to
> used_atom[] and then do something like this:
>
>     arg = used_atom[i].name + used_atom[i].atom->namelen +
>           used_atom[i].has_deref;
>
> but I do not think we want to go there.  It would hardcode the
> knowledge that used_atom[i].name is either used_atom[i].atom->name
> or one asterisk prefixed to it, making future extension of the
> syntax even harder.

Makes sense, to sum it up, we'll provide arguments to the parser function:

        void (*parser)(struct used_atom *atom, const char *arg);

So that we provide the arguments to the functions and ensure no need of parsing
atom->name.

Also ensure that we have separate parser functions for 'body',
'subject' and 'contents'.

-- 
Regards,
Karthik Nayak
