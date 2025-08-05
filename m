Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69AC2701D6
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402143; cv=none; b=tSJnV/w97n83YWuporaYA2LiDsfXcp2anG8Rw5lzosjUwaESEwWZ3gX/L1BV+68S84gZ6vt91iZCLU11LGJ0mqtDfkcxWpNDqKbKUm5Fscw97HhCyaZs8cw7aZEV/vXL3aI/7xvTsmMeQ3OuMIlsc8HMhQV5d+AUVObl+YOm4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402143; c=relaxed/simple;
	bh=I3cy+bpdZiPv1Xpg7NFizSlIhL8SVvSjKZnAODaQO9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KKtexCE0YWAmdYF3vgyuvTxUlV3vW1O+A/VTccBRjWzAy0zLoQjvG7MHQHVBlGJDiGmNBlGsacOpJ6WMUJmBrBEIUgLpvJ7kyDEVxylnyyXM64qRzUmb2i/7IDx6EuTagtC8ntq3Y7L7DllkS9i11Ga7f/1ZZ3hmq7DbgOGBlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=j0nIyXf3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="j0nIyXf3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754402136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhIYe1HksnTuLWErtFE5MUP5dGsae98kPdLVuUphDtk=;
	b=j0nIyXf3PYq0EdmtSJs6ixnOcfxpXAj4p9K94c26tsN3feGW1aCuXQsdJKKKesjoTVPeOr
	osvi/qUUsWoC4H9/jwPQ0uywizDy5T2ZRSdyW+Q9Q4i6Rjv4GToE/Ga1b+c/j4tuJ1eRkV
	2YfJ/wY0SuCqGRm+AeJ1ii6opBwJt5w=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2025, #02; Mon, 4)
In-Reply-To: <xmqqectr57ax.fsf@gitster.g>
References: <xmqqectr57ax.fsf@gitster.g>
Date: Tue, 05 Aug 2025 15:55:25 +0200
Message-ID: <87y0rxub3m.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * jt/archive-zip-deflate-fix (2025-08-02) 1 commit
>   (merged to 'next' on 2025-08-04 at 4444b611dc)
>  + archive: flush deflate stream until Z_STREAM_END
>
>  The deflate codepath in "git archive --format=zip" had a
>  longstanding bug coming from misuse of zlib API, which has been
>  corrected.
>
>  Will merge to 'master'.
>  source: <20250802220803.95137-1-jltobler@gmail.com>

I see this was merged into 'next' with 4444b611dc (Merge branch
'jt/archive-zip-deflate-fix' into next, 2025-08-04), but was reverted
again in 5297b08916 (Revert "Merge branch 'jt/archive-zip-deflate-fix'
into next", 2025-08-04)

The fix in this patch definitely was the correct way forward, and it
fixed the issue at hand. So I don't think it should have been reverted.

I've sent a review and some patches in response, suggesting for an
alternative fix. I'm not claiming my fix is better, and it might
introduce other bug. I don't even know if the changes are even required.

To dive into the details: The output buffer for the compressed data is
twice the size of the input buffer. There is no reason to believe this
would cause any issues.

So currently I'm more in line with Justin, and I agree with the
pragmatic approach to only fix the issue we know is an issue, while we
keep the number of changed lines minimal.

Sorry for the confusion and for bringing in a concurrent series of
patches. Please ignore those and continue with this patch from Justin.

-- 
Cheers,
Toon
