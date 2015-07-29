From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 07/11] ref-filter: add option to match literal pattern
Date: Wed, 29 Jul 2015 21:47:14 +0530
Message-ID: <CAOLa=ZS0jV-8-BROSjPwZZHe9gVSa-tgs+79Bxdqb1pETSVFdw@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-7-git-send-email-Karthik.188@gmail.com>
 <CAPig+cSiCR3OdYf=4BnaiS8PuSKxd7OPPxOUQYyZpBjkQ15LQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:17:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKU3A-0005Rb-Os
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 18:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbbG2QRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 12:17:45 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33659 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbG2QRo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 12:17:44 -0400
Received: by oixx19 with SMTP id x19so7714921oix.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v9LPBv01y6P4/Cslxs7B8mr6iCU2M6m1w6Ls1nqVzus=;
        b=Zq9anNuwsLX/m61XLRXvwRNeo1NUEfzMqRyfgJXO7PeIQ+lsfVCaV36TMyiVvQHfv/
         K1YP+ZrLXv6TY+dLt2Npo4j2mfL1UJQATY6dZTU6gOFFbPm3NbEEtoe6wdMQ0zbMKCjj
         agJn2txydupqmUc4Hw+WkxKwWxJoT4jproWTXX9epRLUv5xNCcMu+A74sjzXFiJ0yFhL
         FQCLwLKsNXiEulUjqpwzsU79S1NM/t65l7KKvQlhAa22M1nwqph7kfAw44rGX/HLLxsB
         kQUmxF76n6Y4sK2kriVVuYBysi+o8ykWz845B2vlflz7+A0PwzLgB9s42VOHB6L+YXuS
         Wazg==
X-Received: by 10.202.73.83 with SMTP id w80mr7859894oia.102.1438186663914;
 Wed, 29 Jul 2015 09:17:43 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 09:17:14 -0700 (PDT)
In-Reply-To: <CAPig+cSiCR3OdYf=4BnaiS8PuSKxd7OPPxOUQYyZpBjkQ15LQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274918>

On Wed, Jul 29, 2015 at 3:19 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jul 27, 2015 at 3:27 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Since 'ref-filter' only has an option to match path names add an
>> option for plain fnmatch pattern-matching.
>>
>> This is to support the pattern matching options which are used in `git
>> tag -l` and `git branch -l` where we can match patterns like `git tag
>> -l foo*` which would match all tags which has a "foo*" pattern.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 26eb26c..597b189 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -946,6 +946,32 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>>
>>  /*
>>   * Return 1 if the refname matches one of the patterns, otherwise 0.
>> + * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
>> + * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same ref
>> + * matches "refs/heads/mas*", too).
>> + */
>> +static int match_pattern(const char **patterns, const char *refname)
>> +{
>> +       /*
>> +        * When no '--format' option is given we need to skip the prefix
>> +        * for matching refs of tags and branches.
>> +        */
>> +       if (skip_prefix(refname, "refs/tags/", &refname))
>> +               ;
>> +       else if (skip_prefix(refname, "refs/heads/", &refname))
>> +               ;
>> +       else if (skip_prefix(refname, "refs/remotes/", &refname))
>> +               ;
>
> Or, more concisely:
>
>     skip_prefix(refname, "refs/tags/", &refname) ||
>     skip_prefix(refname, "refs/heads/", &refname) ||
>     skip_prefix(refname, "refs/remotes/", &refname);
>
> since || short-circuits. No need for the 'if' or cascading 'else if's.
>
>> +       for (; *patterns; patterns++) {
>> +               if (!wildmatch(*patterns, refname, 0, NULL))
>> +                       return 1;
>> +       }
>> +       return 0;
>> +}

Looks better thanks :)

-- 
Regards,
Karthik Nayak
