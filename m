Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253FA3446C5
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231560; cv=none; b=ReEEofjnR82r6dDaR7pJTBnCx27mp1syFW6VexkwRnhfjVMW0cQHqksQu9bIPiKuCntKn9RymP32g0NLi1ZMubvuq1iXmcOB/fedIa3FvOi3tfnGwLNFsyJEQHWsmuijS0JMU55n0hPqAKQkN9WI1KlXiGeq6dWMhQlPqndrnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231560; c=relaxed/simple;
	bh=VVMYUkFYm11B0voBU0H3j9EdIQ79KZkOWvZt6ByRlV4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From:
	 References:In-Reply-To; b=heo7wfe7o23ss8/ObSS83Y+Yvj7c2XK+CLXPYtkZf56G2ph9fno4q7FTYQzQf/xr3oX0+ue/ttv3wtZbfLwMHo/fhDkD9Gm4khDY6QpeWtQSzQcMllTja74anO9TAwOeMcIr2yKuhP/fIbpp4pyh9xtDg469GVT1ROFXvOd+9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=QY8b+9Ac; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="QY8b+9Ac"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 430A160038;
	Tue, 28 Jul 2026 09:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1785231552; bh=VVMYUkFYm11B0voBU0H3j9EdIQ79KZkOWvZt6ByRlV4=;
	h=Date:Subject:To:From:References:In-Reply-To:From;
	b=QY8b+9AcIHQjBSZG6M8sRp/pj0DSbEudIA6E34sXnfcMGMx1fRfvfsn7uFVSO2o23
	 plYzvGq/ml1/RKzpcZm3OLZQoySVaaH1oD+Ym+YNn7ra7qPApLpt16kNOBwfjIrTu3
	 w0IU87SK9Qp0Z9vkYI9BPYTOSFQMgVoTy82Jftx0=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 05:39:11 -0400
Message-Id: <DKA3RP12A8LU.2VD89MQ7G2KLL@lfurio.us>
Subject: Re: REBASE_HEAD still exists after success end rebase
To: "Long 76" <long76.git@mail.ru>, <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <edfc868b-6be6-4871-a539-e70791db216d@mail.ru>
In-Reply-To: <edfc868b-6be6-4871-a539-e70791db216d@mail.ru>

On Tue Jul 28, 2026 at 4:26 AM EDT, Long 76 wrote:
>
> In other words REBASE_HEAD exists if ogirinal commit in new branch=20
> modified and need call git push --force to send it to server. Please fix=
=20
> it, thanks!

I ran into this not that long ago too, while working on a script.  It
looked like this behavior depended on how the _last_ item in the rebase
todo list was handled.  I found if the last action was a squash or edit
(I don't think reword did this), then REBASE_HEAD was left behind.

Also, if rebase stops on a break command, then REBASE_HEAD will be
missing, even though a rebase is still in-progress.

I made a very short-lived effort to look into why this "bug" was
happening.  I say "bug" in quotes, because I'm not even sure if it is
even problematic behavior.

I solved my need at the time (detecting a rebase in progress) by
checking for the existence of either of the 'rebase-merge' or
'rebase-apply' directories in $GIT_DIR.
>
> --
> Long76
