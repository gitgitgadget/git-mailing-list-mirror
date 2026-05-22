Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B5938E13F
	for <git@vger.kernel.org>; Fri, 22 May 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438334; cv=none; b=jKGJxZiOz/51hEAz9sTDSdFJnQvrgDHbVkPy3H+OYRJL+xBkHPUXpvPfN4VJg4tRUBThnDLXknN5vnp2S0FR4+uXvnPbeW2GaO+DiqwQ2De+obLzHGc/Izhmv0E2K2SVay+yCDb9AwkSEtqzZi2FXF6IJvDF83RCQa0q9E/Co7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438334; c=relaxed/simple;
	bh=InFF2Q1qrEc9Ct1toVpNtXnUql8yGC7TQjvbJyLTK0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Omdrj1b6E6xqzSHnzjdy4YRW2MdCBpmX0uHkqzo0yEu16DcMcePe+8GD3p02K/doDRu/xdqEdO67q+n8ZBZmnLFrwKIcDIfC1FLWr9lfcqyFKK7ScTq7FlcJkwCu0Gb9XVMG7PrU1QgQX3tSgW6IzLpwPe7WCqaQ79bcnlQSHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4gMJHr4mYXzRpKt;
	Fri, 22 May 2026 10:25:28 +0200 (CEST)
Message-ID: <b3f8bdf0-fed9-4f02-a86f-ca4d400be852@kdbg.org>
Date: Fri, 22 May 2026 10:25:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] git-gui: use --absolute-git-dir
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-4-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-4-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:24 schrieb Mark Levedahl:
> git-gui uses git rev-parse --git-dir to get the pathname of the
> discovered git repository. The returned value can be relative, and is
> '.' if the current directory is the top of the repository directory
> itself.  git-gui has code to change '.' to [pwd] in this case so that
> subsequent logic runs.
> 
> But, git rev-parse supports --absolute-git-dir from fac60b8925
> ("rev-parse: add option for absolute or relative path formatting",
> 2020-12-13), and included in git 2.31. git-gui requires git >= 2.36, so
> this more useful form is always available. Use --absolute-git-dir to
> always get an absolute path, avoiding the need for other checks, and
> delete the now unneeded code to fix a relative _gitdir.

Very good!

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 4a736190a9..233c975786 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1146,7 +1146,7 @@ if {[catch {
>  	&& [catch {
>  		# beware that from the .git dir this sets _gitdir to .
>  		# and _prefix to the empty string

Note that the comment above needs some adjustment as well.

> -		set _gitdir [git rev-parse --git-dir]
> +		set _gitdir [git rev-parse --absolute-git-dir]
>  		set _prefix [git rev-parse --show-prefix]
>  	} err]} {
>  	load_config 1
> @@ -1155,7 +1155,7 @@ if {[catch {
>  		exit 1
>  	}
>  	if {[catch {
> -		set _gitdir [git rev-parse --git-dir]
> +		set _gitdir [git rev-parse --absolute-git-dir]
>  	} err]} {
>  		catch {wm withdraw .}
>  		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] "\n\n$err"]
> @@ -1175,13 +1175,6 @@ if {$hashalgorithm eq "sha1"} {
>  	exit 1
>  }
>  
> -# we expand the _gitdir when it's just a single dot (i.e. when we're being
> -# run from the .git dir itself) lest the routines to find the worktree
> -# get confused
> -if {$_gitdir eq "."} {
> -	set _gitdir [pwd]
> -}
> -
>  if {![file isdirectory $_gitdir]} {
>  	catch {wm withdraw .}
>  	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]

-- Hannes

