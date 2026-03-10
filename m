Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3136B062
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176187; cv=none; b=lP/9Ll4T19rX2/Mw93X8khdClfKVkHMX6puxxa8ZjM4z6Gzr2n6B4d6dLU6u2N/IdmKrtmTWqksAfTZRd5H56MUvVPbaRFzIeVXxyYONfC6PShJZvpjslj823APakAfHOzmo4wm7Bntwymf5BVMrIvcuWcr8/MtzSlzaLL/s0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176187; c=relaxed/simple;
	bh=3vNspb8dygIu3ji0MrRPGCAyeUc8gUERE4uT6fiaDfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0elEgcK7T+2JRyqQOsuFQqmmfWRobqXBiUAszZ7NG5a6SFfS/+L4aXZC2R4yfoa3ylDXGvdil8xa5CjQXrCCyNeMkiJOqk81O8nOvoGYwMDTZVvFrYE+Rnv2wJiBr80It2tVdXISHxBCOvldeWrX/cMozDOlUrnOVBEJIGH/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4fVmPq43YqzRpKq;
	Tue, 10 Mar 2026 21:56:15 +0100 (CET)
Message-ID: <2116166d-1aa2-46e5-b912-6268ebbcad4f@kdbg.org>
Date: Tue, 10 Mar 2026 21:56:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] upload-pack: reduce lock contention when writing
 packfile data
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Matt Smiley <msmiley@gitlab.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King
 <peff@peff.net>, git@vger.kernel.org
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
 <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 10.03.26 um 14:24 schrieb Patrick Steinhardt:
>       compat/posix: introduce writev(3p) wrapper
>       wrapper: introduce writev(3p) wrappers

I looked at these two patches.

At first, I was thrown off by the early exits when bytes_written == 0.
But I convinced myself that it makes sense:

- In the emulation, if the underlying write(2) does return 0, it makes
sense to signal a partial successful write to the caller of writev. It's
the best we can do when earlier blocks have already been written. A
return value of 0 is strange and may be an indication of future
problems, so let's just stop the work we are doing and let the upper
layers deal with the problem.

- In writev_in_full we need to treat the case specially in order to
guarantee forward progress.  Treating it as ENOSPC is plucked out of
thin air, I guess, but not unreasonable.

In conclusion, these patches look good.

-- Hannes

