Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5656440
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691704; cv=none; b=pZCC22wih9kmyIk7nnqN8Sxma2PMtCt0ueUlc3WPfRV1A3uL3DTkx18TndR2Jxa8Jhj3xPp5ac1b1q7tUbY2tMEXDlyNIxdIxpNVrSstNP3SpmQNxcql8w1OJAtVDNn5vUcvVX6WPvzaozfb4atMXLbB+if+F7U/sexLDDADMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691704; c=relaxed/simple;
	bh=7nh55eE9zyjO14jgFPvAkAyCqDs7rYmgMoJJnp3vBoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WdSVjckL48HydPW/S4dmMpfr5eCU0DjVmqt+OZ62Zj1bhWm2/SQ2HXhCpDVaPdb61TH+MiFzALXjrrdtL72f00mAt09SbCxFdAlDH9RXpMc8FyOIOCQdv6xgFXhU3i9YfVTJAwSLD46ABFYTeFlVjHZF4wteSi5xfTFnGXtD6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xg9vQYmo; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xg9vQYmo"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C94A232488;
	Fri, 19 Jan 2024 14:15:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7nh55eE9zyjO14jgFPvAkAyCqDs7rYmgMoJJnp
	3vBoM=; b=Xg9vQYmojx8N9Lv/DbR3JtmVGGxsqxkSKLILEkW236zuDvqQB1YPjW
	FvqbY2wB0UpgD2NvooVDvNqh45DCRVaWg8GA5CSRyXoeDXbto2iiLIhIUOQ+rKCw
	awu4QT8ozvDTUf3WHsVjLsbnwwyPKYfrnH6fE5atZP7kPsdfCBEEM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C101A32487;
	Fri, 19 Jan 2024 14:15:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 567CA32480;
	Fri, 19 Jan 2024 14:14:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] sequencer: clean up pseudo refs with REF_NO_DEREF
In-Reply-To: <48b95fe954c1dbdd080ce7a0cc871f4850bddeae.1705659748.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 19 Jan 2024 11:39:59 +0100")
References: <cover.1705659748.git.ps@pks.im>
	<48b95fe954c1dbdd080ce7a0cc871f4850bddeae.1705659748.git.ps@pks.im>
Date: Fri, 19 Jan 2024 11:14:57 -0800
Message-ID: <xmqqttn9jfta.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 09E03DAA-B6FF-11EE-B403-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When cleaning up the state-tracking pseudorefs CHERRY_PICK_HEAD or
> REVERT_HEAD we do not set REF_NO_DEREF. In the unlikely case where those
> refs are a symref we would thus end up deleting the symref targets, and
> not the symrefs themselves.
>
> Harden the code to use REF_NO_DEREF to fix this.

This level of attention to detail is very much appreciated.  I
suspect that this was inspired by the other topic we discussed the
other day to tighten accesses to {MERGE,CHERRY_PICK,REVERT}_HEAD
that is done via repo_get_oid() to the one based on read_ref_full()?
