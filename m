Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB381E526
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231203; cv=none; b=AGdkoQ2WXMVAoBl/rDPTrOrxVnaTqPDYSVU6/gMVsQVtwAx4P9l7NfH8yKPyG6FBG41XduJGJblH81NJR4iNsoxz+bP1VZ2g+yWtaScH5K/sEgiauGCS0kONaHytMBbKC1JWGHxnmGZjvqSrPx9f30HeH72v1oy31gKThh4oMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231203; c=relaxed/simple;
	bh=i97mbGrwK0hheSRoYfcIfXE5g6/spub5hVEPEV4OsGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lBLMkC2SzTFaQ0dgjr2oTpdEtHpqp/xYtbGPH05FuSxgKdXq94U/JhVTJoR1w8Gn9jqdEnTh2q4GXeX1PRtdDR28zzgUETtTZ5YVkHIajXUnjwINWMxdMYcKl2tbfkvpcG1/CjOvZIWNOus00ENznqgTt6raGoBpDDSSyHYMZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ACazwX5j; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ACazwX5j"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18251203FC;
	Wed, 17 Jul 2024 11:46:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i97mbGrwK0hheSRoYfcIfXE5g6/spub5hVEPEV
	4OsGg=; b=ACazwX5jx9uir7kyQfm8FaMctyWMy1YXpC93iUD+DahG00I7tCitob
	Jk0WNTDRlY46LeVmeWlLlCUoiRLy7o+LiSFQ2v3Eb0Dh+4GNfAqK9gOOWODH+BPA
	qLTkwF4B0Re3aTXxXtPi/Df2W59R7kQLd68qqFQkUxIqerZXQ+PMY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10DC5203FB;
	Wed, 17 Jul 2024 11:46:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 746E3203FA;
	Wed, 17 Jul 2024 11:46:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jullyana Ramos <jullyana.ramos@microsoft.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: rev-list does not output commit metadata (nor honor --format)
 when --use-bitmap-index is on
In-Reply-To: <20240717074418.GI547635@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 17 Jul 2024 03:44:18 -0400")
References: <DM4PR21MB3537F74639094ECFA909880C85A52@DM4PR21MB3537.namprd21.prod.outlook.com>
	<20240717074418.GI547635@coredump.intra.peff.net>
Date: Wed, 17 Jul 2024 08:46:38 -0700
Message-ID: <xmqq8qy058dd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C2524C8E-4453-11EF-A288-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> This is the expected output, but perhaps not by anybody who isn't
> familiar with the rev-list and bitmap internals.

Certainly not by me ;-).

If this were an end-user facing Porcelain, I would actually say we
should warn and disable "--use-bitmap-index" when any of these
incompatible options are given (i.e., request for features override
request for performance tweaks), but at least we need to document
this better, both in documentation and probably in command line
parser with warning().
