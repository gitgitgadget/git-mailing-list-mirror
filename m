Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849253398
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500384; cv=none; b=hjItR9erhqHm2gUzj+V17rQAGNvyl7HfirG4qbTaW/glpPPDS9+MCYOnT7QRLY0Ax78wr63mMs6yAjKM2lCQNRteqlVi6V75IGDkqVQxvlsZLSmzFuHswGTx4nva3/DIjJG2mq03A9H0fAGPqtMm5gH2ZIyn8wbN36kkWg3SF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500384; c=relaxed/simple;
	bh=3Vf+9xp4zyKp0psRWy3QfOqyIoTEgjVXC36A3LX8WWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KoGVwiyd9FRt/YB7yCaAhS/4K4izB9nyeYqYs6lGZ6jG/Hi4VeICDsPPdExCmpVLgLM3jWmORZvLW6zYcsmrh3F4hWVMLAmhfViYnSr4+KkBU+CPzF6ud3Lo2q5igExpNp9UpLW1EMMN/xn7yyLEP8120CubOAeeKxe90rHsqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=buc8yANF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="buc8yANF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 573021AD35;
	Fri,  9 Feb 2024 12:39:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3Vf+9xp4zyKp0psRWy3QfOqyIoTEgjVXC36A3L
	X8WWg=; b=buc8yANF4/4oWQMpqBTbEPVf3tyYeRvkTAk4TYj4p2RD3f+CPSBxkL
	sPjQOfhmOo4uKhfb/iAoEvKkHf9YlskUpBkgZoOhE4CWkPG4hilWA44cqHZxxQMB
	Koigum4ccJNvET3tRoyn2o5vHoEuWfOHDlTxtsASAdBFtzT260Syg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5013E1AD34;
	Fri,  9 Feb 2024 12:39:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 742DC1AD33;
	Fri,  9 Feb 2024 12:39:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: Race condition in git-bundle(1) create when ref is updated
 while running
In-Reply-To: <87eddlpx5k.fsf@iotcl.com> (Toon Claes's message of "Fri, 09 Feb
	2024 14:40:30 +0100")
References: <87eddlpx5k.fsf@iotcl.com>
Date: Fri, 09 Feb 2024 09:39:38 -0800
Message-ID: <xmqq5xyxh6zp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 333CEB52-C772-11EE-B56D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Toon Claes <toon@iotcl.com> writes:

> I discovered a bug in git-bundle(1) create. There is a race condition
> happening when a ref gets updated while the bundle creation process is
> running.

"--all" that tells "traverse from the tip of all the refs" to any
rev-list family of commands (like log and bundle) eventually boils
down to opendir("refs/...") followed by readdir(), and if somebody
creates or deletes files while you are reading in such a loop,
readdir() may appear to skip an entry, which is understandable.
Even "git for-each-ref" would race with a ref update (which involves
removing a file and then creating another file at the same path), I
would think.  IOW, I do not think this is limited to "git bundle".

