From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 06/11] ref-filter: introduce color_atom_parser()
Date: Sat, 19 Dec 2015 11:30:21 +0530
Message-ID: <CAOLa=ZTRJFrOFbYbqMOsicinJmzrMhi0NB3ySf1=-DTWY6sc+w@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
 <1450279802-29414-7-git-send-email-Karthik.188@gmail.com> <CAPig+cTNEXA75Gh_jXrdhLOJpXYgyZ97TJCPHXz4DodOcjWheA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 07:01:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAAZk-0006VC-UG
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 07:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbbLSGAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 01:00:52 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32783 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbbLSGAv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 01:00:51 -0500
Received: by mail-vk0-f51.google.com with SMTP id a188so77661112vkc.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 22:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MHkx5K+6xdsAIxKmkrkdyhJcJCeopfb4PLK909Z0gRA=;
        b=xvZmUJREm0hG+SqMOqfotQZL+hNVffBbIvI9AY27n6haLYCwG3yU3aBYtNBFBrM6J6
         bVayVM+Jv+b03inRPQhwsk6gIdmpd1Qg41SDG55yKPXPCm5hZHuIoGQdvJBIxUdtu5Ne
         W3D4OYpqubQGFNACvgFjEFn0xMqSzEo2bpI/9abqf7DF5ro9STxGLAoBd5nA2/LUhexU
         6zippGDo/nm+1IB3mvyGAxQ3Y86lAqO1LpxfQnN0epUe/ymab3QH6sDOey15pwTC5BV4
         56R6HABx83juzeL/TWPWnvbn5dy8jZEw2A45pfTuUA9tCkOhR2DxZvZlqnvEbRpVAyak
         d16w==
X-Received: by 10.31.155.23 with SMTP id d23mr4268164vke.146.1450504850693;
 Fri, 18 Dec 2015 22:00:50 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Fri, 18 Dec 2015 22:00:21 -0800 (PST)
In-Reply-To: <CAPig+cTNEXA75Gh_jXrdhLOJpXYgyZ97TJCPHXz4DodOcjWheA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282737>

On Thu, Dec 17, 2015 at 2:51 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce color_atom_parser() which will parse a "color" atom and
>> store its color in the "use_atom" structure for further usage in
>
> Same comment as last time: s/use_atom/used_atom/
>

Will change.

>> 'populate_value()'.
>
> s/'//g
>

Will do.

> More below...
>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -29,6 +29,9 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>  static struct used_atom {
>>         const char *str;
>>         cmp_type type;
>> +       union {
>> +               const char *color;
>> +       } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>>  static int need_color_reset_at_eol;
>> @@ -53,6 +56,13 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
>> +static void color_atom_parser(struct used_atom *atom)
>> +{
>> +       match_atom_name(atom->str, "color", &atom->u.color);
>> +       if (!atom->u.color)
>> +               die(_("expected format: %%(color:<color>)"));
>> +}
>> +
>> @@ -833,12 +846,10 @@ static void populate_value(struct ref_array_item *ref)
>>                         refname = branch_get_push(branch, NULL);
>>                         if (!refname)
>>                                 continue;
>> -               } else if (match_atom_name(name, "color", &valp)) {
>> +               } else if (starts_with(name, "color:")) {
>>                         char color[COLOR_MAXLEN] = "";
>>
>> -                       if (!valp)
>> -                               die(_("expected format: %%(color:<color>)"));
>> -                       if (color_parse(valp, color) < 0)
>> +                       if (color_parse(atom->u.color, color) < 0)
>
> It would make a lot more sense to invoke color_parse() with the
> unchanging argument to "color:" just once in color_atom_parser()
> rather than doing it here repeatedly. (Also, you'd drop 'const' from
> used_atom.u.color declaration.)
>

This makes sense, I'll put have color_parse() in color_atom_parser().
This would also require us to allocate memory once in color_atom_parser.

>
> Does v->s get freed each time through the loop? If not, then, assuming
> you parse the color just once in color_atom_parser(), then you could
> just assign the parsed color directly to v->s rather than duplicating
> it.

No it doesn't. Yup will do.

-- 
Regards,
Karthik Nayak
