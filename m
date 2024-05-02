Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28316FF27
	for <git@vger.kernel.org>; Thu,  2 May 2024 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672429; cv=none; b=V5vnd33BIf1qUG4hhCIwwE/ivfgBCcoTYhC8vJz7fX0WSkCsvPQE2eE5QE4ia24Yv+acjwMN5P5pzQO7XG+WJIyF/KpydUijBbBzQOJ2pmWsLNw4d7L7lC0vxfIe5ShJkqR4lo1ifkZD3cfq+CKfurrooJXNuuZD7APd6louhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672429; c=relaxed/simple;
	bh=zlMR8a036DTWrtpbrn8C8YJkltYK3LAZBh54lplQ7wQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sEWdNXGGAhc5koVwDTLG+crsty3w/jxGrhraZ8j3iYZO4UNO96t1oYwmoyqa1KexUK8CZfzsfEPotjG45mmKdhhGyYDEhE5SPKfaAuBZvbz339VmX2tfFgg94u2UqxhJIx8FT2EQr+qjYS8veYug4eArbtCzfAa9Gf0G+F2mdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cydbjzwW; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cydbjzwW"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CCCA22202;
	Thu,  2 May 2024 13:53:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zlMR8a036DTWrtpbrn8C8YJkltYK3LAZBh54lp
	lQ7wQ=; b=cydbjzwWb2EJ5f4V0vE79gNoYFbXuwjGyx7GKxugDTHYJdBF6MYSbS
	x1yk+zorZR4W9uJP3GO8Xjcn4SD43mnaRQhRaUZZUgSCnb52Ixo+zQNunFT34te3
	8mkoGcEPAAxRBZUeJBdJHj2dvvjetHl5O6/jTRqPDcgaUDWXwbsdA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 92C5E22201;
	Thu,  2 May 2024 13:53:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06F7F22200;
	Thu,  2 May 2024 13:53:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 4/7] refs: add support for transactional symref updates
In-Reply-To: <20240501202229.2695774-5-knayak@gitlab.com> (Karthik Nayak's
	message of "Wed, 1 May 2024 22:22:26 +0200")
References: <20240426152449.228860-1-knayak@gitlab.com>
	<20240501202229.2695774-1-knayak@gitlab.com>
	<20240501202229.2695774-5-knayak@gitlab.com>
Date: Thu, 02 May 2024 10:53:44 -0700
Message-ID: <xmqqbk5odrrr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EC1C6636-08AC-11EF-B4C1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -2863,12 +2928,26 @@ static int files_transaction_finish(struct ref_store *ref_store,
>  
>  		if (update->flags & REF_NEEDS_COMMIT ||
>  		    update->flags & REF_LOG_ONLY) {
> -			if (files_log_ref_write(refs,
> -						lock->ref_name,
> -						&lock->old_oid,
> -						&update->new_oid,
> -						update->msg, update->flags,
> -						err)) {
> +			int create_reflog = 1;
> +
> +			if (update->new_target) {
> +				/*
> +				 * We want to get the resolved OID for the target, to ensure
> +				 * that the correct value is added to the reflog.
> +				 */
> +				if (!refs_resolve_ref_unsafe(&refs->base, update->new_target,
> +							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
> +					/* for dangling symrefs we skip creating a reflog entry. */
> +					create_reflog = 0;
> +				}
> +			}
> +
> +			if (create_reflog && files_log_ref_write(refs,
> +								 lock->ref_name,
> +								 &lock->old_oid,
> +								 &update->new_oid,
> +								 update->msg, update->flags,
> +								 err)) {
>  				char *old_msg = strbuf_detach(err, NULL);
>  
>  				strbuf_addf(err, "cannot update the ref '%s': %s",

This hunk is overly wide.

You could of course fix it mechanically (e.g., by rewrapping overly
wide comment block, wrapping an expression after &&-), but a code
path that is too deeply indented may be a sign that the function may
want to be split into calls to a smaller helper function for
readability.
