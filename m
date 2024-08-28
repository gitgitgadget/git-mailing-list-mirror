Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403618A6DC
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862741; cv=none; b=FESHI0ebXBvkY0EoLxRMGEb5AT8jpJQpsztAbN8Fp2/OcT2NuOhegd5ZO9oDvw4oWx64eB1dUtBSIiOva6+YHySCqdIgvpGgiQCcyXr9vnoNflq4I+fymdCJKnkYC1BHEa9Ei5ttKN5zX5bUq+2NWc5IflBBuRvV+lwsSViY5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862741; c=relaxed/simple;
	bh=JF1LID0gDFONcebViUuHGtMawJOnEXzd2dDG5m8QMpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YTdRSbbm6f+sBIdElVQMIHBDNuXMKOfhTe8UbTFIPEFM9lyTwK/e1Z/1HYyjRjNr9YEbNdS/875005PzaFZAZq86Nxi6zVu+Pa8m3OtP5b0bOWlnCpo7b/OEfcMaG367y6j1awhjhhG8kaz2RHoqVAFPwslUKJ0REnnlE5N7AZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GTz2ntGA; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GTz2ntGA"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 774AE1847A;
	Wed, 28 Aug 2024 12:32:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JF1LID0gDFONcebViUuHGtMawJOnEXzd2dDG5m
	8QMpU=; b=GTz2ntGAmVEZZJObSOpdP2VXEOZ+8h8uHWXm9g1z2xz3aXK+bMGaXZ
	MGAjrDgLJQ9gqVf+QpsRRAl758VF/D9cu3hy+P2OqikEN3oeA0bV2R3U1aJKhDY/
	ctfzr4KjglM857ukO9pcAik25ZyFU1ozgEf725t7l7KEyEvW6uSaw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D01718479;
	Wed, 28 Aug 2024 12:32:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB52F18478;
	Wed, 28 Aug 2024 12:32:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/4] ref: add regular ref content check for files
 backend
In-Reply-To: <Zs8c_vuqOSSWJjpd@tanuki> (Patrick Steinhardt's message of "Wed,
	28 Aug 2024 14:50:06 +0200")
References: <Zs348uXMBdCuwF-2@ArchLinux> <Zs353oLDaw2SbNQs@ArchLinux>
	<xmqqjzg1aksx.fsf@gitster.g> <Zs8c_vuqOSSWJjpd@tanuki>
Date: Wed, 28 Aug 2024 09:32:16 -0700
Message-ID: <xmqqv7zk1ucv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 174380E6-655B-11EF-936B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Git 3.0 boundary might be a good time to tighten interoperability
>> rules such that we won't accept anything we wouldn't have written
>> ourselves (not limited to loose ref format, but this applies to
>> anything on-disk or on-wire), but we'd need enough preparation if we
>> want to be able to do so in the future.
>
> I quite like this idea.

I wouldn't say that I wrote it as a devil's advocate comment, but I
was hoping that somebody quote Postel in response, as the above
advocates a directly opposite position, which I wouldn't usually
take.

> I guess another prereq for the change is to integrate `git refs verify`
> with git-fsck(1), because otherwise people likely wouldn't see the new
> messages in the first place.

Absolutely.
