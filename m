From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 21:37:30 -0700
Message-ID: <CAGZ79kYSDGZ=H9c9tcjNn=GV8ZzUXXpr6LoWNkWe_vhPmfMAiw@mail.gmail.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
	<1461079290-6523-3-git-send-email-sbeller@google.com>
	<CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
	<20160420041827.GA7627@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 06:37:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asjtS-000472-7V
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 06:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbcDTEhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 00:37:32 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37329 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbcDTEhb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 00:37:31 -0400
Received: by mail-ig0-f170.google.com with SMTP id g8so37972883igr.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 21:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Ajyan20mxLSeCjQD4MfOov8DQ8fDjx7qXGPU0ZDyMg8=;
        b=bPPREXeZtZaUSwXu6Q0PyiMmsEsDweq5TJ5RyqTSYvmoDe6C+CgNKZlJkEvM59UPNU
         YSGlzR/OhOaSyriAIaZoi81oPwCyWOchHj+H60E0AvlI5s4CegpH6jeByWZ3kBEIaQAt
         zFmqXaVYhat23ycF6fE8zf+5gzN1gzL+VEflMnVlMG6+R3z5ZG0G7MpvdpEvI3mTHNIq
         TfLy69B4GlSFsMdWRMRslaVR9PTtXEXEh+duuUK+sBwEn7tuUvvOIWkicJ/H9YxAO4xa
         Va3liY9bhCAO96n+oSzZzMvaypD/CasyKWLHMtgB+73bupIj6M7mRgCrlj/Ix+oFSxKs
         S4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Ajyan20mxLSeCjQD4MfOov8DQ8fDjx7qXGPU0ZDyMg8=;
        b=gliY3odvsCe0Vql+9AJHaEU+4equlWQLeRQ5ZQYbL8cNKmEZpUPkhfhe+dgfzyhxL3
         tsYYSHx5L5asgIMCHvrruyu2TLT/RfZBYd7rLo7pR1sc1mcFR/GQn0OZe/Y/UnQBuSvV
         v4d7UOh7KDQO7CU2kbgJ9hprizbRCCenlEvkgKucsofMtIpCMxrbRwJMW8KToktn4xa2
         wdpr2QbJCEvl1YQ42Oa84T15Bz5FqdM5Bn6KmRpG90P7gZtlV7erZ50/D++6YqOqAk8f
         wXuov5D3J8GOK4nSQE2gP6iM7bvzvrrTTcC9NPQmFT6m7J+FQ2y4DZCPS8KuTHuMVNrN
         Dspw==
X-Gm-Message-State: AOPr4FXcSN1EPmfVf+0kjE/o/hg3tEzDkOVaIFp2gvzYKCCHZknFXpXrY57pUuwdfL7FAtildhuYRODexEVn8EiT
X-Received: by 10.50.72.107 with SMTP id c11mr1176455igv.85.1461127050639;
 Tue, 19 Apr 2016 21:37:30 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 19 Apr 2016 21:37:30 -0700 (PDT)
In-Reply-To: <20160420041827.GA7627@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291981>

On Tue, Apr 19, 2016 at 9:18 PM, Jeff King <peff@peff.net> wrote:
> [your original probably didn't make it to the list because of its 5MB
>  attachment; the list has a 100K limit; I'll try to quote liberally]
>
> On Tue, Apr 19, 2016 at 04:17:50PM -0700, Jacob Keller wrote:
>
>> I ran this version of the patch against the entire Linux kernel
>> history, as I figured this has a large batch of C code to try and spot
>> any issues.
>>
>> I ran something like the following command in bash
>>
>> $git rev-list HEAD | while read -r rev; do diff -F ^commit -u <(git
>> show --format="commit %H" --no-compaction-heuristic $rev) <(git show
>> --format="commit %H" --compaction-heuristic $rev); done >
>> heuristic.patch
>
> My earlier tests with the perl script were all done with "git log -p",
> which will not show anything at all for merges (and my script wouldn't
> know how to deal with combined diffs anyway). But I think this new patch
> _will_ kick in for combined diffs (because it is built on individual
> diffs). It will be interesting to see if this has any effect there, and
> what it looks like.
>
> We should be able to see it (on a small enough repository) with:
>
>   git log --format='commit %H' --cc --merges
>
> and comparing the before/after.
>
>> I've attached the file that I generated for the Linux history, it's
>> rather large so hopefully I can get some help to spot any differences.
>> The above approach will work for pretty much any repository, and works
>> better than trying to generate the entire thing first and then diff
>> (since that runs out of memory pretty fast).
>
> I don't think there is much point in generating a complete diff between
> the patches for every commit, when nobody can look at the whole thing.
> Unless we have automated tooling to find "interesting" bits (and
> certainly a tool to remove the boring "a comment got shifted by one"
> lines would help; those are all known improvements, but it's the _other_
> stuff we want to look).
>
> But if we are not using automated tooling to find the needle in the
> haystack, we might as well using sampling to make the dataset more
> manageable. Adding "--since=1.year.ago" is one way, though we may want
> to sample more randomly across time.
>
>> So far, I haven't spotted anything that would want me to disable it,
>> while I've spotted several cases where I felt that readability was
>> improved. It's somewhat difficult to spot though.
>
> I did find one case that I think is worse. Look at 857942fd1a in the
> kernel. It has a pattern like this:
>
>   ... surrounding code ...
>
>   function_one();
>   ... more surrounding code ...
>
> which becomes:
>
>   ... surrounding code ...
>
>   function_two();
>
>   ... more surrounding code
>
> Without the new heuristic, that looks like:
>
>   -function_one();
>   +function_two();
>   +
>
> but with it, it becomes:
>
>   +
>   +function_two();
>
>   -function_one();
>
> which is kind of weird. Having the two directly next to each other reads
> better to me. This is a pretty unusual diff, though, in that it did
> change the surrounding whitespace (and if you look further in the diff,
> the identical change is made elsewhere _without_ touching the
> whitespace). So this is kind of an anomaly. And IMHO the weirdness here
> is outweighed by the vast number of improvements elsewhere.

The new implementation supports the flags for ignoring white space, too.

>
> -Peff
