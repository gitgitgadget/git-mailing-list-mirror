From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 05/10] ref-filter: introduce color_atom_parser()
Date: Thu, 3 Dec 2015 19:05:17 +0530
Message-ID: <CAOLa=ZQY3PMtfemVAsbHydtguQG9pc2uVTiJ6Qh+jLf6mY4dFw@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-6-git-send-email-Karthik.188@gmail.com> <CAPig+cRXgLqmUf1ZK2QnHbHM6-1Ya=iTx6Jq9YdnkO8aOsq+tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 14:39:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4U64-0004hk-6T
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 14:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760160AbbLCNgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 08:36:05 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35122 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760034AbbLCNfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 08:35:47 -0500
Received: by vkha189 with SMTP id a189so45055241vkh.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 05:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vaASyaGh65fXgXbt0UDJsQPjtWwGyZGa5uaJJL1m/ZM=;
        b=c5OQy9f8xRsJZJxJU2A3Iao+2oHwESn963ziD0yps6c/fb0+XFp9tV/t/LhSlML/yX
         j2DghTZ8NURk2g4iW8mdDcRXh242bNO1gMkgomGIix79Hl6YGCMq03hFzysGm/z//l3+
         EBlEeSDCsp9Lz9qR1hW8V4WnvG54/8qnE/G6HF0NImVdkJjJKDgG5SDIsDheGEgdvnQI
         0FHE43f34hcK0wopR4gShVlPrCXLCIR7LBKaFDL0CSAGVWfNFb5VYkxQJqWdarJziNB8
         X9odEW3YlQepRuBV3So8s2SQuG7eT80op60n91Ust4ZpduJXbUE7CwoTxvD1eFd4XHVY
         9Gdg==
X-Received: by 10.31.157.144 with SMTP id g138mr6432024vke.71.1449149746777;
 Thu, 03 Dec 2015 05:35:46 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Thu, 3 Dec 2015 05:35:17 -0800 (PST)
In-Reply-To: <CAPig+cRXgLqmUf1ZK2QnHbHM6-1Ya=iTx6Jq9YdnkO8aOsq+tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281954>

On Wed, Dec 2, 2015 at 4:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce color_atom_parser() which will parse a "color" atom and
>> store its color in the "use_atom" structure for further usage in
>
> s/use_atom/used_atom/
>

will change.

>> 'populate_value()'.
>>
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
>> @@ -53,6 +56,13 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
>> +void color_atom_parser(struct used_atom *atom)
>> +{
>> +       match_atom_name(atom->str, "color", &atom->u.color);
>> +       if (!atom->u.color)
>> +               die(_("expected format: %%(color:<color>)"));
>> +}
>> +
>> @@ -175,6 +185,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>         REALLOC_ARRAY(used_atom, used_atom_cnt);
>>         used_atom[at].str = xmemdupz(atom, ep - atom);
>>         used_atom[at].type = valid_atom[i].cmp_type;
>> +       memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
>> +       if (valid_atom[i].parser)
>> +               valid_atom[i].parser(&used_atom[at]);
>>         if (*atom == '*')
>>                 need_tagged = 1;
>>         if (!strcmp(used_atom[at].str, "symref"))
>> @@ -833,11 +846,10 @@ static void populate_value(struct ref_array_item *ref)
>>                         refname = branch_get_push(branch, NULL);
>>                         if (!refname)
>>                                 continue;
>> -               } else if (match_atom_name(name, "color", &valp)) {
>> +               } else if (starts_with(name, "color")) {
>
> Hmm, so this will also match "colorize". Is that desirable?
>

Well the error checking is done when we parse the atom in color_atom_parser()
so here we don't need to worry about something like this.

>>                         char color[COLOR_MAXLEN] = "";
>> +                       const char *valp = atom->u.color;
>>
>> -                       if (!valp)
>> -                               die(_("expected format: %%(color:<color>)"));
>>                         if (color_parse(valp, color) < 0)
>
> Rather than declaring variable 'valp', why not just say:
>
>     if (color_parse(atom->u.color, color) < 0)
>
> ?

Yes, will change, thanks.

-- 
Regards,
Karthik Nayak
