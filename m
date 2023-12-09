Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KOukITdc"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F92F1734
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 17:40:34 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C96A1CFE4;
	Fri,  8 Dec 2023 20:40:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=C8P9W56o1JyFkDtCZlP6TGsmGYjv/9udeWKnTt
	uUCw0=; b=KOukITdcwPYJowdWz55CuHD6fZ7H/Jyyn8/ZWGImrhjOdaraJE+nwi
	lnczJKlrU1oSqlNf0p7SQ/TxW4cd0V2HANrVC0dZ4kX0AngsiUqCY5An7JBcf1bu
	rB6L/zaaXKrHjWMvfm2bDG1wZ/RWpUafnWiUC1RCfDqz9A1wV9E50=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7469B1CFE3;
	Fri,  8 Dec 2023 20:40:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B5D41CFE2;
	Fri,  8 Dec 2023 20:40:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 05/24] midx: implement `DISP` chunk
In-Reply-To: <ZW95WSErCXvkfrAG@nand.local> (Taylor Blau's message of "Tue, 5
	Dec 2023 14:26:17 -0500")
References: <cover.1701198172.git.me@ttaylorr.com>
	<c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com>
	<xmqqjzpv4ecg.fsf@gitster.g> <ZW95WSErCXvkfrAG@nand.local>
Date: Fri, 08 Dec 2023 17:40:29 -0800
Message-ID: <xmqqlea4nofm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F02175D2-9633-11EE-9CA3-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Hopefully you're satisfied with the way things are split up and
> organized currently, but if you have suggestions on other ways I could
> slice or dice this, please let me know.

I did wonder how expensive to recompute and validate the "distinct"
information (in other words, is it too expensive for the consumers
of an existing midx file to see which packs are distinct on demand
before they stream contents out of the underlying packs?), as the
way the packs are marked as distinct looked rather error prone (you
can very easily list packfiles with overlaps with "+" prefix and the
DISK chunk writer does not even notice that you lied to it).  As long
as "git fsck" catches when two packs that are marked as distinct share
an object, that is OK, but the arrangement did look rather brittle
to me.
