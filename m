Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8493F1D6BD
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710089945; cv=none; b=IttFPtXrqIypBWKr6zUCN0TX3G2S1m+WDDDOZeYlnw4m4NR56Cp1xy8UiMPwaziwet3PftoqQ4fR0uFQ1A55LnHPilL7NopW3789ZWG4GVdXF7UV7zIxxRKQSkmBHRRdzpEovFVsHBfzTqrjmTCtqOMbqMID5axkR9L9EL3auYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710089945; c=relaxed/simple;
	bh=aZ/Z9PmZEKz19xnX4qmvkRIEfTYKR2H67XF7f6ehqh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YaG6NY+rBFbas/UfeRg0UBW3+ScClR9rR1dNA7HaCXii7j2X6wUAML1299CHs/zFaxs+cg37Oc/4wkthX0H9iYpvHMvCqcHn5TD4UTFuQ/qTLPm+vpnV0nHQhuMtmyzI+yPAjQ4B7pWqd05tQkzrZZHUeF3sZ43hZPqsLWm8G8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i+W7olFX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i+W7olFX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A3201F3D2F;
	Sun, 10 Mar 2024 12:59:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aZ/Z9PmZEKz19xnX4qmvkRIEfTYKR2H67XF7f6
	ehqh0=; b=i+W7olFX/z7X3/Xmv36ghsGFd6Z3D11GGvu5iiuRT9w0mgA54bJUrX
	gwgaDM92jv8VXSvaopjDcYzNlTTLEpqRDGvN09eADvkBUCWFbYOg/cxYP6UtEUQ5
	g/31onBTFmq4Cy5hMrpqTbq0MNTUGpF8vrsJVNmAxa4MSuUYVzLHU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 228BE1F3D2E;
	Sun, 10 Mar 2024 12:59:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 921CE1F3D2D;
	Sun, 10 Mar 2024 12:59:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
In-Reply-To: <20240309181828.45496-2-ignacio@iencinas.com> (Ignacio Encinas's
	message of "Sat, 9 Mar 2024 19:18:28 +0100")
References: <20240307205006.467443-1-ignacio@iencinas.com>
	<20240309181828.45496-1-ignacio@iencinas.com>
	<20240309181828.45496-2-ignacio@iencinas.com>
Date: Sun, 10 Mar 2024 09:59:00 -0700
Message-ID: <xmqqy1aqvx9n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E8B2282-DEFF-11EE-9DCE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ignacio Encinas <ignacio@iencinas.com> writes:

> +test_expect_success 'conditional include, hostname' '
> +	cat >>.git/config <<-EOF &&
> +	[includeIf "hostname:$(hostname)a"]

This unconditionally runs the $(hostname) command assuming it exists
everywhere, but

    $ git grep '$(hostname' t/
    t/t6500-gc.sh:	hostname=$(hostname || echo unknown) &&

tells us that we should be prepared to meet a platform where such a
command does not exist.

I have a feeling that it is better done with a test prerequisite
than hardcoded "unknown", as xgethostname() at C level may come up
with some random string but it is not guaranteed to be "unknown".

Perhaps have one instance of this before these added tests

	test_lazy_prereq WORKING_HOSTNAME '
		hostname >/dev/null 2>&1
	'

and then start them with

	test_expect_success WORKING_HOSTNAME 'hostname: includeIf' '
		...
	'

or something?  Others may think of a better way to make sure this
test does not cause false failures on platforms only because they
lack working hostname(1) but have a working gethostname(2) and their
xgethostname() may be working fine.

Thanks.


