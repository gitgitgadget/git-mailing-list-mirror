Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A2328B71
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178582; cv=none; b=SS7f5qqKFat2S+ruyv5CPVt6WWyrS63RFEsWjf2JlKAx5SHI5tYWkCFiCqyvVJ0V51jjc+xRY07gbLpccJgEcGpJqi7ISaWXVAeQxers0+kiBVhOHXjKVJtoEv3KjrFuugolM7BdS4Cu21M9JqNzSElnbzwB2Bj+YijGJloyN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178582; c=relaxed/simple;
	bh=j0AioWpJ0JYh0Uw7O0s6FRFGSIY2ATk4805Z4UIxkHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2h0MFAPN5oNIFiKpjkb3MlL2sQtO+2lis4g5CcAS1LocMnma85KT8HsBNIerrwjXZbPUxOSG9Elk6iAY7Y6MvKnjbsUVn8PePbKqyxZUh2BXmzy/UlnDzWlhr2UF+2btoQ4RLRxJNmdfgi8DmHxzAmH2YpoJQ6soBi8jkX58Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gKSDW2pmgzRnlZ;
	Tue, 19 May 2026 10:16:11 +0200 (CEST)
Message-ID: <5081fcc5-19b5-49aa-a33c-2c13aba7edb1@kdbg.org>
Date: Tue, 19 May 2026 10:16:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] git-gui: improve worktree discovery
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-11-mlevedahl@gmail.com>
 <8b8feffa-1651-41aa-ac76-d2721d656b45@kdbg.org>
 <f654eab3-2157-4591-9ae0-440efb052e8e@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <f654eab3-2157-4591-9ae0-440efb052e8e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 16.05.26 um 17:28 schrieb Mark Levedahl:
> On 5/16/26 4:16 AM, Johannes Sixt wrote:
>> Am 14.05.26 um 16:33 schrieb Mark Levedahl:
>>> +	if {[is_gitvars_error $err]} {
>>> +		exit 1
>>> +	}
>>> +	set _gitworktree {}
>>> +	set _prefix {}
>>> +	if {[is_enabled bare]} {
>>> +		cd $_gitdir
>> Why change the directory here? If we run `git gui browser master dir` we
>> do not want to change the directory in an uncontrolled manner. The
>> argument parser will want to check for the existence of files, and then
>> we do not want to operate from a random directory.
>>
>> Also, I think that the check must be for [is_bare] and not [is_enabled
>> bare].
> 
> [is_enabled_bare] is correct. This code handles the case: 
>     - neither the startup directory nor GIT_WORK_TREE are useable worktrees, so [is_bare]
> is currently true.
>     - the command given is browser or blame so a worktree is not needed. We can proceed.

But in the case where the command is browser or blame, the argument
parser must later check for the existence of files, provided that a
worktree is present. But this conditional would change directory to
somewhere that is not a worktree at all even though a worktree is
available. So, I am still convinced that [is_bare] is correct.

> The bigger question is whether to change directory at all: git-gui should never touch
> files that are neither in the worktree nor in the repository. Leaving the current
> directory as neither of those could be troublesome. I have no strong feeling here though,
> will delete this.

OK. We need the conditional, but not change the directory.

>>> +	} elseif {![is_parent_worktree]} {
>>> +		catch {wm withdraw .}
>>> +		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" $_gitdir]
>>> +		exit 1
>>> +	}
>>> +}
>>> +
>>> +# repository and worktree config are complete, export them
>>> +set_gitdir_vars
>>>  
>>>  # Use object format as hash algorithm (either "sha1" or "sha256")
>>>  set hashalgorithm [git rev-parse --show-object-format]
>> This moves code around. In particular, we see load_config and
>> apply_config in the context below, which now happens only after these
>> calls. How certain are we that these have no effect on the code that
>> runs now earlier?
> We need to load the system and user global config before running the repository picker. We
> (re-) load the full config including the repository after we have a repository. I think
> this is correct: git-config explicitly lists worktree dependent includeif statements,
> meaning the config can be worktree dependent, and we must not load the final config until
> repository and worktree discovery are complete.

Good point.

> 
> git rev-parse, etc., perform discovery and config file loading each time they are invoked,
> those are unaffected by git-gui's internal config.

Also very true. Only calls to proc get_config would be affected by a
different setup, but there are none in the code that has swapped places
with working tree discovery. Only --show-object-format would be affected
by the discovered environment, and for that case it is more correct to
operate in the final setup.

-- Hannes

