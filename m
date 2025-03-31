Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B726AF6
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743441144; cv=none; b=n2ShLVn4pPlPHG3dvaymSFnDW9NJ5lJnwPv5G6zS2LtSz9ji3K+ox+eSFP06C4f+Eh/QOU3hGZpaFPOh3NQINCPbgKxytwSgBna48LOPVEbnLD1P9+grSBvHN8/TbIbtWBgzlcsngEf+VRmYFBStdUkEWQ+lQGIwN9NkY/oxjqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743441144; c=relaxed/simple;
	bh=dmlbIDF8WT9oe96ajE4sfvui5D/9sxl1lBNepfn7DOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpJIpsxWPMvtKlR7KM/AXEwiFc4RBQQ68MzFNfnn5S4V8xHA2+0G2ZjsYWZ4166IN0a8mEt9FAPAuyJFiJsaf5Q1z7GM+dvGEQn2+9t6DRqYT2HyqoGadvs0uVzv38Ik61DAXStvtFNfscpX1YKkhoNVDFtKgYGXfeOE6mTs7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4ZRHk7207YzRnlK;
	Mon, 31 Mar 2025 19:12:15 +0200 (CEST)
Message-ID: <58556f57-698d-4f58-bbcf-c752cba00ff7@kdbg.org>
Date: Mon, 31 Mar 2025 19:12:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk - override $PATH search only on Windows
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
References: <53c31331-97ed-48be-8399-2701581b09a9@gmail.com>
 <20250331151213.274691-1-mlevedahl@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250331151213.274691-1-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 31.03.25 um 17:12 schrieb Mark Levedahl:
> Commit 4cbe9e0e2 was written to address problems that result from Tcl's
> documented behavior on Windows where the current working directory and a
> number of Windows system directories are automatically prepended to
> $PATH when searching for executables [1].  This basic Windows behavior
> has resulted in more than one CVE against git for Windows:
> CVE-2023-23618, CVE-2022-41953 are listed on the git for Windows github
> website for the Tcl components of git (gitk, git-gui).
> 
> 4cbe9e0e2 is intended to restrict the search to looking only in
> directories given in $PATH and in the given order, which is exactly the
> Tcl behavior documented to exist on non-Windows platforms [1]. Thus,
> this change could have been written to affect only Windows, leaving
> other platforms alone.
> 
> However, 4cbe9e0e2 implements the override for all platforms.  and
> includes specialized code for Cygwin, copied copied from git-gui prior
> to commit 6d2f9d90 on https://github.com/j6t/git-gui.git), so targets a

I can't find 6d2f9d90 anywhere. Do you have a URL?

> long retired Cygwin port of the Windows Tcl/Tk using Windows pathnames.
> Since 2012, Cygwin uses a Unix/X11 port requiring Unix pathnames,
> meaning 4cbe9e0e2 is incompatible. The patch also induces an infinite
> recursion as _which now invokes the exec wrapper that invokes _which.
> As this is part of git v2.49.0, gitk on Cygwin is broken in that
> release.
> 
> Rather than fix the unnecessary override code for Cygwin, let's just
> limit the override of exec/open to Windows, leaving all other platforms
> using their native exec/open as they did prior to 4cbe9e0e2. This patch
> wraps the override code in an "if {[is_Windows]} { ... }" block while
> removing the non-Windows code added in 4cbe9e0e2.
> 
> [1] see https://www.tcl-lang.org/man/tcl8.6/TclCmd/exec.htm

