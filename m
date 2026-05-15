Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7B176238
	for <git@vger.kernel.org>; Fri, 15 May 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860573; cv=none; b=A/p8CHBBuE7IcRM3t2kdbffz1KlJJcc5BkJ8dyNl3iokyKcfEzFsOq756YwWHlxi5mHSObGNy1aWdIHgwaJ6FzS3z3vdovfOGZyN0EO+CAQISnf7FMka8NpQ2D0N2OeftEM1WUI64cIDug7qbIhoTi99v1Z3kOWJkLYaRPYbajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860573; c=relaxed/simple;
	bh=ZuGz/2QSFEFYVSGCteGSpUQm4li3ygM8kE+/5uvLWEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkH51x1ivwfA6VZ/DQfakOrqksfed/vvVVRVgc9O0s7THtGsPp5vAXNx3hD/pGAgz8Hp8PM1kuibjZ+Lx+StssYlJmbmh05Hd0jtsbt0svrLGgb3DP0/8ZfhrueufB9i2Y0492OktxoDRlWjO4Hr1scl0x4qvt0L7ZtKWC6+zBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4gHBd463fVzRpKv;
	Fri, 15 May 2026 17:56:08 +0200 (CEST)
Message-ID: <cb3012ab-1a97-4197-bc57-34eb3fa472a2@kdbg.org>
Date: Fri, 15 May 2026 17:56:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/11] git-gui: refactor browser / blame argument
 parsing
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-3-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-3-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> git-gui has subcommands blame and browser, both of which accept a
> pathname, possibly preceded by a commit-ish item to specify a revision.
> Also, blame can take a first argument that gives a line number to focus.
> 
> The command line parser for the above is more complex than needed, and
> cannot work without a worktree as the pathname objects are checked
> against the current worktree for existence. This also precludes naming a
> directory or file that does not exist on the currently checked out
> branch.

While the old browser isn't simple, it implements the strategy "revs
before paths, no revs after the first path or '--'" that is applied by
every git command. The rewritten parser is only slightly simpler. It
should not ignore "--". Furthermore, the old parser ignored excessive
trailing arguments, while the new parser ignores excessive leading
arguments. Neither is desirable, and we should report an incorrect
argument list (if we don't, then I prefer the old behavior).

> 
> So, replace this with a simpler parser that looks at argument number and
> number of arguments to know what value to expect. The blame and browser
> backends already have error checking with diagnostic information, so
> defer most error checking to those. Also, allow a line-number selection
> to be given and silently ignored for the browser, further simplifying
> this code.

The line number selection isn't ignored by the browser, but reported as
an incorrect usage before and after this patch.

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 66 +++++++++++++-----------------------------------------
>  1 file changed, 16 insertions(+), 50 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 6048f92..a951fcd 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2986,51 +2986,34 @@ blame {
>  	set head {}
>  	set path {}
>  	set jump_spec {}
> -	set is_path 0
> +	set nargs [llength $argv]
> +	if {$nargs < 1} {
> +		usage
> +	}
> +	set argn 0
>  	foreach a $argv {
> -		set p [file join $_prefix $a]
> +		set argn [expr {$argn + 1}]
>  
> -		if {$is_path || [file exists $p]} {
> -			if {$path ne {}} usage
> -			set path [normalize_relpath $p]
> -			break
> -		} elseif {$a eq {--}} {
> -			if {$path ne {}} {
> -				if {$head ne {}} usage
> -				set head $path
> -				set path {}
> +		if {$argn < $nargs} {
> +			# revision or line number
> +			if {[regexp {^--line=(\d+)$} $a a lnum]} {
> +				set jump_spec [list $lnum]
> +			} else {
> +				set head $a
>  			}
> -			set is_path 1
> -		} elseif {[regexp {^--line=(\d+)$} $a a lnum]} {
> -			if {$jump_spec ne {} || $head ne {}} usage
> -			set jump_spec [list $lnum]
> -		} elseif {$head eq {}} {
> -			if {$head ne {}} usage
> -			set head $a
> -			set is_path 1
> -		} else {
> -			usage
> -		}
> -	}
> -	unset is_path
> -
> -	if {$head ne {} && $path eq {}} {
> -		if {[string index $head 0] eq {/}} {
> -			set path [normalize_relpath $head]
> -			set head {}
>  		} else {
> -			set path [normalize_relpath $_prefix$head]
> -			set head {}
> +			set path [normalize_relpath $a]

This loses the capability to request a browser relative to a
subdirectory of the working tree. For example, "git gui browser main ."
now shows the top-level directory instead of the subdirectory when
invoked from a subdirectory.

>  		}
>  	}
>  
>  	if {$head eq {}} {
>  		load_current_branch
> +		set head $current_branch
>  	} else {
>  		if {[regexp [string map "@@ [expr $hashlength - 1]" {^[0-9a-f]{1,@@}$}] $head]} {
>  			if {[catch {
> -					set head [git rev-parse --verify $head]
> -				} err]} {
> +				set head [git rev-parse --verify $head]
> +			} err]} {

Please leave the indentation unchanged.

>  				if {[tk windowingsystem] eq "win32"} {
>  					tk_messageBox -icon error -title [mc Error] -message $err
>  				} else {
> @@ -3046,26 +3029,9 @@ blame {
>  	switch -- $subcommand {
>  	browser {
>  		if {$jump_spec ne {}} usage
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
>  	blame   {
> -		if {$head eq {} && ![file exists $path]} {
> -			catch {wm withdraw .}
> -			tk_messageBox \
> -				-icon error \
> -				-type ok \
> -				-title [mc "git-gui: fatal error"] \
> -				-message [mc "fatal: cannot stat path %s: No such file or directory" $path]
> -			exit 1
> -		}
>  		blame::new $head $path $jump_spec
>  	}
>  	}

The check for the existence of files is actually necessary to
disambiguate the meaning of the argument. If a file "maint" exists, then
the argument is to be interpreted as path, not as the ref "maint", even
if that exists, too.

I suggest to protect the "file exists" calls with ($_gitworktree ne {}
&& ...) or (![is_bare] && ...) to handle being invoked from a bare
repository. That is, in a bare repository we treat arguments the same as
files that do not exist in the currently checked-out branch.

-- Hannes

