Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0D17C220
	for <git@vger.kernel.org>; Fri, 15 May 2026 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860741; cv=none; b=n6mBpxc2MTxZBwp4KuvP9m8ESTGPP1A0hZ7WhF1iDzmvh6OSSeBM0SH3RNE9akbzWALEJ9a5T08Q9WVcWHjitvwNC6jD+8FdjGC1zApMPq5o/3BlB1IF1DdoR8vALzKTcHkVVCLOS3D4hfsTBRYDZK6sCF5mujn7UCs5ThYkU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860741; c=relaxed/simple;
	bh=yY5Ozvej7Z6R7xZKksX58muTnHZa/Zsai6PemCOHiSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/eh5KfG8FRkFiPKsCL/87ghbEKIFNUReyY3bZVy8yGdRzgvIN/G6kM+EOsX7Eb90dsyeCJLb2KWNY4ay0yQOSnEfgbmZAkVD9NKu4I7CgIbFD6l/9v3icVTIu9cKLzSMpfynVP+j1seAYm7wfxhla2X2uHfrtEUlm4s0Qhh3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gHBhJ53DZzRpXM;
	Fri, 15 May 2026 17:58:56 +0200 (CEST)
Message-ID: <d9af8b60-e354-4cfc-87b3-a3e708b362da@kdbg.org>
Date: Fri, 15 May 2026 17:58:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] git-gui: guard set/unset of GIT_DIR and
 GIT_WORK_TREE
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-4-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-4-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> git-gui unconditionally exports GIT_DIR and GIT_WORK_TREE to the
> environment, and furthmore unconditionally unsets these in many places.
> But, GIT_WORK_TREE should be set only if it is not {} as the empty
> value, really meaning no work-tree is found, causes git to throw fatal
> errors (git-gui gets the error from branch --show-current).  Fixing this
> is required to allow blame and browser to operate from a repository
> without a worktree.
> 
> Establish a pair of functions to remove GIT_DIR and GIT_WORK_TREE from
> the environment, avoiding any error if they do not exist. Also, add a
> function to export these, but export GIT_WORK_TREE only if not empty.

Good. But as I said in a parallel thread, I actually concur with your
assessment in the coverletter of this patch series that GIT_WORK_TREE
should be not set at all. At least in the modes that require a working tree.

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index a951fcd..387cad6 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1122,6 +1122,22 @@ unset argv0dir
>  ##
>  ## repository setup
>  
> +proc set_gitdir_vars {} {
> +	global _gitdir _gitworktree env
> +	if {$_gitdir ne {}} {
> +		set env(GIT_DIR) $_gitdir
> +	}
> +	if {$_gitworktree ne {}} {
> +		set env(GIT_WORK_TREE) $_gitworktree
> +	}
> +}
> +
> +proc unset_gitdir_vars {} {
> +	global env
> +	catch {unset env(GIT_DIR)}
> +	catch {unset env(GIT_WORK_TREE)}
> +}
> +
>  set picked 0
>  if {[catch {
>  		set _gitdir $env(GIT_DIR)
> @@ -1207,8 +1223,8 @@ if {[lindex $_reponame end] eq {.git}} {
>  	set _reponame [lindex $_reponame end]
>  }
>  
> -set env(GIT_DIR) $_gitdir
> -set env(GIT_WORK_TREE) $_gitworktree
> +# Export the final paths
> +set_gitdir_vars
>  
>  ######################################################################
>  ##
> @@ -2050,13 +2066,11 @@ proc do_gitk {revs {is_submodule false}} {
>  			# TODO we could make life easier (start up faster?) for gitk
>  			# by setting these to the appropriate values to allow gitk
>  			# to skip the heuristics to find their proper value
> -			unset env(GIT_DIR)
> -			unset env(GIT_WORK_TREE)
> +			unset_gitdir_vars
>  		}
>  		safe_exec_bg [concat $cmd $revs "--" "--"]
>  
> -		set env(GIT_DIR) $_gitdir
> -		set env(GIT_WORK_TREE) $_gitworktree
> +		set_gitdir_vars
>  		cd $pwd
>  
>  		if {[info exists main_status]} {
> @@ -2084,16 +2098,14 @@ proc do_git_gui {} {
>  
>  		# see note in do_gitk about unsetting these vars when
>  		# running tools in a submodule
> -		unset env(GIT_DIR)
> -		unset env(GIT_WORK_TREE)
> +		unset_gitdir_vars
>  
>  		set pwd [pwd]
>  		cd $current_diff_path
>  
>  		safe_exec_bg [concat $exe gui]
>  
> -		set env(GIT_DIR) $_gitdir
> -		set env(GIT_WORK_TREE) $_gitworktree
> +		set_gitdir_vars
>  		cd $pwd
>  
>  		set status_operation [$::main_status \

After these changes, a 'global env' probably becomes stale and could be
removed.

-- Hannes

