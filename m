Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530517F394
	for <git@vger.kernel.org>; Tue, 14 May 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707153; cv=none; b=Qkqg4J0bXK00LUn2Npg6E84yCX5CIQVviJrRKZm/+XtdB7iSukDXSr4d2aVp1eBIJVylNJHuwFIvOg8NoIarahGcVKOsvNhUdApeRuQdo6z8WqSwsEU0LElBK8IwVaOLVO04KBTkL58jCgDDunmn20oZDaI/GuvCKlxDVSBcVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707153; c=relaxed/simple;
	bh=MsvN5bUFwkvHFjxgxWIZH2sB6oiPA/GiAQwfSMZfreA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kEmxydpgJhaQRipi3qfurVrtbOixNG6l0ONp9R3w0jmqMkLxjfmCeXUj6EXNxfyxArGope+JOJyzNuyKOIxkkbJa7Cg+oO178xp+CdMUjt4l/Wpf39waUTZmOIkr1ChwBgg2q62GcDtnmNrUSxn+fuQfwaxmCG9gJGOun2B5DnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pn9IOA0F; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pn9IOA0F"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4691C3DF4E;
	Tue, 14 May 2024 13:19:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MsvN5bUFwkvHFjxgxWIZH2sB6oiPA/GiAQwfSM
	ZfreA=; b=pn9IOA0FV67s80hzkpbvChv1TZUklE0sx67reN2U/IIc9ZCcJme7sW
	eTKcFJJrOo7dtWh/r7NXZ3EIY2hYB0WRt2eKRSfU0K3n1f5ZesEG5qhzO5zd8J7B
	N4wMkQC+1vlnpD31PfoFqxDFZFwqNjHEka2ISlGCrlWBZDErNsTFw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C8283DF4D;
	Tue, 14 May 2024 13:19:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A3F1A3DF4B;
	Tue, 14 May 2024 13:19:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v4 1/5] setup: add an escape hatch for "no more default
 hash algorithm" change
In-Reply-To: <20240514011437.3779151-2-gitster@pobox.com> (Junio C. Hamano's
	message of "Mon, 13 May 2024 18:14:33 -0700")
References: <cover.1715582857.git.ps@pks.im>
	<20240514011437.3779151-1-gitster@pobox.com>
	<20240514011437.3779151-2-gitster@pobox.com>
Date: Tue, 14 May 2024 10:19:01 -0700
Message-ID: <xmqqikzg48hm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0F4A55D8-1216-11EF-BC4B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Partially revert c8aed5e8 (repository: stop setting SHA1 as the
> default object hash, 2024-05-07), to keep end-user systems still
> broken when we have gap in our test coverage but yet give them an
> escape hatch to set the GIT_DEFAULT_HASH environment variable to
> "sha1" in order to revert to the previous behaviour.  This variable
> has been in use for using SHA-256 hash by default, and it should be
> a better fit than inventing a new and test-only knob.

Having done all of this, I actually am very tempted to add the
"always default to SHA-1" back as a fallback position to the
set_default_hash_algo() function.  We know we are going to get the
right hash algorithm when working in the repository, so the only
case the default matters in practice is when working outside the
repository.

We already have such a custom code for "git diff --no-index", and we
are adding a few more back in here, but they can disappear if we had
code to set the fallback default when GIT_DEFAULT_HASH does not
exist here.  The "always use SHA-1 regardless of the hash used by
the repository" code like "patch-id" should not depend on such a
fallback default but should have its own code to explicitly set it.

As the user can tweak what algorithm they want if the wanted to, it
does not sound too bad to have a fallback default when the user did
not choose.
