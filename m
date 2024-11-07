Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66019539F
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961451; cv=none; b=R5bVtnkoewdHuelkJ0RbNa3dBg2jzEv87/3bP24AnKH3oC3lgtdSXKm6Ha5cVgQgSXwXMUEAzz7lXCwvH1nZnihig565vGPqN2EvmiHyxDg6mNpLclH1dk9WvpkT2acssxniXjuKHTK2NUDMFGOC4zltBXSqzt1GpEdHUsrl31I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961451; c=relaxed/simple;
	bh=D0tfmunP9azB0cNVTZSd92AbMZpVhpRSn/w3jti2hYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=u5RE5wbxUwuWw+mmG6cghJaCKEuEtpi4Isu92+hzOeElf1IH4hf5D01w8aVgi3mbYy4ziPvCHk9/1hHTStugH45OBnZbkDEz5nSC08XztjH8D5feKpkphrcia5Z4XmGeXrSRBhZh2D0BvNT1imSHOYvHy4lc0HsfYqGHvrmV3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4XkXS10fxCzRnQP;
	Thu,  7 Nov 2024 07:37:19 +0100 (CET)
Message-ID: <eb367098-0c88-4bc6-b824-32ee6e6d273e@kdbg.org>
Date: Thu, 7 Nov 2024 07:37:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about merge & cherry pick
To: Julien Maurel <julien@maurel.me>
References: <711a0faa-6d82-48b6-819d-9ddbeda03f6a@maurel.me>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <711a0faa-6d82-48b6-819d-9ddbeda03f6a@maurel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.11.24 um 21:24 schrieb Julien Maurel:
> From my point of view, after these operations, content on branch master
> and dev should be same with "zZz" on second line and "eDe" on last one.
> But it's not the case on second line...

The behavior that you observe is as intended and not a bug.

You have this (consider each letter on its own line):

          A Z Q E       initial commit
         /       \
     A Y Q E      |     dev: Z -> Y
        |         |
        |     A Y Q E   master: cherry-pick Z -> Y
        |         |
     A Z Q D      |     dev: revert Y -> Z and change E -> D
         \        /
          A Y Q D       merge

Your expectation that the merge result is "A Z Q D" is wrong. Consider
what happened on the dev branch (left) since the branches diverged:
Since the change from Z to Y was reverted to Z, the only change that the
dev side contributes to the merge is that of E to D. The master side, on
the other hand, contributes the change of Z to Y. So the total of the
merge must be Z to Y from the master side and E to D from the dev side,
and that is what you get.

A merge does not consider the individual changes on the branches, but
only the differences since the merge base. For the merge operation, the
change from Z to Y never happened on the dev side. The reversal of Y to
Z is not visible for the merge and cannot contribute to the result.

-- Hannes

