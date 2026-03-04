Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6954319848
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609085; cv=none; b=mNyYzwR++BZarDnDgA2bi0/D9TvrsSqMWmpohwbbG+ODWleE8M0T4RR3mANaQSZtziOCLxCTFsjiEbsWp495poY3mxe1qgrbNo4bN7IddyECJZP4Vwz+YZT3RRHZ0FsJh59mqwSb0woCxrA1akGad82kB3/ibILUg2hdIuFzkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609085; c=relaxed/simple;
	bh=+xeXkKQJEATxE+jD3vKxL20H9ircyvFTZ9thanZTmxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzoCXZ3m7byfZidL2/0SkxqpFSjXlohRnaR9935ZbMXsMQ/gSVneqf6dI3/b9XS99cTB8AAK4IMZNkCHSu81F+s1ktXfYk6wdR/Lz/SkAvmkSCQ1ZNv+ynq/m/gZx8LSIwk1PSY/LTAU5iz35v9mKxm8MNDX52xAp6MRx6jG2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4fQkh452rQz7QcFw
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 08:24:36 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4fQkgv5jBNzRpLL;
	Wed,  4 Mar 2026 08:24:27 +0100 (CET)
Message-ID: <fd298e8c-462d-4309-a20c-ea3dcd00d09d@kdbg.org>
Date: Wed, 4 Mar 2026 08:24:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: highlight comment lines in commit message
To: Wolfgang Faust <contrib-git@wolfgangfaust.com>
Cc: git@vger.kernel.org
References: <a72715e2-c3ae-4050-95e3-7fc7f9b74b5d@app.fastmail.com>
 <08da87b1-32c6-43c2-be1f-d60bc93ea135@kdbg.org>
 <c2416342-dbb8-4003-b959-cb0ed2b00eeb@app.fastmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <c2416342-dbb8-4003-b959-cb0ed2b00eeb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.03.26 um 02:30 schrieb Wolfgang Faust:
> Thank you, "dim" is a better term.

You forgot to update the commit message. I took the liberty to rewrite
it like so:

    git-gui: grey out comment lines in commit message

    Comment lines are stripped by wash_commit_message, but there is no
    indication in the UI that they are special and will be removed.
    Grey these lines out to indicate that they will be removed.

    Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>
    Signed-off-by: Johannes Sixt <j6t@kdbg.org>

>> (I wonder why we need the +1char, though.)
> 
> Without it, putting the cursor at the end of a comment line and typing
> causes the newly inserted text to flash black briefly. Adding +1 puts
> the tag on the other side of the cursor, so the newly added text is dim.
> (The tradeoff is that putting the cursor at the end of the comment,
> pressing enter, and typing causes the newly inserted text to be grey
> briefly. I think this looks somewhat less bad than the other way around.)

Fair enough.

> +	# Grey out comment lines (which are stripped from the final commit message by
> +	# wash_commit_message).
> +	$ui_comm tag configure commit_comment -foreground gray
> +	proc dim_commit_comment_lines {} {
> +		global ui_comm comment_string
> +		$ui_comm tag remove commit_comment 1.0 end
> +		set text [$ui_comm get 1.0 end]
> +		# See also cmt_rx in wash_commit_message
> +		set cmt_rx [strcat {^} [regsub -all {\W} $comment_string {\\&}]]
> +		set ranges [regexp -all -indices -inline -line -- $cmt_rx $text]
> +		foreach pair $ranges {
> +			set idx "1.0 + [lindex $pair 0] chars"
> +			$ui_comm tag add commit_comment $idx "$idx lineend + 1 char"
> +		}
> +	}
> +	dim_commit_comment_lines
> +	bind $ui_comm <<Modified>> { after idle dim_commit_comment_lines }
Nicely done! Queued.

Thanks,
-- Hannes

