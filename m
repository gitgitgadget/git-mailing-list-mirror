Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09C8C06
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234357; cv=none; b=AW94CSmUHIRJffPwRmUjvBb5ekRi4BhVu7fJFzrLhVahUjIvZuxrn6NZgL0+V2NwABPFaPHqkHtOP2Rmym08AtSjpi7wuI74sbOegwglGhijq49y1FaP0LITi+bUkTr5qLYVxJ5kvjJgXrRhdgkj5mbTnFEf98lwizl1w25tB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234357; c=relaxed/simple;
	bh=v7FQgmyGLkuhwsJFjKQDakyF+uah4q5dFOi+jDy4wWo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Htdf2IsPfHn/3YMI6L5DSFTLW1WxjzAG2EbpblSl31Utx1WtmQtIa7sbz9i+hTiBFqchHe6VLLH4OKPqhhy5e2EePePcWd2hSSXnoh+4rTC21kPGMYIr4R5TshrwMCvz6I3SaK0d+ZQjjHOw8IqNDLHsIwtE6Yi3IVAGIElCvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RJdFT02R; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RJdFT02R"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716234351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YG4IhvFULeen3QKgmOhF2ZnanQC8s2Yz00sj66fEQU=;
	b=RJdFT02R+5xv0sGjUXgxAMfcK6l6p+Gwcub0kpo7HkXNkADyhqcGYE/NyY2o0bozNLICX1
	EX1IUZsjgsDu0BRUc3mRlwwwSIYXFs3OWiR1iNjH81u4H2r1JOLz7YdxhIRFXRdlPE3LnP
	dvza56eC0b7QH6EhvczH79MOUhF1CbVzjyPBXl2mIy/ZU5BG2b31MoCLZon3odrqIAIzAJ
	qg4HsjtHGKN4zNJMSLMpgJ9/MM/TfcxRllwyoTXD/6e2w60wikCuu8/ml+lr8ah96JD/RQ
	s3eibJqa9Q7HQswzu4KqL0QHYfd5WrYr+agz/hJwPHQWGDw1ssfT/71JRdW6/Q==
Date: Mon, 20 May 2024 21:45:51 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <xmqqh6esffh1.fsf@gitster.g>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 <xmqqh6esffh1.fsf@gitster.g>
Message-ID: <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio and Ruben,

On 2024-05-20 21:30, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
>> Invoke the pager when displaying hunks during "add -p" sessions, to 
>> make
>> it easier for the user to review hunks longer than one screen height.
> 
> If the hunk fits on one screen, it is annoying to see a pager
> invoked and then torn down immediately, even with "less -F"
> (--quit-if-one-screen).  As we know how much output we are throwing
> at the user, we'd want to make this conditional to the size of the
> hunk being shown and the terminal height.
> 
> Or perhaps show them without such a trick, and add a new variant to
> 'p' that allows the user to request the output be sent to a pager
> (perhaps 'P')?  It would certainly be an alternative with much
> smaller damage.  The existing end-user experience would not degrade,
> but when the user wants to see a huge hunk, they can send it to the
> pager.
> 
> Another, ulteriour, motive here behind this suggestion is to
> encourage users to work with smaller hunks.  Being able to scroll
> around and view lines on demand (i.e. use of pager) is one thing.
> Being able to view all relevant lines at once (i.e. not wasting
> vertical screen real estate and making things fit on one screen) is
> very different and much nicer.

There's another thing to consider, which makes the introduction of
"P" as the new option even more desirable.  Let me explain.

With the upcoming changes to the way less(1) as the pager works,
which was already discussed at length and even required new features
to be implemented in less(1), [1] displaying anything through less(1)
will not leave an accessible scrollback in the terminal emulator.
Only one screen worth of text will be displayed, even after quitting
less(1).  That's what we have to do, to fix age-old issues with the
pager-generated scrollback that easily gets corrupted and actually
becomes misleading.

Thus, if someone wants to have a complete longer-than-one-screen hunk
displayed and use the terminal emulator scrollback to inspect the
hunk in its entirety, passing such (or all) hunks through the pager
would make such inspection impossible.  I'd assume that at least some
Git users already do that (I do, for example), and we surely don't want
to make that no longer possible.  That's why introducing "P" as the
new option would be the desired approach.

[1] 
https://lore.kernel.org/git/8289ef15266172cbfa10bb146afe9797@manjaro.org/
