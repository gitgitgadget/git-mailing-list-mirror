Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95F539A
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="pOQJ5HK9"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704030525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ak9cWBiSOji/9xMX1A4qvv5NSw9kkBrrcGBAiGlJtD0=;
	b=pOQJ5HK9sWRQEVjhjl54VyD49L07ESFNekBfa5pufqyn66nabiJN3F1YElQ6Of0UfxiKua
	b6VkYMaPU+p5jJcz2EONf4O8HF1KA/mF360bKhS2nQiRzOvUlYVYhPjBtu0BJ7IGPwoGwm
	hi2gvsKC6yL08GVtJsrmaPD2PNF1Jwu6mytkC8hK+w9GyrIwfYuQBDg5Io7pSD4qOHfAmJ
	o9yl1wtz8EEgjBaPuR1PZupCA3+aSC/AORB/G/euuORL+2GAKe7ZUVbesdlTaBuSe7zk0A
	dPAaPO+Zar55AipQQYUCvIc8BL2gqKSk68dGSsvCatL12g3V0zRV48SXTjOUPw==
Date: Sun, 31 Dec 2023 14:48:45 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org
Subject: Re: Concurrent fetch commands
In-Reply-To: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
Message-ID: <0a98597e270276c67a7aafae20c6d073@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-12-31 14:30, Stefan Haller wrote:
> Currently, git doesn't seem to be very good at handling two concurrent
> invocations of git fetch (or git fetch and git pull). This is a problem
> because it is common for git clients to run git fetch periodically in
> the background. In that case, when you happen to invoke git pull while
> such a background fetch is running, an error occurs ("Cannot rebase 
> onto
> multiple branches").
> 
> I can reliably reproduce this by doing
> 
>    $ git fetch&; sleep 0.1; git pull
>    [1] 42160
>    [1]  + done       git fetch
>    fatal: Cannot rebase onto multiple branches.
> 
> The reason for this failure seems to be that both the first fetch and
> the fetch that runs as part of the pull append their information to
> .git/FETCH_HEAD, so that the information for the current branch ends up
> twice in the file.
> 
> Do you think git fetch should be made more robust against scenarios 
> like
> this?

I believe a similar issue has been already raised recently, so perhaps 
introducing some kind of file-based locking within git itself could be 
justified.  It would make the things a bit more robust, and would also 
improve the overall user experience.

> More context: the git client that I'm contributing to (lazygit) used to
> guard against this for its own background fetch with a global mutex 
> that
> allowed only one single fetch, pull, or push at a time. This solved the
> problem nicely for lazygit's own operations (at the expense of some 
> lag,
> occasionally); and I'm not aware of any reports about failures because
> some other git client's background fetch got in the way, so maybe we
> don't have to worry about that too much.
> 
> However, we now removed that mutex to allow certain parallel fetch
> operations to run at the same time, most notably fetching (and 
> updating)
> a branch that is not checked out (by doing "git fetch origin
> branch:branch"). It is useful to be able to trigger this for multiple
> branches concurrently, and actually this works fine.
> 
> But now we have the problem described above, where a pull of the
> checked-out branch runs at the same time as a background fetch; this is
> not so unlikely, because lazygit triggers the first background fetch at
> startup, so invoking the pull command right after starting lazygit is
> very likely to fail.
> 
> We could re-introduce a mutex and just make it a little less global;
> e.g. protect only pull and parameter-less fetch. But fixing it in git
> itself seems preferable to me.
> 
> Sorry for the wall of text, but I figured giving more context could be
> useful.
