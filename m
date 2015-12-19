From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/11] ref-filter: introduce align_atom_parser()
Date: Sat, 19 Dec 2015 16:42:55 +0530
Message-ID: <CAOLa=ZQH4sb1e87Hrze_xThkH9fCKMzzFQQ106cXf3w83wr1aA@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
 <1450279802-29414-8-git-send-email-Karthik.188@gmail.com> <CAPig+cR=dYnMfaHUYcq_kz8M+C1nCxOX=SN=_6+ep1aWvVCUow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 12:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAFS6-0001cC-S5
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 12:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbbLSLN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 06:13:27 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35942 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbbLSLN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 06:13:26 -0500
Received: by mail-vk0-f44.google.com with SMTP id f2so40232853vkb.3
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 03:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YOQMqET8BQG6sPnqoY3bYrMIaZ9ClUjZkU91b8b7iCo=;
        b=FVs/0NCfRuHZ1ropxQZk/BkKMj15W2RH66HopJg6681KfLYimZzhlnkfYJGBKBvKE6
         bAFk2jeqAz/q1eX9zpGwA86pYh1tqgxt2+wF9ofOI9gNmiOaKnrV+xPRqXGZ8L1r33tU
         cCMQ4Xet+ZKGnRsj+iOcCd2PTSzkZdEioPTF7BZupwlqDL0szzKxEA8jnEePSEA2W9Wh
         B6ikFzAxXsVcD4imcu9ulOKDB7sMhNrC4LPKN9WLrStQmMIqNGFRQP8CcncrVqcAlQp0
         Cvt/zgnH4S613lAnN1lK/4nS6q+1/v0qtX01pYWer13ZCZu06Kn8tLMnQ52cFB14A0z5
         FJiQ==
X-Received: by 10.31.16.140 with SMTP id 12mr5113552vkq.106.1450523605391;
 Sat, 19 Dec 2015 03:13:25 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sat, 19 Dec 2015 03:12:55 -0800 (PST)
In-Reply-To: <CAPig+cR=dYnMfaHUYcq_kz8M+C1nCxOX=SN=_6+ep1aWvVCUow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282743>

On Thu, Dec 17, 2015 at 3:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce align_atom_parser() which will parse an "align" atom and
>> store the required alignment position and width in the "use_atom"
>> structure for further usage in 'populate_value()'.
>>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -63,6 +69,49 @@ static void color_atom_parser(struct used_atom *atom)
>> +static align_type parse_align_position(const char *s)
>> +{
>> +       if (!strcmp(s, "right"))
>> +               return ALIGN_RIGHT;
>> +       else if (!strcmp(s, "middle"))
>> +               return ALIGN_MIDDLE;
>> +       else if (!strcmp(s, "left"))
>> +               return ALIGN_LEFT;
>> +       return -1;
>> +}
>> +
>> +static void align_atom_parser(struct used_atom *atom)
>> +{
>> +       struct align *align = &atom->u.align;
>> +       const char *buf = NULL;
>> +       struct strbuf **s, **to_free;
>> +       int width = -1;
>> +
>> +       match_atom_name(atom->str, "align", &buf);
>> +       if (!buf)
>> +               die(_("expected format: %%(align:<width>,<position>)"));
>> +       s = to_free = strbuf_split_str_omit_term(buf, ',', 0);
>> +
>> +       align->position = ALIGN_LEFT;
>> +
>> +       while (*s) {
>> +               int position;
>> +
>> +               if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
>
> This casting is pretty ugly. It probably would be cleaner to declare
> 'width' as 'unsigned int' and initialize it with ~0U than to do this
> ugly and potentially dangerous casting. Likewise, below where you
> check 'width < 0', you'd check instead for ~0U. However, such a change
> should not be part of the current patch, but rather as a separate
> preparatory patch.
>

Will do.

>> +                       ;
>> +               else if ((position = parse_align_position(s[0]->buf)) > 0)
>
> Shouldn't this be '>=' rather than '>'?
>
> This likely would have been easier to spot if parse_align_position()
> had been factored out in its own patch, as suggested by my v1
> review[1], since the caller would have been trivially inspectable
> rather than having to keep track of both code movement and changes.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/281916
>

Yes. it should. Will split this into three patches.

1. Creation of align_atom_parser().
2. Introduce parse_align_position().
3. make 'width' an unsigned int.

-- 
Regards,
Karthik Nayak
