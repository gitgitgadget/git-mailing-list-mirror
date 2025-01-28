Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668495789D
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738047180; cv=none; b=dsIpcddva5z2240itU2d1giLNBgD2MC61t1JVHIrWtMlp2c3PHTJex3JRNzpOdOEUz7ZfA3xe1TYobFkvtNLVdduz9nA6pe/A3dhAFLdGvZwbo4Tqp0wYIxZY+RowMAPtVIbcgTpiUZI9Vs4bRHYqvrbksgs6Nc+mClDtuRRuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738047180; c=relaxed/simple;
	bh=5HuklN3i1wu7zg0cpFPLglQt8yzpNWvEWInQdX7xrFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+eMIrgS06zKB+6+bU6e8vZ51UMkwH2zlHhYOzj76oR3Jh8ohw+FBzdvh2e1GN8HvXhFgXJiSXHTNubRVjyPLR9sqmy8ctxICHR5XFKgs9wNrqXJreeQBNdaNnmJvVgo7pO+S+4QKXRlUeW/biGqzpmVyygNBg9W9Hq8PuPTr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Yhww13LvdzRpKy;
	Tue, 28 Jan 2025 07:52:49 +0100 (CET)
Message-ID: <b9b548e0-e42e-4854-92f2-337a26f692ac@kdbg.org>
Date: Tue, 28 Jan 2025 07:52:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reftable: ignore file-in-use errors when unlink(3p) fails
 on Windows
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Reich <Zottelbart@t-online.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
 <6acb9e8a-7014-4605-b8af-59c4584e9fe6@kdbg.org> <Z5ShoLCWREAsWZVh@pks.im>
 <267314c0-3aba-4f69-9f41-89392391290f@kdbg.org> <Z5c6VlsdNXwYkUsv@pks.im>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Z5c6VlsdNXwYkUsv@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 27.01.25 um 08:48 schrieb Patrick Steinhardt:
> On Sat, Jan 25, 2025 at 03:28:28PM +0100, Johannes Sixt wrote:
>> Am 25.01.25 um 09:32 schrieb Patrick Steinhardt:
>> Instead of calling _wunlink() in mingw_unlink, we could CreateFileW()
>> with access mode DELETE and flag FILE_FLAG_DELETE_ON_CLOSE, then close
>> the file right away. That would apply semantics that is similar, but not
>> quite, POSIX at least among the files that we open ourselves.
> 
> Huh. And that works even when the file is still being held open by other
> processes?

Only if the process cooperates and has opened the file with
FILE_SHARE_DELETE. So, in general, no.

I think, Cygwin implements unlink() in this manner.

> I have a feeling that there's a misunderstanding here, either on my side
> or on yours. It's the rest of Git that wants to have POSIX behaviour for
> `unlink()`, not the reftable library.

Yes and no. Yes, we expect to be able to delete a file that was opened
by some *other* Git process (e.g., packfiles during gc), but, no, we do
not delete files that have been opened in the current process and are
still open.

For this reason, I am arguing to remove the interactive part of
mingw_unlink() and use the cooperative strategy I mentioned above. That
gives us POSIX-like behavior for concurrent Git processes.

The interactive question is only useful when the user has control over
an uncooperative process that keeps a file open for an extended time and
can find that processes, which is either obvious or extremely difficult.
As I said, I haven't seen the question since a long, long time now, but
I am also the first to admit that my way of using Git is rather narrow.

-- Hannes

