Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E194DA0C
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069639; cv=none; b=j/g4ikFrFqZOJjl3AtXFPGaTsUXjnFHrL/dN26mFbpkJp6FRYwG1NKIm2avZc/5Bi6CAmtdxii1D1bOxZJ/ri4zlg+LPfGOgeqg5SQBov+8tTLwKX/Ugo1JgR7zVEinz0qwAEfasUwtG9gAE4EJoyTgjb+iTBxOWnEtJ9jqlKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069639; c=relaxed/simple;
	bh=V8fG1zSNKu44p99EwsF+zv6FZS1j9ABVAlyzbiEyluo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1Rl7HmApo52oaSZO3g2FfrhQr2z9zJaFbsaO12dFmOEUuhJHL2fEGyWzMXe6XFbVO2KVTQxQET/Ukoh1+5BJm1mcVQmlvRGHu9iFydBLOenaHo6MN9Cuwvs3jhqwazqcsxW8nwju4o0BfnBp492Q50fMsZb11oOBvdLQr1FOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uinGfa4e; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uinGfa4e"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1344E1D30E9;
	Tue, 27 Feb 2024 16:33:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V8fG1zSNKu44p99EwsF+zv6FZS1j9ABVAlyzbi
	Eyluo=; b=uinGfa4esRFy0V8TQYtOZFvoTLvgW/oq4oqbSnP0jfcu70rVV/kvYV
	0qIY2y8VfKLrltiOGcIwDwi+UL0dUvTQsyrNfxf08wuvJ3NOO7Ajw0t//2wOOH4p
	AlPyUVWLMTf24XKj0C5u9Giah5e5Rta7YTuyAnJr+uFeIi74bzVdw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BCDF1D30E8;
	Tue, 27 Feb 2024 16:33:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74B8B1D30E7;
	Tue, 27 Feb 2024 16:33:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 0/2] builtin/clone: allow remote helpers to detect repo
In-Reply-To: <xmqqcyshr5em.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	27 Feb 2024 12:58:09 -0800")
References: <cover.1709041721.git.ps@pks.im> <xmqqcyshr5em.fsf@gitster.g>
Date: Tue, 27 Feb 2024 13:33:55 -0800
Message-ID: <xmqqh6htpp6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E94D1536-D5B7-11EE-A59C-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Hi,
>>
>> this patch series addresses a regression reported by Mike in Git v2.44
>> where remote helpers cannot access the Git repository anymore when
>> running git-clone(1).
>> ...
>>  builtin/clone.c            | 46 ++++++++++++++++++++++++++++++++++++++
>>  refs/reftable-backend.c    |  1 +
>
> Sorry, but this confuses me.  Was a regression really in v2.44.0,
> where refs/reftable-backend.c did not even exist?  If so why does a
> fix for it need to touch that file?
>
> Thanks.

I guess [2/2] alone is the fix to be applied directly on top of v2.44.0
and eventually be merged to 'maint' to become v2.44.1 release, while
[1/2] is necessary to adjust reftable backend when such a fix is
merged to more recent codebase that already has the reftable
backend?

