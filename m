Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43EC1369AE
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035419; cv=none; b=VQb0C9iBxzYlqLE//PRp3PM3m3oCnQoUjJb5w0CHKmi2uiUvlossU/5SnkGjdO2Jp92dXF0doI3Zq7jnoF8MQ9F/+T1yEA42QUOmx+OCR6FcS2c+WTDHE2zEH2DpwFUVbOkSkdIOSBTmZ55blY6LU+ehZWqc/hzPe5FOXF8jiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035419; c=relaxed/simple;
	bh=gTyp3o1z6qPMs0yQ1sSrRb256UM5evRdSKXXtZcMWSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kc8fldp9WP0LlfGez8RcctaHnm6p2SWnagbsIiJHxAOWmLrVXuuMOt2B7sX9eqsbqvi9Bs2eQ+labUBlJSTBE1hq0FpvQSH2e9jpHi7j97fEmm0wuJ0+bv8WWuM6HHDCk/SnpT2fLgsW67tzjyCpaMOGA5ZZ0ylTffAGre2gsOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vrUwTF/v; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vrUwTF/v"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 873961F4AF;
	Fri, 30 Aug 2024 12:30:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gTyp3o1z6qPMs0yQ1sSrRb256UM5evRdSKXXtZ
	cMWSQ=; b=vrUwTF/vyh4Vf6273g74uM0gQnl19ifvwY/zYLosZxODJaK0kxFp+G
	CY4iiie3ddclwMo86xRlHWZlUR+uW5dZUILEjI2RawEwje80er8z+Pw34SbZWKq4
	I12zT+7NqWp+NOkxa5+9QqhAUEhKTcn49jZPSjMOYjC72KTud+wQ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 68BA01F4AE;
	Fri, 30 Aug 2024 12:30:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7847A1F4AB;
	Fri, 30 Aug 2024 12:30:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] grep: prefer UNUSED to MAYBE_UNUSED for pcre
 allocators
In-Reply-To: <ZtFpGjBFlMNPnSld@tanuki> (Patrick Steinhardt's message of "Fri,
	30 Aug 2024 08:39:22 +0200")
References: <20240829200807.GA430283@coredump.intra.peff.net>
	<20240829200953.GB432235@coredump.intra.peff.net>
	<ZtFpGjBFlMNPnSld@tanuki>
Date: Fri, 30 Aug 2024 09:30:14 -0700
Message-ID: <xmqqwmjyrn1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 232BC2AE-66ED-11EF-92A4-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 29, 2024 at 04:09:53PM -0400, Jeff King wrote:
>> We prove custom malloc/free callbacks for the pcre library to use. Those
>> take an extra "data" parameter, but we don't use it. Back when these
>> were added in 513f2b0bbd (grep: make PCRE2 aware of custom allocator,
>> 2019-10-16), we only had MAYBE_UNUSED. But these days we have UNUSED,
>> which we should prefer, as it will let the compiler inform us if the
>> code changes to actually use the parameters.
>> 
>> I also moved the annotations to come after the variable name, which is
>> how we typically spell it.
>> 
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> Where "how we typically spell it" is "me", because I wrote 99% of the
>> annotations we have. ;) I'm open to debate, but only if it is
>> accompanied by a patch to change all of them to be consistent.
>
> I don't care about the order, but if we settle on one I think we should
> also document this accordingly in our code style guide.

Very true.  I think Peff's [PATCH 7/6] was sufficient by ending the
new instruction with

	... like "int foo UNUSED".

when it talked about the -Werror=unused-parameter.

Thanks.
