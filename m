Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0E155351
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753882; cv=none; b=iEmYpB1FiTE7y1migEpOIKlvG6gmr3GTURYxjYvH19jKqmkHCHLz4j0bVfTjMYkI1b3MWL71Kq/ogwZ3k7OG46MjTPw6B2cisMGo/W60PyWVMxTfzO8EqkGoPZfQLrvGACQIXjQcgCKcvDfR+4HGWoX/hFc88vPt2+X5K94sfSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753882; c=relaxed/simple;
	bh=jViGV+Maw+VOx7hv/9c7zFCe6Vq+cETGp9aLoeHYgbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HLZVhBEo9MSpOMLbhtusxTU+BsWDHlBwEeJOigJlsc3qwJnLZxtCNlLR1TaOSMRgzr57njl2u+mRdgf5ONlYjQjepYp9QUj60yMvNMszfuZwul9dLxNlQwNB4Ft5tqEcO75tUz12zSkUiMwfnU4G0qJSFdePMqYhPW/X+rPZ4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KAYYinXf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KAYYinXf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 95BDE2C5C8;
	Tue, 18 Jun 2024 19:37:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jViGV+Maw+VOx7hv/9c7zFCe6Vq+cETGp9aLoe
	HYgbw=; b=KAYYinXfkWzpq/sdMHUEWyq3s1KeupRktVMhsMCsx6kP8rT2W7ZNeF
	GGuIazP+RSqoA/8Q5QVGNtBY/POJwYxuhuZtL1O15xfQpb4SLgHbrOoMc+LRqZx+
	z4Lu5YiX1CfM6b4pqDPDUrWmDzfzLaVfGL2uHsXObWxj+K4b7FCpw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E6EC2C5C7;
	Tue, 18 Jun 2024 19:37:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C236B2C5C6;
	Tue, 18 Jun 2024 19:37:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t1006: ensure cat-file info isn't buffered by
 default
In-Reply-To: <20240618213041.M462972@dcvr> (Eric Wong's message of "Tue, 18
	Jun 2024 21:30:41 +0000")
References: <20240617104326.3522535-1-e@80x24.org>
	<20240617104326.3522535-3-e@80x24.org> <xmqq1q4v5m5a.fsf@gitster.g>
	<20240618213041.M462972@dcvr>
Date: Tue, 18 Jun 2024 16:37:48 -0700
Message-ID: <xmqqzfrhyg8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C6C4126E-2DCB-11EF-87D8-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Eric Wong <e@80x24.org> writes:

>> Yes, using Perl is a good substitute for writing it in C in this
>> case.  I however question the choice to use t9700/test.pl here,
>> which is clearly stated that its purpose is to "test perl interface
>> which is Git.pm", and added tests are not testing anything in Git.pm
>> at all.
>> 
>> Using t9700/test.pl only because it happens to use "perl -MTest::More"
>> sounds a bit eh, suboptimal.
>
> *shrug*  I figure Test::More is common enough since it's part of
> the Perl standard library; but I consider Perl a better scripting
> language than sh by far and wish our whole test suite were Perl :>

Oh, I think we (actually the author of t9700) considers it common
enough that we have PERL_TEST_MORE prerequisite to allow us to write
tests, assuming that it is available, and let us easily skip where
it is not available.  So I do not think I mind the dependency on
Test::More at all.  Moving the tests to t1006 and rewriting the
tests not to use Test::More are two separate and unrelated things,
and if you are more comfortable with Test::More (and more
importantly if it is natural to write Perl based tests using
Test::More), it is not necessary to switch away from it.

