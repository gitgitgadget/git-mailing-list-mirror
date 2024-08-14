Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8821B1409
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654489; cv=none; b=ae801nk8qQDjaKbIz/8Uww1vEISnrhMUmX93gBrk5Jr1sIudQHEq5cRefDZ1NLi1+QF0jhrLAhrpL8G4I1U80a8Q6EkvGwLdl8Kfqa2htipJyMoiuxFfAMfYogtmj4UkR9Bg7Cu0J7MIwnfXYNLZOGBVc/t6+vvZm4DVRfooWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654489; c=relaxed/simple;
	bh=d/8H0oouHlaK6v+lTvrYl18ZuXlT1bnocuPWXktMNVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N6kcAv7OiNyG+NhfPzIg0YRmpkqHMrK3mxo+uavCFxsDStmCWi2NJmBrGYMx2f5GqzJQGHutGXrYFYYGNzNQT5ZLxMseT0r1Sbo5WUWok297EvFH1mvR3S0UUyUBYbHrkiIANQUk6Txn/EhUqcQ3yfplvklVL8GJFyhbz4UBrog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nW9OVH7E; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nW9OVH7E"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 01CC1188E1;
	Wed, 14 Aug 2024 12:54:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=d/8H0oouHlaK6v+lTvrYl18ZuXlT1bnocuPWXk
	tMNVs=; b=nW9OVH7EaayfeCMPE14iMGEy7AYGZsbMfIemIcbBxptS9f6g98eigC
	JNsFjjLCGbsQN/He8hu1LCrnkUEo/+bFpaNsW826DinagfR9ECIduU5eucNvIVWp
	ChOBmTd4bujbB10i72AndxWYLJAiizsah+8jcMcOuECK11HP4g+rA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC070188E0;
	Wed, 14 Aug 2024 12:54:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C3D4188DF;
	Wed, 14 Aug 2024 12:54:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2 0/3] send-email: teach git send-email mode to
 translate aliases
In-Reply-To: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
	(Jacob Keller's message of "Tue, 13 Aug 2024 17:05:08 -0700")
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
Date: Wed, 14 Aug 2024 09:54:45 -0700
Message-ID: <xmqq34n711uy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E9477754-5A5D-11EF-8755-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> The b4 program has its own "b4 send" utility for sending a patch series. It
> is similar in many respects to git send-email. Currently, it lacks support
> for processing aliases, which makes switching between git send-email and b4
> send somewhat annoying.
>
> It would be convenient if b4 (or other programs interacting with git) could
> make use of git send-email's alias file support.
>
> Teach git send-email a new --translate-aliases option, which enables a new
> mode for git send-email. When executed with this option, git send-email
> will read standard input and convert each input according to the configured
> alias file. The resulting address will be output to standard out.
>
> I also considered implementing a new "full" format for --dump-aliases which
> would dump the entire alias file along with its configured email addresses.
> I ended up dropping that change as I felt that it would be less usable than
> the translation feature.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Changes in v2:
> - Use standard input instead of command line arguments
> - Link to v1: https://lore.kernel.org/r/20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com
>
> ---
> Jacob Keller (3):
>       t90001-send-email.sh: fix quoting for mailrc --dump-aliases test

Nobody noticed the typo in the filename since the previous iteration
was posted?

>       t9001-send-email.sh: update alias list used for pine test
>       send-email: teach git send-email option to translate aliases
>
>  Documentation/git-send-email.txt |   7 +++
>  git-send-email.perl              |  21 ++++++-
>  t/t9001-send-email.sh            | 118 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 139 insertions(+), 7 deletions(-)
> ---
> base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
> change-id: 20240808-jk-translate-alias-send-email-1ce048643e5d
>
> Best regards,
