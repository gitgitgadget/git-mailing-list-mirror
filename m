Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4A4A093C
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008885; cv=none; b=Rm2DyuEkN3Q1AtO1OluNZrtqcaGbA+YpEetlpnfAExk4999TThgK4K/eGE/9q1HS0rK/x0CenVNJmiKeXURPEmXoO3ZHNpZAQF/tl+XyX74PCCN6MAVNJRwpJ1js6Vkeb3PEkt3R6YJ20uxWgxLo/WDkV+GBAaM+4/XWefrItJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008885; c=relaxed/simple;
	bh=5+7m7EnXbTfrBbKWKpe780epM9w/MezsqJPROqBcoFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CedLSFkZ4dWFo26DsFlcD4HSZMLEdB9tSVM1+TLr6Z1r8+8woB0J3zFxn4VbDSyKI+oyxGw8VwDPLP2SC5k0sNH4kvUpuk38rczMaOn2mVIfjcshRwlQsoJE4Fl4Ph2pJltrawsKn//i0sNqhJGMWM4aNNe2FRIWBerXnM0I004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hpTWY6n2Sz7WGbJ
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 18:41:13 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hpTWP0gCPzRpL9;
	Mon, 21 Sep 2026 18:41:04 +0200 (CEST)
Message-ID: <4c88bb3c-4005-41bc-8ff5-9b8597aa05eb@kdbg.org>
Date: Mon, 21 Sep 2026 18:40:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bugreport: git log -L
Content-Language: en-US
To: Nikita Makarov <n.makarov@yadro.com>
References: <41c54b809eb1490fb467ba0fd4c5a8cf@yadro.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <41c54b809eb1490fb467ba0fd4c5a8cf@yadro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.09.26 um 09:45 schrieb Nikita Makarov:
> Hello, I have the found the strange behavior of "git log -L" command
> with python function. It is counting a blank line that sits after a
> function's last statement as part of that function. This happens
> only when the function is at the end of a file.
(No, it happens all the time, not just at the end of the file.)

> Though I expect that commit "c2" should never appear in log, since
> the changes from it doesn't affect the functions body at all.
Most likely, Git has successfully kept up the illusion that it knows
what "a function" is in your programming language, because you have
frequently seen function names in hunk headers.

But the truth is, Git doesn't know. For the purpose of `git log -L
:function_name:file`, Git uses the same pattern as for the hunk headers
to determine function boundaries. In particular, a function ends right
before the next function begins (if there is one). By this metric, any
blank lines (and comments!) before the next function count to the
previous function.

So, what you are seeing here is to be expected for the lack of a better
notion of what "a function" is.

If we are to improve on this, then a more serious problem to fix is that
comments above a function do not count to the function that they
document, but to the previous function.

-- Hannes

