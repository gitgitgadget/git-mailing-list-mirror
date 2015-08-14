From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v7 4/4] notes: teach git-notes about notes.<ref>.mergestrategy
 option
Date: Fri, 14 Aug 2015 15:48:54 -0700
Message-ID: <CA+P7+xqHzE5b7_yEqnCDq_vVJGSnsHPV8qJrXqUAGW=h_5C0mQ@mail.gmail.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
 <1439586835-15712-5-git-send-email-jacob.e.keller@intel.com> <xmqq8u9dh6lq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQNmp-0004sO-9J
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 00:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbbHNWtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 18:49:15 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37986 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbHNWtO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 18:49:14 -0400
Received: by igfj19 with SMTP id j19so21784940igf.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DUqU3qFcgV7/4xh3Nek0/WDmhxjY+Z/3Xaos4G/nAaU=;
        b=AyJMH8aFH9rzYsBrnAl6DMqAcyTnWHn/MGRFa/Hg/DTdYXgUDZJKUowiowX2nR96iR
         A6BmQ9fkkR8QkMtoxP3/+Iv2vF65FLsvFAUGjKjA4CaKmucM9kxDz04o7J+suu145Sls
         pfcHh8Kh0pT9nDGUyRdtU6P33yl3t6GAZvbg5yVI6//6uGzFJYGMitLDLuB+CEyWfmuo
         JhwWNu4JQhjZWadPVkJX/GaQrkAOnrOFhRVwsLSrK9xGkTRiZ4PKEhevBVXbPHveii9G
         NJ7kHO/o+IjlatxkH7uraNrTjIfVbKTP6XJKAx3j95v3wQUGEtLBzMiDGvvFR3l8CglT
         6r8A==
X-Received: by 10.50.78.161 with SMTP id c1mr5410552igx.35.1439592553786; Fri,
 14 Aug 2015 15:49:13 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Fri, 14 Aug 2015 15:48:54 -0700 (PDT)
In-Reply-To: <xmqq8u9dh6lq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275971>

On Fri, Aug 14, 2015 at 3:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> index 12a42b583f98..bdfd9c7d29b4 100644
>> --- a/builtin/notes.c
>> +++ b/builtin/notes.c
>> ...
>> @@ -833,7 +833,14 @@ static int merge(int argc, const char **argv, const char *prefix)
>>                       usage_with_options(git_notes_merge_usage, options);
>>               }
>>       } else {
>> -             git_config_get_notes_strategy("notes.mergestrategy", &o.strategy);
>> +             if (!skip_prefix(o.local_ref, "refs/notes/", &short_ref))
>> +                     die("Refusing to merge notes into %s (outside of refs/notes/)",
>> +                         o.local_ref);
>> +
>
> Sorry, but I lost track.
>
> Do I understand correctly the consensus on the previous discussion?
> My understanding is:
>
>  (1) We do not currently refuse to merge notes into anywhere outside
>      of refs/notes/;
>


We do. I mis understood the original code. We check inside
"init_notes_check()", which will check if the ref is under refs/notes/

>  (2) But that is not a designed behaviour---we simply forgot to
>      check it---we should start checking and refusing.
>
> If that is the concensus, having this check somewhere in the merge()
> function is indeed necessary, but this looks very out of place.
> Think what happens if the user passes "--stratagy manual" from the
> command line.  This check is not even performed, is it?
>

It is checked (also) in init_notes_check(). I just happen to re-check
here because I didn't want to out-right ignore it in some weird flow
where it was incorrect.

> I'd prefer to see:
>
>  * "Let's start making sure that we do not allow touching outside
>    refs/notes/" as a separate patch, perhaps as a preparatory step.
>

We already don't allow it. See init_notes_check()

>  * Have the check apply consistently, regardless of where the
>    strategy comes from.

It already does. There is just a second check. I could completely
remove that check if you like, but then we'd check config since we
don't run init_notes_check until after we find the merge strategy.

>
>  * That separate patch to add this restriction should test that
>    the refusal triggers correctly when it should, and it does not
>    trigger when it shouldn't.
>
>> +             strbuf_addf(&merge_key, "notes.%s.mergestrategy", short_ref);
>> +
>> +             if (git_config_get_notes_strategy(merge_key.buf, &o.strategy))
>> +                     git_config_get_notes_strategy("notes.mergestrategy", &o.strategy);
>>       }
>
> I think you are leaking merge_key after you are done using it.
>
> It is tempting to suggest writing the above like so:
>
>                 git_config_get_notes_strategy(merge_key.buf, &o.strategy)) ||
>                 git_config_get_notes_strategy("notes.mergestrategy", &o.strategy);
>
> which might make it more obvious what is going on, but I do not care
> too deeply about it.  To be honest, I am not sure which one is
> easier to read in the longer term myself ;-).
>

 the || strategy results in a warning that we are checking and then
dropping the outcome.

> Thanks.

Regards,
Jake
