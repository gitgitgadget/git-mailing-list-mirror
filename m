Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717778276
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756294; cv=none; b=SzIIgP7bzrz+IPOKruAoqCbofLIETPblxTn+yrPyYF9ruGuZ+MZdK9lQ58UXWJYYsfb2HIu14GN+wlG+ZzeNRmCpk0NwksS0TuG4q+GYAcazWnpbgF1Zv/5nwLOy5zkQ3DswkO0RSkaKfOnPsUFLdTionWyBMIe2cybRX+QZfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756294; c=relaxed/simple;
	bh=wNYAllGoCy46VitI4PpYdhgHv30WamRGfWgFdBqyF7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o8m7+ZdUz8M6P8URuMOmF9aA0fFq7EnBzTFF7Fe3TeFb9zRPJB2HN0WNjzKNEtziPAgEe6ZUI8NPM/xNVgFY0TkmvanTbheOeeQmUFHbTr+WOlCicN6U6sDwjliT/IB/zLQSN5iBo8owO69Fgzpg8ZU73KU8/65LBarggnnX3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=K/1dVOSn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K/1dVOSn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05D682A7CE;
	Fri,  3 May 2024 13:11:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wNYAllGoCy46VitI4PpYdhgHv30WamRGfWgFdB
	qyF7A=; b=K/1dVOSncsbxvwGmjz+y7oVAAPVwYQCE4cTDf5JBzKdmC2XB0t8MOh
	Ew8Ri6KrBJ8i2+xi5KARhHkT88vTYcl4wP/1dIy/a/A9LukvthC0bONbYv59+OEc
	G/f1lr2b8lp8eXqw5fai8EwbCj47+W5eFMgDIesmMo4rNPQNZuZtg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2D2C2A7CD;
	Fri,  3 May 2024 13:11:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60C592A7CC;
	Fri,  3 May 2024 13:11:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] refs: introduce missing functions that accept a
 `struct ref_store`
In-Reply-To: <dba5df086d9dbbc2801f946abef47714b41d3750.1714717057.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 3 May 2024 08:27:59 +0200")
References: <cover.1714717057.git.ps@pks.im>
	<dba5df086d9dbbc2801f946abef47714b41d3750.1714717057.git.ps@pks.im>
Date: Fri, 03 May 2024 10:11:30 -0700
Message-ID: <xmqqttje95x9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2FC3C1AE-0970-11EF-8FFF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> While most of the functions in "refs.h" have a variant that accepts a
> `struct ref_store`, some don't. Callers of these functions are thus
> forced to implicitly rely on `the_repository` to figure out the ref
> store that is to be used.
>
> Introduce those missing functions to address this shortcoming.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 65 +++++++++++++++++++++++++++++++++++++++++++++-------------
>  refs.h | 13 ++++++++++++
>  2 files changed, 64 insertions(+), 14 deletions(-)

This will eventually allow us to even use an independent ref_store
that is not tied to a repository, but the huge patch we see later
will just force all the callers to call get_main_ref_store() on
the_repository before calling these functions, so while the whole
thing looks scary huge and noisy, there aren't all that much risky
going on in this series.

Looking good.