Thanks, nicely summarized.

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  gitk | 146 ++++++++++++++++++++++++-----------------------------------
>  1 file changed, 58 insertions(+), 88 deletions(-)
> 
> diff --git a/gitk b/gitk
> index bc9efa1..a101b07 100755
> --- a/gitk
> +++ b/gitk
> @@ -13,13 +13,6 @@ package require Tk
>  ##
>  ## Enabling platform-specific code paths
>  
> -proc is_MacOSX {} {
> -	if {[tk windowingsystem] eq {aqua}} {
> -		return 1
> -	}
> -	return 0
> -}
> -
>  proc is_Windows {} {
>  	if {$::tcl_platform(platform) eq {windows}} {
>  		return 1
> @@ -27,36 +20,16 @@ proc is_Windows {} {
>  	return 0
>  }
>  
> -set _iscygwin {}
> -proc is_Cygwin {} {
> -	global _iscygwin
> -	if {$_iscygwin eq {}} {
> -		if {[string match "CYGWIN_*" $::tcl_platform(os)]} {
> -			set _iscygwin 1
> -		} else {
> -			set _iscygwin 0
> -		}
> -	}
> -	return $_iscygwin
> -}
> -
>  ######################################################################
>  ##
>  ## PATH lookup
>  
> -set _search_path {}
> -proc _which {what args} {
> -	global env _search_exe _search_path
> -
> -	if {$_search_path eq {}} {
> -		if {[is_Cygwin] && [regexp {^(/|\.:)} $env(PATH)]} {
> -			set _search_path [split [exec cygpath \
> -				--windows \
> -				--path \
> -				--absolute \
> -				$env(PATH)] {;}]
> -			set _search_exe .exe
> -		} elseif {[is_Windows]} {
> +if {[is_Windows]} {
> +	set _search_path {}
> +	proc _which {what args} {
> +		global env _search_exe _search_path
> +
> +		if {$_search_path eq {}} {
>  			set gitguidir [file dirname [info script]]
>  			regsub -all ";" $gitguidir "\\;" gitguidir
>  			set env(PATH) "$gitguidir;$env(PATH)"
> @@ -65,81 +38,78 @@ proc _which {what args} {
>  			set _search_path [lsearch -all -inline -not -exact \
>  				$_search_path ""]
>  			set _search_exe .exe
> -		} else {
> -			set _search_path [split $env(PATH) :]
> -			set _search_exe {}
>  		}
> -	}
>  
> -	if {[is_Windows] && [lsearch -exact $args -script] >= 0} {
> -		set suffix {}
> -	} else {
> -		set suffix $_search_exe
> -	}
> +		if {[lsearch -exact $args -script] >= 0} {
> +			set suffix {}
> +		} else {
> +			set suffix $_search_exe
> +		}

Now that this code is only about Windows, _search_exe is always ".exe".
It would be great if we could remove it as well.

>  
> -	foreach p $_search_path {
> -		set p [file join $p $what$suffix]
> -		if {[file exists $p]} {
> -			return [file normalize $p]
> +		foreach p $_search_path {
> +			set p [file join $p $what$suffix]
> +			if {[file exists $p]} {
> +				return [file normalize $p]
> +			}
>  		}
> +		return {}
>  	}
> -	return {}
> -}
>  
> -proc sanitize_command_line {command_line from_index} {
> -	set i $from_index
> -	while {$i < [llength $command_line]} {
> -		set cmd [lindex $command_line $i]
> -		if {[file pathtype $cmd] ne "absolute"} {
> -			set fullpath [_which $cmd]
> -			if {$fullpath eq ""} {
> -				throw {NOT-FOUND} "$cmd not found in PATH"
> +	proc sanitize_command_line {command_line from_index} {
> +		set i $from_index
> +		while {$i < [llength $command_line]} {
> +			set cmd [lindex $command_line $i]
> +			if {[file pathtype $cmd] ne "absolute"} {
> +				set fullpath [_which $cmd]
> +				if {$fullpath eq ""} {
> +					throw {NOT-FOUND} "$cmd not found in PATH"
> +				}
> +				lset command_line $i $fullpath
>  			}
> -			lset command_line $i $fullpath
> -		}
>  
> -		# handle piped commands, e.g. `exec A | B`
> -		for {incr i} {$i < [llength $command_line]} {incr i} {
> -			if {[lindex $command_line $i] eq "|"} {
> -				incr i
> -				break
> +			# handle piped commands, e.g. `exec A | B`
> +			for {incr i} {$i < [llength $command_line]} {incr i} {
> +				if {[lindex $command_line $i] eq "|"} {
> +					incr i
> +					break
> +				}
>  			}
>  		}
> +		return $command_line
>  	}
> -	return $command_line
> -}
>  
> -# Override `exec` to avoid unsafe PATH lookup
> +	# Override `exec` to avoid unsafe PATH lookup
>  
> -rename exec real_exec
> +	rename exec real_exec
>  
> -proc exec {args} {
> -	# skip options
> -	for {set i 0} {$i < [llength $args]} {incr i} {
> -		set arg [lindex $args $i]
> -		if {$arg eq "--"} {
> -			incr i
> -			break
> -		}
> -		if {[string range $arg 0 0] ne "-"} {
> -			break
> +	proc exec {args} {
> +		# skip options
> +		for {set i 0} {$i < [llength $args]} {incr i} {
> +			set arg [lindex $args $i]
> +			if {$arg eq "--"} {
> +				incr i
> +				break
> +			}
> +			if {[string range $arg 0 0] ne "-"} {
> +				break
> +			}
>  		}
> +		set args [sanitize_command_line $args $i]
> +		uplevel 1 real_exec $args
>  	}
> -	set args [sanitize_command_line $args $i]
> -	uplevel 1 real_exec $args
> -}
>  
> -# Override `open` to avoid unsafe PATH lookup
> +	# Override `open` to avoid unsafe PATH lookup
>  
> -rename open real_open
> +	rename open real_open
>  
> -proc open {args} {
> -	set arg0 [lindex $args 0]
> -	if {[string range $arg0 0 0] eq "|"} {
> -		set command_line [string trim [string range $arg0 1 end]]
> -		lset args 0 "| [sanitize_command_line $command_line 0]"
> +	proc open {args} {
> +		set arg0 [lindex $args 0]
> +		if {[string range $arg0 0 0] eq "|"} {
> +			set command_line [string trim [string range $arg0 1 end]]
> +			lset args 0 "| [sanitize_command_line $command_line 0]"
> +		}
> +		uplevel 1 real_open $args
>  	}
> -	uplevel 1 real_open $args
>  }
>  
>  # End of safe PATH lookup stuff

-- Hannes

