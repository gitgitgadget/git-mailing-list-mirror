Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0710A18
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515041; cv=none; b=GpvXFlvg7wALRnWeYoC7YH0qmThHr5ZX4b8HqtjEaCagRCULukY9jgfuCcsruB1XByFLe505heoOvff3CgbEyz1qsbnL8QJwgZllue5HyGC2idNykJrAcLMbkHF/BcPDKoM1WU5rERUW3oF9VlZUrQ1BZ/6U/NS9osdcAPmUjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515041; c=relaxed/simple;
	bh=kNVBJhDA4fCWH6I5u6olPJ0+kTxtNwExfUYViC8DdRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XH7bZUa5geu39keCetHV5yIUQO9BE1Vpl8xY5MkImcC1KmTSBmQn9qh2rVB3qqlFukDmCn6n2CFan4/eepErATbwo4QeO+QBs1YWZ5cR1Wg28M1us8XQwg17Tl10k1xwwc4sm8eeJDbFGfezhoL7Uy6EGVR9OTKYWbSkFAmF/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wlLbONAt; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wlLbONAt"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 276B136FC1;
	Mon, 16 Sep 2024 15:30:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kNVBJhDA4fCWH6I5u6olPJ0+kTxtNwExfUYViC
	8DdRk=; b=wlLbONAtjG62h36QaHye8cnSa1yCD3CDWvWDUcRZ4PNCUV1IxKQZbA
	T7SeQA0h6QKzA/Twk7sO90YV6JE+aBA5qQSLsWqs3tTsKPiTblAFKBa3jhSebPN9
	zgMUMYyNZKnnjPoop+7twMd13mhSc8rQ9K/JXlsKFYwP+SituC3pI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F26836FC0;
	Mon, 16 Sep 2024 15:30:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D22736FBD;
	Mon, 16 Sep 2024 15:30:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] apply: refactor `struct image` to use a `struct
 strbuf`
In-Reply-To: <6cf45daf84af68f74d87a5b2ae7102d4cd8ceb57.1726470385.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 16 Sep 2024 09:10:16 +0200")
References: <cover.1726470385.git.ps@pks.im>
	<6cf45daf84af68f74d87a5b2ae7102d4cd8ceb57.1726470385.git.ps@pks.im>
Date: Mon, 16 Sep 2024 12:30:37 -0700
Message-ID: <xmqq8qvrmm5e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 27406750-7462-11EF-828C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Refactor the code to use a `struct strbuf` instead, addressing all of
> the above. Like this we can easily perform in-place updates in all
> situations, the logic to perform those updates becomes way simpler and
> the lifetime of the buffer becomes a ton easier to track.
>
> This refactoring also plugs some leaking buffers as a side effect.

Nice.

In short, the leaks were in the original code where it was making
direct assignment to image->buf, and we now use strbuf_attach(),
which releases the current buffer before replacing it with a piece
of memory allocated outside the control of strbuf API?

>  static void image_remove_last_line(struct image *img)
>  {
> -	img->len -= img->line[--img->line_nr].len;
> +	strbuf_setlen(&img->buf, img->buf.len - img->line[--img->line_nr].len);
>  }

I feel that this, while technically is faithful to the original, got
a bit too complex to understand what is going on.  Perhaps split it
into two statements with an intermediate variable?  I dunno.

Thanks.
