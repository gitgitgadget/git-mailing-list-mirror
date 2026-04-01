Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CB3B4E83
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032590; cv=none; b=P6ru76rWx7e/7ETZeg83Zuq3QD9Bdk2OE5I6aNyO7Y8LJRkBaivPFBFBYwtoEIEnaKIjulnh1N41Z3Aufv02VHuWyd9ZK0JvO/DtJEbhadsByrtqt+FE9Bt6BQccavF6E7IC3TuUKenRfRARdR9ldL4u2dDaVmWc0kzL/UuJQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032590; c=relaxed/simple;
	bh=9T66KtpwUSSGUDZK9tEzB21GEpBFYodS5ZXp3JPDq18=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Snddtnu6kQ3n4l1Xztnv6nCXCU7k6AuenEzas9JzAMOYxaCJE6qG9l8UdijQDkvizta2s/Uki2fgYmxM5CohzrtuH77qp9OZbH4Vcf2VwVFfUix2uXSsvkaaYUBzRlMrzSciwp0eLe/2GhRpgY9xk26BKIZUmZzgxeagonVAmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4flyxv1x49zRq2F;
	Wed,  1 Apr 2026 10:36:19 +0200 (CEST)
Message-ID: <bdff0a5d-b738-4053-9b72-08eba88156de@kdbg.org>
Date: Wed, 1 Apr 2026 10:36:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [GSoC PATCH v6 0/3] graph: add --graph-lane-limit option
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com,
 ayu.chandekar@gmail.com, siddharthasthana31@gmail.com,
 chandrapratap3519@gmail.com, gitster@pobox.com, szeder.dev@gmail.com,
 git@vger.kernel.org
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
 <20260328001113.1275291-1-pabloosabaterr@gmail.com>
Content-Language: en-US
In-Reply-To: <20260328001113.1275291-1-pabloosabaterr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.03.26 um 01:11 schrieb Pablo Sabater:
> Repositories that have many active branches at the same time produce
> wide graphs. A lane consists of two columns, the edge and the space
> padding, each branch takes a lane in the graph and there is no way
> to limit how many can be shown.
> 
> The limit is a horizontal truncation, each lane is cut at the lane limit:
> 
>   Without --graph-lane-limit:
> 
>   *   7_M1
>   |\  
>   | * 7_E
>   * | 7_C
>   | | *   7_M2
>   | | |\  
>   | | | * 7_H
>   | | |/  
>   | |/|   
>   | * | 7_D
>   | | * 7_G
>   | | * 7_F
>   | |/  
>   |/|   
>   * | 7_B
>   |/  
>   * 7_A
> 
>   With --graph-lane-limit=1:
> 
>   *   7_M1
>   |\  
>   | * 7_E
>   * ~ 7_C
>   | ~ 7_M2
>   | ~ 7_H
>   | ~ 
>   | ~ 
>   | * 7_D
>   | ~ 7_G
>   | ~ 7_F
>   | ~ 
>   |/~ 
>   * ~ 7_B
>   |/  
>   * 7_A

After seeing this example, my first reaction was that this
--graph-lane-limit option would not be useful for me. The relationship
among the commits is apparently obfuscated to such a degree that the
graph is not a lot better than a plain listing without --graph.

But then I tried on a few real-world examples, and the result turned out
to be a lot better. The commits (asterisks) typically occur in the
left-most lanes, and the lanes to the right are usually just connections
without commits. This makes it more practical to just truncate the graph
part, i.e., hide the connecting lanes.

In conclusion, I regard the way the option works as useful, even though
it is not the way of truncation I had envisioned originally.

I discovered a small glitch, though. If you download today's gitk
repository https://github.com/j6t/gitk.git, run

  git log --graph --oneline --decorate --boundary \
     --graph-lane-limit=4 465f03869ae11acd0..origin/j6t-testing

(j6t-testing is a volatile branch and is 86848fe40b60ae58f today).
Scroll down to line 166 and you see the '~' at the wrong place:

| | * | ~ 9f0d1c2 gitk: sanitize 'exec' arguments: simple cases
| | * | ~ 6eb797f gitk: have callers of diffcmd supply pipe symbol...
| | * | ~ b966b73 gitk: treat file names beginning with "|" as...
* | | | ~ 0c8be6f Merge branch 'ah/fix-open-with-stdin'
|\| | |~           <-- this is line 166
| * | | ~ 8e3070a (...) gitk: encode arguments correctly with "open"
* | | | ~ bfb0fa7 Merge branch 'top-panel-search-highlight' of ...
|\ \ \ \~
| * | | ~ 9cad4a9 gitk: do not hard-code color of search results...

I haven't tried to find out what is going wrong here or to simplify the
reproducer.

-- Hannes

