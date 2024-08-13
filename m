Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F591A2575
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564988; cv=none; b=gHOJ9VpdAUEGQ68HGXueAllL2z+I+doP4E/E98WuqLWSBk1lq7QxyBGY/IgICDgIgP04tpjva9ZgsviZn3hJto38ms8qdRNvol8LGhCuGk7u2CiN//RInn2H0C4+K1Qk05EojZC3PrDtxGNAex57WgTZRP8uByekT1qXVUe79tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564988; c=relaxed/simple;
	bh=Dt0N6vEez2mgDKo5cfxyCQ07fVKqlrz7SP2LvIxM4/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Deb3E7CbUi4RZmKbyDAijlEj2oSCBwGtCQtgTZeCEbjrhXHsx+isoPZghIDC0ReiUZJ++9pcrkaO/iB23f2qdPaYTXokRbx3iL7r93MVpUhhxW1n70oP0lzoHy5ptTOkNf6fmG8wfwn16A8UWpSKi3JtzLpenm5wv+weR03zSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VQWFQv80; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VQWFQv80"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E7A79356F1;
	Tue, 13 Aug 2024 12:03:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Dt0N6vEez2mgDKo5cfxyCQ07fVKqlrz7SP2LvI
	xM4/8=; b=VQWFQv80ByanBGdhigIfQDioob+LikRg6FpTeVg4xSkvYKV2ccFmHT
	fduf3gpKuhWXEr0viOakr0V3nxmXZoFxZKShstGeCLvCBEmhEsbfwIb/qEXvF1vB
	mQTy7SJvpjhenkFMEQEBXEQjaGxjrBffhyXeGTdnN9t0V3vG78+Ns=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DF312356F0;
	Tue, 13 Aug 2024 12:03:01 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5984A356ED;
	Tue, 13 Aug 2024 12:02:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  James Liu
 <james@jamesliu.io>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 02/22] git: fix leaking system paths
In-Reply-To: <Zrr9oxgg3w8JyUpw@tanuki> (Patrick Steinhardt's message of "Tue,
	13 Aug 2024 08:30:59 +0200")
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im>
	<324140e4fdee54fbf0054e76abb287b7212fd21e.1723121979.git.ps@pks.im>
	<ZroX+SSgTe7YnWHS@nand.local> <Zrr9oxgg3w8JyUpw@tanuki>
Date: Tue, 13 Aug 2024 09:02:56 -0700
Message-ID: <xmqqh6bo8l73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8258109C-598D-11EF-9B27-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Makes sense, though I wonder if this would be slightly cleaner to write
>> like so (applies on top of this patch):
>
> It is cleaner indeed, thanks for the proposal!

Yup, it is only 3 repetitions but they are repetitions nevertheless.
A small helper function that gets rid of them is worth it.

Thanks.
