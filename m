Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078835BDBE
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773013283; cv=none; b=FNhtLPIfqtecrSXB9mrBequyL7RPMiZrzzE9DCy33sB/e0WM9QUyj0RtRVHDn4vkKoW6k8xXG5OYh+h9m4o+Hv6a3XyQoS1pl/7tg9tbghHRwpHN1Np2CcvngKD+ztFptaDmiV4juKSIgh/8vDfkruPf23rZulcmjlzypnma+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773013283; c=relaxed/simple;
	bh=LBS3HFtjqRcl0TWRuKQVJn6XzNHlVIHsm0YFQYT+qd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlUJQu9+MQLcN+LxVSLWwRmqLXDxnjt4Eo5qAne0mbLzM29btYqhgiR7DDT5O+LiBhomUcSZReVAZ3LRKJkuIiRX6XU4HWgp0reHnUTH4dYXgI3+WnYHSEBTyWX9RGPCIn7+nWXVneAzfU2KWZE4PCksIqVwj1i24S6+hdvETcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBkIo+S1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBkIo+S1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975C4C116C6;
	Sun,  8 Mar 2026 23:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773013282;
	bh=LBS3HFtjqRcl0TWRuKQVJn6XzNHlVIHsm0YFQYT+qd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBkIo+S1DKQmcYMvptle4zL8fkwOczW+npRKsGWIzZgvSNlPG79RQF1NJEhuf4ECS
	 n69EPWgRdIhQGdAEv3iGGBDdEV3SgLER8Z5nmlqCrZ5wfDI//HheBsDJflCxRRgk1s
	 jvtVwbTj/V/9085KrShM2I+pn2kz4fxtHz6IjxGYliw4L61gEN/8BJSUtYUmC5WQB0
	 +wBxEaMgAzs4GlZBQDAr+L0cx6YnGDJbxk8Hl02wcGOwtI8jC5eJNIpEYd4m+mKLzW
	 dCYiwFwm5AGC86x/gsaoRyo3cQGYC1nmBMBg7/VACZfxbzmEaMZwO63MDdr49oqs49
	 tU/3MQtVqEIOQ==
Date: Sun, 8 Mar 2026 19:41:21 -0400
From: Sasha Levin <sashal@kernel.org>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] quiltimport: fix backslash expansion in patch subjects
Message-ID: <aa4JIWrkgNAPnXA5@laps>
References: <20260308165531.40655-1-sashal@kernel.org>
 <92EC21F4-52E1-4FE8-A1B8-5878D6CC654C@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92EC21F4-52E1-4FE8-A1B8-5878D6CC654C@gmail.com>

Thanks for the review Ben! I'll send a v2 based on your review.

More explanation below:

On Sun, Mar 08, 2026 at 04:56:57PM -0400, Ben Knoble wrote:
>> Le 8 mars 2026 à 13:01, Sasha Levin <sashal@kernel.org> a écrit :
>>
>> ﻿echo interprets backslash sequences, so a patch with "\0" in its
>> subject has that expanded into a NUL byte, which git commit-tree
>> rejects.
>
>Echo _shouldn’t_ do that without flags like -e depending on your implementation, but I wouldn’t put it past echo ;) hence my preference for printf in scripts.

Right, this is just dash being "funny" and interprets backslash sequences in
echo by default.

sasha@laps:~$ dash -c 'echo "hello \0 world"' | xxd
00000000: 6865 6c6c 6f20 0020 776f 726c 640a       hello . world.
sasha@laps:~$ bash -c 'echo "hello \0 world"' | xxd
00000000: 6865 6c6c 6f20 5c30 2077 6f72 6c64 0a    hello \0 world.

>More interestingly, though: do the patch-names or subjects being adjusted below contain such a sequence? They look like user input, so possibly (and we can’t be sure they don’t).

