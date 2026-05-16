Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324DF507
	for <git@vger.kernel.org>; Sat, 16 May 2026 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778919505; cv=none; b=JBfal9TnyhXxwqOeZkngfK2WAvpWM1zZgM3SbGVlr1nhx740xbMC0niKHUXFoZcyNX0mlhpcqUezidP6s4K+V1Mf6zCyy7F33dB/uqxcygNaiAq8rtRJJc/1EN47TfKJ13bvzkcWrX+PLt2QuARxDwvAHKxJi+/6zZxCAZJF/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778919505; c=relaxed/simple;
	bh=TLF4MMutkA3pLOno256j3eJbxWdKwaMpqXBFAzIT2Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEQ+3PH/bIurOXB81v6+S1hxcdtyCsj3pU1+qq6g9UzZqlUxWS11rZi/Eyov0cG0/znKwjmGdMD8xXa0gooeGXNn2qP2YJjBUqcAnGZMf9ZPB9B5sBFQPSdBFctibBFFSEXIjMCDgRP99NuZNrwpNkyVif3hJLaGwLBoJ7EoV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gHcQP0WCBzRnlT;
	Sat, 16 May 2026 10:18:21 +0200 (CEST)
Message-ID: <e336544b-941d-43ed-890f-2b8950dbaf88@kdbg.org>
Date: Sat, 16 May 2026 10:18:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/11] git-gui: add gui and pick as explicit
 subcommands
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-12-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-12-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> git-gui accepts subcommands blame | browser | citool, and assumes the
> subcommand is 'gui' if none is actually given, But, git gui also has a
> repository picker (choose_repository::pick) that can create a new
> repository + worktree, or choose an existing one, switch to that, and
> the run the gui. The user has no direct control over invoking the
> picker, instead the picker is triggered by failure in the repository /
> worktree discover process: this includes being started in a directory
> not controlled by git, which is probably the intended use case.
> 
> The picker can appear when the user has no intention of creating a new
> worktree, and the user cannot use the picker to create a new worktree
> inside another.
> 
> So, add two new explicit subcommands:
>     gui  - Run the gui if repository/worktree discovery succeeds, or die
>            with an error message, but never run the picker.
>     pick - First run the picker, regardless, then start the gui in
>            the chosen worktree.
> 
> Nothing in this changes the prior behavior, the alternates above must be
> explicitly selected to see any change.

OK.

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 3a83dd5..c56aeef 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1021,6 +1021,7 @@ proc load_config {include_global} {
>  ##
>  ## feature option selection
>  
> +set run_picker_on_error 1
>  if {[regexp {^git-(.+)$} [file tail $argv0] _junk subcommand]} {
>  	unset _junk
>  } else {
> @@ -1030,6 +1031,7 @@ if {$subcommand eq {gui.sh}} {
>  	set subcommand gui
>  }
>  if {$subcommand eq {gui} && [llength $argv] > 0} {
> +	set run_picker_on_error 0
>  	set subcommand [lindex $argv 0]
>  	set argv [lrange $argv 1 end]
>  }
> @@ -1047,6 +1049,7 @@ blame {
>  	disable_option multicommit
>  	disable_option branch
>  	disable_option transport
> +	set run_picker_on_error 0
>  }
>  citool {
>  	enable_option singlecommit
> @@ -1055,6 +1058,7 @@ citool {
>  	disable_option multicommit
>  	disable_option branch
>  	disable_option transport
> +	set run_picker_on_error 0
>  
>  	while {[llength $argv] > 0} {
>  		set a [lindex $argv 0]

Can we please use the available disable_option and enable_option feature
instead of a new variable. Just for consistency around repository discovery.

> @@ -1162,14 +1166,28 @@ proc pick_repo {} {
>  	set picked 1
>  }
>  
> +# run repository picker if explicitly requested
> +switch -- $subcommand {
> +	pick {
> +		pick_repo
> +		set subcommand gui
> +		set run_picker_on_error 0
> +	}
> +}
> +

It just feels wrong to have a new pick_repo call before repository
discovery. Can we not treat this case below as if regular repository
discovery failed and then end up in the existing call of pick_repo?

>  # find repository.
>  if {[catch {
>  	set _gitdir [git rev-parse --absolute-git-dir]
>  } err]} {
>  	if {[is_gitvars_error $err]} {
>  		exit 1
> -	} else {
> +	}
> +	if {$run_picker_on_error} {
>  		pick_repo
> +	} else {
> +		catch {wm withdraw .}
> +		error_popup [strcat [mc "Git directory not found:"] "\n\n$err"]
> +		exit 1
>  	}
>  }
>  
> @@ -3051,7 +3069,7 @@ gui {
>  	# fall through to setup UI for commits
>  }
>  default {
> -	set err "[mc usage:] $argv0 \[{blame|browser|citool}\]"
> +	set err "[mc usage:] $argv0 \[{blame|browser|citool|gui|pick}\]"
>  	if {[tk windowingsystem] eq "win32"} {
>  		wm withdraw .
>  		tk_messageBox -icon error -message $err \

We don't need to switch on the new subcommands?

As a follow-up to my comment on 04/11: How relevant is it that variable
$picked is set in a 'git gui pick' invocation?

-- Hannes

