From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Sun, 11 Oct 2015 18:18:43 +0530
Message-ID: <CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <vpqr3l5zgst.fsf@grenoble-inp.fr> <CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
 <vpq8u7dp9qr.fsf@grenoble-inp.fr> <CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
 <xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com> <vpqpp0ojvs6.fsf@grenoble-inp.fr>
 <xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 14:49:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlG3y-0004nU-Cm
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 14:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbbJKMtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 08:49:14 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35309 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbbJKMtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 08:49:13 -0400
Received: by vkha6 with SMTP id a6so16964927vkh.2
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0T8x8Ek3TV6QWLyC41YLmvqRxvFWlFseiFexh+AT/3I=;
        b=CIv2TgncUlopsddxtIrw3KxJEnumSZQgd7Ktza7b5xpAz0LDcIMwtW+x4xrOI5Ue8a
         3iC/lGOvQxGUf1eDdE4sULTGqxbRdCbHR9ruBdqTuFYyXS+3ijngCNG/OvmWOX4ir3v9
         4xP3b0SlIVos9aCRjxU7f+s/r2nJgAHQVOiqdHaDWit1K9EFzdryNKvciiPWJVG0sWNN
         jluiGlYIUwnmf8Kcc4tUPENyaKtDoIcbn49V+PJGbsJwU3H55k5GqU8bH45CaQGzWBJz
         GMMHOdHuGO5MMh/sZUN63Wz038bK37D15yC58fObK6DbFndabxC+kY2MegHRUVJ17+/c
         NhXA==
X-Received: by 10.31.161.142 with SMTP id k136mr15134899vke.17.1444567752478;
 Sun, 11 Oct 2015 05:49:12 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 11 Oct 2015 05:48:43 -0700 (PDT)
In-Reply-To: <xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279336>

On Fri, Oct 9, 2015 at 11:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Then used_atom[] could become something like
>>>
>>>     struct {
>>>      const char *str; /* e.g. "align:position=left,32" */
>>>      struct {
>>>              const char *part0; /* everything before '=' */
>>>                 const char *part1; /* optional */
>>>      } *modifier;
>>>         int modifier_nr;
>>>     } *used_atom;
>>
>> If the goal is to prepare as much as possible when parsing the format
>> string, I'd even push it one step further and have stg like
>>
>>      struct {
>>       const char *str; /* e.g. "align:position=left,32" */
>>       union {
>>               struct {
>>                       int position;
>>                       enum { left, right, center } kind;
>>               } align;
>>                 struct {
>>                       ....;
>>                 } objectname;
>>         int modifier_nr;
>>      } *used_atom;
>>
>> Just a thought, I'm not sure how useful this would be, and this may be
>> too much change for this series (so it may deserve a separate topic).
>
> Yes, if we are willing to enrich the element of valid_atom[] array
> with a type-specific parsing functions, we could even do that.  Then
> populate_value() would not have to do any parsing and just do the
> filling.
>
> I was shooting for a middle ground, but certainly with an eye
> towards such an endgame state in the future.

I like the idea's here, I was trying out what you suggested before
Matthieu suggestion.

We could have:

static void parse_atom_modifiers(struct used_atom *atom)
{
    const char *sp = NULL;

    atom->modifier = NULL;
    atom->modifier_nr = 0;

    if ((sp = strchr(atom->str, ':'))) {
        while (sp[1]) {
            const char *equal, *comma, *ep;
            int no = atom->modifier_nr;

            atom->modifier_nr++;
            sp++;
            REALLOC_ARRAY(atom->modifier, atom->modifier_nr);

            equal = strchr(sp, '=');
            comma = strchr(sp, ',');

            if (comma)
                ep = comma;
            else
                ep = sp + strlen(sp);

            if (!equal) {
                atom->modifier[no].part0 = xstrndup(sp, ep - sp);
                atom->modifier[no].part1 = NULL;
            } else {
                atom->modifier[no].part0 = xstrndup(sp, equal - sp);
                atom->modifier[no].part1 = xstrndup(equal + 1, ep - equal - 1);
            }
            sp = ep;
        }
    }
}

or something on these lines for what you suggested. We could improve by
having a special parsing function for selected atoms and leave this to
be default.

Also does it make sense to integrate these changes here? Or would you like to
have another series on this?

-- 
Regards,
Karthik Nayak
