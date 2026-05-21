Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008493DD863
	for <git@vger.kernel.org>; Thu, 21 May 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374177; cv=none; b=aGfISg5pUv8d+fN65YFfNTxX89j3nLYvISYX8wAqLasyAMWTeQAae72DpVxcdkMpMdmbq/AsC5TCL6C2MbkNWdFl78ktfWoNHTOd3mVxnIkYz6UrB22NqFxPSKEQXx37hw6f5rmGU3XD11ko0o+johyIDYKzoS+6H2zKwaGsziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374177; c=relaxed/simple;
	bh=SJU8V92Wb/jaQyjajWVECvivjDQxArBae8SU1q6SYg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEWNees+8aYdfzeDiJAVwCRC2M9V4b7LFKZhCQUFuB31IhEt6GCdKeApE0uNL50oQOGVCiOz2eksI6YIlEFnCP8tIGZ8zBfS2LoGH5HfkKuu/StLva/gizqzrSc14doSrabMKWe1JgYdLX9lixMn4GMuPYbN0RgGPp/n/+UR9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gLrYx6tQQzRnlY;
	Thu, 21 May 2026 16:36:05 +0200 (CEST)
Message-ID: <cf52154c-1275-4a4b-957e-5aa17f22705c@kdbg.org>
Date: Thu, 21 May 2026 16:36:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] run-command: add support for timeout in command
 finisher
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 "gitster@pobox.com" <gitster@pobox.com>, "newren@gmail.com"
 <newren@gmail.com>, "ps@pks.im" <ps@pks.im>,
 "oswald.buddenhagen@gmx.de" <oswald.buddenhagen@gmx.de>,
 "code@khaugsbakk.name" <code@khaugsbakk.name>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
 <f58c8c522814dce9257f64733e9fbc9bd9f446c0.1779207350.git.siddh.raman.pant@oracle.com>
 <b69605a6-e841-47b9-a899-a57e184d3c8b@kdbg.org>
 <2f7eea03273ffaacc50a9ae186673da88fc3345f.camel@oracle.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <2f7eea03273ffaacc50a9ae186673da88fc3345f.camel@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.05.26 um 11:59 schrieb Siddh Raman Pant:
> The timeout is for the failure path, where the external helper has
> already stopped following that protocol or is blocked on something
> outside git's control. Since git starts the helper and puts it on the
> log/grep path, git also needs a bounded way to recover when that helper
> does not make progress. Otherwise an optional note source can prevent
> the main git command from completing.

That Git communicates with a process that looks like it stopped is the
normal case, for example:

- Output is sent to the pager. The user can take their time to study the
output. All the while, git waits patiently for the user to advance the
pager.

- Git fetch transfers large amounts of data across the network. Most of
the time it waits for data to arrive and does nothing. The peer process
looks like it hangs. Git does not decide to kill the connection at any
time. It is the user's decision to do so.

If the notes provider hangs, then it is not on Git to decide when it has
waited long enough.

-- Hannes

