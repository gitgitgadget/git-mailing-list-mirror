Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3247125E
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657211; cv=none; b=kXpDVAgGGb90NTELbZ/sF5/aGR1tXJqvdQ2ptwmYQL3z0rk0sdGl9TH1G1E2UbCLOVy6HK6e+/eCXfJm82+WC9TmJY5GJUFI1PaBSk+C9rtubUxeUhZCvKJEyUFG08KjbRzNd0nHISctF25ZolSp74CvfaXekSuRVO643PR4cds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657211; c=relaxed/simple;
	bh=brzec4A88YUXxzDFh79z0xq/j9sqCfidcWIKHuBxpao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLPNxCuDoJH4NwWWjXNTkgZp28hdn4fbSVhb/0cRNoZvr6zi/h87f5+K3yrmQK56JdWZc/8v27Ps+uHAvxxEi0rmduulZCimiZQwBfNteMj/3rxXqyk2N4Rn6WeI5BOBWznvNOyTZfH6OZHjEQILdS7mFCSGFybLd7xv016vrgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=uIXkuXQa; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="uIXkuXQa"
Date: Wed, 22 Jul 2026 02:06:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1784657205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeH7JiCogo+tny25dRtK2hLnThJSIvArl7B7ni8ARr8=;
	b=uIXkuXQaxxjdgE/7oUojDL0u/fT9BjDWUTpB1MgMNKIObgtF3VLk9Aer9ZnfReCUbR0zhx
	bPgqHRA5Il97lIeMrvNZEzAhmzBfllMFebAH4PF4JlWgS1Iizwps8OQiipBSa2JETcbMTb
	+2DAcC1YPa8ckJYeCxSDJZkTyS2mAM/tkR7ZCQOfKpZF7wCWOBG2UfybB5VzO/jhxnYrSf
	WN68vUZeYbLO6ECYmN3Teg6uG/vSfdo1vfJ+s+n0dd/Wi1w2Mx++qoLeCUYPZVI96BP/y/
	JxFZBK8lT5yLDmaU5nrmYIbdA+WaL5bJNfxV4y+ZHHBb2jrTCOX91w29HNtaYQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Jamie Magee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jamie Magee <jamie.magee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0213: skip ancestry tests under user-mode emulation
Message-ID: <al-1JkcH91aW6VWM@wyuan.org>
References: <pull.2168.git.1783359242130.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2168.git.1783359242130.gitgitgadget@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 06, 2026 at 05:34:01PM +0000, Jamie Magee via GitGitGadget wrote:
> From: Jamie Magee <jamie.magee@gmail.com>
> 
> The tests added in 3c8c638df6 (t0213: add trace2 cmd_ancestry tests,
> 2026-02-13) expect the cmd_ancestry event to name "test-tool" and
> "git". On Linux those names come from the "comm" field of
> /proc/<pid>/stat. Under user-mode emulation (e.g. qemu-user) /proc
> reports the emulator ("qemu-riscv64") instead, so the event is still
> emitted, the TRACE2_ANCESTRY probe enables the tests, and tests 2-5
> fail even though they pass on native riscv64.
> 
> Require the probe to see "test-tool" in the ancestry of a test-tool
> spawned from test-tool, so the tests skip when the names are unreliable.
> 
> Cc: Matthew John Cheetham <mjcheetham@outlook.com>
> Signed-off-by: Jamie Magee <jamie.magee@gmail.com>
> ---

Very sorry to say something completely outside the patch.

But may I ask what's the point of writting the line started with "Cc:"?
I know that Linux kernel has something about writting Cc in the commit
message, while I don't see much from Git's documentation about trailers,
including MyFirstContribution and SubmittingPatches. Although I know
that "git send-email" and "git interpret-trailers" could use "Cc:", I
still wonder whether using this trailer is encouraged or not. If so,
adding some decriptions about it would be nice, I guess, since I was
confused when reading kernel docs about using Cc trailers in the commit
message sometime ago.

Sorry in advance if I missed any context.

Thanks very much.
