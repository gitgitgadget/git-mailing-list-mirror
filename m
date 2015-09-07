From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v16 06/14] ref-filter: implement an `align` atom
Date: Mon, 7 Sep 2015 23:56:54 +0530
Message-ID: <CAOLa=ZS7zjedyq5bA4yhxats3BcdvcDn-uBDeKYbX0cirxd-Kw@mail.gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
 <1441479135-5285-7-git-send-email-Karthik.188@gmail.com> <CAPig+cS28v552BZ63PTKrchYc4M-GYMhhEyfcHXW89vqvYhcOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 20:27:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ18t-0008P3-Ue
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 20:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbbIGS1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 14:27:25 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:32894 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbbIGS1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 14:27:24 -0400
Received: by obbbh8 with SMTP id bh8so66818642obb.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kp4AOsl6gCqmv7JBMMLhw0zRCRrqeB7opH0D033vjIU=;
        b=NK7F91lOGYS4O+RP8Eit62MeE5YSichGHp6ZzOoGPgXVDPHFSGlJD0rVshsKreAu54
         /qFGnsWe9PGKGIC4dfYlPmCwKmAbbJNVAdBAwZY5Ps2QK+iXfd1HoefT4fEpkMv06seu
         ysdj/9O8XAF6EakvOpnxGjyqph0KsQi10rho5oB9TdDFuTO5RRcSp9eg/45KoC1yzuCo
         mXXVo2DsJT+FXlBwL/6OM/8XxoaDkqLHinihH0XAhulBQ1B9V1Usv5p5UrEuKS9kgOoa
         mivjN+3IR9mxWSyasCyjDXEzUenAdbXu2A+4i8Upu9FfzEnZGSF4i7Mf3caE1B/i31DN
         WvGw==
X-Received: by 10.182.171.35 with SMTP id ar3mr15423534obc.57.1441650443446;
 Mon, 07 Sep 2015 11:27:23 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 7 Sep 2015 11:26:54 -0700 (PDT)
In-Reply-To: <CAPig+cS28v552BZ63PTKrchYc4M-GYMhhEyfcHXW89vqvYhcOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277473>

On Mon, Sep 7, 2015 at 1:40 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Sep 5, 2015 at 2:52 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Implement an `align` atom which left-, middle-, or right-aligns the
>> content between %(align:...) and %(end).
>>
>> It is followed by `:<width>,<position>`, where the `<position>` is
>> either left, right or middle and `<width>` is the size of the area
>> into which the content will be placed. If the content between
>> %(align:...) and %(end) is more than the width then no alignment is
>> performed. e.g. to align a refname atom to the middle with a total
>> width of 40 we can do: --format="%(align:middle,40)%(refname)%(end)".
>>
>> We introduce an `at_end` function for each element of the stack which
>> is to be called when the `end` atom is encountered. Using this we
>> implement end_align_handler() for the `align` atom, this aligns the
>> final strbuf by calling `strbuf_utf8_align()` from utf8.c.
>>
>> Ensure that quote formatting is performed on the whole of
>> %(align:...)...%(end) rather than individual atoms inside. We skip
>> quote formatting for individual atoms when the current stack element
>> is handling an %(align:...) atom and perform quote formatting at the
>> end when we encounter the %(end) atom of the second element of then
>> stack.
>>
>> Add documentation and tests for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index e49d578..b23412d 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -127,6 +127,16 @@ color::
>> +align::
>> +       Left-, middle-, or right-align the content between %(align:...)
>> +       and %(end). Followed by `:<width>,<position>`, where the
>> +       `<position>` is either left, right or middle and `<width>` is
>> +       the total length of the content with alignment. If the
>
> This should mention that <position> is optional and default to "left"
> if omitted.
>

Will add that.

>> +       contents length is more than the width then no alignment is
>> +       performed. If used with '--quote' everything in between
>> +       %(align:...) and %(end) is quoted, but if nested then only the
>> +       topmost level performs quoting.
>> diff --git a/ref-filter.c b/ref-filter.c
>> index e99c342..6c9ef08 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -773,6 +837,50 @@ static void populate_value(struct ref_array_item *ref)
>>                         else
>>                                 v->s = " ";
>>                         continue;
>> +               } else if (match_atom_name(name, "align", &valp)) {
>> +                       struct align *align = &v->u.align;
>> +                       struct strbuf **s;
>> +
>> +                       if (!valp)
>> +                               die(_("expected format: %%(align:<width>, <position>)"));
>
> I'm pretty sure this parsing code won't deal well with a space after
> the comma, so the space should be dropped from the diagnostic message
> advising the user of the correct format: s/, /,/
>

Will change.

>> +                       /*
>> +                        * TODO: Implement a function similar to strbuf_split_str()
>> +                        * which would strip the terminator at the end.
>
> "...which would omit the separator from the end of each value."
>

Will change.

>> +                        */
>> +                       s = strbuf_split_str(valp, ',', 0);
>> +
>> +                       /* If the position is given trim the ',' from the first strbuf */
>> +                       if (s[1])
>> +                               strbuf_setlen(s[0], s[0]->len - 1);
>> +                       if (s[2])
>> +                               die(_("align:<width>,<position> followed by garbage: %s"), s[2]->buf);
>
> If <position> is omitted, strbuf_split_str("42", ...) will return the
> array ["42", NULL] which won't have an element [2], which means this
> code will access beyond end-of-array. (This is another good argument
> for looping over s[] as Junio suggested rather than assuming these
> fixed yet optional positions. It can be hard to get it right.)

You're right, probably something on the lines of what Junio suggested here
http://article.gmane.org/gmane.comp.version-control.git/277041


-- 
Regards,
Karthik Nayak
