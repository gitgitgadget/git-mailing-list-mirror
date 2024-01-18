Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074C2E636
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608437; cv=none; b=gLFyo9b6uP3NIOEGdaf9MLrzksbmRnBKwH5cQBh7xO5N8yy4WBX09+qfihZLZ6AW9FXp8zFAyuGMTrlAOzZG4gyLTfWzMlcLS9TinEp6kkuq3Kl/Hmpy+h/UOLI6xCamLJ38QkwHtuv9jqUSw+XA6YCMG5302spwD8Fw0CEjEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608437; c=relaxed/simple;
	bh=xMWIrw2gBq81Uwi1G9Nua7J3yATXNefqBtTQssIRUo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K5DMkImCQ6DUL6pw7zJYOl0B1ojAgyYjQAy0XdQXAWRwcInA4fO2NLty6qKOUeTtqX3VWe1gLrqrdydqRjvqkuz/3Jkvabmdjm3v1Mar8onD7WrgGExJc9gX72OALXIzwPlio3Ky0ldjucA2llBjmdzHt7N+EPBc1ZdEGYZuKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sHwiRBvQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sHwiRBvQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E2CD437EFD;
	Thu, 18 Jan 2024 15:07:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xMWIrw2gBq81Uwi1G9Nua7J3yATXNefqBtTQss
	IRUo8=; b=sHwiRBvQXk+rbm4zkZ6WvX0IneckPFp3IxtHhhkDH0AjX9W9K+r+2v
	rYenUybltPj0w+fwwZjIdojAF38DtHUT1rf2rc5qgQjytXL2p0yiyUo775rjeY/Q
	uUGv2y2zqsMnH5d9fmWeA0n1sNOiFlRTHUGi/Bih24GVuxOKlR1iA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DB84237EFC;
	Thu, 18 Jan 2024 15:07:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7293837EFA;
	Thu, 18 Jan 2024 15:07:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] reftable/stack: fix race in up-to-date check
In-Reply-To: <713e51a25c1c4cfa830db97f71cd7c39e85864d4.1705585037.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 18 Jan 2024 14:41:56 +0100")
References: <cover.1705585037.git.ps@pks.im>
	<713e51a25c1c4cfa830db97f71cd7c39e85864d4.1705585037.git.ps@pks.im>
Date: Thu, 18 Jan 2024 12:07:06 -0800
Message-ID: <xmqqcytyquc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 288F94C0-B63D-11EE-B93D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> This should address the race in a POSIX-compliant way. The only real
> downside is that this mechanism cannot be used on non-POSIX-compliant
> systems like Windows. But we at least have the second-level caching
> mechanism in place that compares contents of "files.list" with the
> currently loaded list of tables.

OK.


> +	/*
> +	 * Cache stat information in case it provides a useful signal to us.
> +	 * According to POSIX, "The st_ino and st_dev fields taken together
> +	 * uniquely identify the file within the system." That being said,
> +	 * Windows is not POSIX compliant and we do not have these fields
> +	 * available. So the information we have there is insufficient to
> +	 * determine whether two file descriptors point to the same file.
> +	 *
> +	 * While we could fall back to using other signals like the file's
> +	 * mtime, those are not sufficient to avoid races. We thus refrain from
> +	 * using the stat cache on such systems and fall back to the secondary
> +	 * caching mechanism, which is to check whether contents of the file
> +	 * have changed.

OK.

> +	 *
> +	 * On other systems which are POSIX compliant we must keep the file
> +	 * descriptor open. This is to avoid a race condition where two
> +	 * processes access the reftable stack at the same point in time:
> +	 *
> +	 *   1. A reads the reftable stack and caches its stat info.
> +	 *
> +	 *   2. B updates the stack, appending a new table to "tables.list".
> +	 *      This will both use a new inode and result in a different file
> +	 *      size, thus invalidating A's cache in theory.
> +	 *
> +	 *   3. B decides to auto-compact the stack and merges two tables. The
> +	 *      file size now matches what A has cached again. Furthermore, the
> +	 *      filesystem may decide to recycle the inode number of the file
> +	 *      we have replaced in (2) because it is not in use anymore.
> +	 *
> +	 *   4. A reloads the reftable stack. Neither the inode number nor the
> +	 *      file size changed. If the timestamps did not change either then
> +	 *      we think the cached copy of our stack is up-to-date.
> +	 *
> +	 * By keeping the file descriptor open the inode number cannot be
> +	 * recycled, mitigating the race.
> +	 */

This is nasty.  Well diagnosed and fixed.

Will queue.

Thanks.
