From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Sat, 11 Jul 2015 11:37:01 +0530
Message-ID: <CAOLa=ZRJSA7hrRatP8GH49eZUrcSYz=UCnAJPaR+yJ2P-zrP4g@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <vpq380x8p3a.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jul 11 08:07:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDnwt-0007AK-HE
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbbGKGHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 02:07:40 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34580 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbbGKGHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 02:07:31 -0400
Received: by oiab3 with SMTP id b3so106320231oia.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 23:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jUrF65GGOHal9RRrVthe8+i43i6tqQjW6PRNg7JQ5uU=;
        b=hln3rOe0+6aLkG+29tL2O5679bHQLxpksjZreNc3DSzdcQ3TKOi8ZTIu7D5DOvBgZD
         EC/jU7inF9nb1xSIRTVS4AJIbAt0PTLJTPKCz3dNa6TlRDZewv5pBl5WZoR8dtnb1xq+
         UsywuImPuK7kPgJ5aCRt54F/R1I8hciZwIw/9ydZTpyELuPlH0odPfoW50zhayy06fQL
         VaI4N4B55E3ASs6KAoYDinLiIf1pXM95n2BRsTkybQl3D6ddnFn7Rlz36I3UFP6SuaLW
         MJa/3AR1XOSwaNvsbMZI7/Px7UzQ3AD38jpquJhb5ESw0s/rSFHjlqzRIh9q1FFdDG/8
         Epvw==
X-Received: by 10.182.29.68 with SMTP id i4mr21539563obh.57.1436594850484;
 Fri, 10 Jul 2015 23:07:30 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 10 Jul 2015 23:07:01 -0700 (PDT)
In-Reply-To: <vpq380x8p3a.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273840>

On Thu, Jul 9, 2015 at 6:28 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add support for %(refname:shortalign=X) where X is a number.
>> This will print a shortened refname aligned to the left
>> followed by spaces for a total length of X characters.
>> If X is less than the shortened refname size, the entire
>> shortened refname is printed.
>
> Not really an issue, but you're wrapping your text at ~60 characters.
> The common use is to wrap around 70 to 80. Using Emacs, auto-fill-mode
> or M-q does this automatically. If you use another text editor, it can
> probably do that for you too.
>

Thanks, I was just manually clipping it.

>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  ref-filter.c | 19 ++++++++++++++++++-
>
> I think this would deserve a test and documentation. Even though your
> motivation is for an internal implementation, some users may want to use
> the feature in 'git for-each-ref --format=...'.
>

I didn't want to include documentation as this is mostly for internal use,
but will add with tests.

>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index dd0709d..3098497 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -10,6 +10,7 @@
>>  #include "quote.h"
>>  #include "ref-filter.h"
>>  #include "revision.h"
>> +#include "utf8.h"
>>
>>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>
>> @@ -695,7 +696,23 @@ static void populate_value(struct ref_array_item *ref)
>>                       int num_ours, num_theirs;
>>
>>                       formatp++;
>> -                     if (!strcmp(formatp, "short"))
>> +                     if (starts_with(formatp, "shortalign=")) {
>> +                             const char *valp, *short_refname = NULL;
>> +                             int val, len;
>> +
>> +                             skip_prefix(formatp, "shortalign=", &valp);
>> +                             val = atoi(valp);
>
> You're silently accepting %(refname:shortalign=foo) and
> %(refname:shortalign=). I think it would be better to reject such cases
> explicitly.
>

Oh yeah! will do.

-- 
Regards,
Karthik Nayak
