From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/15] ref-filter: use parsing functions
Date: Fri, 8 Jan 2016 01:50:00 +0530
Message-ID: <CAOLa=ZSoAdSet5LL9fxJA-xj6Z_giuVL3+x_N7qTs_yFujrhWA@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <CAPig+cRjXHmBnnmHbbibeV-gcvwMFQc7-5ce4s2OHu+wQwMy4Q@mail.gmail.com>
 <CAOLa=ZSi0c61G8oXsCC0UfprDhf3hESaqKw8eGNRZJ7MTvNY4g@mail.gmail.com> <xmqqvb7544de.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 21:20:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHH2x-0004Xu-EE
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 21:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbcAGUUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 15:20:31 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33738 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbcAGUUa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 15:20:30 -0500
Received: by mail-vk0-f53.google.com with SMTP id i129so42445698vkb.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 12:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=imavu3P3GecBhprCrR4z2EE8nxYGBo30DGyjNQRLp3o=;
        b=qbRcBtDfnz+RkAmmbk8fEgfhaKoloJcTkG4uRB8jFeytwpZBxYiJsghK+/hUq6V6V4
         9cArwfTheW0MQ9wVgM5IZaORe7MfjeJF4VY0Q8bK4ttupCdUIQj25iV5EsETqfx6miBv
         bx0mgeaqxhUZ/7ISMLAu+3ecGzsgRM/kSVt2AX6DAcMax0dmWPp7Ivr2JKykJeQMlGAF
         UUlb3y9nVLffxty44vawrq6hcBGhGkP1nJqCfy/hj/jjO577xCWMyLc5KQYEKIAUoVMd
         jGnn+rGOlfG7fejrVQe91DGsF5snkvLgBKplHap9UAfqM4wmrcuECV3bLl63MEq7gmEv
         Kb8g==
X-Received: by 10.31.155.23 with SMTP id d23mr67140915vke.146.1452198029414;
 Thu, 07 Jan 2016 12:20:29 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Thu, 7 Jan 2016 12:20:00 -0800 (PST)
In-Reply-To: <xmqqvb7544de.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283503>

On Fri, Jan 8, 2016 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> I don't understand the difficulty. It should be easy to manually skip
>>> the 'deref' for this one particular case:
>>>
>>>     const char *name = atom->name;
>>>     if (*name == '*')
>>>         name++;
>>>
>>> Which would allow this unnecessarily complicated code from patch 14/15:
>>>
>>>     if (match_atom_name(atom->name, "subject", &buf) && !buf) {
>>>         ...
>>>         return;
>>>     } else if (match_atom_name(atom->name, "body", &buf) && !buf) {
>>>         ...
>>>         return;
>>>     } if (!match_atom_name(atom->name, "contents", &buf))
>>>         die("BUG: parsing non-'contents'");
>>>
>>> to be simplified to the more easily understood form suggested during
>>> review[1] of v2:
>>>
>>>     if (!strcmp(name, "subject")) {
>>>         ...
>>>         return;
>>>     } else if (!strcmp(name, "body")) {
>>>         ...
>>>         return;
>>>     } else if (!match_atom_name(name,"contents", &buf))
>>>         die("BUG: expected 'contents' or 'contents:'");
>>>
>>> You could also just use (!strcmp("body") || !strcmp("*body")) rather
>>> than skipping "*" manually, but the repetition makes that a bit
>>> noisier and uglier.
>>>
>>> [1]: http://article.gmane.org/gmane.comp.version-control.git/282645
>>
>> Definitely not a difficulty per se. Just that it seems like something
>> match_atom_name()
>> seems to be fit for. As the function name suggests that we're matching
>> the atom name
>> and the check for '!buf' indicates that no options are to be included
>> for that particular atom.
>>
>> Also after Junio's suggestion[1], I think It looks better now[2]. But
>> either ways, I'm not
>> strongly against what you're saying, so my opinion on this matter is
>> quite flexible.
>>
>> [1]: http://article.gmane.org/gmane.comp.version-control.git/283404
>> [2]: http://article.gmane.org/gmane.comp.version-control.git/283449
>
> Sorry, but I suspect I was looking at a leaf function without
> thinking about the larger picture.
>
> I suspect that the interface to customized parsing function called
> by parse_ref_filter_atom() is misdesigned.  I understand that the
> overall parsing that starts at verify_ref_format() goes like this:
>
>  * Iterate over the string and find a matching "%(",")" pair.
>
>    - For each such pair found, use parse_ref_filter_atom() on
>      what is inside that matching pair.
>
>      - parse_ref_filter_atom() iterates over the table of known
>        atoms, and finds the entry in that table.
>
>        Note that at this point, it knows that "%(" is followed by
>        'contents' or 'contents:' when it picked the "contents" atom
>        from the table, for example.
>
>      - if the entry we found in that table for the atom being parsed
>        has a custom parse function, that function is called, but the
>        calling convention does not pass the fact that we already
>        know what we are seeing inside "%(",")" pair is 'contents',
>        for example, and we know what argument it is given if any.
>

Absolutely correct.

> So it appears to me that match_atom_name() is a misguided helper
> function that you shouldn't have to use too often.  If the signature
> of parse() functions is changed to take not just the atom but the
> pointer to its argument (could be NULL, if we are seeing
> "%(contents)", for example) that is already available as "formatp"
> in the function, then contents_atom_parser() could become more like:
>

I see, I think this does make sense, since we have extracted any arguments
following ':' already in parse_ref_filter_atom() it only makes sense to use it
without doing the same type of work again.

> contents_atom_parser(struct used_atom *atom, const char *arg)
> {
>         if (args)
>                 atom->u.contents.option = C_BARE;
>         else if (!strcmp(arg, "body"))
>                 atom->u.contents.option = C_BODY;
>         ...
> }
>
> and there is no reason for this caller to even look at atom->name or
> worry about that it might have the dereferencing asterisk in front.
>

This looks good.

> If we really want to avoid having separate subject_atom_parser() and
> body_atom_parser(), they can be folded into the same function and it
> becomes necessary to switch on atom->name like you did in the code
> being discussed in the quoted part above.  For that, as Eric said,
> skipping '*' manually would not be a big deal, as that should not
> happen so often in the code _anyway_.  It is not a good idea to
> switch on atom->name inside contents_atom_parser() like you did.
> You are better off having separate {subject,body}_atom_parser()
> functions.
>
> For one thing, you are not reusing or sharing any code by squishing
> these three functions into one.  A conceptually larger problem is
> that you are adding two extra !strcmp() calls to figure out the
> caller _already_ knows (notice I said this is "conceptual", this is
> not about performance).  parse_ref_filter_atom() knows that it is a
> "%(subject)" or "%(subject:...)" atom, but because you throw away
> that information and call contents_atom_parser() by saying that it
> is one of the contents, subject or body, the called function has to
> redo strcmp in order to figure it out itself.

I understand what you're saying and keeping these functions separate
seems like the way to go. Also this might also remove all uses of
match_atom_name() from ref-filter.c. This Idea seems good to me,
thanks for your suggestions, I will work on it.

-- 
Regards,
Karthik Nayak