Yes, this was hit in practice. A patch in the Linux kernel stable queue was
titled "selftests: tc_actions: don't dump 2MB of \0 to stdout". The literal \0
in the subject caused git-quiltimport to abort mid-import under dash.

>It might be nice to say more about what “rejects” means (errors confusingly? Truncates user input?), but otherwise I expect this is reasonable.

commit_tree_extended() in commit.c does:

     if (memchr(msg, '\0', msg_len))
         return error("a NUL byte in commit log message not allowed.");

So commit-tree errors out, which triggers the "|| exit 4" in the script and
aborts the entire quiltimport. Everything after the offending patch in the
series is silently lost. I'll add it to the commit message.

>> Use printf '%s\n' instead, which doesn't interpret the string.
>>
>> Also quote $tmp_dir to handle paths with spaces.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>> git-quiltimport.sh | 10 +++++-----
>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
>> index eb34cda409..38302d28c9 100755
>> --- a/git-quiltimport.sh
>> +++ b/git-quiltimport.sh
>> @@ -79,7 +79,7 @@ tmp_info="$tmp_dir/info"
>> # Find the initial commit
>> commit=$(git rev-parse HEAD)
>>
>> -mkdir $tmp_dir || exit 2
>> +mkdir "$tmp_dir" || exit 2
>
>We prefer to leave such “while at it” changes in separate patches, so perhaps a preliminary cleanup “quote variable expansions to handle whitespace” or some such step would help?
>
>(I didn’t look past the context to see if tmp_dir may have whitespace or shell meta characters.)

Will do: I'll split the $tmp_dir quoting into a preliminary cleanup patch.

>> while read patch_name level garbage <&3
>> do
>>    case "$patch_name" in ''|'#'*) continue;; esac
>> @@ -101,7 +101,7 @@ do
>>        echo "$patch_name doesn't exist. Skipping."
>>        continue
>>    fi
>> -    echo $patch_name
>> +    printf '%s\n' "$patch_name"
>
>Does this go to commit-tree? Or just protecting the output for the user’s terminal?

Just terminal output. It doesn't feed into commit-tree, but under dash a patch
name with backslash sequences would still produce garbled output, so worth
fixing alongside.

>>    git mailinfo $MAILINFO_OPT "$tmp_msg" "$tmp_patch" \
>>        <"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
>>    test -s "$tmp_patch" || {
>> @@ -142,14 +142,14 @@ do
>>    SUBJECT=$(sed -ne 's/Subject: //p' "$tmp_info")
>>    export GIT_AUTHOR_DATE SUBJECT
>>    if [ -z "$SUBJECT" ] ; then
>> -        SUBJECT=$(echo $patch_name | sed -e 's/.patch$//')
>> +        SUBJECT=$(printf '%s' "$patch_name" | sed -e 's/.patch$//')
>
>Interesting. I think POSIX sh  supports the ${x#suffix} expansion, which could avoid sed. I think it unlikely the “.” in the RE is intended to match any character rather than a literal dot. But should be done a separate patch and could be left for another series if you wanted (assuming my memory of supported expansions is correct).
>
>Importantly, this does get fed to commit-tree below…

Good catch! ${patch_name%.patch} is POSIX and already used throughout git's
shell scripts.

>>    fi
>>
>>    if [ -z "$dry_run" ] ; then
>>        git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
>>        tree=$(git write-tree) &&
>> -        commit=$( { echo "$SUBJECT"; echo; cat "$tmp_msg"; } | git commit-tree $tree -p $commit) &&
>> +        commit=$( { printf '%s\n' "$SUBJECT"; echo; cat "$tmp_msg"; } | git commit-tree $tree -p $commit) &&
>>        git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
>>    fi
>
>… so may need protected as described. Neat.
>
>> done 3<"$QUILT_SERIES"
>> -rm -rf $tmp_dir || exit 5
>> +rm -rf "$tmp_dir" || exit 5
>
>Ditto for cleanup.

ack!

-- 
Thanks,
Sasha
