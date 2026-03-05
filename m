Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AF28FFF6
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692766; cv=none; b=BtG/Z69Lq1omOFcGxAVtsZniD4mIXRCnwST++ooRym8QUkaWmTKm22jZOx0yEzWOsUaqyPf9uLZtGGnozjqmA/wXEubJf9Z+pDYfwjAsPa3LzIL1skZDDOBGPyB1GmRKch0xGvUwS/m13SdC13A936eGzecxqoO4j80zziVGzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692766; c=relaxed/simple;
	bh=ieTMpVdi3d1YlepiiZIbmXrf0yTYuUZnxVg3G0hjwJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Sn3BMFfULLJj63BmURkoAi0hIoR5rNdSo6RbHI4XL4XtBkxtaNEuIs996S3cDt3SX5bBZKGYjiw9m5YuYIgF9lXojNGspBm5SkD6HYOMpdL4HonFknoxxYl2Ga4/QHxhnnAEsLT3O6E/Oa2LyLc/sJZh2vkQQlJMKQ9tFdMW56c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4fRKdG3KJdzRnmP;
	Thu,  5 Mar 2026 07:39:14 +0100 (CET)
Message-ID: <7e8b51d1-382d-47f8-be71-74e76f0c9888@kdbg.org>
Date: Thu, 5 Mar 2026 07:39:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] compat/posix: introduce writev(3p) wrapper
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
 <20260303-pks-upload-pack-write-contention-v2-5-7321830f08fe@pks.im>
 <xmqqseaf5k5t.fsf@gitster.g> <20260305003745.GA4943@coredump.intra.peff.net>
 <aajnZZI5yqL9CYeR@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Matt Smiley <msmiley@gitlab.com>, git@vger.kernel.org
In-Reply-To: <aajnZZI5yqL9CYeR@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.03.26 um 03:16 schrieb brian m. carlson:
> On 2026-03-05 at 00:37:45, Jeff King wrote:
>> I like that writev() can work as a drop-in replacement for write() at
>> the lowest level. But given that our main use is likely to be pkt-lines,
>> I do kind of wonder if we should just try to be more clever in forming
>> our buffers. That makes all of the portability and compat questions go
>> away (and gives the benefit to platforms that don't even have writev).
> 
> This does work and it is clever, but I think the writev is clearer and
> more explicit.  In addition, this is literally the kind of use case that
> it's designed for and the kernel will have a highly optimized
> implementation handling it.  I could also see myself making use of
> writev in my future work as well,...

Please don't. The use of writev may mislead you to depend on guarantees
that a kernel implementation of writev can provide, but a compat/
implementation cannot. (For example, I read something about "the file
pointer shall be unchanged" in the case of errors.) Please use simple
and stupid functions (write). I highly doubt that you can squeeze out a
noticable performance improvement with writev.

-- Hannes

