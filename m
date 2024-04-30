Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53C1EB35
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495098; cv=none; b=C030y96urtKbWN+gWOfWjG+1EJwVU2v4OgSzj7eFVyMYAijn5UpYUyRQ/ktfS/HELq5j4RFCVhyY+QURf4SIKwkt00MgAhFhlZwTbZdoPSCfbxSy5uzYPaJPYemy2/Fiqn6+l0TejImkVUofncls3ghfYQTNCuohtg7/tnBfSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495098; c=relaxed/simple;
	bh=TqFQCrqR5Q7EJSPk2b8QrinZmrHGt5bGBHatdeNzMd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MNWUhRwzFkoat6pGFLCIqcF6zbk7rwBy5Vde1uCPS6hPnt7SObmgcpA8hr7jonFjshmrQYnobgoUzkef96M5yPY8FyVkqnOhGif10CmjKGi0ZgZdRK+oAN3pI6fkl7E5jFupFxbu/rqnNtFMHSilaNZM9SHtMljCnG531w/f3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ce/vnLPs; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ce/vnLPs"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A7322052F;
	Tue, 30 Apr 2024 12:38:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TqFQCrqR5Q7EJSPk2b8QrinZmrHGt5bGBHatde
	NzMd0=; b=ce/vnLPsNTAv6nLOUVJo1Y1BEaD7E+t4apE21t3gzJ4I8+Ann90xqu
	0S/XhwskAPCC2t4aMPAZeM6Y5PAqp3UphWNouptqqYJIqdYf9a+jGxv2hvbN0cGx
	rHhjcX8C/OoR+1bgK9cNYMSYBIpiCjCarwKR5eODGXAXf/rHsTSfc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 828252052E;
	Tue, 30 Apr 2024 12:38:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DECF2052D;
	Tue, 30 Apr 2024 12:38:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Passaro via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH v3 1/3] builtin/commit.c: refactor --trailer logic
In-Reply-To: <ZjCHiPS8N-eSBrQV@tanuki> (Patrick Steinhardt's message of "Tue,
	30 Apr 2024 07:54:16 +0200")
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
	<pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
	<0c9517f434aa5456dbde129f0514e3e3f50a095d.1714416865.git.gitgitgadget@gmail.com>
	<ZjCHiPS8N-eSBrQV@tanuki>
Date: Tue, 30 Apr 2024 09:38:09 -0700
Message-ID: <xmqq7cgest5a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 088B3B9C-0710-11EF-9CBC-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +int amend_file_with_trailers(const char *path, struct strvec const* trailer_args) {
>
> I would have called this `amend_trailers_to_file()`, which feels a bit
> easier to understand. But I don't mind this much, your version should be
> okay, too.

I had the same reaction, but we are editing trailers in the file
(without touching other things in the same file), so I would have
suggested "in" instead of "to" here.

I agree with everything else you said you your review, and I do not
think I have anything to add to this step.

> Arguably you don't have to include "strvec.h" here, but can instead add
> a simple forward declaration `struct strvec`.

Sensible.

Thanks.
