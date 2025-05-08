Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083F20298C
	for <git@vger.kernel.org>; Thu,  8 May 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685261; cv=none; b=KNQVDVAG+qGFg79AqjSBEsc9X3WNTijkzPfTr2/6qbPeRMdxcKP2t69sICJ3o4qYIqPmmkh39ODUUhPRviL6HKgYkgT4LjqkGvbYNanqViQdYSpzClntBz8QpMqdisSCVp6Om8pvxlwmQ4+Fz3P0B+uCDo/Os4/BRCLMoNQOJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685261; c=relaxed/simple;
	bh=XfQEIIsXCzqiaE9ukyJN8R19HYZJR1vrkCjHGai5f5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aG0a3Y/roPojV4sierq8vv/8SchAJGE4GyYBF2Oyr3MhHDURopuWRuRIaBDFtKLFAzcTT5sQkjRoHOxTHVmnB+xh+wZTunmPG5ujh2cNI+7HjTRSMwJ/BT6xMSLx/ZeAEoUw9KAEFrNMrNpwgul+8KVrPqF2IMSQ+dUTo527l/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4ZtMSz3CZrz7QZYx
	for <git@vger.kernel.org>; Thu,  8 May 2025 08:20:51 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4ZtMSm4bVmzRq26;
	Thu,  8 May 2025 08:20:40 +0200 (CEST)
Message-ID: <9bb1699a-ec99-40b3-bd6a-00e809d77d0d@kdbg.org>
Date: Thu, 8 May 2025 08:20:40 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gitk: Add a basic support of SHA256 repositories into
 Gitk
To: Takashi Iwai <tiwai@suse.de>
Cc: Denton Liu <liu.denton@gmail.com>, Eric Huber <echuber2@illinois.edu>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Avi Halachmi <avihpit@yahoo.com>, Christoph Sommer <sommer@cms-labs.org>,
 Paul Mackerras <paulus@ozlabs.org>, git@vger.kernel.org
References: <20250320154136.23262-1-tiwai@suse.de>
 <20250320154136.23262-2-tiwai@suse.de>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250320154136.23262-2-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.03.25 um 16:41 schrieb Takashi Iwai:
> From: Rostislav Krasny <rosti.bsd@gmail.com>
> 
> This PR makes Gitk working on both SHA256 and SHA1 repositories without
> errors/crashes. I made it by changing and testing the gitk script of Git
> for Windows [https://gitforwindows.org/] version 2.32.0.windows.1 that
> is a little bit different than the mainstream 2.32.0 version.
> 
> Still not fixed functionality: [1] There is the "Auto-select SHA1
> (length)" configuration preference that affects "Copy commit reference"
> on both SHA1 and SHA256 repositories.
> 
> A new "Auto-select SHA256 (length)" configuration preference should be
> added and used on SHA256 repositories instead of the old one. Since I'm
> not familiar with Tcl/Tk and this issue isn't critical I didn't
> implement it.
> 
> [ Changes from the original patch:
>   * Discard the changes for generic words (e.g. "Commit ID"), so that
>     translations can be still applied after this patch
>   * Simplify the regexp check in gotocommit as suggested in the
>     previous review
>   -- tiwai ]

The message should be updated to not mention the evolution of the change
and what is not relevant anymore or not relevant in this patch.

> 
> Signed-off-by: Rostislav Krasny <rosti.bsd@gmail.com>
> Link: https://patchwork.kernel.org/project/git/patch/pull.979.git.1623687519832.gitgitgadget@gmail.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---

> @@ -8920,11 +8932,11 @@ proc gotocommit {} {
>          set id $headids($sha1string)
>      } else {
>          set id [string tolower $sha1string]
> -        if {[regexp {^[0-9a-f]{4,39}$} $id]} {
> +	if {[regexp {^[0-9a-f]{4,63}$} $id]} {

This doesn't use $hashlength. Should it?

Also watch out space vs. TAB.

> @@ -12524,6 +12539,18 @@ if {$tclencoding == {}} {
>      puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
>  }
>  
> +set objformat [exec git rev-parse --show-object-format]
> +if {$objformat eq "sha1"} {
> +    set hashlength 40
> +} elseif {$objformat eq "sha256"} {
> +    set hashlength 64
> +} else {
> +    error_popup "[mc "Not supported hash algorithm:"] {$objformat}"

This looks strange. Where is the $objformat substituted?

> +    exit 1
> +}
> +set hashalgorithm [string toupper $objformat]
> +unset objformat

Why not set hashalgorithm right away, without using a temporary
objformat? Why set it at all here? It's unused.

> +
>  set gui_encoding [encoding system]
>  catch {
>      set enc [exec git config --get gui.encoding]

