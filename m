Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795B16FF3E
	for <git@vger.kernel.org>; Thu,  2 May 2024 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671864; cv=none; b=tTrnJZtPk6J2VG9NsAFDB3hzvQge6CcV4SQZeKNiFiCJkF6QA0J6JeR0nYGLYdN2IMZGe4ZjxKDn/OparpQEBc8C+YHiYyP54rXw5fUlDPAs0MZZi9CkThheVY1KKTE1pYs8xneAJFok7W9T5edH3kGF/dP+m4khOvDN/HLxCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671864; c=relaxed/simple;
	bh=5sON7LKDIC2vXr/EHqQZl6cyDvjUKpnG/sczSfnm3X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B55avptf7rUrMAIjSKKUYQRPDNGeuLrk0nHQx6JNzGjNhVvzS/TJXZfV01ns265Zw4VMhNptiejHPn/iGyPOS+Ak1M9OPcJPr2EXIY0iACx9csDXmd6E4YD1au+XWvfD6dpSrcIVdb4X64HhRyNPl/JZjlfjuCgv+oC16KETGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I7SM90+L; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I7SM90+L"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C03E22141;
	Thu,  2 May 2024 13:44:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5sON7LKDIC2vXr/EHqQZl6cyDvjUKpnG/sczSf
	nm3X4=; b=I7SM90+LjNNkU25J3uWoygH1YayXEVXKT2PNfsUamHUF+IzaqNDY+R
	jGCVFX1Fx+ATFl20a5APtDRcqEQkKlA6JoGyBcwyVnfoyu/PzW4uBuWtyPKJANB9
	KA6HoxJjnTVkvnpDnfk+8mf8EjBzHAqkbXxk/m0Lgbvam2vy73QEs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14AD122140;
	Thu,  2 May 2024 13:44:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 776252213F;
	Thu,  2 May 2024 13:44:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  Dhruva Krishnamurthy <dhruvakm@gmail.com>,
  John Cai <johncai86@gmail.com>,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org
Subject: Re: using tree as attribute source is slow, was Re: Help
 troubleshoot performance regression cloning with depth: git 2.44 vs git
 2.42
In-Reply-To: <ZjPOd83r+tkmsv3o@nand.local> (Taylor Blau's message of "Thu, 2
	May 2024 13:33:43 -0400")
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
	<20240501220030.GA1442509@coredump.intra.peff.net>
	<ZjLfcCxjLq4o7hpw@nand.local> <ZjPOd83r+tkmsv3o@nand.local>
Date: Thu, 02 May 2024 10:44:20 -0700
Message-ID: <xmqqfrv0ds7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B9E66B0-08AB-11EF-9136-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Instead, this patch changes the behavior to only fallback to "HEAD" in
> bare repositories from check-attr, but leaves pack-objects, archive, and
> all other builtins alone.

I thought the whole point of the exercise was to allow server-side
(which typically is bare and cannot use anything from the working
tree) to pay attention to the attributes.  This patch rips that out
and piles even more new and unproven code on top?  I am not sure.

