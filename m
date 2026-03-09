Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0E79DA
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 01:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773019879; cv=none; b=T5jN6zvz6jjBlimIp+CSuRsWbdm7lzx3DVuukKkphY8R7GZJ6BVgR6EK+iuHCqsPtREP+Pdv46Wqqc99A0w8tb7Z6dd/NzhsdXBfIdmnXMoCmvtdCN85bLIqCIKkmFWiXM2WwUEC4qCpkSy/Gg6kMvVNrl8saKPM0KPJd0phhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773019879; c=relaxed/simple;
	bh=y08WYBl6xf3H8PO3JXGnm946cMqwBtG65SnL3ag7rh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSbuMsZ+wcCt++7Sh8JMOknv+a4HYCthFG4RA9TLvC69xKOgbqJAH+68E90nN7dDpM3va/HSg8tjwLs3LwygUAOSjQSXR9Im941sdM50Vb684tt2Y6qI3nZNzaIBgoKcbTYRON4/UJ9VHKIB9qhdGEgimOkkp2uyB80Zxkus7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGZS8yCG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGZS8yCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84941C116C6;
	Mon,  9 Mar 2026 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773019878;
	bh=y08WYBl6xf3H8PO3JXGnm946cMqwBtG65SnL3ag7rh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGZS8yCGZduCH/UB5fbg5a3BvcAfPRsMVsojs4xt+adYBMAyAsHYPu5vKv6K6zO/c
	 wVjT95Uyulnw7UeEqwjKeBlovSu5Ax/9wlpmwRHngYVYyRClEvBQlnOunCPWGo/EKI
	 0+R0KTQPs2CtUGRhfpSEKtaao8bQbY6/rNUqVKJlCUnBmGOyJQNPKzGOiQ2wptJGO1
	 Nj9ZVAz5iSdqkTU+2fSN4NuHGDfFJ7Tc+sAFtuPedtssFfgHyIr3btmF8mK1A++7tr
	 oPTRWBMWKwnxIfL+OB/r2oBKn4szP+cSjvqRy7vWZZR0BB/tS7gXjjGcenzToYKrwj
	 KXLHTHlVeBvXA==
Date: Sun, 8 Mar 2026 21:31:17 -0400
From: Sasha Levin <sashal@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] quiltimport: fix backslash expansion in patch subjects
Message-ID: <aa4i5TDt7uPYw9Jq@laps>
References: <20260308165531.40655-1-sashal@kernel.org>
 <xmqqa4wh96qr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqa4wh96qr.fsf@gitster.g>

On Sun, Mar 08, 2026 at 05:38:52PM -0700, Junio C Hamano wrote:
>Sasha Levin <sashal@kernel.org> writes:
>
>> echo interprets backslash sequences, so a patch with "\0" in its
>
>"Some implementations of echo"; I think it is in XSI but the
>plain vanilla POSIX makes it "implementation-defined".

I had to Google this one :)

I'll reword to "Some implementations of echo (notably dash) interpret backslash
sequences by default; POSIX leaves this behavior implementation-defined."

>> subject has that expanded into a NUL byte, which git commit-tree
>> rejects.
>>
>> Use printf '%s\n' instead, which doesn't interpret the string.
>>
>> Also quote $tmp_dir to handle paths with spaces.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  git-quiltimport.sh | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
>> index eb34cda409..38302d28c9 100755
>> --- a/git-quiltimport.sh
>> +++ b/git-quiltimport.sh
>> @@ -79,7 +79,7 @@ tmp_info="$tmp_dir/info"
>>  # Find the initial commit
>>  commit=$(git rev-parse HEAD)
>>
>> -mkdir $tmp_dir || exit 2
>> +mkdir "$tmp_dir" || exit 2
>>  while read patch_name level garbage <&3
>>  do
>>  	case "$patch_name" in ''|'#'*) continue;; esac
>> @@ -101,7 +101,7 @@ do
>>  		echo "$patch_name doesn't exist. Skipping."
>>  		continue
>>  	fi
>> -	echo $patch_name
>> +	printf '%s\n' "$patch_name"
>
>Unquoted "$patch_name" in the original fed to "echo" is doing more
>than just backslash 0.
>
>    patch_name="My   casual patch"
>
>would be split into three tokens, runs of multiple spaces in the
>original will be squashed into one, and "My casual patch" would have
>been the result, which people may have appreciated as cleaning up a
>sloppy original patch title.
>
>The updated version will give completely different result, losing
>the "cleaning up" feature and parrotting the garbage input to
>garbage output.
>
>So I am not 100% convinced that this change would not result in
>robbing Peter to pay Paul.

patch_name is read from the series file via:

     while read patch_name level garbage <&3

Since read splits on IFS, patch_name only ever gets the first
whitespace delimited token. So in the normal case it can never
contain internal whitespace, and the word splitting in echo is a
noop:

     $ printf 'my-patch.patch -p1\n' |
       while read name level garbage; do
         echo "name=[$name]"
       done
     name=[my-patch.patch]

The only way patch_name gets internal spaces is if the series file
uses "\ " escaping, but in that case the spaces should be (??)
intentional.

>Likewise for the next hunk.

Same reasoning applies to the SUBJECT fallback, I think...

     SUBJECT=$(echo $patch_name | sed -e 's/.patch$//')

patch_name is still the same single token from read. And the old path was
already quoted:

     echo "$SUBJECT"

So the only issue there was backslash interpretation, rather than splitting?
similar to 47be066026 ("rebase -i: do not "echo" random user-supplied
strings")?

I need a beer.

-- 
Thanks,
Sasha
