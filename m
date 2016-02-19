From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: Fetch the direct sha1 first
Date: Fri, 19 Feb 2016 14:10:34 -0800
Message-ID: <CAGZ79kaOQTGEY6akKgz695nPdG4cG4SsYKLcJkKr1im+RQjK5A@mail.gmail.com>
References: <1455908253-1136-1-git-send-email-sbeller@google.com>
	<xmqqpovsbdyu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Dave Borowitz <dborowitz@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 23:10:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWtG5-0006PK-9O
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 23:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2994236AbcBSWKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 17:10:36 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:36288 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992511AbcBSWKf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 17:10:35 -0500
Received: by mail-io0-f179.google.com with SMTP id l127so123754066iof.3
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 14:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4w0FesFPF7V52uQV6/RHILBPrYAbSEFhteD85g7GrtQ=;
        b=X3puHF98Er3ZMDh2nkTOmSYRDUZA7ZRk/Ba8bpp9tA83xd4Ar0Ppty0Oi2eZxohp1L
         PAn5zPlcMnPAlOwjTd7ktLxP7gFHNpNGIskE8kcQ/7HqikZlhHotbmZtv1yGBA7LMlG4
         MDjdNyvh35S7Hwic5B4K/p5iJhSNcbjGetU+AyU/P7uY9ZL9UTFMnGbcynhmiT+TGEIN
         JZgG4SLMdC0wp9yOmkFG6nIIS5eH/hueXlbFNXp3KxWQ+QxDgqbIKlvJ3KfuUAljqC27
         a63bRaDNJNeivbONWve6C2O+xAneLpDQlFnWDcH7/UloTNK/zF9CCpd6+NCwJqk3iGWX
         Sn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4w0FesFPF7V52uQV6/RHILBPrYAbSEFhteD85g7GrtQ=;
        b=fPGWwJ/3T32in5yc0GxJrMv88yoBfpHR/BPOzqcheTKOlKLNaFrbik10qEzR5Zq8CS
         dEfjkIbNJFBbGKAiKre2coSi3VybGyFLFgjXy4oNS1ve+7Pey4M2bBniM4F27EM0yt4t
         3KUROGjldBspztEX/6cNUIlbLImKqgjtcjnEuH77PMiNlDE8JzcMZBvQeKDtA6BxR6rs
         0ZtfAVIWwkPKOvYIGsO7sOkI5nVqmCyWUvJzQIwtU5mhviBdfx+hTDHC1r238IMq8KzJ
         Hzo7KZ3fdASVxcO9VjZLVRcOJQZL5L6WMZrrkuXGqGkDKXTzXy+NnGPHtZ2uhUIuZru+
         VyrA==
X-Gm-Message-State: AG10YOSCAkBm2lfpL50SFI+DTBDNoYw9DbPI2UdhjpIQbBFs9Ns9JYAcQxJ0AnaisMMawSov1fzWG3kFU7C3c1ll
X-Received: by 10.107.168.149 with SMTP id e21mr16789541ioj.96.1455919834644;
 Fri, 19 Feb 2016 14:10:34 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 19 Feb 2016 14:10:34 -0800 (PST)
In-Reply-To: <xmqqpovsbdyu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286754>

On Fri, Feb 19, 2016 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When reviewing a change in Gerrit, which also updates a submodule,
>> a common review practice is to download and cherry-pick the patch locally
>> to test it. However when testing it locally, the 'git submodule update'
>> may fail fetching the correct submodule sha1 as the corresponding commit
>> in the submodule is not yet part of the project history, but also just a
>> proposed change.
>>
>> To ease this, try fetching by sha1 first and when that fails (in case of
>> servers which do not allow fetching by sha1), fall back to the default
>> behavior we already have.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> I think it's best to apply this on origin/master, there is no collision
>> with sb/submodule-parallel-update.
>>
>> Also I do not see a good way to test this both in correctness as well
>> as performance degeneration. If the first git fetch fails, the second
>> fetch is executed, so it should behave as before this patch w.r.t. correctness.
>>
>> Regarding performance, the first fetch should fail quite fast iff the fetch
>> fails and then continue with the normal fetch. In case the first fetch works
>> fine getting the exact sha1, the fetch should be faster than a default fetch
>> as potentially less data needs to be fetched.
>
> "The fetch should be faster" may not be making a good trade-off
> overall--people may have depended on the branches configured to be
> fetched to be fetched after this codepath is exercised, but now if
> the commit bound to the superproject tree happens to be complete,
> even though it is not anchored by any remote tracking ref (hence the
> next GC may clobber it), the fetch of other branches will not
> happen.
>
> My knee-jerk reaction is that the order of fallback is probably the
> other way around.  That is, try "git fetch" as before, check again
> if the commit bound to the superproject tree is now complete, and
> fallback to fetch that commit with an extra "git fetch".

I thought about that and assumed we'd need to have an option for
fetch like "--try-to-get-sha1", which depending on the servers capabilities
would just add that sha1 to the "wants" during fetching negotiation if the
server supports it, otherwise just fetch normally.

Doing a 'git fetch' only and not the fetch for the specific sha1 would be
incorrect? ('git fetch' with no args finishes successfully, so no fallback is
triggered. But we are not sure if we obtained the sha1, so we need to
check if we have the sha1 by doing a local check and then try to get the sha1
again if we don't have it locally. So doing the reverse order would be
more code here for correctness.

>
> Jens, what do you think?
>
>>  git-submodule.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 9bc5c5f..ee0b985 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -746,8 +746,9 @@ Maybe you want to use 'update --init'?")"
>>                               # Run fetch only if $sha1 isn't present or it
>>                               # is not reachable from a ref.
>>                               (clear_local_git_env; cd "$sm_path" &&
>> +                                     remote_name=$(get_default_remote)
>>                                       ( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
>> -                                      test -z "$rev") || git-fetch)) ||
>> +                                      test -z "$rev") || git-fetch $remote_name $rev
>
> Regardless of the "fallback order" issue, I do not think $rev is a
> correct thing to fetch here.  The superproject binds $sha1 to its
> tree, and you would be checking that out, so shouldn't you be
> fetching that commit?

Both $sha1 and $rev are in the submodule (because
'git submodule--helper list' puts out the sha1 as the
submodule sha1). $rev is either empty or equal to $sha1
in my understanding of "rev-list $sha1 --not --all". However for
readability maybe we want to write:

    (clear_local_git_env; cd "$sm_path" &&
        test -z $(git rev-list -n 1 $sha1 --not --all 2>/dev/null) ||
        git fetch $(get_default_remote) $sha1 ||
        git fetch ||
        die ...
    )

So in case you want to the other order, I'd propose

    (clear_local_git_env; cd "$sm_path" &&
        test -z $(git rev-list -n 1 $sha1 --not --all 2>/dev/null) ||
        git fetch ||
        (git cat-file -e $sha1 && git fetch $(get_default_remote) $sha1) ||
        die ...
    )

Oh! Looking at that I suspect the
"test -z $(git rev-list -n 1 $sha1 --not --all 2>/dev/null)"
and "git cat-file -e" are serving the same purpose here and should just
indicate if the given sha1 is present or not.

So we could reduce it further to

    (clear_local_git_env; cd "$sm_path" &&
        git cat-file -e $sha1 || git fetch ||
        (git cat-file -e $sha1 && git fetch $(get_default_remote) $sha1) ||
        die ...
    )

I may have messed up the logic operators along the way, maybe it is
even better if
we rewrite it with non shorted conditions.

Thanks,
Stefan
