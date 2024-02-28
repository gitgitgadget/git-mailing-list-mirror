Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD58624E
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154001; cv=none; b=YaTB4utkonPxS5gZzkcHiusRoutYr2RwD7wvNfrubOGmkBZI1x5NKZWuXKw16a0lqXErkv+WHw4NA6o3Ol/gpehT3rYDZo0L+uAU5SVGM733xdXBzQ10AteFsKVvarQgIHkfRdX8rR/WJvvH+TrstwjMHXEEu3Nh4Wa51QeWS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154001; c=relaxed/simple;
	bh=wwM1WhhBJ25+6wiGASoJGRBVKw+GzgBug5Ar9ZCqvvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jBcgsk6CMJ0VJVQ6Z8EZTw3qcpsHRvASdifixFR/JegDHB19aEEyxNHMATYrXbRjjWjMNz7+pxIZUjKixoXeGita9To+/2oQNh48hwWPsFNG27d/nLFfWCfPHDLR6plwFhYDs/lgZXCvjEpI5+GSBKPHwLjtMDrCLj9O4vQDVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=PY1icz/v; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="PY1icz/v"
Received: from localhost (ip-109-42-177-117.web.vodafone.de [109.42.177.117])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 41SKxdnq005545
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 28 Feb 2024 21:59:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1709153981; bh=wwM1WhhBJ25+6wiGASoJGRBVKw+GzgBug5Ar9ZCqvvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PY1icz/vRzUGKvjdWnvixOocUa0D7BT7jAJvzIoVJfWHt6kPhValMYSowbu5wY5ho
	 AFRMrrvAXNNBcfSyhuhpGhTF7pAz+Ri1S4dwO8Ui21U6+bZ773zVCGzkDgYxSZxtWp
	 EQHNFoUvEWXIUa6nFsC2+V49dvFdF59dMaY3rVzM=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin
 <johannes.schindelin@gmx.de>
Cc: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 04/11] commit-reach(paint_down_to_common): prepare
 for handling shallow commits
In-Reply-To: <xmqqedcwjq04.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	28 Feb 2024 12:24:59 -0800")
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
	<837aa5a89c640427a5de064da93f1de4934d8212.1709113458.git.gitgitgadget@gmail.com>
	<xmqqedcwjq04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 28 Feb 2024 21:59:34 +0100
Message-ID: <gh7cioqp8p.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> When `git fetch --update-shallow` needs to test for commit ancestry, it
>> can naturally run into a missing object (e.g. if it is a parent of a
>> shallow commit). For the purpose of `--update-shallow`, this needs to be
>> treated as if the child commit did not even have that parent, i.e. the
>> commit history needs to be clamped.
>>
>> For all other scenarios, clamping the commit history is actually a bug,
>> as it would hide repository corruption (for an analysis regarding
>> shallow and partial clones, see the analysis further down).
>>
>> Add a flag to optionally ask the function to ignore missing commits, as
>> `--update-shallow` needs it to, while detecting missing objects as a
>> repository corruption error by default.
>>
>> This flag is needed, and cannot replaced by `is_repository_shallow()` to
>> indicate that situation, because that function would return 0 in the
>> `--update-shallow` scenario: There is not actually a `shallow` file in
>> that scenario, as demonstrated e.g. by t5537.10 ("add new shallow root
>> with receive.updateshallow on") and t5538.4 ("add new shallow root with
>> receive.updateshallow on").
>
> Nicely written.
>
> The description above that has been totally revamped reads much much
> clearer, at least to me, compared to the previous round.  
>
> Should we declare the topic done and mark it for 'next'?
>
> Thanks.

I agree that this text reads much clearer -- even to me with close to
zero experience, here.

Thank you for taking the time to rewrite the text, Johannes.

Dirk
