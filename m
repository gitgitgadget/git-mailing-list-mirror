Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB627AC28
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033989; cv=none; b=SknfXRikffLQCeh3vINWF4OEQ1JOOCWfhJpvzvLxqERBJunwk457YF8kwxaIS90zC+WI17HxTiXc9Qja79RURk39Q+Kx/SgQppKQilEKicaqs1yOKuRvr0hKHMlZ/YHTtWEubeJkEFhnCneVNhmrqydWKQj6keTW8YEZvvEY1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033989; c=relaxed/simple;
	bh=OWJZK9Bq4LiYzDq+PZL7ev+2jNDripQtBUl8BLBPMjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYszgtrgYQkdOjQavTpfEFJ1+V48nJIt6NgomlvF8I2KbEnTXv0S6i3Or1B2zwb9y65ZKN4mL2TPjTe5W4q2l3SjN+uqEgRTMCsgBwhs0AWr/G1owrBkm3LSLlee8IvLpMQ7P/gW9p4klozDj1HnLpse2Q86GD7ffQqJj0cHVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Doc6PCul; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Doc6PCul"
Received: (qmail 291972 invoked by uid 109); 21 Oct 2025 08:06:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OWJZK9Bq4LiYzDq+PZL7ev+2jNDripQtBUl8BLBPMjw=; b=Doc6PCulD5s6RqylE44RLhS7BOU5SQwdwQ33E0pmg3YHb1sOMoi8FGny4Noo6qgaP9kWGSwzSEiNtddElTq6NbzMfuIO99SwMIJNUjn1o8bZ/e4jRxCz2tKuUCIFvtAOsCu6y+H09d1wP2rYdI44gGD/VIAKwhB+E62tvsP3wmEZGo09V4HT7tY8IwAUjozov+aNU9MfQMaMcd/5rCWsXCbt6mOpnE7gvJvauda+8AO+seOl2aDbRAOm09lMi+kdOeQHsbxwiM5ojqoodpShTtxPENN0UUeHlHi4wi53vdtmn6p59R4jL3fwdrTDaKA7XJGHO3ExzTc35fGAEf8n8A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Oct 2025 08:06:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 454988 invoked by uid 111); 21 Oct 2025 08:06:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Oct 2025 04:06:26 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 21 Oct 2025 04:06:25 -0400
From: Jeff King <peff@peff.net>
To: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] macOS: queue for munmap operations
Message-ID: <20251021080625.GD259661@coredump.intra.peff.net>
References: <pull.1993.git.1760999702581.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1993.git.1760999702581.gitgitgadget@gmail.com>

On Mon, Oct 20, 2025 at 10:35:02PM +0000, Koji Nakamaru via GitGitGadget wrote:

> From: Koji Nakamaru <koji.nakamaru@gree.net>
> 
> Executing many mmap/munmap calls alternately can cause a huge load on
> macOS. In order to reduce it, we should temporarily store munmap
> operations in a queue and process them all at once when the queue is
> filled. When the program terminates, we can discard any remaining munmap
> operations as corresponding mmaped regions are automatically reclaimed.
> 
> Add a queue for munmap operations to perform them all at once.
> 
> Here are some example timings. On the Linux kernel repository that
> requires about 1700 mmap/munmap calls:
> 
>   time git ls-tree -r -l --full-tree 211ddde > /dev/null

Why is it doing so many mmap calls? Do you have a ton of loose objects?
We have to mmap loose objects individually (because they're all in
separate files), but each pack only gets a single map (well, there's a
window parameter, but it's 1GB on 64-bit systems, so you should get a
handful of maps at most).

If you run "git gc", how does the resulting ls-tree perform? I have only
27 mmap() calls on my system.

I know that running "git gc" is relatively expensive, but it is also
bringing other optimizations (like the fact that we don't have to open()
and map each of those files in the first place!).

> On a private repository that requires about 943000 mmap/munmap calls:
> 
>   time git ls-tree -r -l --full-tree xxxxxxx > /dev/null

Ditto here. I'd be curious how well packed the repo is, and how it does
after a repack. If it has a very large packfile, you might also try:

  git config core.packedGitWindowSize 4G

or similar (though for just an ls-tree, we should only be looking at
tree objects, which in general I'd expect to be in a confined area of
the packfile; so the 1GB window is probably plenty).

> +int git_munmap(void *start, size_t length)
> +{
> +	static pthread_mutex_t mutex;
> +	static struct munmap_queue *queue;
> +	static int count;
> +	int i;
> +
> +	pthread_mutex_lock(&mutex);
> +	if (!queue)
> +		queue = xmalloc(COUNT_MAX * sizeof(struct munmap_queue));
> +	queue[count].start = start;
> +	queue[count].length = length;
> +	if (++count == COUNT_MAX) {
> +		for (i = 0; i < COUNT_MAX; i++)
> +			munmap(queue[i].start, queue[i].length);
> +		count = 0;
> +	}
> +	pthread_mutex_unlock(&mutex);
> +	return 0;
> +}

Does batching those unmaps actually make them faster? Or is it just that
the commands you showed did not fill the queue, so we essentially just
leaked all of those maps until the program exited?

If the latter, then I'd wonder:

  1. Does this increase memory pressure, since the OS has no idea we're
     not actually interested in those maps anymore? Some of them can be
     quite large, if the command is looking at blobs.

  2. How does it perform on a command that actually fills the queue? I
     guess something like "git log --raw" might do it (though if my
     guesses above are right, you'd need on the order of 64,000 loose
     trees).

-Peff
