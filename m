Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902A183CC3
	for <git@vger.kernel.org>; Sat, 23 May 2026 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779568304; cv=none; b=k4kggIQhREhuYKGS28YFKCV55Gg415lnIe15CJ1bzkiE1kFu1fXOKNXCQs7cTdvM2duqJhHhn6UU2A9N1WaJt/86VVf6C/qiianVHZCf2JOWGX8LxdglS7uDJRvFj0a4T9S3ny3bVvSI4g5Vkx7DkNldNg9Co8H7XeVlJKmWwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779568304; c=relaxed/simple;
	bh=stI0eeIho88EiXuhLHuouRsxlms7GNf+/Pcnm6qDOIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRhh+fEMGp6ALMqCId6DolOROXog60aiV9IrK9bK06zwGhF3wI+YxPpzl1kHqMIAU5d5Xxz8SQbWtwLxfZtXDHUHE2dmERsrbJKTL27fKkCY9qZiVV+BaciF3V6yxk5RekfNduTVSEHl6XWN90t6y90DS2cU/gM3N4bwU9A2dhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4gNDMF5gRQzRnlt;
	Sat, 23 May 2026 22:31:37 +0200 (CEST)
Message-ID: <8b4e8b73-eb2c-41bb-9653-08e38fedd434@kdbg.org>
Date: Sat, 23 May 2026 22:31:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] git-gui: adapt blame/browser parsing for bare
 operation
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-11-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-11-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:24 schrieb Mark Levedahl:
> git-gui's blame and browser subcommands do not work with bare
> repositories, but they should per commit c52c94524b ("git-gui: Allow
> blame/browser subcommands on bare repositories", 2007-07-17). Assuming
> that commit worked, something changed since reintroducing a hard-coded
> dependency upon a worktree.
> 
> The basic issue goes back to 3e45ee1ef2 ("git-gui: Smarter command line
> parsing for browser, blame", 2007-05-08), which seeks to implement
> command line parsing similar to git blame. That commit introduces
> depencies upon the worktree to decide which argument is rev or path.
> 
> Looking at builtin/blame.c in git around line 1120:
> 
> 	 * (1) if dashdash_pos != 0, it is either
> 	 *     "blame [revisions] -- <path>" or
> 	 *     "blame -- <path> <rev>"
> 	 *
> 	 * (2) otherwise, it is one of the two:
> 	 *     "blame [revisions] <path>"
> 	 *     "blame <path> <rev>"
> 
> shows the clear intent: rev and path may be swapped in input so both
> meanings must be tried, but -- may be used to designate which is the
> path forcing or precluding trying the swapped arguments.

Please do not use this code comment as recipe for our own argument
parseing. In particular, that <path> can occur for <rev> goes back to
the initial implementation of git pickaxe in cee7f245dcae ("git-pickaxe:
blame rewritten.", 2006-10-19). Since acca687fa9db ("git-pickaxe: retire
pickaxe", 2006-11-08), the documentation of git-blame states that <file>
is always last (but the implementation was not adjusted accordingly).

In general, Git's argument parsing requires revisions before pathspec.
To disambiguate, '--' can be used. If it is not used, arguments are
check whether they are files or refs, and as soon as one argument is
identified as file unambiguously, all later arguments must also be files.

We should follow this pattern, and to do that, we could just delegate
argument processing to `git rev-parse`.

> 
> With a worktree, git gui correctly swaps the arguments if the given path
> exists in the worktree. git blame does this using the git repository.
> But, git-gui sometimes interprets the -- to have an exactly opposite
> meaning:
> 
>     git blame       Makefile gitgui-0.19.0       works
>     git gui blame   Makefile gitgui-0.19.0       works

Git gui shows something, but ignores the ref, so doesn't quite work.

> 
>     git blame       -- Makefile gitgui-0.19.0    works
>     git gui blame   -- Makefile gitgui-0.19.0    works

Ditto.

> 
>     git blame       Makefile -- gitgui-0.19.0    fails (correctly)
>     git gui blame   Makefile -- gitgui-0.19.0    works (should fail)

Ditto.

> 
>     git blame       gitgui-0.19.0 -- Makefile    works (correctly)
>     git gui blame   gitgui-0.19.0 -- Makefile    fails (should work)

Yes, there's a bug in the argument parser that -- isn't skipped, but
treated as the file name.

> 
> It is possible to patch the code to operate without a worktree, but this
> will make the commands operate differently with and without a worktree,
> won't fix the parsing issues above, and won't address the issues that
> can arise when using a worktree to help decisions on a different rev
> with file/directory conflicts, etc.

Before this patch 'git gui blame' can show contents uncommitted changes,
but with this patch this isn't possible. I see you have just sent a
patch that may fix this, but I havn't looked at it, yet.

> 
> So, let's rework the parser so that it uses -- as does git blame, and
> uses git ls-tree to query the given revision for existence and type of
> path rather than basing this upon a possibly unrelated worktree. Also,
> abort early when the given path is not found, or does not match the need
> (file or directory). This fixes some current cases where git-gui will
> open a window with no content, possibly also with an error message.

There is no desire to make 'git gui blame' work the same with and
without a working tree.

If we invoke git to help argument parsing, then it should be
'rev-parse', not 'ls-tree'.

> 
> This does not change whether or how git-gui uses staged and unstaged
> content in the current worktree for blame display.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---

>  	wm deiconify .
>  	switch -- $subcommand {
>  	browser {
> -		if {$jump_spec ne {}} usage

Let's keep this line, which diagnoses an incorrect --line= argument.

> -		if {$head eq {}} {
> -			if {$path ne {} && [file isdirectory $path]} {
> -				set head $current_branch
> -			} else {
> -				set head $path
> -				set path {}
> -			}
> -		}
>  		browser::new $head $path
>  	}
> -	blame   {
> -		if {$head eq {} && ![file exists $path]} {
> -			catch {wm withdraw .}
> -			tk_messageBox \
> -				-icon error \
> -				-type ok \
> -				-title [mc "git-gui: fatal error"] \
> -				-message [mc "fatal: cannot stat path %s: No such file or directory" $path]
> -			exit 1
> -		}
> +	blame {
>  		blame::new $head $path $jump_spec
>  	}
>  	}

-- Hannes

