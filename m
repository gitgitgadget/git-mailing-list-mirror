From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 5/9] ref-filter: add option to match literal pattern
Date: Mon, 20 Jul 2015 14:12:11 -0400
Message-ID: <CAPig+cSu7-wegGd90WHeppt8inHSBxrakzuJSvcRV7OocJHAgg@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-6-git-send-email-Karthik.188@gmail.com>
	<CAPig+cSTQgaL-nYfOCWdTaCEpM_23E5TZOPQpnWXEZ8YCcvbZg@mail.gmail.com>
	<CAP8UFD0kaqSUGMbWrim+59H8CweO-MKSyeQr+3q2cYdJ-+D-Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 20:12:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHFY8-0007kn-Pe
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 20:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbbGTSMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 14:12:13 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36186 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbbGTSML (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 14:12:11 -0400
Received: by ykay190 with SMTP id y190so145226479yka.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8kH4Vx08GKWBcAStrhXYcQBIRoU3IH5MEn5ymsY/rZU=;
        b=qOJ/+tVnqEROVvJ/0uEU7hRsHtJUdFoDlQ5IF5lXox9Q7O0EjNjeaJW3t4e4C+0Kij
         BIjIaFXgzoj7qT2RCTnTc5vmKLrfeFzlfr7E9SaQIhC/0+/R2dd+9AFucapL88jA14M8
         4Wu+Rp9OaHJMRARzBZiyhzilIX/VbQJXxm+DsYn5cgFIT4LZU2Apq6rTJrylmmcH2Ogq
         yNdiRpqaQ923A3cOoA39MrYMEXUhbb13xoLQmt/wigN3YGqTYuTAOh1XGBtI1oPcopYJ
         ZWoFD0gUes6qq22F8xjZEg7z5f5lBt3BoriWhXNRfEqUEfMYseQLDuQu8EWRF9hnS4iF
         Fqaw==
X-Received: by 10.170.97.9 with SMTP id o9mr29589120yka.84.1437415931072; Mon,
 20 Jul 2015 11:12:11 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 20 Jul 2015 11:12:11 -0700 (PDT)
In-Reply-To: <CAP8UFD0kaqSUGMbWrim+59H8CweO-MKSyeQr+3q2cYdJ-+D-Mw@mail.gmail.com>
X-Google-Sender-Auth: fmoRcHrHGKmbg2DNrXnEhQFMJFc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274339>

On Mon, Jul 20, 2015 at 4:01 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Jul 20, 2015 at 8:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> +static int filter_pattern_match(struct ref_filter *filter, const char *refname)
>>> +{
>>> +       if (!*filter->name_patterns)
>>> +               return 1;
>>> +       if (filter->match_as_path)
>>> +               return match_name_as_path(filter->name_patterns, refname);
>>> +       return match_pattern(filter->name_patterns, refname);
>>> +}
>>> @@ -1034,7 +1057,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>>> -       if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
>>> +       if (!filter_pattern_match(filter, refname))
>>>                 return 0;
>>
>> I find it much more difficult to grok the new logic due to
>> '*filter->name_patterns' having moved into the called function and its
>> negation inside the function returning 1 which is then negated (again)
>> upon return here. This sort of twisty logic places a higher cognitive
>> load on the reader. Retaining the original logic makes the code far
>> simpler to understand:
>>
>>     if (*filter->name_patterns &&
>>         !filter_pattern_match(filter, refname))
>>         return 0;
>>
>> although it's a bit less nicely encapsulated, so I dunno...
>
> I think a comment before filter_pattern_match() and perhaps also one
> inside it might help. For example something like:
>
> /* Return 1 if the refname matches one of the patterns, otherwise 0. */
> static int filter_pattern_match(struct ref_filter *filter, const char *refname)
> {
>        if (!*filter->name_patterns)
>                return 1; /* No pattern always matches */
>        if (filter->match_as_path)
>                return match_name_as_path(filter->name_patterns, refname);
>        return match_pattern(filter->name_patterns, refname);
> }

Yes, the comments do improve the situation and may be a reasonable compromise...
