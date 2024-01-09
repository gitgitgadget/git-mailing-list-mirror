Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A63B780
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k0VwmqDk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 84F531C8C2A;
	Tue,  9 Jan 2024 12:35:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Kd3/JpuCAZsORJhR613j/1YAbuV47DcF9ZeLl/
	NBo2Q=; b=k0VwmqDk3V9vSDTkSE7vpIOhrP9KLNcsOG3Pd/cZ41rSaTg3SBg56/
	oHFVMCnIyaynN3UnSeEt3rXo6CXnWMYjRz+LyUVo7i8OwMfjcTNo+w3/FEegU+9b
	7gjB3+Yk/1y648UEFJy7g9lcOYF081I04aO1Op5NLogWd0ObmFHlg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B9A11C8C29;
	Tue,  9 Jan 2024 12:35:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD9B11C8C28;
	Tue,  9 Jan 2024 12:35:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] t7501: Add tests for various index usages, -i and
 -o, of commit command.
In-Reply-To: <20240109060417.1144647-3-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Tue, 9 Jan 2024 11:34:13 +0530")
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
	<20240109060417.1144647-3-shyamthakkar001@gmail.com>
Date: Tue, 09 Jan 2024 09:35:38 -0800
Message-ID: <xmqqplyaif4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 819A3B1C-AF15-11EE-826B-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Subject: Re: [PATCH 1/2] t7501: Add tests for various index usages, -i and -o, of commit command.

Overly long subject that has an unusual capitalization after
"t7501:" (see "git log --no-merges --format=%s -20 v2.43.0" for
example and try to write something that blends better).

> +test_expect_success 'commit with -i fails with untracked files' '
> +	test_when_finished "rm -rf testdir" &&
> +	git init testdir &&
> +	echo content >testdir/file.txt &&
> +	test_must_fail git -C testdir commit -i file.txt -m initial
> +'

In addition to "why a new repository???" comment raised already, I
do not want to see the last command spelled like so.  Always write
dashed options (and their parameters) before non-option arguments,
i.e.

	git commit -i -m initial file.txt
	git -C testdir  commit -i -m initial file.txt
	test_must_fail git -C testdir commit -i -m initial file.txt

The command line parser does rotate the unrecognized arguments to
the end and keeps looking for recognisable option (possibly followed
by its parameter), but that is purely to help lazy writers (i.e.,
interactive command users).  When writers know "-i" does not take
any parameter, it may be convenient if the writer who forgot to say
"-m" can just append "-m initial" to what has already be written.

When writing source (be it the production code or test), however, we
write for readers.  What you wrote at a first glance, especially
given that "-i" (or "-o" for that matter) is a relatively less
commonly used option, would confuse less experienced readers by
making them wonder what "-i file.txt" means (e.g., "is that taking
input from the contents of file.txt?").

