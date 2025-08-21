Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01525A352
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801569; cv=none; b=S73f3KzQgVoQMpJaYWfNLsNCMtVxzKBa48Zu0+4OcvIlVDqVqznaskLxgq9XCt2Dp/UZAnP/nCbVVi6LUad390PMhkijVGpvjh/rgVHnASLrev4ADcn/XHupN+AYzU4WK9wN2qFzRBuk5CcFrAkGHbMiVe9mFTrgx/Spmt7EbVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801569; c=relaxed/simple;
	bh=ibj7Aae3G3EkRM7I+Jk1AWTCFrVEgzyrRVaBW+gdnJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S8xvvU7ij8h8i8PhfWAmykVSLnYocyYG84brdjbU03zoCcaZxaONbmQ1oaX9QlyO0DvmMaLIbdFlcp0FAPjQ+uIPC9lScH+gDOyFunSyGobIh+VhW8q26bDqXeAV5iW9EiKHzTDJ1vO/AHKFM+nc8L+48aJjtmyHV7tzoMEqRy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4c7BtZ2Q46zRmx1;
	Thu, 21 Aug 2025 20:39:18 +0200 (CEST)
Message-ID: <db481d03-1ebb-4e85-8b82-21ff3945289d@kdbg.org>
Date: Thu, 21 Aug 2025 20:39:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: simplify PATH de-duplication
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
References: <20250820153143.21181-1-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250820153143.21181-1-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.08.25 um 17:31 schrieb Mark Levedahl:
> git-gui since 8fe7861c51 ("git-gui: assure PATH has only absolute
> elements.", 2025-04-11) uses a list to maintain order and a dict to
> detect duplicated elements without quadratic complexity.  But, Tcl's
> dict explicitly maintains keys in the order first added, thus the list
> is not needed.  Simplify the code.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index b64d065..4528b22 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -103,21 +103,16 @@ if {[is_Windows]} {
>  	set _path_sep {:}
>  }
>  
> -set _search_path {}
>  set _path_seen [dict create]
>  foreach p [split $env(PATH) $_path_sep] {
>  	# Keep only absolute paths, getting rid of ., empty, etc.
>  	if {[file pathtype $p] ne {absolute}} {
>  		continue
>  	}
> -	# Keep only the first occurence of any duplicates.
>  	set norm_p [file normalize $p]
> -	if {[dict exists $_path_seen $norm_p]} {
> -		continue
> -	}
>  	dict set _path_seen $norm_p 1
> -	lappend _search_path $norm_p
>  }
> +set _search_path [dict keys $_path_seen]
>  unset _path_seen
>  
>  set env(PATH) [join $_search_path $_path_sep]

Thanks, this looks good; queued. I tweaked it to keep the comment.

-- Hannes

