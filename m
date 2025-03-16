Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482519CC3E
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122964; cv=none; b=kYty7zUAPBfFptaIUoapkwpuTE8ZfSebe+pC9pKpUmeF4mU89pkJV8iewhcIrfmp3J7t9QFWKmlFjcTWryJL0EtdsgHhfx0GDZa/nff2JWkk5U5fQzS2lAnzZxeYZBowdURunYBhSpLPPmjU9cU2WispyS80lLkb7bXkRusdSSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122964; c=relaxed/simple;
	bh=VUKu4FDIWRh9DmmRv2V8fNZTdnyxuAdvXUTnDGFTMsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=DYibxCs09vBMk4jn1fQjxpTWVuw9KnTn8J8zwVx1jsgAEJ/2ty4N7p2VTBoztX4bb7MHljGCuo9pVIQWZK0bVZrOVikFiytQegWe2ErriSOMCwUP65S8cgpFlNdWHEADcB6A+VIv9HKelgeYr9kuuwJmgj+7F9pwDIjvJqyKh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4ZFvL46xpxz7QSyc
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 11:22:20 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4ZFvKw5c7JzRnmS;
	Sun, 16 Mar 2025 11:22:12 +0100 (CET)
Message-ID: <a62035cf-b67e-4291-acf6-d2454a9459bb@kdbg.org>
Date: Sun, 16 Mar 2025 11:22:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: heed core.commentChar/commentString
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20250315140913.577422-1-oswald.buddenhagen@gmx.de>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250315140913.577422-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 15.03.25 um 15:09 schrieb Oswald Buddenhagen:
> This amends 1ae85ff6d (git-gui: strip comments and consecutive empty
> lines from commit messages, 2024-08-13) to deal with custom comment
> characters/strings.
> 
> The magic commentString value "auto" is not handled, because the option
> makes no sense to me - it does not support comments in templates and
> hook output, and it seems far-fetched that someone would introduce
> comments during editing the message.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> Change-Id: Iafc0580e818cb5058cfacbafe6e5da40679a1b1c
> 
> --
> 
> Cc: Johannes Sixt <j6t@kdbg.org>
> 
> the textfield label munging is modeled after b9a43869c9 (without
> introducing the same compatibility problem with tcl 8.5), but i'm not
> positive it's actually a good idea to have it - it looks a bit messy,
> while providing info that the command line client assumes to be known.

See below.

> ---
>  git-gui/git-gui.sh     | 11 ++++++++++-
>  git-gui/lib/commit.tcl |  4 +++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 887d6d596c..ed14ba679b 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -880,16 +880,24 @@ proc apply_config {} {
>  			color::sync_with_theme
>  		}
>  	}
> +
> +	global comment_string
> +	set comment_string [get_config core.commentstring]
> +	if {$comment_string eq {}} {
> +		set comment_string [get_config core.commentchar]
> +	}

Taking care of both forms. Good!

>  }
>  
>  set default_config(branch.autosetupmerge) true
>  set default_config(merge.tool) {}
>  set default_config(mergetool.keepbackup) true
>  set default_config(merge.diffstat) true
>  set default_config(merge.summary) false
>  set default_config(merge.verbosity) 2
>  set default_config(user.name) {}
>  set default_config(user.email) {}
> +set default_config(core.commentchar) "#"
> +set default_config(core.commentstring) {}
>  
>  set default_config(gui.encoding) [encoding system]
>  set default_config(gui.matchtrackingbranch) false

> @@ -3416,15 +3424,16 @@ ${NS}::label $ui_coml \
>  	-anchor w \
>  	-justify left
>  proc trace_commit_type {varname args} {
> -	global ui_coml commit_type
> +	global ui_coml commit_type comment_string
>  	switch -glob -- $commit_type {
>  	initial       {set txt [mc "Initial Commit Message:"]}
>  	amend         {set txt [mc "Amended Commit Message:"]}
>  	amend-initial {set txt [mc "Amended Initial Commit Message:"]}
>  	amend-merge   {set txt [mc "Amended Merge Commit Message:"]}
>  	merge         {set txt [mc "Merge Commit Message:"]}
>  	*             {set txt [mc "Commit Message:"]}
>  	}
> +	append txt [mc " (Lines starting with '%s' will be discarded)" $comment_string]
>  	$ui_coml conf -text $txt
>  }
>  trace add variable commit_type write trace_commit_type

Like you said in the introduction, this does look messy. Would you
approve that I remove this hunk while queuing?

> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
> index 208dc2817c..a570f9cdc6 100644
> --- a/git-gui/lib/commit.tcl
> +++ b/git-gui/lib/commit.tcl
> @@ -211,7 +211,9 @@ You must stage at least 1 file before you can commit.
>  	# Strip trailing whitespace
>  	regsub -all -line {[ \t\r]+$} $msg {} msg
>  	# Strip comment lines
> -	regsub -all {(^|\n)#[^\n]*} $msg {\1} msg
> +	global comment_string
> +	set cmt_rx [strcat {(^|\n)} [regsub -all {\W} $comment_string {\\&}] {[^\n]*}]

This escapes all non-word characters so that they lose their special
meaning in a regular expression. Good.

> +	regsub -all $cmt_rx $msg {\1} msg
>  	# Strip leading empty lines
>  	regsub {^\n*} $msg {} msg
>  	# Compress consecutive empty lines

Thank you very much!

-- Hannes

