Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A51649A8
	for <git@vger.kernel.org>; Wed,  1 May 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601183; cv=none; b=XC3Pv8gkZm7rQnHp1UGLxjtc1EQ/mYGzT/inlQYi6tbHA4WVSpPewQB5Y0uucRPXsmKODTsxqR1n7KU+scPq7dwEuCaa545nazwYr4HHJhZWEbkHNpgpjlyV/Ytck5GMstc2RLyKIAtr2fL5ueOIljXOd8f+rc+2RS9kkee3XJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601183; c=relaxed/simple;
	bh=v89b6CxEFxku5dsa8ETG4aMNb88g4KWyGjJR16t7LRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSyUXnYlvzvBLbfOzubw44Gwzkj2Usu0+B+m+sgPOYZHUQVxNE/6xrSnIw2Y1FRk+iw0cB5kLdV0wUgbZT0hPbQ337A+lPY5iscbjJDQtKs3KZ2CRhgXMARVBGE5tg7WpJ4DSVt4rAMOOjtB3XBOyiUQnJ/ArSRovHIELBHaqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eu2zT3C/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eu2zT3C/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 416831B318;
	Wed,  1 May 2024 18:06:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=v89b6CxEFxku5dsa8ETG4aMNb88g4KWyGjJR16
	t7LRM=; b=eu2zT3C/TVHubvvoCFZP5Ys2PCc6kYFPJL8pWsBINZJFZ4X1WbkEH+
	AuQtMbKLh+ETwf2eTFC7jvgMLHKd7qg538R2XepVZGH46fVdB7UEKqEqo6JlS6oD
	HHRsXZ+OOGb+GQkMN+3Aqm6hynGH6aPylgfHhd8aO7gC2H8TITyvc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 399481B317;
	Wed,  1 May 2024 18:06:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E0AC1B316;
	Wed,  1 May 2024 18:06:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 2/7] files-backend: extract out `create_symref_lock()`
In-Reply-To: <20240501202229.2695774-3-knayak@gitlab.com> (Karthik Nayak's
	message of "Wed, 1 May 2024 22:22:24 +0200")
References: <20240426152449.228860-1-knayak@gitlab.com>
	<20240501202229.2695774-1-knayak@gitlab.com>
	<20240501202229.2695774-3-knayak@gitlab.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 01 May 2024 15:06:19 -0700
Message-ID: <xmqq7cgdjig4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A8E0828-0807-11EF-9F59-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> +	if (!fdopen_lock_file(&lock->lk, "w"))
> +		return error("unable to fdopen %s: %s",
> +			     get_lock_file_path(&lock->lk), strerror(errno));
> +
> +	if (fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target) < 0)
> +		return error("unable to fprintf %s: %s",
> +			     get_lock_file_path(&lock->lk), strerror(errno));

error() is end-user facing, so "fprintf" is probably a bit too
precise?  "fprintf" -> "write to"

Also we may want to make them (not just this new message but other
error() messages in related code paths) localizable but that is
probably beyond the scope of this topic.
