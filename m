Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4281547F3
	for <git@vger.kernel.org>; Sat, 25 Jan 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793217; cv=none; b=oaiQ56/SY2FBj3ens8rE7yAksKSjD/a0tJaiw7vFIoJARnGE3wWl8YbLAGNjvW04eTyUS1W1wzqBUJ5B4rfdzJszk3FG48ZBNlMcSsbAgY6TvzmgkVK0CkL9KfHaiyuBlF1/b21DAYosdsGmE+oDOyQRJmAYKzZynjSo+N20qzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793217; c=relaxed/simple;
	bh=EKGC2lmJXfvF09vj1uWtlGHo2NY8uU1L3ZT/vKfEjYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTprL6SG+hX6XHLXLs7SKmHQe8+2XFdMBC8vdqiKLY69DJm7hccRt6gOCAWlRzVByhAmBdIlMWzGsJXHApPAH4lduOAePy9P8cBforb+pfnWTNae2OBnnNTNA7VwsXm37pU9gVVC7qi4v9Pu6kvuoK+/qmu021Fd15RQTiDIdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Yg7064SZKz7QSvJ
	for <git@vger.kernel.org>; Sat, 25 Jan 2025 09:20:06 +0100 (CET)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Yg6zy0tW9zRnlK;
	Sat, 25 Jan 2025 09:19:57 +0100 (CET)
Message-ID: <6acb9e8a-7014-4605-b8af-59c4584e9fe6@kdbg.org>
Date: Sat, 25 Jan 2025 09:19:57 +0100
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
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 25.01.25 um 06:41 schrieb Patrick Steinhardt:
> While this logic might be sensible in many callsites throughout Git, it
> is less when used in the reftable library. We only use unlink(3) there
> to delete tables which aren't referenced anymore, and the code is very
> aware of the limitations on Windows. As such, all calls to unlink(3p)
> don't perform any error checking at all and are fine with the call
> failing.
> 
> Instead, the library provides the `reftable_stack_clean()` function,
> which Git knows to execute in git-pack-refs(1) after compacting a stack.
> The effect of this function is that all stale tables will eventually get
> deleted once they aren't kept open anymore.
> 
> So while we're fine with unlink(3p) failing, the Windows-emulation of
> that function will still perform several sleeps and ultimately end up
> asking the user:

Why don't the changes that your commits ending at 391bceae4350
("compat/mingw: support POSIX semantics for atomic renames", 2024-10-27)
help in this case, too?

Since the reftable layer is aware of the problem, why don't we just fix
it there and instead sweep it under the rug in the compat layer?

-- Hannes

