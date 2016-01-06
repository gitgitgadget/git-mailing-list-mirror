From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 14/15] ref-filter: introduce contents_atom_parser()
Date: Wed, 6 Jan 2016 23:52:03 +0530
Message-ID: <CAOLa=ZQY09yqDVELb9ObTnWfU-9nRyxJiV=_2tHbZPk_oe8sGQ@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-15-git-send-email-Karthik.188@gmail.com> <xmqqio37iuvj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 19:22:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGsjH-00044v-3j
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 19:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbcAFSWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 13:22:35 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34544 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbcAFSWe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 13:22:34 -0500
Received: by mail-vk0-f65.google.com with SMTP id a123so1742649vkh.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C+KUdcbMx2x+7jEAtdOofYq5vo3ItsSVQR3FPTo9Mz8=;
        b=S4MtI66wZJH2/TxN+vxj2iimyxCtY8KbdhE/DGEkS4cmPwwDmKJTZVv6Z8B7a/HP4Y
         3IytEOP7/ffYC/jIT2U8OcxQD8DHEWmQfYQt2XaNknXQ6dpuWRvpaIyjLWdhVgjiCk/A
         BLnEiT1DmDecp8zC2c6AnXXp5DEzard+EffkkFBAg/IoqC6/g2rG61vYt4eP6RiCcwzS
         bXcOxrmOO4LnYGw3Z1HQytTXkuEzDPo66HvYyIGP9ICMQq4wC5gqibgi0Q/vR3GXhs+6
         6lbTKNxykZ3xztuOCfGB9PLNAAow2576/NFJhpWowQsUkrH67YTJJNmO4jot8wlQ9I3h
         z1yg==
X-Received: by 10.31.16.158 with SMTP id 30mr68727340vkq.97.1452104553074;
 Wed, 06 Jan 2016 10:22:33 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Wed, 6 Jan 2016 10:22:03 -0800 (PST)
In-Reply-To: <xmqqio37iuvj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283449>

On Wed, Jan 6, 2016 at 2:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Introduce contents_atom_parser() which will parse the '%(contents)'
>> atom and store information into the 'used_atom' structure based on the
>> modifiers used along with the atom.
>>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>>  ref-filter.c | 74 +++++++++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 46 insertions(+), 28 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 32b4674..9e61530 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -39,6 +39,10 @@ static struct used_atom {
>>               struct align align;
>>               enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
>>                       remote_ref;
>> +             struct {
>> +                     enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>> +                     unsigned int nlines;
>> +             } contents;
>>       } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>> @@ -96,6 +100,35 @@ static void remote_ref_atom_parser(struct used_atom *atom)
>>               die(_("unrecognized format: %%(%s)"), atom->name);
>>  }
>>
>> +static void contents_atom_parser(struct used_atom *atom)
>> +{
>> +     const char * buf;
>> +
>> +     if (match_atom_name(atom->name, "subject", &buf) && !buf) {
>> +             atom->u.contents.option = C_SUB;
>> +             return;
>> +     } else if (match_atom_name(atom->name, "body", &buf) && !buf) {
>> +             atom->u.contents.option = C_BODY_DEP;
>> +             return;
>> +     } if (!match_atom_name(atom->name, "contents", &buf))
>> +               die("BUG: parsing non-'contents'");
>
> Did you really intend to say "if" here, not "else if"?
>

Not that it makes a difference here since both the previous
condition return. I think "else if" would be better.

> I also wonder if the "&& !buf" in the first two are correct.  What
> should happen to "%(subject:foo)", which gives you a non-empty buf?
> It may or may not be an error, but it should not fall thru and cause
> "BUG:parsing non-contents", should it?
>

I think It would be better to add specific messages there

if (match_atom_name(atom->name, "subject", &buf)) {
    if (buf)
        die("%%(subject) atom does not take arguments");
    atom->u.contents.option = C_SUB;
    return;
} else if (match_atom_name(atom->name, "body", &buf)) {
    if (buf)
        die("%%(body) atom does not take arguments");
    atom->u.contents.option = C_BODY_DEP;
    return;
} else if (!match_atom_name(atom->name, "contents", &buf))
     die("BUG: parsing non-'contents'");

-- 
Regards,
Karthik Nayak
