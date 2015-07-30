From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 07/11] ref-filter: add option to match literal pattern
Date: Thu, 30 Jul 2015 16:51:21 +0530
Message-ID: <CAOLa=ZRsX-xxJyD1OZ47wzZg2qbZWvvR6qpvfp_M-xtqLBZRsw@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Jul 30 13:21:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKluP-0006wx-2x
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 13:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbbG3LVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 07:21:52 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36443 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbG3LVv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 07:21:51 -0400
Received: by obnw1 with SMTP id w1so28259239obn.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 04:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N68B0ETZ6HsbrJtkafO6j9NfVEmc8iTQo3Gyl5zES0w=;
        b=W7wGYwNrEAUjJWMxRbLeJGThJSK4P6NYSjATSUSKR1gk7TbZ293YhyqMRy0RBMGZLr
         NzDYMj00tm5xAAnG7coZWWA9MyIAL7wQZw7tOPgdWiBa+oGTnL7CLNHSQ7BJ+LJ7CAGy
         gPDmE3Ndhk5k5+C5CGSRWrShdm9zmdBOT1f+5vTOKjW0WwImAmOM/sk2202QkJzbX/cr
         IlTetO/Byiob2UEgkI5GfSrHfzqHVxsFcwpEqtynSqAja+LWHO4jsTLsZUEBhCUzBQKA
         ZAcva2XCm+hrJu0nwrOKJIie0QZUKzEGBey4q+naaHMnLEkdMf0r5itfX/6TyJ0EVno+
         pmOw==
X-Received: by 10.60.58.136 with SMTP id r8mr44982907oeq.30.1438255311242;
 Thu, 30 Jul 2015 04:21:51 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 30 Jul 2015 04:21:21 -0700 (PDT)
In-Reply-To: <CAPig+cSiCR3OdYf=4BnaiS8PuSKxd7OPPxOUQYyZpBjkQ15LQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274982>

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

Gives a "warning: value computed is not used [-Wunused-value]"

so I typecasted the output as:

      (void)(skip_prefix(refname, "refs/tags/", &refname) ||
                skip_prefix(refname, "refs/heads/", &refname) ||
                skip_prefix(refname, "refs/remotes/", &refname));

Just wondering if that's alright.

-- 
Regards,
Karthik Nayak
