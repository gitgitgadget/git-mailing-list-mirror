Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B212D747
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709682703; cv=none; b=Pylc0h1yk0Km6a6291B/3ZSnm3suFfKpf9tv5V4VR+rM2ceBoLlXo0oITcPZj/IEuFn1CQHj93j5IbaKhah2X6FmhnB3Ax5imZ/AyxBFsEleu93sB7kCdpNP5ajplSs1K6O+b6I5IpXH7vN1ZIZK4Y60h+7Gj1ueqBdnbTRtMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709682703; c=relaxed/simple;
	bh=dd4WK5bFzvgw684BBVq+BJwtxMSTN7N02JSTDUYJDsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fmxWd5Yl/HmiMIzrY+gRM+rYlc8DrhSps30ti81obOkbYFlpiQcIU+Iq2MDo43XwE3s1eMtZCr6qAt10uQGY47BJyy3rkj0nbnM/UKwEL54H8ewtXqEyRpoIHn4/w5zbDNnyx0GSrQO3RPKLrzPTjbYT/QheOaPBqxODmmZLXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XCXH48gQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XCXH48gQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CA3F618B35;
	Tue,  5 Mar 2024 18:51:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dd4WK5bFzvgw684BBVq+BJwtxMSTN7N02JSTDU
	YJDsM=; b=XCXH48gQHozSgtxmMYTP9n4s4cTUNc263ZTOVHIWYTZSznZmuMtRq1
	HTfcO3LsRtjG66zfWbssrjcKUkAdmNg+BtI1EI0Ku+sZbUh9EpJfFYBnqrqoeQbf
	TFGweZj5SfDLC/V4IPEs3Knb8Wy/yPkUSaaKNE4REs2i8+5hxYhYc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C255018B34;
	Tue,  5 Mar 2024 18:51:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 62D4C18B33;
	Tue,  5 Mar 2024 18:51:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>,  =?utf-8?Q?Ren?=
 =?utf-8?Q?=C3=A9?= Scharfe
 <l.s.r@web.de>,  Elijah Newren <newren@gmail.com>,  Philippe Blain
 <levraiphilippeblain@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/22] avoid redundant pipelines
In-Reply-To: <20240305212533.12947-1-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:24:59 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 15:51:36 -0800
Message-ID: <xmqqbk7sxmnr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EAF51EE-DB4B-11EE-9B79-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> As follow-up to [1], here's a series that eliminates redundant
> pipelines, mostly under t/.
>
> Spawning a process is notoriously slow on Windows, so this will improve
> test performance.

Yay!

> 1/22 to 14/22 remove redundant uses of "cat" where the shell handles
> input redirection from a file or the command can take a file argument.
>
> 15/22 to 20/22 merge redundant uses of "grep" into the following "sed"
> or "awk" command. Both of these are capable of filtering themselves. I'm
> a bit on the fence about this part because readability suffers in some
> cases. It was a fun exercise, though :-)
>
> 21/22 merges multiple "sed" calls into one and replaces a whole "cat |
> grep | awk" construct with a single "awk" call and uses "sort -u"
> instead of "sort | uniq".
>
> 22/22 finally is a bit of an outlier in that it replaces a subshell with
> a shell compound command.
>
> In the tests, I have completely arbitrarily separated the commits into
> thousands blocks to keep the commits and their reviews manageable.
>
> All tests that I was able to run still pass. I don't have p4 or cvs
> installed.
>
> [1] https://lore.kernel.org/git/20240216171046.927552-1-dev+git@drbeat.li/

Thanks.
