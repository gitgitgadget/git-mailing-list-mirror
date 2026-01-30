Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977333DEFB
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769755307; cv=none; b=QgE4BZUx2SXcQPza79l+fHnxWym5AMKbEImpib6bUvp0nVFIhmtYLYTivkbnuOtcNltHEVCG+FOfXvtHLt7fiVVghKG810WgJg+3+Q4CsWowoxU5pvMhQdhOvP3L4L3rR4bQdl24ab+V9T5DVPNC45OP4RTeYa/5TVwtGsnsWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769755307; c=relaxed/simple;
	bh=koY+LBlEj/CGsO9Z22pzBb9D9uMu1zc9oI+QkNK6eHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCzrYhE8JpFIpdEpcQQvnWSXIvIhOpvKbGjMdWNsPJVjFb/yKdy9K64yOTu0g1zdjK3N19fPxlDI8nTu5WWPf/FqeqIBhrJmR2E70oS4d+g8KRV3vMtkV7Uwrc8blTlir5WBnHIxMWUtocVnDuYQkg8wBeweUU16nINtPsPhUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4f2RHf6X0TzRnlL;
	Fri, 30 Jan 2026 07:41:34 +0100 (CET)
Message-ID: <04005f67-3ec5-4fa7-9fd7-37ef9034286a@kdbg.org>
Date: Fri, 30 Jan 2026 07:41:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] t/perf/p3400: speed up setup using fast-import
To: Tian Yuchen <a3205153416@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
References: <20260126165618.596944-1-a3205153416@gmail.com>
 <20260128160717.611391-1-a3205153416@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260128160717.611391-1-a3205153416@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.01.26 um 17:07 schrieb Tian Yuchen:
> +	test_seq 1000 >content_fwd &&
> +	test_seq 1000 | sort -nr >content_rev &&

Remove another pipe with

	sort -nr content_fwd >content_rev &&

> +
> +	(
> +		for i in $(test_seq 100)
> +		do
> +			...
> +			cat content_rev &&
> +			echo "EOF" || return 1

This is an incorrect use of `return` outside a function. This must be
`|| exit 1` (or just `|| exit`) to actually break out of the loop.

Of course, the error code is ignored, because it is in the upstream of a
pipe, so in order to fail the complete command, it would be necessary
that the original error left an incorrect fast-import stream such that
the down-stream `git fast-import` fails. Otherwise, the entire command
can complete successfully in an unexpected way.

Maybe instead of a pipe, dump the stream into a temporary file, so that
the loop's exit code can be captured?

> +		done
> +	) | git fast-import &&
-- Hannes

