Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83D715EFA1
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970413; cv=none; b=huokrJB79H1M3JeIFj+j4gvjEXsQvSzj3BkGxP9fyPJVtmByoFIZKjRRYQcwOdr7QsddczjoFelA9ONARPqvmVw4Y7tGkMgDL/GByAAq1KM6E9Q9vRhWwrHxA5mTaJ/JaIevbSkdnwdBbbpiN25UHZzqwkGlEKPyXmyKpaakuSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970413; c=relaxed/simple;
	bh=Lg4axU+01Igs85afFtkMlgFgKULf/emPeGDyrRwa4XU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cBt+TGiu+htXwMyChOBtanydfh4NNUC3LqSUQnXvcuzL/FMZOGr6gJ7Y1DxDFCmyx1L1bLP2nGUjpaBcKbXsdVgawoZg7etwIfTCPNtvEE1rHsphIRk8Sfau2KUysXJaAsBot9kXFh4LkEXyScO3UrrZ/X1Cz1k+/NAI7cLaRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vc9tCCXb; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vc9tCCXb"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D097D33E8D;
	Wed, 24 Apr 2024 10:53:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Lg4axU+01Igs85afFtkMlgFgKULf/emPeGDyrR
	wa4XU=; b=vc9tCCXbUbTTXfoqCMdQS6j+9v+Igl9u3wSZhB6Z6ltQ5wv4LsDOGY
	hacHpui8lN4IafiIqId7q6iKdERFxJQ7JQQKZvsgXAiMXQGOg5zjpMn/nkBQtANs
	1irnyihxOgpJc4CoyvJbWqlkkuHq/W6bMkSTM/O01xIhkFFpDaLMM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C84C733E8C;
	Wed, 24 Apr 2024 10:53:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ABEEC33E8B;
	Wed, 24 Apr 2024 10:53:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Teng Long <dyroneteng@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 7/7] builtin/reflog: introduce subcommand to list
 reflogs
In-Reply-To: <Zii8cxOxM-Ggwtu7@tanuki> (Patrick Steinhardt's message of "Wed,
	24 Apr 2024 10:01:55 +0200")
References: <d7b9cff4c360147e65df17316533fba0b4f2ab7d.1708418805.git.ps@pks.im>
	<20240424073047.53755-1-tenglong.tl@alibaba-inc.com>
	<Zii8cxOxM-Ggwtu7@tanuki>
Date: Wed, 24 Apr 2024 07:53:25 -0700
Message-ID: <xmqqbk5y3j8a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 68945D0E-024A-11EF-A5EA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Apr 24, 2024 at 03:30:47PM +0800, Teng Long wrote:
>> Patrick Steinhardt <ps@pks.im> wrote:
>> 
>> +#define BUILTIN_REFLOG_LIST_USAGE \
>> +	N_("git reflog list")
>> 
>> Doesn't seem to need a translation here?
>
> I was following the precedent of the other subcommands, which all mark
> their usage as needing translation. Whether that is ultimately warranted
> I can't really tell. In any case, if we decide that it's not we should
> also drop the marker for all the other usages.

The motivation for N_() in others (namely, the ones with
<placeholder>s) is that the literal part like "git" "reflog"
"expire" and "--expire=" cannot be given differently even when the
user works in a different locale, but placeholders that explain the
meaning of what the user must plug in there like "<time>" is easier
for the users to be in their language.

The "list" subcommand is currently an oddball that does not happen
to take an argument or an option with value, and does not use any
<placeholder>, but for consistency and future-proofing, it is better
to have it in N_().

Thanks.

