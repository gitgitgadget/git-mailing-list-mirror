Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3310124EA81
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115879; cv=none; b=NED5QcBRtldHjEaB7yq8CpNhwHgkwfUqqlPP8UMUoOYfDQA+4PoPIUFigpsJ3ACzZUdvpIBMTr3gueXuEa26wKeYQkcFm2XceCiQSw9J0NnnUKYC2FAmngqTIRe+UFfjeS+c+gJkF+NCVLKOktbU9vOpP5/OZAwIRd30RGBUoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115879; c=relaxed/simple;
	bh=yg9vv347SnDtqbzFT6rFPFwFBvV3EzFuKOHk5jKk6iQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=C3mfLO6MqhZrpdZDVZzRxnJ8jrus18532RxpJ3sIRmOkh+r42jBh+U9mXH2WuSNr8lTJ3Hy6xzQwogFSi00WKcdohIuAdEaPX0PaUGfMwbcy40ZlGn9W2RQEiNZuwdwfRoC8NU01bw7BTyZIPFAFBml3G2NRu3r8Q18WA+OBPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=pkn+rHBX; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="pkn+rHBX"
Received: from [172.31.49.241] ([172.31.49.241])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.9/8.18.1.9) with ESMTPSA id 524JHkVr017562
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 4 Mar 2025 20:17:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1741115866;
	bh=yg9vv347SnDtqbzFT6rFPFwFBvV3EzFuKOHk5jKk6iQ=;
	h=Date:To:From:Subject;
	b=pkn+rHBXVnwDgdDG9hNzwkcttdLeNWXPqvQhh/DQm0zK26W1Vj/58SoVg5fTSdhXP
	 oviKMvjD0pyrEo6ljhy1JMP3OyX45leL0Cnvp1oYMpu+/3XwsWHzRxngYlKjdfl6Wb
	 nK2tLBCXprReXF1BtHD5J6pP38ciPqtwRqqsFZYk=
Message-ID: <43b26c9b-fd08-4a21-8371-9fd53f54694a@tu-dortmund.de>
Date: Tue, 4 Mar 2025 20:17:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Joschua Kesper <joschua.kesper@tu-dortmund.de>
Subject: [Feature Request] Negated non-wildcard patterns in excluded
 directories in `.gitignore`
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Git Community,

I have the somewhat unusual use-case and use negated patterns somewhat
regularly. If I have a path `foo/bar/baz` which I want to track with
git, but don't want any other files in `foo`. I would have to write the
following in the `.gitignore`:

	foo/*
	!foo/bar
	foo/bar/*
	!foo/bar/baz

Instead of the simpler:

	foo
	!foo/bar/baz

In `gitignore(5)` you mention:

 > It is not possible to re-include a file if a parent directory of that
 > file is excluded. Git doesn’t list excluded directories for
 > performance reasons, so any patterns on contained files have no
 > effect, no matter where they are defined.

This is (I think) due to patterns like `!*.c`.
So I propose changing it so exact-matching pattern parts like `foo` or
`bar` to always work. This could be done by expanding it to the form
mentioned above.

This change wouldn't affect performance I would argue, since writing
`!foo/bar/baz` is pretty unambiguous in what the user intended.
Depending on the implementation it may even improve performance,
since we would only require listing of `foo/bar/baz` and not all of it's
parents (though I am simply guessing the implementation for
`<something>/*` here).

Joschua
