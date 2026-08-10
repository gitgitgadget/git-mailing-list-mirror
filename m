Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1138A299
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786337596; cv=none; b=eGEz3ZYdqjLzRhhQuyA8llALw1iTxhyIGAO7NNAkbHCVIAlDIvPg5Fc33ZBPRzgJrXg9hbDEq1ILsV7sJp93izwPI6eMXbRRdYZ8XerAESYmZzkfqpteB8qDf9lJd6HNjqcasvrL03+TSHZGAJOdpcMUe6KfWQgAMEI8VSxfiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786337596; c=relaxed/simple;
	bh=FATCSyvxbcw+cULQu/eYVWvLdv5JwFCRI7sT6qsS4Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZvaPC1qoxg8PXvOP/DryF0Re875XupBc7tkgbkEJm2yO2mogPqzWxq89v49WOHBdTYRsqCe+R0YG8pwihfSsBNSr34YmUm4WHekpjLzd4+73Xlzq2NAmkdAlfFISW2d35OgQe2kCuQbOgf6T7D44p628jGesdesmJDQWlDTcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=bbFvBPek; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="bbFvBPek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202608070029; t=1786337026;
	bh=5r4e0sXDyMOMepwwyil3FXG/KyTXGsTihYZ7WDd5yhU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=bbFvBPekkwFP4BaghGYPWqU69yXXy/2thxVMJ/r2bVNuo8BaYZbDM2up6OhzljWwd
	 ydu0+TTE7+0rc4ZIp78rg3P9yBEWB/b+XL1tZeOxz5P5kgc3Zmh6FVeJDLbqWAwsXM
	 zeP0/a6ahuc6P7Tshl4FWQUdP3y5rC6tJQXy1HVt2gfpZMYiNJPbnnutEP8/Cgp7fg
	 6+Nj6lYHGjrWIZP/edqDNWnxE687sG/viJB1nibfaw3TmRNBHnzhiViNrXS0r03Mm0
	 MfOItjDGFff7ReWlVum1KxodZwESHgqvOMhiXyuVocSYlDP42fpoa2MkLh2v7sWN/m
	 kmCEK2Et4p6DQ==
Received: from [192.168.42.64] (66-97-142-46.pool.kielnet.net [46.142.97.66])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id E01673C3D11;
	Mon, 10 Aug 2026 06:43:45 +0200 (CEST)
Message-ID: <17d460c0-564e-45fd-830e-548f60e01e01@haller-berlin.de>
Date: Mon, 10 Aug 2026 06:43:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] t: fix races caused by background maintenance
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 20.02.26 11:15, Patrick Steinhardt wrote:
> Introduce a new `GIT_TEST_MAINT_AUTO_DETACH` environment variable that
> allows us to override the auto-detach behaviour and set that varibale in
> our tests.
I have just run into this problem with the lazygit test suite, and I
worked around it there by turning off auto maintenance altogether. Some
more details of how this affected us and why can be found in [1].

I'm fine with that solution, but I do wonder why we think this doesn't
also affect ordinary usage. Lazygit's integration test suite doesn't do
anything special, it simply executes git commands like a normal user
would. Maybe a bit faster than a normal user would type them, but for
scripts that create a bunch of files, stage them, and commit them, I see
no reason why they shouldn't run into the same problem. Or am I missing
something?

Thanks,
Stefan


[1] <https://github.com/jesseduffield/lazygit/pull/5898/
      changes/4ec91a0bf58e07ce040f08600cd0c6b64f996e07>
