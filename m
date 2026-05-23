Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41DF5B1EB
	for <git@vger.kernel.org>; Sat, 23 May 2026 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779523311; cv=none; b=Ko/PdZ54F+KXbmUYcP+RJZZdhCp33kWq6fAUWZ6ydKz93ttgSBrU+MvpsC/25aV2VkZ+KZCLp4ixPvWX59kqg3XcAP2j+3ipxKS++SGF4nbmXxxwNVK7c3iN/zzfrACgDenGcSeTegqHv89NE2recJOVFeSNs59oqHHL97Bp8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779523311; c=relaxed/simple;
	bh=PurIBlpP/jcmktq38oTQez0RqpUKzZqJmRzllLrUwJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuKcA1OrtMZXAXL9nH8FEeYI3mCrMawOyoIxU5LqrwmESiiON6G60EpeIT4mcOekGdUUGjty3xcxp0DFopWUre1cqPUjZcvE57eSp0X/7aWItUfFt9Ep2GaIHfk1paWf/iz0+Sg5n+t+N1nGxl8JnyualOXVtR0St7gYHRoJWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gMvjx0nF4zRpKp;
	Sat, 23 May 2026 10:01:40 +0200 (CEST)
Message-ID: <c8d1ab1e-e0cb-44e2-afcd-728b7b43774c@kdbg.org>
Date: Sat, 23 May 2026 10:01:40 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] git-gui: try harder to find worktree from gitdir
To: Shroom Moo <egg_mushroomcow@foxmail.com>
Cc: git@vger.kernel.org, Aina Boot <bootaina702@gmail.com>,
 Mark Levedahl <mlevedahl@gmail.com>
References: <tencent_E13EB585242AD7C263B8B3B732A428465D09@qq.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <tencent_E13EB585242AD7C263B8B3B732A428465D09@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.05.26 um 06:55 schrieb Shroom Moo:
> On 5/21/26 4:24 AM, Mark Levedahl wrote:
>> +	} elseif [file exists {gitdir}] {
>> +		if {[catch {
>> +			set fd_gitdir [open {gitdir} {r}]
>> +			set gitlink_parent [file dirname [read $fd_gitdir]]
>> +			catch {close $fd_gitdir}
>> +			set worktree [git -C $gitlink_parent rev-parse --show-toplevel]
>> +			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
>> +			if {$::_gitdir ne $parent_gitdir} {
>> +				set worktree {}
>> +			}
>> +		}]} {
>> +			catch {close $fd_gitdir}
>> +			set worktree {}
>> +		}
>> +	}

> Additionally, [file exists {gitdir}] checks for the gitdir file in 
> the current working directory. Since the function has not yet 
> switched to $_gitdir when this check runs, it is almost impossible 
> to find the file. Consequently, this logic never triggers, preventing 
> linked worktrees from being recognized. 

I think you are misunderstanding which use-case this code is addressing.
The case can be triggered very easily.

First, the code before the part we see above is intended for the special
case where we start in a .git, where `--show-toplevel` bails out and we
define the worktree to be the directory containing .git.

However, if we start in .git/worktrees/feature, then the code cited
above kicks in, because `--show-toplevel` still bails out,
`--absolute-git-dir` does not end in '.git', but now we have a file
named 'gitdir' in the current directory. In this case, we define (and
this is new with this patch) that the worktree is the one where the
'gitdir' points.

-- Hannes

