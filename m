Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829E265623
	for <git@vger.kernel.org>; Sun, 24 May 2026 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779606044; cv=none; b=hL/r3PgiFtwVOyt9zX6tqOj0EcarG0sOeHFEysxeDvRbnWjWlaudYpojiT5BcHI96GCBOcG+3X8Sk7bL709/a1qvTcpnSUrt5Wrlv+RTWEpUXt7hif26ij6ix1hMP38SElJ4nf29ufffYSUPHcXHGiDOCpq8M7W80uqfMPY5Po0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779606044; c=relaxed/simple;
	bh=uGJu45hnTcADybiwVTTrh0XJ3tvPqCg64YznY4D7VH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLvjG+D3PoIrqMy55hZgvF2OtQkeHZrnFppKffQp9j+0Iw65DXo0t0nqEdhA0oz0TrkcW/e4IGB3rUki6oT5XjLzHI//0R2GmYw2t7ZO9Upp5DA3L5j30V7nCJAYY7DDm4etmsujAEYV8ii8VtFLUp1sSCz/Qiiio2ygw5nWp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gNVJv166GzRnmQ;
	Sun, 24 May 2026 09:00:31 +0200 (CEST)
Message-ID: <03385a9e-bc94-4096-8fa5-7b8298269230@kdbg.org>
Date: Sun, 24 May 2026 09:00:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] git-gui: add gui and pick as explicit
 subcommands
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-12-mlevedahl@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-12-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:24 schrieb Mark Levedahl:
> git-gui accepts subcommands blame | browser | citool, and assumes the
> subcommand is 'gui' if none is actually given, But, git-gui also has a
> repository picker (choose_repository::pick) that can create a new
> repository + worktree, or choose an existing one, switch to that, and
> the run the gui. The user has no direct control over invoking the
> picker, instead the picker is triggered by failure in the repository /
> worktree discovery process: this includes being started in a directory
> not controlled by git, which is probably the intended use case.
> 
> The picker can appear when the user has no intention of creating a new
> worktree, and the user cannot use the picker to create a new worktree
> inside another.
> 
> So, add two explicit subcommands:
>     gui  - Run the gui if repository/worktree discovery succeeds, or die
>            with an error message, but never run the picker.
>     pick - First run the picker, regardless, then start the gui in
>            the chosen worktree.
> 
> Nothing in this changes the prior behavior, the alternates above must be
> explicitly selected to see any change.

Good.

> @@ -1174,7 +1184,7 @@ proc unset_gitdir_vars {} {
>  
>  # find repository.
>  set _gitdir {}
> -if {$_gitdir eq {}} {
> +if {[is_enabled gitdir_discovery]} {

This makes a factually unconditional branch into a conditional one.

>  	if {[catch {
>  		set _gitdir [git rev-parse --absolute-git-dir]
>  	} err]} {
> @@ -1186,7 +1196,7 @@ if {$_gitdir eq {}} {
>  }
>  
>  set picked 0
> -if {$_gitdir eq {}} {
> +if {$_gitdir eq {} && [is_enabled picker]} {
>  	unset_gitdir_vars
>  	load_config 1
>  	apply_config
> @@ -1202,6 +1212,12 @@ if {$_gitdir eq {}} {
>  	set picked 1
>  }
>  
> +if {$_gitdir eq {}} {
> +	catch {wm withdraw .}
> +	error_popup [strcat [mc "Git directory not found:"] "\n\n$err"]

I wondered where this $err is filled in, and it can only be the error
from a failed gitdir discovery. Good.

> +	exit 1
> +}
> +
>  # find worktree, continue without if not required
>  if {[catch {
>  	set _gitworktree [git rev-parse --show-toplevel]
This looks good!

-- Hannes

