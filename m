Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA7717F36D
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496419; cv=none; b=k0LdfbiKrgS/Ylxca4asb9s2MRR4Si6GmsM3sU2lLheBa4WimR8asoPEAHhxOh0vXwfG0zduSrn9fRquATrYyWMaY4m4DCz5XtvU9Cdj+p+//2mHrDA8J7agqDAfMXKXa+7jGTqs1mz+vk+sdcDBd3hnr/pkRa/Bt4TS2zV1q68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496419; c=relaxed/simple;
	bh=0DgRIlrSnX8zpTjdHyizl3vxrMk0XNLhGHsVTEz19cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rgwoHoKRMHgJNyR2vQ8r/bTv/J1Iu8XsYfUPVIueWKHAUOdRTPKohZ4XFtWt5aGlMfFbt29AOfhNTYAZvckvW1iy85ftaQDSRhk6onG4/Lsh2nULlN47durwd5FaRMGn23xnfwaFRba3QaiDYhHl4cLa13r/9EJ+ZnGDw5kbO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DikC3BqF; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DikC3BqF"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 382731F9F6;
	Tue, 30 Apr 2024 13:00:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0DgRIlrSnX8zpTjdHyizl3vxrMk0XNLhGHsVTE
	z19cs=; b=DikC3BqFmjw8tg62WROj+f9GS/Me25lL9w9PbiWm4rgkFPU7u8CvVj
	zwbjhnUl6wAeLCSqNff7iutJAzWIldzvoDvTmb6MFg6e9YZkFOtPOcQ227nEZpCX
	dcxXS6T+SoopBrRSPriW4b81PFflOfZdVILJcfRgzVUCOYN+f51yk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 301271F9F2;
	Tue, 30 Apr 2024 13:00:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA5C81F9EE;
	Tue, 30 Apr 2024 13:00:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 6/8] check_refname_format(): add FULLY_QUALIFIED flag
In-Reply-To: <ZjDDa5PIxPCFzMhq@tanuki> (Patrick Steinhardt's message of "Tue,
	30 Apr 2024 12:09:47 +0200")
References: <20240429083325.GE233423@coredump.intra.peff.net>
	<ZjB5bHiF5kAcRMpP@tanuki>
	<20240430100145.GB1279403@coredump.intra.peff.net>
	<ZjDDa5PIxPCFzMhq@tanuki>
Date: Tue, 30 Apr 2024 10:00:10 -0700
Message-ID: <xmqqmspardk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1C1B6800-0713-11EF-AEF0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> valid. E.g., validating a refspec may involve a name like "main" on its
>> own. I suspect it would be OK in practice to just give it an arbitrary
>> "refs/foo/$main", but that feels kind of hacky.
>
> Ah, fair enough.

I actually do not think it is fair enough.  Why does the caller want
to validate "main" in the first place?  To make the example more
realistic, lets imagine a caller wants to validate "HEAD".  We can
say "it is syntactically correct", but in what context is that
answer useful?  If the caller is contemplating to create a new
branch given a short-name, we would want to say "no, refs/heads/HEAD
is not something we want you to create", but if the caller is
planning to create refs/remotes/origin/HEAD, our answer would be
different.


