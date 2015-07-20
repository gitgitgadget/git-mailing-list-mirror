From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 5/9] ref-filter: add option to match literal pattern
Date: Mon, 20 Jul 2015 10:01:11 +0200
Message-ID: <CAP8UFD0kaqSUGMbWrim+59H8CweO-MKSyeQr+3q2cYdJ-+D-Mw@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-6-git-send-email-Karthik.188@gmail.com>
	<CAPig+cSTQgaL-nYfOCWdTaCEpM_23E5TZOPQpnWXEZ8YCcvbZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 10:01:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH60o-0005ET-Oa
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 10:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028AbbGTIBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 04:01:15 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34300 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009AbbGTIBM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 04:01:12 -0400
Received: by wgkl9 with SMTP id l9so123850772wgk.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 01:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9mEP7y7473cluCjACU/18CyvcNp8ssjK5UQ1pE+qaeA=;
        b=SMnlJQBGQ9A1Dnf8FDRzhiQBgU3Cvi2oGT8FjNDvc6LmcxfE/CfQyPu8ZmfIgCmU/C
         UkMjD5zHWtpA0YYjarYdzYjUtnWK+bql+FdjgL14BKmLKW8JV4Y0vATWM5U1QRq4nax5
         w8zepVSWfRGklcvihSjMkzOsCgq/WI4fIhHDgLHk9R9Ib3Gt1/KTCuVE5sSbxUZDmJyP
         bTVe6UvuRFU5ELQoWu0gue5PDTimfJpdjvuzTDs1wYkW0Qy9aRIBTGGIKgMzq3U7eBae
         5oqU1lwbXdDjvpYvdhXcQucwV9dcHDr1octHDEDeXejaMKAfO2WcELivV7QfzG6SwJo4
         n2ew==
X-Received: by 10.181.25.234 with SMTP id it10mr18931233wid.41.1437379271082;
 Mon, 20 Jul 2015 01:01:11 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Mon, 20 Jul 2015 01:01:11 -0700 (PDT)
In-Reply-To: <CAPig+cSTQgaL-nYfOCWdTaCEpM_23E5TZOPQpnWXEZ8YCcvbZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274320>

On Mon, Jul 20, 2015 at 8:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
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
>> index 85c561e..7ff3ded 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -966,6 +980,15 @@ static int match_name_as_path(const char **pattern, const char *refname)
>>         return 0;
>>  }
>>
>> +static int filter_pattern_match(struct ref_filter *filter, const char *refname)
>> +{
>> +       if (!*filter->name_patterns)
>> +               return 1;
>> +       if (filter->match_as_path)
>> +               return match_name_as_path(filter->name_patterns, refname);
>> +       return match_pattern(filter->name_patterns, refname);
>> +}
>> +
>>  /*
>>   * Given a ref (sha1, refname), check if the ref belongs to the array
>>   * of sha1s. If the given ref is a tag, check if the given tag points
>> @@ -1034,7 +1057,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>>                 return 0;
>>         }
>>
>> -       if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
>> +       if (!filter_pattern_match(filter, refname))
>>                 return 0;
>
> I find it much more difficult to grok the new logic due to
> '*filter->name_patterns' having moved into the called function and its
> negation inside the function returning 1 which is then negated (again)
> upon return here. This sort of twisty logic places a higher cognitive
> load on the reader. Retaining the original logic makes the code far
> simpler to understand:
>
>     if (*filter->name_patterns &&
>         !filter_pattern_match(filter, refname))
>         return 0;
>
> although it's a bit less nicely encapsulated, so I dunno...

I think a comment before filter_pattern_match() and perhaps also one
inside it might help. For example something like:

/* Return 1 if the refname matches one of the patterns, otherwise 0. */
static int filter_pattern_match(struct ref_filter *filter, const char *refname)
{
       if (!*filter->name_patterns)
               return 1; /* No pattern always matches */
       if (filter->match_as_path)
               return match_name_as_path(filter->name_patterns, refname);
       return match_pattern(filter->name_patterns, refname);
}
