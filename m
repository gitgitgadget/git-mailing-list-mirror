Received: from aburayama.m.codeberg.org (aburayama.m.codeberg.org [217.197.91.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5B444713
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.91.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054179; cv=none; b=HmZ1dFE+u+GEuR9gpRQ1hmjWDnFr1EWodlMhn3HucEvH27O1NytPACCX9SYPkjl1rPJcEg2abO6vithXR11ubU13lDMfDuX5acqCfJadYLo555ycv8JZl0EBWl+8QLshEQ4DoFX6EEIdafHLARp2VizZs8y/k4C4FCz3F984pK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054179; c=relaxed/simple;
	bh=61KgB8s8Z5guv6AkceE2LDb1vRPpvP+KuOKe8YGOWNM=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=ei0b+3yUlnIEvyechMRY2yNbuy08DtJlfOEcDT5KmAwow3bxJhzfxGMNFB0vdNtGyOcBUmjoOx3Jk0eA6cYRcmFNLE+3eAU1EF5BZk6R0UZ76gyJPGN4zmJgIdcO3RoLO4FsD2x2sMiq9TvanF4qxyczlw7kTz6vqqzgCdmB3WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org; spf=pass smtp.mailfrom=codeberg.org; dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=vGfNW9VW; dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=F1rkk3tC; arc=none smtp.client-ip=217.197.91.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="vGfNW9VW";
	dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="F1rkk3tC"
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=codeberg.org; c=relaxed/relaxed; r=y;
	h=Subject:To:From:Date:Message-ID; t=1784054039; bh=61KgB8s8Z5guv6AkceE2LDb
	1vRPpvP+KuOKe8YGOWNM=; b=vGfNW9VWzsUsCZdIZtYSSPB/jTwrlv3gTrlEc/HavICnjN17QU
	DcbfYHxAbb9SUjWsHhREYOVflz9RAIiY/jCw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=codeberg.org; c=relaxed/relaxed; r=y;
	h=Subject:To:From:Date:Message-ID; t=1784054039; bh=61KgB8s8Z5guv6AkceE2LDb
	1vRPpvP+KuOKe8YGOWNM=; b=F1rkk3tCrSjMzfoBjAnIUEXg5d9pSr98otfFAh52eIaSgNg1Gi
	PJBzt7FFZSTDMZbjwj6QrshhuX6PNmClNghUKqww+pAYf0JLBZOQ4bF2rdTilYVaRuQ20F+wYhM
	FYPN6CkBgHxeHpdMRAkiEgCRutgZzG1kqYPph7k47Ns2mIdPqwNX4zk4R/D0JqQP8TreZqNunta
	HO4/U+bnJU04OXSvjXt8xq2h5xPT/bMb3h6tRl0x1QE8AjnFatjynkDsRpMswX5K7pNvSRDmiYY
	Yyr9+DAR3vFuqD70mgNOHyz/2Q9GejUgdY5xba3cjZLS+b0aOFg31kNKYaTOZ1lKnUQ==;
Message-ID: <17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org>
Date: Tue, 14 Jul 2026 20:33:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gusted <gusted@codeberg.org>
Content-Language: en-US
To: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: git-last-modified(1) slower than git-log(1)?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I'm working at switching Forgejo's implementation of getting the last
modified commits in a directory to git-last-modified(1). I'd expected
equal or better performance than the current implementation, but have
not yet been able to get this and I'm a bit puzzled as to why.

The current implementation of Forgejo (inherited from Gitea) works
roughly like this:
1. Run `git log --name-status -c --format=commit%x00%H %P%x00" --parents
--no-renames -t -z $OID -- :(literal)some/path`, the output of this is
quite complex and possible outputs more information than necessary.
2. The output of this is piped to some code to a parser and reconstructs
what commit ID last modified each file in the directory.
3. Via `git cat-file --batch` get each unique commits information.

With git-last-modified(1) (-z --show-trees --max-depth=0) this replaces
step 1-2, but is slower. I've isolated the degraded performance to the
fact that git-last-changed(1) takes more time to finish. So from my
perspective it does not seem worth it to replace the current
implementation with git-last-modified(1), and I would like to know if
I'm missing something here or if git-last-modified(1) possibly could see
a speedup?

The repository I'm currently using to evaluate the performance is
https://codeberg.org/ziglang/zig

Reproduction steps:
1. `git clone https://codeberg.org/ziglang/zig $(mktemp -d)`
2. cd to tmp directory.
3. `git commit-graph write --changed-paths`. As git-last-modified(1)
makes good use of the bloom filters.
4. `hyperfine 'git last-modified -z -t --max-depth=0
80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- doc/langref/' 'git log
--name-status -c "--format=commit%x00%H %P%x00" --parents --no-renames
-t -z 80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- ":(literal)doc/langref"'`

With as output:
Benchmark 1: git last-modified -z -t --max-depth=0
80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- doc/langref/
 Time (mean ± σ): 66.5 ms ± 0.6 ms [User: 60.6 ms, System: 5.2 ms]
 Range (min … max): 65.3 ms … 67.7 ms 44 runs

Benchmark 2: git log --name-status -c "--format=commit%x00%H %P%x00"
--parents --no-renames -t -z 80d06578ac66bce3aa0a21e9610cdb782b9a0593 --
":(literal)doc/langref"
 Time (mean ± σ): 26.2 ms ± 1.0 ms [User: 17.3 ms, System: 8.4 ms]
 Range (min … max): 24.3 ms … 30.1 ms 110 runs

Summary
 git log --name-status -c "--format=commit%x00%H %P%x00" --parents
--no-renames -t -z 80d06578ac66bce3aa0a21e9610cdb782b9a0593 --
":(literal)doc/langref" ran
 2.54 ± 0.10 times faster than git last-modified -z -t --max-depth=0
80d06578ac66bce3aa0a21e9610cdb782b9a0593 -- doc/langref/

Kind Regards
Gusted
