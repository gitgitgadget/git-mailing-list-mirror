Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE233F8DC
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460610; cv=none; b=O73asm+lEzpnq5VTpQ4HblbVmh9+cVmiAJdIA0dT18/fL/kbZzs4143OoqEEOR7yv6j4l2eamHk0ogkKHvtrtkKfNxIMrSWD2qUtwb6O6i/Hdk/ccg2XQ2HxnbmcD2KaRBS7iJy0zhEjGhx8gSK9mkWSxSvCzZ9kRyuCpeCmBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460610; c=relaxed/simple;
	bh=353mps+XtiAigGXQYpYl5cy18ZYW9IGt9CTGB44uWiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Decef4BDQQDpBkMbLqBq7FUBryRUxF/cqQQ9c/jgWiLuZehtbuB7pQZ3/mqyUfi83Bq18qsesqRpWgSp8eLVi6QKgRL3wzKgBj8amjlIhQjJ9Nq28JDLmTxJl3k5a7iFz0qmxAJhrX6GxVk0XXoyhpJyNJ+UdRL1BXVZ81bymvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hbRv36BwZz7Ryb6
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 19:49:51 +0200 (CEST)
Received: from [192.168.1.103] (089144201115.atnat0010.highway.a1.net [89.144.201.115])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hbRtv0WMqzRpWr;
	Thu,  3 Sep 2026 19:49:40 +0200 (CEST)
Message-ID: <51211bf8-caa6-4aa4-82fd-c80d9b378ea7@kdbg.org>
Date: Thu, 3 Sep 2026 19:49:40 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: drain the cat-file pipe before closing it
Content-Language: en-US
To: chib <chib@foxmail.com>
Cc: chib via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2216.git.1788452262806.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2216.git.1788452262806.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 03.09.26 um 18:17 schrieb chib via GitGitGadget:
> From: chib <chib@foxmail.com>
> 
> commit_committree opens "git cat-file commit <parent>" to read the tree
> line for the empty-commit check, reads only the first line, and then
> closes the pipe while the rest of the commit object (often several
> kilobytes of commit message) is still unread.
> 
> On Linux this is harmless: the child process dies of SIGPIPE when it
> keeps writing, and that is not reported as an error when the pipe is
> closed. On Windows there is no SIGPIPE: the native git.exe gets a
> broken-pipe error when writing and exits with a non-zero status. Tcl's
> [close] then surfaces that as "child process exited abnormally", the
> commit is aborted, and the index lock is released with nothing
> committed. The failure only shows up once the parent commit's object is
> larger than the pipe buffer: in testing with Git for Windows 2.52,
> objects up to ~6.5 KiB always succeed while objects of ~9 KiB and up
> fail 10 out of 10 times (the threshold is around the 8 KiB pipe
> buffer). Amending a commit with a long message therefore triggers it
> reliably while short commits slip through.

Nicely analyzed. While this all sounds sensible, I am unable to
reproduce the failure on Windows. (But I use my own build, not Git for
Windows.) I made a tiny change, then inserted a lot of text in the
commit message field (18k), and committed. Then I clicked "Amend Last
Commit", changed the commit message slightly, and committed again. No
error. Do you have instructions how to reproduce the failure?

> Reading the pipe to EOF
> before closing fixes it 10 out of 10 times, and is harmless on POSIX
> platforms where the same test succeeds either way.
> 
> Read the rest of the pipe before closing it, mirroring what the amend
> path already does when loading the parent commit's message.

You can't compare this case with the "amend" case, because "amend" needs
the commit message. The usual way to stop that 'close' complains is to
wrap it in a 'catch'.

> Signed-off-by: chib <chib@foxmail.com>
Please use your full name as author and to sign off, not a nick name.

-- Hannes

