Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD51953AA
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776144; cv=none; b=mH7wuGQFHmi3DMGhHCkPekD2XEbEXg3BjyrnimUJt2hDgmGD7Kzn4zThcTlFAdUyKR/B2QwtllrO+4t7LeQOxe95v7SjD95xmnoxS67F2p+fTKHydazWDKN698Bl/LE2Elfq2Kt76ZPPvuth4ovvXNhzVad5KEiQkycFaUST3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776144; c=relaxed/simple;
	bh=EvB4oJWQMgeFHYIRaBqo30WiRxBG20OtczXCkqhfR3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cJKJ7F2M00xWrs7IWdDBEHnVHZQxRMmAZiXA7UQ5w6kltZHaCJKZ4+HmXlFhNBA/cs6YqQu5F0xLESWUssDSeoZvLA+52hzcVWz+LTgbvTEzTzWdks61OCScIZ2B6dKc5O+owprSOFm50qSiMFT2XRqL2TcwEtvF80h3PNbxyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SvjJKMDZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SvjJKMDZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 167D92F3A6;
	Fri,  7 Jun 2024 12:02:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EvB4oJWQMgeFHYIRaBqo30WiRxBG20OtczXCkq
	hfR3Y=; b=SvjJKMDZxrCHfdWBDdzAeQqC03hVswNJlsFOzl/6s1HP/SvxGe7e3G
	op+TZtTH8SLT58SNP7lcNhtrC69dolhTL58tBv8lN8hkc6vzD7EuRniyHtkYWfR1
	MHZLqg3tAghTKlgTytRQFbHbWE76MTqP456GVgEkrzY3TVTT0PNzQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C9842F3A5;
	Fri,  7 Jun 2024 12:02:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C3B32F3A4;
	Fri,  7 Jun 2024 12:02:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 2/2] server-info.c: remove temporary info files on exit
In-Reply-To: <2d5a0536af1a6d45835622e2c020266079fa0873.1717712358.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 6 Jun 2024 18:19:31 -0400")
References: <cover.1717712358.git.me@ttaylorr.com>
	<2d5a0536af1a6d45835622e2c020266079fa0873.1717712358.git.me@ttaylorr.com>
Date: Fri, 07 Jun 2024 09:02:14 -0700
Message-ID: <xmqqfrtog2rd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4F155530-24E7-11EF-ABE3-6488940A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> @@ -121,27 +120,22 @@ static int update_info_file(char *path,
>  	}
>  
>  	uic.cur_fp = NULL;
> -	if (fclose(to_close))
> -		goto out;

We should fflush() of cur_fp before nuking it, at least, no?

In the original code, to_close was a mere copy of uic.cur_fp and we
made sure that anything buffered at the stdio layer are flushed to
the underlying file desciptor (fd that we obtained from
git_mkstemp_mode() in the original code) with this fclose() call.

We no longer do so.  We later call rename_tempfile() to close the
underlying file descriptor and move the temporary file to its final
place, but I do not see what guarantee we have that we do not lose
what we had buffered in the stdio with the updated code.

>  	if (uic_is_stale(&uic)) {
> -		if (adjust_shared_perm(tmp) < 0)
> +		if (adjust_shared_perm(get_tempfile_path(f)) < 0)
>  			goto out;
> -		if (rename(tmp, path) < 0)
> +		if (rename_tempfile(&f, path) < 0)
>  			goto out;
>  	} else {
> -		unlink(tmp);
> +		delete_tempfile(&f);
>  	}
>  	ret = 0;
>  
>  out:
>  	if (ret) {
>  		error_errno("unable to update %s", path);
> -		if (uic.cur_fp)
> -			fclose(uic.cur_fp);
> -		else if (fd >= 0)
> -			close(fd);
> -		unlink(tmp);
> +		if (f)
> +			delete_tempfile(&f);
>  	}
>  	free(tmp);
>  	if (uic.old_fp)
