Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E668350A2E
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769607614; cv=none; b=ol7KKQUd0/9sA7NaF+rGhfemC4ZMuSZLq9t7d1hIyF0pST3jdjOWqK/+43mVtBlAkAjLtrsoZZBf2WYsjFGYplG6SEY5GF5MbSxTxcsDNY+ZDotYMHKUrAAKfdGGxlWUkvFATdiggfg6WDBpuzrXmLUj9xN2Elu0GBNBNKgeO/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769607614; c=relaxed/simple;
	bh=2YMMdM0lOeNwcd320OgvuatBrT1OFFqy3uLyeF5yCiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzlvc8SGFJFO4xHF8nVecMgro35g/snomwkW0vT9BE+xBx/aC8bwFeuBiO3W7X4yz/AkR6RsiGFAWCgko7sxWgW65Up/asObNTOSX+Gc53koJV76tRKJmHgsZYGrHFdxkJOoqbJDB8H0ewzywVWpV88ES2KtShKa1L4/CkoTQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4f1NgQ50WzzRnlb;
	Wed, 28 Jan 2026 14:40:02 +0100 (CET)
Message-ID: <71494127-c17d-4fd9-a69d-1f547205ac8f@kdbg.org>
Date: Wed, 28 Jan 2026 14:40:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix
 alignment instead of spaces.
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Chris Idema <github_chris_idema@proton.me>
Cc: git@vger.kernel.org, Michael Lutz <michi@icosahedron.de>,
 Pat Thoyts <patthoyts@users.sourceforge.net>,
 Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
 <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
 <e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com>
 <xmqqsebqem1n.fsf@gitster.g> <xmqqfr7qeixq.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqfr7qeixq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.01.26 um 00:26 schrieb Junio C Hamano:
> It is clear that "apply_tab_size 0" is designed for a single-parent
> diff, while "apply_tab_size 1" is designed for two parents diff.  If
> this new series to make sense, I think it should argue why that
> setting that users are already familiar with for the past 14 years
> is wrong, and "apply_tab_size 1" is more appropriate for a single
> parent diff (and presumably "apply_tab_size 2" is better for two
> aprent diff), I think.

I concur. Also, "apply_tab_size 0" is needed when the contents of an
unstaged file are shown instead of patch text.

> +proc apply_tab_size {{firsttab {}}} {
> +	global have_tk85 repo_config ui_diff
> +
> +	set w [font measure font_diff "0"]
> +	if {$have_tk85 && $firsttab != 0} {
> +		$ui_diff configure -tabs [list [expr {$firsttab * $w}] [expr {($firsttab + $repo_config(gui.tabsize)) * $w}]]

I think that these values for tabstops aren't optimal. It does not make
sense to have tabstop at column 1 for diff output, because there is
always at least one character ('+', '-', or SP), so that the first tab
would jump right to the second stop. In Gitk, the initial version looked
like this as well, but it this was changed soon after.

> +	} elseif {$have_tk85 || $repo_config(gui.tabsize) != 8} {
> +		$ui_diff configure -tabs [expr {$repo_config(gui.tabsize) * $w}]
> +	} else {
> +		$ui_diff configure -tabs {}
> +	}
> +}
-- Hannes

