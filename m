Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F13346A0
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722593; cv=none; b=ZM8+EXNLTxzjCJArJ4DsEFimwjdlkSj9bnN2QZYkkoNNjO2x76nQHMwE7SlgcxxzswqmOj77qgSjX/zpIXI01K6iCOGhdQ68ng+hu4GrZB3aknmNuHNMZn8xjSWu3q08JDjE3SmhnXwQqesJxZnVF9dnU4hEseOG27PPto6K//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722593; c=relaxed/simple;
	bh=8D9WIk4H1zC36AIwSXj2dh/xRGkKaDz/8CXZhuWv2Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsK2gWPsQszsr/8hkoiQOvnVJ+l/tWFH06meK1VF5iMQyhSnVAoxgC12peNp88kMvVm31v4ct0/l1Z5kXpiXhNCu9rV8wv0aonbyF9vmdpogbeWrXWzs63ZQcJA98WG5ImCYP8TeFQrRqJiHVTo835Pn8jgX11Sq4bH3lUU1ks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4f2CBY2bGkzRpLJ;
	Thu, 29 Jan 2026 22:36:21 +0100 (CET)
Message-ID: <191b6fe4-e273-4ecd-9b73-725c2dff4306@kdbg.org>
Date: Thu, 29 Jan 2026 22:36:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] git-gui: shift tabstops to account for the first
 column of context diffs
Content-Language: en-US
To: Chris Idema <github_chris_idema@proton.me>
Cc: Chris Idema via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com>
 <pull.2179.v4.git.git.1769684944593.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2179.v4.git.git.1769684944593.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 29.01.26 um 12:09 schrieb Chris Idema via GitGitGadget:
> From: Chris Idema <github_chris_idema@proton.me>
> 
> When reviewing a file before staging you want its content aligned using
> gui.tabsize. The prefixing of lines with +, - or space characters should
> not change this alignment. In gitk this is done correctly. In Git Gui not.
> 
> Signed-off-by: Chris Idema <github_chris_idema@proton.me>
> ---

> 
>  git-gui/lib/diff.tcl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
> index 442737ba4f..8be1a613fb 100644
> --- a/git-gui/lib/diff.tcl
> +++ b/git-gui/lib/diff.tcl
> @@ -385,6 +385,8 @@ proc read_diff {fd conflict_size cont_info} {
>  		#
>  		if {[string match {@@@ *} $line]} {
>  			set is_3way_diff 1
> +			apply_tab_size 2
> +		} elseif {[string match {@@ *} $line]} {
>  			apply_tab_size 1
>  		}
>  
Just "else" without a condition would have been sufficient, but we can
do it this way as well.

I've rewritten the commit message like so:

    git-gui: shift tabstops to account for the first column of patch text
    
    When reviewing a change before staging, it is desirable to see text after
    tabstops aligned the same way as in the text editor. However, since there
    is always an additional character in column one in patch text ('+', '-',
    or space), the alignment is broken if text before the first tab character
    is just long enough to push the stop to the next tab position.
    
    Commit a43c5f51a4b1 (git-gui: add configurable tab size to the diff view,
    2012-02-12) added infrastructure that manipulates the tabstop positions
    of the Tk text widget. However, it does so only when a 3-way diff is
    shown and only so that it takes into account the one additional markup at
    the beginning of lines. This only achieved that alignment does not get
    worse for 3-way diffs compared to regular patch text, but left misaligned
    text in regular patch text unmodified.
    
    Use and modify this infrastructure to shift tabstops by one position for
    regular patch text and two positions for 3-way diffs. Existing code
    already resets the tabstops to an unshifted position when contents of
    untracked files are displayed.
    
    Signed-off-by: Chris Idema <github_chris_idema@proton.me>
    [j6t: extend commit message]
    Signed-off-by: Johannes Sixt <j6t@kdbg.org>

In particular there was no bug; this is a new feature.

Thanks,
-- Hannes

