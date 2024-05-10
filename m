Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8A50A93
	for <git@vger.kernel.org>; Fri, 10 May 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375972; cv=none; b=W3lSCSPWlUcSCR636obS6CGf2xAhgejSci89KonKe97xKz6Nm/MMQcozWjluC74gFZ9tNZblr9mNHrWKOoV/G3BQEqNTtdOp7QqGGzEdKP8D+mZ73EMrrAiZsDdPtztblUfRfYP8ezq5//sO+Qmh7o8ImBgL0wKUKq3Di9ResXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375972; c=relaxed/simple;
	bh=pY1gUeqrqzGSFJPkyI3CFdUqzsCXcxAjaDJ76lrXSnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H+Ev8fSKiXCzv8xHX95TFtBXAxov1T0lWcmc8Yh5tr/Op/gpR4w6+2SLhWKPYsz8abW/xz4cEgBMN11YcfNDGnvzmoUQ+zrcjOOBclNkWk5Y4Xdzaels3+IRj3Eq5//O7HN8sq7l8++GkhsgBZpdc8dxjyv5PJ7FoYbSpRPVLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W/+ZP9iU; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W/+ZP9iU"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 47A3036EC1;
	Fri, 10 May 2024 17:19:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pY1gUeqrqzGSFJPkyI3CFdUqzsCXcxAjaDJ76l
	rXSnc=; b=W/+ZP9iUEem/FugXSXYTjSmRIfUNvlvecItQqAT3bQv0NCggVYHjwk
	Ti8v3YS5bkkxip4m1IEAJw13ii8bnzFXDksWGfeQV4YoIQ7P9Jtg+0zZ8Abpd+hd
	Q7sKOEEPMdZj58SNEwG+lYFmC8l1IdBo5mGQ5DcZFhwoWZxfMxgp4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4047B36EC0;
	Fri, 10 May 2024 17:19:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BE58836EBF;
	Fri, 10 May 2024 17:19:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 03/11] reftable/writer: drop static variable used to
 initialize strbuf
In-Reply-To: <aa2903e3e5ac76f82252e12919a8a09178e267ee.1715336798.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 May 2024 12:29:30 +0200")
References: <cover.1714630191.git.ps@pks.im> <cover.1715336797.git.ps@pks.im>
	<aa2903e3e5ac76f82252e12919a8a09178e267ee.1715336798.git.ps@pks.im>
Date: Fri, 10 May 2024 14:19:25 -0700
Message-ID: <xmqqttj52wma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FB135598-0F12-11EF-8474-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We have a static variable in the reftable writer code that is merely
> used to initialize the `last_key` of the writer. Convert the code to
> instead use `strbuf_init()` and drop the variable.

Nice.  There is no guarantee that a structure assignment of a
just-initialized empty strbuf to another will stay to be a trouble
free operation, and using an explicit _init() call is the right
thing to do.

