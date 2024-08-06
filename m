Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A58165F1F
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977256; cv=none; b=KAyuuXYvwlRj4Zt0/j/ZBp6aO44Smd33Tr0wEcZE7nBLElqDfUY9v4q+AsHW+RS34Kbqx8OTngrsqzIt/Y4OP+DdFn+fMD/lN27g61cE7mLqDi34Vopk6VNI/A+3xnXIwf5jjRmtbB+78R60DniBYl+m/yrhuq5n7MqpTn4pW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977256; c=relaxed/simple;
	bh=2jdi8TwJv1idD1TV4XcVjPlT8YrhP1jWpUkY70EwiEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HBgfgvCRQatSCVmuYjrPVxvFXOswiLE8XsrkPmJTXgeNUE+R1bs8g4jo3BbNmY+6wzLpe6JMh1l0j9TbNo1QL/JUhWoxp+TI/PsNSvujt5MMOgAN8Zi7wKWCboftYRtOGVuPrLZP9QnOOovWkXXf5w/CnHkHsw26l+q77X+/WXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KeweMs2h; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KeweMs2h"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 86EA524DDE;
	Tue,  6 Aug 2024 16:47:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2jdi8TwJv1idD1TV4XcVjPlT8YrhP1jWpUkY70
	EwiEU=; b=KeweMs2hTgHBIpsgSx17kW5OhHZypBNKdydjfPppNmYaLRaL9RoDqG
	Y+rO0bESY4GhHrWz0b5gNx2ii/XEZILFsmBVN+UhAfE3x0ISKjWm0PZH7HBGXOa9
	YyqYm5LKtJBkHpxhz7T7v20x0c17KJbCygsOU+/E7BTmnurH3CHIk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F62924DDD;
	Tue,  6 Aug 2024 16:47:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8668324DDC;
	Tue,  6 Aug 2024 16:47:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/6] t-reftable-stack: use Git's tempfile API instead of
 mkstemp()
In-Reply-To: <20240806142020.4615-4-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Tue, 6 Aug 2024 19:43:39 +0530")
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
	<20240806142020.4615-4-chandrapratap3519@gmail.com>
Date: Tue, 06 Aug 2024 13:47:28 -0700
Message-ID: <xmqq7ccts7j3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1943ECC8-5435-11EF-9B9C-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> Git's tempfile API defined by $GIT_DIR/tempfile.{c, h} provides

You are using the syntax of (some) shells to express "repeat the
string with 'c' and 'h' appended" here, so drop SP after the comma.
