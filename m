Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F44A9B2
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jweX71+H"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704896298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4UiQVQT71YoF79pBpJxgBqEd3N3oIt9kcyjufZ+LvA=;
	b=jweX71+HVkA0ZZWQTKp/LtA0Qe1aG81eRRA+nEF+w0ieVGXQkz4Kg2FcZJlu/h3UXabl10
	OOB+xJcWiaAiZMtHBCwoy1nPoyAZzDiiIeBBIvP7ul1+HXrRxBg6wndzCF4V3eSRDPO0pd
	bt5IlxAnTzGk9fZBokWFkuPPaAbGwq/hGi2WtTeFi3YV50DdRJFxG9HOpQzEJaU+wLYTde
	sQwlRf0ZWt+kHyqIeEmYxFK/r7+ui+iAtgGUoMq/NnwO+5+ufMxktLGOdP7phCAiExKs/J
	wj5nxcqltIxO0dB5n64LFX5txM7gop99/F3YErYD6aC0UJfCii+ulUmRH9SCdA==
Date: Wed, 10 Jan 2024 15:18:17 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jeff King <peff@peff.net>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <20240110110226.GC16674@coredump.intra.peff.net>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
Message-ID: <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-10 12:02, Jeff King wrote:
> On Tue, Jan 09, 2024 at 04:30:16PM +0100, Rubén Justo wrote:
> 
>> Using advise_if_enabled() to display an advice will automatically
>> include instructions on how to disable the advice, along with the
>> main advice:
>> 
>> 	hint: use --reapply-cherry-picks to include skipped commits
>> 	hint: Disable this message with "git config advice.skippedCherryPicks 
>> false"
>> 
>> This can become distracting or noisy over time, while the user may
>> still want to receive the main advice.
>> 
>> Let's have a switch to allow disabling this automatic advice.
> 
> If I'm reading your patch correctly, this is a single option that
> controls the extra line for _all_ advice messages. But I'd have 
> expected
> this to be something you'd want to set on a per-message basis. Here's 
> my
> thinking.
> 
> The original idea for advice messages was that they might be verbose 
> and
> annoying, but if you had one that showed up a lot you'd choose to shut
> it up individually. But you wouldn't do so for _all_ messages, because
> you might benefit from seeing others (including new ones that get
> added). The "Disable this..." part was added later to help you easily
> know which config option to tweak.

Just to chime in and support this behavior of the advice messages.  
Basically, you don't want to have them all disabled at the same time, 
but to have per-message enable/disable granularity.  I'd guess that some 
of the messages are quite usable even to highly experienced users, and 
encountering newly added messages is also very useful.  Thus, having 
them all disabled wouldn't be the best idea.

> The expectation was that you'd fall into one of two categories:
> 
>   1. You don't see the message often enough to care, so you do nothing.
> 
>   2. You do find it annoying, so you disable this instance.
> 
> Your series proposes a third state:
> 
>   3. You find the actual hint useful, but the verbosity of "how to shut
>      it up" is too much for you.
> 
> That make sense to me, along with being able to partially shut-up a
> message. But wouldn't you still need the "how to shut up" hint for
> _other_ messages, since it's customized for each situation?
> 
> E.g., suppose that after getting annoyed at advice.skippedCherryPicks,
> you run "git config advice.adviseOff false".
> 
> But now you run into another hint, like:
> 
>   $ git foo
>   hint: you can use --empty-commits to deal with isn't as good as 
> --xyzzy
> 
> and you want to disable it entirely. Which advice.* config option does
> so? You're stuck trying to find it in the manpage (which is tedious but
> also kind of tricky since you're now guessing which name goes with 
> which
> message). You probably do want:
> 
>   hint: Disable this message with "git config advice.xyzzy false"
> 
> in that case (at which point you may decide to silence it completely or
> partially).
> 
> Which implies to me that the value of advice.* should be a tri-state to
> match the cases above: true, false, or a "minimal" / "quiet" mode 
> (there
> might be a better name). And then you'd do:
> 
>   git config advice.skippedCherryPicks minimal
> 
> (or whatever it is called) to get the mode you want, without affecting
> advice.xyzzy.
> 
>>  advice.c          | 3 ++-
>>  advice.h          | 3 ++-
>>  t/t0018-advice.sh | 8 ++++++++
>>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> Speaking of manpages, we'd presumably need an update to
> Documentation/config/advice.txt. :)
> 
> -Peff
