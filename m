Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39912632
	for <git@vger.kernel.org>; Thu,  2 May 2024 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714609218; cv=none; b=utqrg7BWiIrp/orVfjbVi8aMdCegBuEynsaQEswLbKoIv5nlFWQAsbPDcBY4JuVtiDiA+CHKc9cLVsCrFyAZvHR9G7jnVd2V1UZQyPWt+tMnON4Vm0yzheNcK9PFexTZgEq1ftpKqZgnrJKtfvuME022B92qloPBJsHnEjeiL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714609218; c=relaxed/simple;
	bh=pDiH1frDMo8ev1/xC1S56tTiQu1IY2GTGiKVWlNBn4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ih3r/T6yXNxyKteE1/9x+iJf7KzXiXqU1mCnmdzHLF5Ttf4+C/DJLfTjmTbr0vhMfIelB8tkFaF0srMmY95zC/JUncfQad607CyuB5yUlasXu4Pg5r0DU0bqSyaIM83gua7cTPzjRInzsOSS+f4I133EW4qlmZ0OTHUSQJg29xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qmjYEhwn; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qmjYEhwn"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D7BE37DC2;
	Wed,  1 May 2024 20:20:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pDiH1frDMo8ev1/xC1S56tTiQu1IY2GTGiKVWl
	NBn4o=; b=qmjYEhwncpGDkFTZs/UANtltti2n1V/9adOrO+tkk7iaUA9o4hV092
	Z4vNkRZx3dP7VnLhjAOF0LBLQcPox6LxIGqvVS7MMVIlnVZxZQIf9QBUoCMuaDfG
	cZPeU01H85deBpAetkiut8MyXoRyH3BMzlR99jE9A80ffs5Ku0J6w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8390D37DC1;
	Wed,  1 May 2024 20:20:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D430E37DC0;
	Wed,  1 May 2024 20:20:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 0/7] refs: add support for transactional symref updates
In-Reply-To: <20240501202229.2695774-1-knayak@gitlab.com> (Karthik Nayak's
	message of "Wed, 1 May 2024 22:22:22 +0200")
References: <20240426152449.228860-1-knayak@gitlab.com>
	<20240501202229.2695774-1-knayak@gitlab.com>
Date: Wed, 01 May 2024 17:20:08 -0700
Message-ID: <xmqq34r1gj47.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BC5857FE-0819-11EF-B6E0-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The patch series takes over from the existing patch series, wherein we
> introduced symref-* commands to git-update-ref. Since there was a ton of
> discussions on the UX of the patch series and its application, I thought it
> would be best to shorten the series and split it into multiple smaller series.
>
> This series adds transactional support for symrefs in the reference db. Then
> we switch refs_create_symref() to start using transactions for symref updates.
> This allows us to deprecate the create_symref code in the ref_storage_be
> interface and remove all associated code which is no longer used.
>
> The split was primarily done so we can merge the non-user facing parts of the
> previous series. While pertaining the user facing components into another set
> of patches wherein deeper discussion on the UX can be held without worrying
> about the internal implementation.

This split probably makes sense in the context of the evolution of
this series.  If this were without any prior discussion, a change to
the internal mechanism, without showing how the end-user facing half
would use it fully, would have been hard to evaluate, but now that
we know where the new mechanism wants to take us, we can fairly
evaluate it alone without the end-user facing part.

I've read only the earlier half of the series but so far the pieces
make sense to me.
