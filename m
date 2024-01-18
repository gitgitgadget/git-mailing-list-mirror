Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE11DA45
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705619070; cv=none; b=lnLavEiLvhs14zwEyodmrV89GnECZ/ihqXf3SCMmrOF2jfzy/RocmLwy4ghA/wOddwNHgEog+bRww425lKVcxizrZOZ5sWj3lT/CaclBEdsH3WlOzo46jkHkbNhkW+KSWlbjtY++Wh9mkxvrsgE+grjIm8NIttigS4XPKCKQ2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705619070; c=relaxed/simple;
	bh=/A3bdo9iNvDc3be+i/3z/JIHl9tFj/ysaj1hJuf55Z8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OJobDlZMLZwxC4dGrJ1IwybCjR+WCE1lWcf4BkKlBxgpXJ9bkdbOVeX842Zdik3gVukS6wiqoNX78t5iYkQ/Q5nVIK+VSnnHaDGeUJJgXhikgwD6h97zBfbr+9NoqwNG5d1ljnGoRF461docD4c7vd9b5rXeo9YJ5Ovvj265ick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=coY/KHIL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="coY/KHIL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9E171CD837;
	Thu, 18 Jan 2024 18:04:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/A3bdo9iNvDc3be+i/3z/JIHl9tFj/ysaj1hJu
	f55Z8=; b=coY/KHILBd2JDpGWKIn6t7Y4yJaMtWbm11H1r39Q/q6W0JAEjPb2/D
	SOAy85ePHIVDeuJK9Fa6FSLU/ysa7OsafHwc1ImDvWPoW3F3IijKNsP6WGbObN2u
	Dspv1IcQvUiULal6urG0MPSpOpCDeCjucuTv9eR2kSzh5x60A9ok8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A02231CD835;
	Thu, 18 Jan 2024 18:04:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1C1B1CD834;
	Thu, 18 Jan 2024 18:04:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] t0024: avoid losing exit status to pipes
In-Reply-To: <20240118215407.8609-1-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Fri, 19 Jan 2024 03:23:39 +0530")
References: <20240118215407.8609-1-shyamthakkar001@gmail.com>
Date: Thu, 18 Jan 2024 15:04:25 -0800
Message-ID: <xmqqmst2nszq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ED9D4AD8-B655-11EE-947B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Replace pipe with redirection operator '>' to store the output
> to a temporary file after 'git archive' command since the pipe
> will swallow the command's exit code and a crash won't
> necessarily be noticed.

OK.  I think this case what the patch does is the right thing.  If
we were creating a huge tar archive and have the downstream only
consuming for a small disk footprint (e.g., "git archive | tar tf -"),
use of pipe (and loss of exit status) may be justified, but I do not
think that is the case here.


> Also refactor an existing use of '>' to avoid having a space after
> '>', according to Documentation/CodingGuidelines.

It may be just me, but I wouldn't call that "refactor", which we
often use to refer to changing the way an existing functional unit
works internally, by splitting the innard of a function into
separate helper functions, by replacing the open-coded duplicate
with calls to such helper functions, etc.  Correcting the coding
style violation is merely a "fix".

	Also fix an unwanted space after '>' redirection to match
	the style in CodingGuidelines.

In any case, the patch text looks good.

Thanks.



> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
>  t/t0024-crlf-archive.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
> index a34de56420..fa4da7c2b3 100755
> --- a/t/t0024-crlf-archive.sh
> +++ b/t/t0024-crlf-archive.sh
> @@ -9,7 +9,7 @@ test_expect_success setup '
>  
>  	git config core.autocrlf true &&
>  
> -	printf "CRLF line ending\r\nAnd another\r\n" > sample &&
> +	printf "CRLF line ending\r\nAnd another\r\n" >sample &&
>  	git add sample &&
>  
>  	test_tick &&
> @@ -19,8 +19,8 @@ test_expect_success setup '
>  
>  test_expect_success 'tar archive' '
>  
> -	git archive --format=tar HEAD |
> -	( mkdir untarred && cd untarred && "$TAR" -xf - ) &&
> +	git archive --format=tar HEAD >test.tar &&
> +	( mkdir untarred && cd untarred && "$TAR" -xf ../test.tar ) &&
>  
>  	test_cmp sample untarred/sample
