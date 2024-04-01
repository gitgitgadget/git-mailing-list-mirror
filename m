Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B803F9DF
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004716; cv=none; b=IOz1hR5bk6PKZNFHFPlOGCDP+xF74gofuuqmTVFbqfFb7ec5LVLmyVzfBKrDaD+JI17mfatMnrpu8WTrR5mo2T+hZf2QcWteDpzK1PCvhgPKxXd2W43A6ajN5TnV6Bde93iTJ6IFVMAkVrdXoQQEmIlCO4HHDAL1kCmt6rM77bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004716; c=relaxed/simple;
	bh=kVN+SiXUYjNNg+dVeIcqUjKCCs5I8cqX815Y+k7pNZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VF0kluhkNkvVC4yjGQ7mmjUV02J23HcWTQQRMMa7f7iYYiF05T+7x85yTfKsnh5thN6dfSGI5AMV//VA3tDxTj+HSqdM8HwjUkkTDGX/nGoIUcwM6XSJvPx9Xny7lo0ndrUUJ1C+0itBHpCZfJQ5Oh28v5wssjA9v4swAEKfPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z2bmChOU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z2bmChOU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CDAA1D8B31;
	Mon,  1 Apr 2024 16:51:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kVN+SiXUYjNNg+dVeIcqUjKCCs5I8cqX815Y+k
	7pNZE=; b=Z2bmChOUtUpArR+cIu9MmoNBguzq6T8FIy4u2u3dk4aAnBXqe+cEJF
	yP1RCLsjuvQyyo9aQLEzjHOXejPE/8K5uI5Z4QAufUBM/K4SVgqkBq/msVU4juh4
	HA5IZ2VpUNqiaAEAr6U0NKlLD2/9ijHImJTSpdd8JzDgXp3Ar4EXU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 346DC1D8B30;
	Mon,  1 Apr 2024 16:51:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BF2C1D8B2F;
	Mon,  1 Apr 2024 16:51:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  chris.torek@gmail.com
Subject: Re: [PATCH 1/2] update-ref: use {old,new}-oid instead of
 {old,new}value
In-Reply-To: <20240401144542.88027-2-knayak@gitlab.com> (Karthik Nayak's
	message of "Mon, 1 Apr 2024 16:45:41 +0200")
References: <20240401144542.88027-1-knayak@gitlab.com>
	<20240401144542.88027-2-knayak@gitlab.com>
Date: Mon, 01 Apr 2024 13:51:46 -0700
Message-ID: <xmqqo7as957h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A7F756B0-F069-11EE-8418-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The `git-update-ref` command is used to modify references. The usage of
> {old,new}value in the documentation refers to the OIDs. This is fine
> since the command only works with regular references which hold OIDs.
> But if the command is updated to support symrefs, we'd also be dealing
> with {old,new}-refs.
>
> To improve clarity around what exactly {old,new}value mean, let's rename
> it to {old,new}-oid.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-update-ref.txt | 58 ++++++++++++++++----------------
>  builtin/update-ref.c             | 26 +++++++-------
>  2 files changed, 42 insertions(+), 42 deletions(-)

Did you run t1400 after this update?  There may be other tests that
the message update is breaking but that was the first one I noticed.
