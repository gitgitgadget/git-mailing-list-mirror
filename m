Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4972253FC
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802794; cv=none; b=XrxlT/66iHB+MuheMoaYF9IX5wrrFVqjOaCvSijlXFWpoZ4fapkmrjq7HigTolD+1iwarpnzMJwrgR4YezLZp+ubqoQ6ymXNQPega2i2XVQWqiG0uZyoyaYxn4bO4nCK0R5GNonP3/DxnPq9XzelEd5uvcB8HFQXszIPfiPLPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802794; c=relaxed/simple;
	bh=9MDVbPX/z5Un5yV7PonA84gy3ion4ZX5lYnPmy4A9BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epROnjaICNyPsRM84/bOf2jSkCAYQeXxVqaR6KOTvThJOcd3ddnaNKp0s0MHk571IFRWON4BIbOIVJ16jzqjWWgSbWdDpRgGMDAYYbEUG9FRYrh0Wp7NEI1QU+P6JMO6vmak/YJNPTdwmD/myu4FsJJYoyZpI28IfXd++nCKmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4c7CL76FQpzRpL2;
	Thu, 21 Aug 2025 20:59:43 +0200 (CEST)
Message-ID: <27f95ac2-380c-4334-8783-4b3b9ce38e24@kdbg.org>
Date: Thu, 21 Aug 2025 20:59:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] git-gui: simplify using nice(1)
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
References: <20250820152451.20872-1-mlevedahl@gmail.com>
 <20250820165021.24604-1-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250820165021.24604-1-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.08.25 um 18:50 schrieb Mark Levedahl:
> git-gui invokes some long running commands using "nice git $cmd" if nice
> is found and works, otherwise just "git $cmd".  The current code is more
> complex than needed; lets simplify it.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
> updates from v1:
> - _which does not return a list, _nice must be a list to handle path
>   with spaces  (should have been in v1, was in another patch - oops)
> - Address Kristoffer Haugsbakk's comments
> 
>  git-gui.sh | 30 +++++++-----------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 4528b22..be0b8d9 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -578,21 +578,6 @@ proc open_cmd_pipe {cmd path} {
>  	return [open |$run r]
>  }
>  
> -proc _lappend_nice {cmd_var} {
> -	global _nice
> -	upvar $cmd_var cmd
> -
> -	if {![info exists _nice]} {
> -		set _nice [_which nice]
> -		if {[catch {safe_exec [list $_nice git version]}]} {
> -			set _nice {}
> -		}
> -	}
> -	if {$_nice ne {}} {
> -		lappend cmd $_nice
> -	}
> -}
> -
>  proc git {args} {
>  	git_redir $args {}
>  }
> @@ -626,15 +611,14 @@ proc git_read {cmd {redir {}}} {
>  	return [safe_open_command $cmdp $redir]
>  }
>  
> -proc git_read_nice {cmd} {
> -	global _git
> -	set opt [list]
> -
> -	_lappend_nice opt
> -
> -	set cmdp [concat [list $_git] $cmd]
> +set _nice [list [_which nice]]
> +if {[catch {safe_exec [list {*}$_nice git version]}]} {
> +	set _nice {}
> +}
>  
> -	return [safe_open_command [concat $opt $cmdp]]
> +proc git_read_nice {cmd} {
> +	set cmdp [list {*}$::_nice $::_git {*}$cmd]
> +	return [safe_open_command $cmdp]
>  }
>  
>  proc git_write {cmd} {

Thank you, that saves quite a few lines. A difference is that `nice` was
looked up only when needed and now it's on every startup. Personally, I
don't mind this change. It should not have a noticable effect on the
responsiveness.

Queued with an apostrophe in "let's".

-- Hannes

