Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76225774
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331188; cv=none; b=NN8FUrGzKmtzOMUWd1uAk+reU6H7/o2yVJLg9CgQe+sE/xvuszCJgqt1Qe2wBT8244oyHDnyrZ6ao+mXpZeMjXrMAn9NV+rE0lK8mJFbLHJ6CiyL+P31WK/7EvEL67JOD834JOUS8Ytz003nT68GGF15Rbau+c071f96sytDkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331188; c=relaxed/simple;
	bh=4bNiNTlQdpbmvhbQxDFtux6y0OWZfKKdEjDOEtLuPYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t1IZl0L2zW/rkvuDIwnyPHhmoe/2RzSvoUAASmLkDq0zbtJhqCTHP3DueMvaEqJyIXn484mKhx29SdKZZ6tfshIwmBxL7cLmhplxk0xb0Fg8wBAnIo0yX2LovMY3lnPfBouDlkDLCVu/RKHPcVysDHMdVbPQqzOqxU33Z0ncEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q+hCDdGu; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q+hCDdGu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C69F29BEA;
	Tue, 25 Jun 2024 11:59:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4bNiNTlQdpbmvhbQxDFtux6y0OWZfKKdEjDOEt
	LuPYU=; b=Q+hCDdGuauC13xQnJR0vNqJDBsl7F/IryJfjmWkGVQftD3nv9eHluJ
	8tLhmIHaU7WxPN2rP7F+Qeam4j5+gEUh9AVf/k8bEsCoa67SlAKjzf/06bz0sC4h
	qT0lyqdntRuonMqCgglc26AoMfRIZUTe5Qn26DtU/BjO0eh5kjw+A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 84D8629BE9;
	Tue, 25 Jun 2024 11:59:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D1F029BE7;
	Tue, 25 Jun 2024 11:59:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  Paul Millar
 <paul.millar@desy.de>,  Phillip Wood <phillip.wood123@gmail.com>,  Elijah
 Newren <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] describe: refresh the index when 'broken' flag is used
In-Reply-To: <20240625133534.223579-1-abhijeet.nkt@gmail.com> (Abhijeet
	Sonar's message of "Tue, 25 Jun 2024 19:05:19 +0530")
References: <20240625133534.223579-1-abhijeet.nkt@gmail.com>
Date: Tue, 25 Jun 2024 08:59:40 -0700
Message-ID: <xmqq34p1813n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF2B0F6A-330B-11EF-B5B7-C38742FD603B-77302942!pb-smtp20.pobox.com

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

>  		if (broken) {
>  			struct child_process cp = CHILD_PROCESS_INIT;
> +			strvec_pushv(&cp.args, update_index_args);
> +			cp.git_cmd = 1;
> +			cp.no_stdin = 1;
> +			cp.no_stdout = 1;
> +			run_command(&cp);
> +			strvec_clear(&cp.args);

Why clear .args here?

Either "struct child_process" is reusable after finish_command()
that is called as the last step of run_command() returns
successfully, or it shouldn't be reused at all.  And when
finish_command() is called, .args as well as .env are cleared
because it calls child_process_clear().

I am wondering if the last part need to be more like

	...
	cp.no_stdout = 1;
	if (run_command(&cp))
		child_process_clear(&cp);

> +
>  			strvec_pushv(&cp.args, diff_index_args);
>  			cp.git_cmd = 1;
>  			cp.no_stdin = 1;

Thanks.


(#leftoverbit)

Outside the scope of this patch, I'd prefer to see somebody makes
sure that it is truly equivalent to prepare a separate and new
struct child_process for each run_command() call and to reuse the
same struct child_process after calling child_process_clear() each
time.  It is unclear if they are equivalent in general, even though
in this particular case I think we should be OK.

There _might_ be other things in the child_process structure that
need to be reset to the initial state before it can be reused, but
are not cleared by child_process_clear().  .git_cmd and other flags
as well as in/out/err file descriptors do not seem to be cleared,
and other callers of run_command() may even be depending on the
current behaviour that they are kept.
