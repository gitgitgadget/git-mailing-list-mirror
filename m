From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 08/15] ref-filter: introduce color_atom_parser()
Date: Wed, 6 Jan 2016 13:22:07 +0530
Message-ID: <CAOLa=ZTqtR4Nn+pRtN0HmDF6exYiq-B8g=zVvcu_8=AqFz9zug@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-9-git-send-email-Karthik.188@gmail.com> <xmqqwprniwfq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 08:52:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGite-0006JY-C1
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 08:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbcAFHwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 02:52:39 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34163 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbcAFHwi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 02:52:38 -0500
Received: by mail-vk0-f68.google.com with SMTP id a123so1079281vkh.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 23:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jy/95EGKwZNeaXJOEahB/+19P/tkmt3DFZaSE6BpQUE=;
        b=xJ+O5oeCisNKOh4rox+8eg6Bq5oivqpFkGXCO6iVCyIx9RhhDeWhMHqoV5Mcr5K+yg
         uHqBuR0/mHIj5xNg+BB5IUkbSD4xoqsx1PJCrL4jcvgMJOZSshT/54L9JP2pPCUHSPnD
         VQVrDblGGi+Pd/SL0SD/eUDOvIVS+PnDhSN/mVBPbNrOahToM3EZzSnJg60ihfNPqAXw
         LGcp8c1rsArfAewvKNclLKzMlzkKQ4Q8ELWO5bQxpFss/SwOSP2QknBLdP4LQkom6Lkt
         usTb9Itb3a1P4FRlwR+B7NqFCsXUTgLepTy6T31pG5zE7dQPBb0h2W+JziUIZyEhsuPm
         qxfg==
X-Received: by 10.31.157.144 with SMTP id g138mr70883574vke.71.1452066757173;
 Tue, 05 Jan 2016 23:52:37 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Tue, 5 Jan 2016 23:52:07 -0800 (PST)
In-Reply-To: <xmqqwprniwfq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283419>

On Wed, Jan 6, 2016 at 2:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Introduce color_atom_parser() which will parse a "color" atom and
>> store its color in the "used_atom" structure for further usage in
>> populate_value().
>>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>>  ref-filter.c | 29 ++++++++++++++++++++---------
>>  1 file changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index b54c872..9708d67 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -29,6 +29,9 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>  static struct used_atom {
>>       const char *name;
>>       cmp_type type;
>> +     union {
>> +             char *color;
>> +     } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>>  static int need_color_reset_at_eol;
>> @@ -53,6 +56,18 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
>>       return 1;
>>  }
>>
>> +static void color_atom_parser(struct used_atom *atom)
>> +{
>> +     if (!match_atom_name(atom->name, "color", (const char **)&atom->u.color))
>> +             die("BUG: parsing non-'color'");
>> +     if (!atom->u.color)
>> +             die(_("expected format: %%(color:<color>)"));
>> +     /* atom->u.color points to part of atom->name */
>> +     atom->u.color = xstrdup(atom->u.color);
>> +     if (color_parse(atom->u.color, atom->u.color) < 0)
>> +             die(_("invalid color value: %s"), atom->u.color);
>
> Is this calling color_parse() from color.c?
>

Yes it is!

> The function wants the destination to be at least COLOR_MAXLEN, but
> I do not see where the piece memory pointed by atom->u.color is
> guaranteed to be that long in the new code.  Looking at the code
> removed by this patch, it used to correctly use a buffer that is
> COLOR_MAXLEN bytes long.  So...
>
>         const char *color_value;
>
>         if (!match_atom_name(atom->name, "color", color_value))
>                 die("BUG: parsing non-'color'");
>         if (!color_value)
>                 die(_("expected format: %%(color:<color>)"));
>         atom->u.color = xmalloc(COLOR_MAXLEN);
>         if (color_parse(color_value, atom->u.color) < 0)
>                 die(_("invalid color value: %s"), color_value);
>
> or even define it in the union, i.e.
>
>         union {
>                 char color[COLOR_MAXLEN];
>         } u;
>
> and then use atom->u.color[] in-place?

I like the in-place suggestion, I wasn't wary of the Minimum length requirement
of the dest in color_parser(). Thanks for bringing it up. Will change.

-- 
Regards,
Karthik Nayak
