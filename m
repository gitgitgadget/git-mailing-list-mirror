Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E781A6831
	for <git@vger.kernel.org>; Fri, 22 May 2026 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437941; cv=none; b=mC+Ni+T3x8c7Hi26UjHqQd0sgT3pImlhTGLktdqI4jLZoNrm0rH/JdOhD3qifN836aIsTyECfM8Y9I8ygmqmdWTWni54nkBm7aHRDteMtRb+e/97TK2SgPd8pes2VbRp5g0GRwztjK+BxacSnGMOvNHZNdW82NXzLaTFIIbTXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437941; c=relaxed/simple;
	bh=4KHG1sB9tvGyRCzz7Gpyl6tgUJYOVC20nXhxV4POClQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stRyrOlkCaGx0Ac5ZSQTiM8P4Jwt5K2gq7w65z1746ska87BOpyQFmSSjMikJ38ZQ7y/E8Dv5UK/K1fg+BmgHytHeIE59hahEPNmEJqtfnN/s4sdHma9UvSqSQFe0PQwC4fQB51lNZcfQNKNSFcWkQSlj8jMhq2JPM9yFHfn83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4gMJ8H2NQLzRpL0;
	Fri, 22 May 2026 10:18:55 +0200 (CEST)
Message-ID: <fdf7aa5c-51ba-4e21-8e4a-5c1fdd8336ab@kdbg.org>
Date: Fri, 22 May 2026 10:18:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] git-gui: return status from
 choose_repository::pick
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-3-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-3-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:24 schrieb Mark Levedahl:
> The repository picker (choose_repository::pick) on success always
> returns with the current directory at the root of the selected worktree,
> and with the global variable _gitdir holding the name of the git
> repository, possibly as a relative path. On failure, _gitdir = {}. If
> the selection was from the "recent" list, no validation has occurred.
> 
> There are too many side effects in this interface. Note that the picker
> only supports worktrees with a .git entry in the worktree root, so git
> repository and worktree discovery will work starting in the current
> directory on return. So, let's change pick to return a 0/1 value, 1
> meaning a worktreee + repo was selected and the current directory is the
> worktree root, and leave validation and setting of _gitdir,
> _gitworktree, and _prefix to the caller.

While the removal of side-effects from the picker is very much desired,
the new return value sounds over-engineered at this point, in particular
due to this note:

> Note: pick actually does not
> return if something was not selected, rather it terminates git-gui.
> But, let's pretend at the call site that pick returns 0/false instead.

If we need the return value later, let's postpone that part of this
commit until then.

> diff --git a/git-gui.sh b/git-gui.sh
> index 4ba25da7b6..4a736190a9 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1151,10 +1151,16 @@ if {[catch {
>  	} err]} {
>  	load_config 1
>  	apply_config
> -	choose_repository::pick
> -	if {![file isdirectory $_gitdir]} {
> +	if {![choose_repository::pick]} {
>  		exit 1
>  	}
> +	if {[catch {
> +		set _gitdir [git rev-parse --git-dir]
> +	} err]} {
> +		catch {wm withdraw .}
> +		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] "\n\n$err"]

There's something wrong with the quotes here, and an 'exit 1' is missing.

> +	}
> +	set _prefix {}
>  	set picked 1
>  }
-- Hannes

