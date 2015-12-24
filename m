From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/11] ref-filter: introduce contents_atom_parser()
Date: Thu, 24 Dec 2015 13:57:18 +0530
Message-ID: <CAOLa=ZTCnOwAa1DDmFiNeCdYFo0tkTfDM-fC_AkPStFA6rFU5w@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
 <1450279802-29414-11-git-send-email-Karthik.188@gmail.com> <CAPig+cRmUe4SRzmiV13XWSYou8M7TuDE3Ko37g8p-q2kEQNU+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 09:27:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aC1FZ-0006JU-6j
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 09:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbbLXI1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 03:27:49 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35568 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbLXI1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 03:27:48 -0500
Received: by mail-vk0-f48.google.com with SMTP id k1so17953377vkb.2
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 00:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2DCiyNbLdHE511dl4TCHDOLJLQ1fwgHRvYl2XVKGyTE=;
        b=R1WdbFlsqSBsSXy860QDPFhy+hV5lZDehrd8vBQt78CCqOlhl83rMD5hqEoj4Lhfqk
         L966YAq8+7WA4gXQYkcjeu/HMl+eaEW29YKPDCvdIADRwadR9hKp/6iXtNJTSCqzoHuA
         7++4lg9Q3xBXevcj7OknnXLntqqYTe0QFbbWx5AppSxu/+XOOGtdo7xqenrd2woDNbXv
         SyYRaTuLKt9fT6nffLVPcYQ+edWNrH2q6gdsaKHMm1CDez/zXH/x6kaegSc+uWusHjC6
         IUNDVCiJd4h9FhmK65avW5p2eP5ZGHbiHcp2DZ33w3mayvjSxRKHy7CyD+9bbCnPVZh3
         22Uw==
X-Received: by 10.31.153.201 with SMTP id b192mr3335075vke.46.1450945667696;
 Thu, 24 Dec 2015 00:27:47 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Thu, 24 Dec 2015 00:27:18 -0800 (PST)
In-Reply-To: <CAPig+cRmUe4SRzmiV13XWSYou8M7TuDE3Ko37g8p-q2kEQNU+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282974>

On Thu, Dec 17, 2015 at 3:09 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 16, 2015 at 10:30 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce contents_atom_parser() which will parse the '%(contents)'
>> atom and store information into the 'used_atom' structure based on the
>> modifiers used along with the atom.
>>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -39,6 +39,10 @@ static struct used_atom {
>>                 struct align align;
>>                 enum { RR_SHORTEN, RR_TRACK, RR_TRACKSHORT, RR_NORMAL }
>>                         remote_ref;
>> +               struct {
>> +                       enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>> +                       unsigned int no_lines;
>
> 'no_lines' sounds like "no lines!". How about 'nlines' instead?
>

Sure, will do.

>> +               } contents;
>>         } u;
>>  } *used_atom;
>>  static int used_atom_cnt, need_tagged, need_symref;
>> @@ -90,6 +94,36 @@ static void remote_ref_atom_parser(struct used_atom *atom)
>> +static void contents_atom_parser(struct used_atom *atom)
>> +{
>> +       const char * buf;
>> +
>> +       if (match_atom_name(atom->str, "contents", &buf))
>> +               atom->u.contents.option = C_BARE;
>> +       else if (match_atom_name(atom->str, "subject", &buf)) {
>
> The original code used strcmp() and matched only "subject", however
> the new code will incorrectly match both "subject" and
> "subject:whatever". Therefore, you should be using strcmp() here
> rather than match_atom_name().
>
> Ditto for "body".

Will change.

>
>> +               atom->u.contents.option = C_SUB;
>> +               return;
>> +       } else if (match_atom_name(atom->str, "body", &buf)) {
>> +               atom->u.contents.option = C_BODY_DEP;
>> +               return;
>> +       }
>> +       if (!buf)
>> +               return;
>
> It's not easy to see that this 'if (!buf)' check relates to the
> "contents" check at the very top of the if/else if/ chain since there
> are entirely unrelated checks in between. Reorganizing it can improve
> clarity:
>
>     if (!strcmp("subject")) {
>         ...
>         return;
>     } else if (!strcmp("body")) {
>         ...
>         return;
>     } else if (!match_atom_name(...,"contents", &buf))
>         die("BUG: expected 'contents' or 'contents:'");
>
>     if (!buf) {
>         atom->u.contents.option = C_BARE;
>         return;
>     }
>

This looks good. Thanks.

-- 
Regards,
Karthik Nayak
