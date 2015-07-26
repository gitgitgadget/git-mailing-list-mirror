From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 06/10] ref-filter: add option to match literal pattern
Date: Sun, 26 Jul 2015 23:51:34 +0530
Message-ID: <CAOLa=ZQQ1F=DibGW=McxORH9CMkOZ8n5fnMOi0_D++Du-zWStw@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-7-git-send-email-Karthik.188@gmail.com> <CAPig+cTAYAxg4aWpaPrHe6Hfz3wCEiypoXZxS_Lir4yNOFzSNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 20:22:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJQYv-0008Kv-OD
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 20:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbbGZSWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 14:22:06 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33058 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbbGZSWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 14:22:04 -0400
Received: by oige126 with SMTP id e126so41755843oig.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2015 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M5dKP3SXfJF35qyGCyxkku8+APEWYLnoB8N63e5uxf4=;
        b=YoUZX4FnAIZUaPu0jUZyI59tRmkV3pqqbtoyM9b6gJXmxQHqaV+XK877n9h4dkzMBY
         YcaudkdFjoTBDexBqs4larw95Wvd5BAFtRRvdylhkTNMhXjltgk4DB/0fG75qoJltT6W
         RtLvxQLyJ1aJNhW2lDMvQ3Pj0h7IuX6wRXUzy0i+V7WdMUQkfWSqE6bP7h6yM6kdLGTQ
         1ofRZNYNSw1DhLeHrPGGNGbKrl9AlqxLWwJq7ypbIRJB7EaHSNgBtG0GQVcOVhZZ4vJ1
         SzEpBLtLViKADpHu52EXwbvT9sTxZLUkB/8O42ddF2HZylgSUHEcBI05QH89iyXkeXdc
         Hy0A==
X-Received: by 10.202.200.151 with SMTP id y145mr23022473oif.111.1437934923786;
 Sun, 26 Jul 2015 11:22:03 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sun, 26 Jul 2015 11:21:34 -0700 (PDT)
In-Reply-To: <CAPig+cTAYAxg4aWpaPrHe6Hfz3wCEiypoXZxS_Lir4yNOFzSNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274645>

On Sun, Jul 26, 2015 at 10:45 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jul 24, 2015 at 3:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
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
>> index 8f2148f..0a64b84 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -951,6 +951,31 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>>
>>  /*
>>   * Return 1 if the refname matches one of the patterns, otherwise 0.
>> + * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
>> + * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same ref
>> + * matches "refs/heads/mas*", too).
>> + */
>> +static int match_pattern(const char **patterns, const char *refname)
>> +{
>> +       for (; *patterns; patterns++) {
>> +               /*
>> +                * When no '--format' option is given we need to skip the prefix
>> +                * for matching refs of tags and branches.
>> +                */
>> +               if (!starts_with(*patterns, "refs/tags/"))
>> +                       skip_prefix(refname, "refs/tags/", &refname);
>> +               if (!starts_with(*patterns, "refs/heads/"))
>> +                       skip_prefix(refname, "refs/heads/", &refname);
>> +               if (!starts_with(*patterns, "refs/remotes/"))
>> +                       skip_prefix(refname, "refs/remotes/", &refname);
>
> Note the inefficiency here: You're performing an "expensive"
> starts_with() on each pattern for each refname even though the
> patterns will never change. You could instead compute starts_with()
> for each pattern just once, in a preprocessing step, and remember each
> result as a boolean, and then use the computed booleans here in place
> of starts_with(). For a few refnames, this may not make a difference,
> but for a project with a huge number, it could. Whether such an
> optimization is worth the complexity (at this time or ever) is
> something that can be answered by taking measurements.
>
> Also, the repetition in the code is not all that pretty. You could
> instead place "refs/tags/", "refs/heads/", and "refs/remotes/" in a
> table and then loop over them rather than repeating the code for each
> one, though whether that would be an improvement is likely a judgment
> call (so not something I'd insist upon).
>

I just put the "starts_with()" code so as to ensure that its only used when
we don't say "refs/heads/", "refs/remotes/" or "refs/tags/" in the pattern.
But looking at the tag.c and branch.c implementations this should always be
done. Hence I think Ill move it outside the loop and make it mandatory as this
pattern matching is only used by tag and branch and as they by default
remove the
path of the ref. I think it'd make sense to remove it here also.

-- 
Regards,
Karthik Nayak
