From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 12/19] fsck: Disallow demoting grave fsck errors to warnings
Date: Fri, 19 Jun 2015 16:30:21 -0700
Message-ID: <CAPc5daWuxBYyA03_WxeEEuDN4BPW58tTTK2yLxVnjR7sRwMhoQ@mail.gmail.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de> <c87d71326fc75773f137eee0ef6a8964645f0b74.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqa8vv78ld.fsf@gitster.dls.corp.google.com> <4e523e191f979706eca5d6ddcd221553@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 20 01:30:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z65kG-00084k-0P
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 01:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbbFSXao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 19:30:44 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35554 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbbFSXam (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 19:30:42 -0400
Received: by oiax193 with SMTP id x193so90220201oia.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Sv4nVp2NfJd2ajWAjDvFZQy0IfoFBcAITHGOwHok0OE=;
        b=G+BiMstfIHpkx5wSM0tM2N1aHUbw2q2J4fz9lpjJ6B7lIMohMyUiCIn3EBr6PuvYSj
         rZkDn75K7J8exUntKMb1taG6Q7ZpFwCORbOQyP8hPPJhMu50DWh7oNABIyg4Oj7ilp8f
         0euj372e2lrQWTJ9dRaG9nraEWDIyuLupgXXe1bvmngJLKYDV/OajkOr7OG9SrO3PPB5
         SF0ZncpbYrafkDELRvkK6B/SW8uFloVm9ClcD0Twj6S6GgshI+ye2BmH8fireA0MYir4
         QEs6YVcodN0+alrVJKYDefVfGH9kHro2XHLsO1RCtzfJZuUK8ZvH/taazJm1UGbN+/7D
         lukA==
X-Received: by 10.202.186.132 with SMTP id k126mr14922601oif.60.1434756642179;
 Fri, 19 Jun 2015 16:30:42 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Fri, 19 Jun 2015 16:30:21 -0700 (PDT)
In-Reply-To: <4e523e191f979706eca5d6ddcd221553@www.dscho.org>
X-Google-Sender-Auth: 6CzVJRQL8rXengK86KAq7lOpzmg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272216>

Ahh, I didn't see that they were not grouped by object types, features
or any meaningful axis.
That explains it (i.e. I can now understand why the original list was
ordered differently from the final order).


On Fri, Jun 19, 2015 at 2:09 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Junio,
>
> On 2015-06-19 22:21, Junio C Hamano wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> Some kinds of errors are intrinsically unrecoverable (e.g. errors while
>>> uncompressing objects). It does not make sense to allow demoting them to
>>> mere warnings.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>  fsck.c                          | 14 ++++++++++++--
>>>  t/t5504-fetch-receive-strict.sh | 11 +++++++++++
>>>  2 files changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fsck.c b/fsck.c
>>> index 21e3052..a4fbce3 100644
>>> --- a/fsck.c
>>> +++ b/fsck.c
>>> @@ -9,7 +9,12 @@
>>>  #include "refs.h"
>>>  #include "utf8.h"
>>>
>>> +#define FSCK_FATAL -1
>>> +
>>>  #define FOREACH_MSG_ID(FUNC) \
>>> +    /* fatal errors */ \
>>> +    FUNC(NUL_IN_HEADER, FATAL) \
>>> +    FUNC(UNTERMINATED_HEADER, FATAL) \
>>>      /* errors */ \
>>>      FUNC(BAD_DATE, ERROR) \
>>>      FUNC(BAD_DATE_OVERFLOW, ERROR) \
>>> @@ -39,11 +44,9 @@
>>>      FUNC(MISSING_TYPE, ERROR) \
>>>      FUNC(MISSING_TYPE_ENTRY, ERROR) \
>>>      FUNC(MULTIPLE_AUTHORS, ERROR) \
>>> -    FUNC(NUL_IN_HEADER, ERROR) \
>>>      FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
>>>      FUNC(TREE_NOT_SORTED, ERROR) \
>>>      FUNC(UNKNOWN_TYPE, ERROR) \
>>> -    FUNC(UNTERMINATED_HEADER, ERROR) \
>>
>> I think the end result very much makes a good sense, but why didn't
>> this list enumerate the errors in the above "final" order from the
>> beginning in 02/19?
>
> Because they are alphabetically ordered, within message type categories, that is; this helped me develop with more ease (you do not want to know how many hundreds of times I ran an interactive rebase on all of these patches...).
>
> And from the point of a development story (which a patch series is), it would puzzle me, as a reader, if those two out of all the others were in front in 02/19, when they are no different from the others at that stage.
>
> Ciao,
> Dscho
