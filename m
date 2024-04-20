Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7E625
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713634235; cv=none; b=fa4vtPq31vSsWaJmGWaNQsjp/y79ziUPnG7FvxVfmOTu2+xJkcgNLaRGV9kM9CURB4Rxo/a+/34/xb7n1OAtfZOIJhMJ2/Xb+eNO0iyQx3qdqKLP2BeUNF3TErL/EOMzIHKnAYk7INQINvZDARw4iqNoeYHpVcPl7RSV3a5XqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713634235; c=relaxed/simple;
	bh=zwpBiTt0SoCqcTegH6HtrnNz0bRpgQLtGphPDc2zHvE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rs3N1kTDTcXhBHAmzIl/0oTQ6dks7RewpM5F35tWg/havVEK0M8RHytqyWLknoV25GY9zlYgM2oTYpMP33pVh4cdzZIhWrKRk4/9m6E9oQZp5Cm+3h/bHwbt+smKFFAs3WCNX3xX8lpklF8FYqAlSzxCIVUm6NbTYU1UhhvbOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O+xJd3tr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O+xJd3tr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B1A81F792C;
	Sat, 20 Apr 2024 13:30:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zwpBiTt0SoCqcTegH6HtrnNz0bRpgQLtGphPDc
	2zHvE=; b=O+xJd3trstDIct6NtlN0gFORGxH7/+Q7QNwXs7kD+vqY/xsrgmlJRP
	ynXESK6zFYxwe/UoiehRYhXWiegFwr0vWFXGMAGD9uHDZG2fqcxNxMWg3wo320jG
	cDx6QaDbf0tCJOYOJTH+kEtOaCoVZ8w2mt25bVOUr53qU0/zPKG0E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 641BB1F792B;
	Sat, 20 Apr 2024 13:30:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1D451F792A;
	Sat, 20 Apr 2024 13:30:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [BUG?] "format-patch --range-diff=$commit HEAD^ HEAD" fails
In-Reply-To: <xmqqbk65jmqp.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	19 Apr 2024 10:17:18 -0700")
References: <xmqqbk65jmqp.fsf@gitster.g>
Date: Sat, 20 Apr 2024 10:30:31 -0700
Message-ID: <xmqqcyqk3ps8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B0C298C8-FF3B-11EE-87D3-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Immediately after "git commit --amend" of a single commit,
> this fails:
>
>     $ git format-patch --range-diff=@{1} -v2 HEAD^ HEAD

Please scratch this one.  I simply forgot that we have lost
the

	git format-patch <his> <mine>

syntax long time ago during Git 1.4.0 timeframe [*].  I somehow was
confused since we still have the corresponding

	rebase <since-onto> <mine>

syntax.


[Footnote]
 * I suspect this may not have been a conscious design decision but
   by accident during the rewrite of the command in C that I started
   at 3eefc189 (Tentative built-in format-patch., 2006-04-18) and
   whose final shape was documented by 2052d146 (Update
   documentation for git-format-patch, 2006-05-31).
