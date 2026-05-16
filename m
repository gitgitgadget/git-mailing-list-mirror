Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07301171AF
	for <git@vger.kernel.org>; Sat, 16 May 2026 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778919172; cv=none; b=i+Zhqu0sttPfTZTgjfJZpDqX8a4/on+xijF7s3c4YjwOmrjyKbJ1sL78tYGzeVglPYSrBZhfiK4UbIRXDFPEgk2PCB1x7lGnD44U5ZCSGOFXwd2w2f6dZeu3nkDlnTRSv1nRGDS8gpZ0tzy8gyBT1dv0+GycniT7yza+93kH7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778919172; c=relaxed/simple;
	bh=DWBz+YZRQu0pUpjXGNCVUklGKfITgVHNWEAEgzcpiLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoimxNrIQqnkCHsLYCtL1H9IkFmFbFJu5/SMcC2fxYhaKiHivfkMZdxGkrt8Un/FT+Hgdb7mE1nILDDUXpkOg6b29aUKgSvRjifSpnkWj6yfD8Gohhl+MUmU6Z2nfwGP+/+s2CMHBP4CE6JCa5mBS1YSAcPC8JdQEGWcOtrxpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gHcHy1t0WzRnlg;
	Sat, 16 May 2026 10:12:46 +0200 (CEST)
Message-ID: <267ad9f6-7816-41ba-8981-bc0e4286577c@kdbg.org>
Date: Sat, 16 May 2026 10:12:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/11] git-gui: simplify [is_bare] to report if a
 worktree is known
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-9-mlevedahl@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-9-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> git-gui includes proc is_bare, used in several places to make decisions
> on whether a worktree exists, but also in discovery to tell if a
> worktree can be supported.
> 
> But, is_bare is out of date with regard to multiple worktrees, safe
> repository guards, and possibly other relevant features known to git
> rev-parse. Also, is_bare caches its result on the first call, so is not
> useful if a later step in the discovery process finds a worktree.
> 
> So, simplify is_bare to report whether git-gui has a worktree or is
> working only from a repository.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 81789dd..a03eaa7 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -372,7 +372,6 @@ if {[tk windowingsystem] eq "aqua"} {
>  set _appname {Git Gui}
>  set _gitdir {}
>  set _gitworktree {}
> -set _isbare {}
>  set _githtmldir {}
>  set _prefix {}
>  set _reponame {}
> @@ -524,29 +523,7 @@ proc get_config {name} {
>  }
>  
>  proc is_bare {} {
> -	global _isbare
> -	global _gitdir
> -	global _gitworktree
> -
> -	if {$_isbare eq {}} {
> -		if {[catch {
> -			set _bare [git rev-parse --is-bare-repository]
> -			switch  -- $_bare {
> -			true { set _isbare 1 }
> -			false { set _isbare 0}
> -			default { throw }
> -			}
> -		}]} {
> -			if {[is_config_true core.bare]
> -				|| ($_gitworktree eq {}
> -					&& [lindex [file split $_gitdir] end] ne {.git})} {
> -				set _isbare 1
> -			} else {
> -				set _isbare 0
> -			}
> -		}
> -	}
> -	return $_isbare
> +	return [expr {$::_gitworktree eq {}}]
>  }
>  
>  ######################################################################

Very nice!

IMO, regardless of which way we end up rewriting repository discovery,
the end result should be that we can use $_gitworktree like this to tell
whether we are in a bare repository or not.

-- Hannes

