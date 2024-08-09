Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48A17557
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229876; cv=none; b=cnsTEuUUq4OH8rWlLZ6IZ1T/Jkn3WiivDT8VibDAgaF3Ywn2UyGcbxOuzkJr7ifShAxC5Sb/9/t4zxg4qf6YaAePs7TEGuJI9557tWWxYVNIgFvRHzzxKqUPoGIGLwbafpO5T49HBtRckQ0ocWpiQ5WX1dcfGJLoR7wMg1nVOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229876; c=relaxed/simple;
	bh=r1TGShFVt2Z7YXMqGpyZqGVlkiQRPm8lakDIvfsakVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J36Qm6EafNksh+cRSYQaceAIbYME6mGoNlydSZFrzyz0kcQPJs9Nn4ZhdZCnMHCRQGTQEkJKoavfCdc+a8oxs6NBrUjcuAEbbN3GKOelTJKqLAplQIEM/pAupVwxzyz3vYYt91io26vHFMWI97RCP0ImyB5vhwMRJHz2HlUN4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=clJYl2VP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="clJYl2VP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D95FD2EE7A;
	Fri,  9 Aug 2024 14:57:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=r1TGShFVt2Z7YXMqGpyZqGVlkiQRPm8lakDIvf
	sakVM=; b=clJYl2VPOcih8TZ7EMcQcA0D0zn3YMtxAYRotHlez1mTsP9D4QInNI
	Sgl0idAyO1XDfhjfrv6c2T2hjsz2+Q1CYEbtS917bHc4Y5YK9SPVXFaXLzhekU5n
	sxdmjecoNtPsuBHbd0Y+/YnRYsTjmojFn02hXVRy9E6s4AfI/pQnA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D19642EE79;
	Fri,  9 Aug 2024 14:57:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D485D2EE78;
	Fri,  9 Aug 2024 14:57:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/4] t-reftable-readwrite: use free_names() instead
 of a for loop
In-Reply-To: <20240809111312.4401-3-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Fri, 9 Aug 2024 16:35:42 +0530")
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
	<20240809111312.4401-1-chandrapratap3519@gmail.com>
	<20240809111312.4401-3-chandrapratap3519@gmail.com>
Date: Fri, 09 Aug 2024 11:57:49 -0700
Message-ID: <xmqqjzgpcymq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 474E1550-5681-11EF-A1ED-BF444491E1BC-77302942!pb-smtp20.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> free_names() as defined by reftable/basics.{c,h} frees a NULL
> terminated array of malloced strings along with the array itself.
> Use this function instead of a for loop to free such an array.

Going back to [1/4], the headers included in this test looked like this:

    -#include "system.h"
    -
    -#include "basics.h"
    -#include "block.h"
    -#include "blocksource.h"
    -#include "reader.h"
    -#include "record.h"
    -#include "test_framework.h"
    -#include "reftable-tests.h"
    -#include "reftable-writer.h"
    +#include "test-lib.h"
    +#include "reftable/reader.h"
    +#include "reftable/blocksource.h"
    +#include "reftable/reftable-error.h"
    +#include "reftable/reftable-writer.h"

I found this part a bit curious, perhaps because I was not involved
in either reftable/ or unit-tests/ development.  So I may be asking
a stupid question, but is it intended that some headers like
"block.h" and "record.h" are no longer included?

It is understandable that inclusion of "test-lib.h" is new (and
needs to be there to work as part of t/unit-tests/), and the leading
directory name "reftable/" added to header files are also justified,
of course.  But if you depend on "basics.h" and do not include it,
that does not sound like the most hygenic thing to do, at least to
me.

The code changes themselves look good; I can see that the
implementation of free_names() in reftable/basics.c safely replaces
these loops.  There is a slight behaviour difference that names[]
that was fed to reftable_iterator_seek_ref() earlier goes away
before the iterator is destroyed, but _seek_ref() does not retain
the names[0] argument in the iterator object, so that is OK.

Thanks.
