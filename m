Received: from mail.cendio.se (mail.cendio.se [193.12.253.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078531C173D
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.12.253.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958447; cv=none; b=nrbFGuMG3HKb61AcxtovVnGTNnjf63xyeb0aAL3Ifs2CCdyo+NA12o9CQohngOh5+qHgLsCHPX7doo0r679HT1Xy0uqgIs9PGxTqlKcCL/5aigxfwh/UAEo4w4DSCNyuSSUl0TzXaNSZyPUrTJhhnnvrvii3OwIMHuU0KppzWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958447; c=relaxed/simple;
	bh=+HT1kifwzdqnHP+oZPfQ9hi6l1YxbGzUCqVBL6HQ4PY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BqvxiAUSTH6KC9nz9K3NxqNBlRAEQgUCjWq5jp1bVAXuoADtRGspmAX018W+uwbOasms0blvv3QjPfIXAywJjV3bnWrQzOMavrL8pDtWpKY1WaqpQ4BnPunyT9phx4WuHYJmHlRJDhwHiWMWjgMF33i4/Df2bQGo1ydCVgbrp2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cendio.se; spf=pass smtp.mailfrom=cendio.se; dkim=pass (2048-bit key) header.d=cendio.se header.i=@cendio.se header.b=diOWqeeT; arc=none smtp.client-ip=193.12.253.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cendio.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cendio.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cendio.se header.i=@cendio.se header.b="diOWqeeT"
Received: from [IPV6:2a00:801:107:4700:e2be:3ff:fe9d:f27] (unknown [IPv6:2a00:801:107:4700:e2be:3ff:fe9d:f27])
	by mail.cendio.se (Postfix) with ESMTPSA id 784271835C13
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 10:38:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cendio.se 784271835C13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cendio.se;
	s=20250112; t=1739957906;
	bh=nDKjgog5kjx/F/JJMo0Qbs9xIu8zVGL4msoG8LQex08=;
	h=Date:To:From:Subject:From;
	b=diOWqeeTyzQQkx0UE1qhx/IJN0TKhR0CStAuVYFBiYT0djjwTmmaJjV8H7yYd9S9j
	 bZ5h80gGnEm8ZVGLtrtDIKkUHSH0Pi56njs2cPTMAQJgf6HceUQ9qvkMU6z2uruW0E
	 wVzArhAO/53JEocg04o3gzUEbqRdjansS5Bjkdsuz2iGiiVj9SKLc54y/2igV7ayZY
	 9oCss2QeX2mVJjgds6pBHR0gnVEJZ77w5ZoE7cn+HjxGXiPiSlyPmcJRWwVr24lVmd
	 7ql9q6/PWeUeCrsJEOC8TiM/VWnl9YpZqDWqm13mipPTqAn2nS0zMI5st8Lqxnsrm9
	 Wrn9y/FYREtNg==
Message-ID: <1524b9a5-6f8b-4537-ba6b-bdfdd4b1bdcb@cendio.se>
Date: Wed, 19 Feb 2025 10:38:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Pierre Ossman <ossman@cendio.se>
Subject: git keeps recreating packs, exploding backup increments
Organization: Cendio AB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I'm trying to understand git's repacking behaviour, as the observed 
behaviour doesn't match how I read the documentation or the code.

The problem we see is excessive backup increments for developer 
directories. The cause is that pack files keep getting regenerated for 
large repositories.

Users are not running 'git gc' manually, so the assumption is that this 
is caused by 'git gc --auto' being run implicitly.

 From what I can see in the code, and the documentation, it should only 
pack up objects not already found in existing packs. Or at the very 
least, not the objects found in the largest existing pack.

(at least not until gc.autoPackLimit is hit)

But this isn't happening. Old packs are constantly being replaced by new 
ones. Despite most of the objects being old and stable.

We tried gc.bigPackThreshold in the hope it would force it to reuse 
packs better. But all we got instead was duplication. It still creates 
new packs with everything. It just stopped removing the old ones.

Some guidance would be appreciated. I cannot find anything in the code 
or documentation that explains the current behaviour.

Regads,
-- 
Pierre Ossman           Software Development
Cendio AB               https://cendio.com
Teknikringen 8          https://twitter.com/ThinLinc
583 30 Linköping        https://facebook.com/ThinLinc
Phone: +46-13-214600

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

