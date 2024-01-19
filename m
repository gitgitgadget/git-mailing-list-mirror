Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB641C98
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705694972; cv=none; b=CaSQn9W6zYErTIAgLvbED9Sw7oUr3RhPX4sLuOWzdzzSpljfN3A5YLku7ZTu3MT1q3iukGmyBLuiqspy2u/hYCRrt3r2xKgsVyLnzZezI3zl1qALrZ3SiK1qv9Wvn8uLFgGhBPDuxUh65pwx1ek6ySPSGrTcRiTbXSd4qXuS6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705694972; c=relaxed/simple;
	bh=OAfA6/7ATyMiSwamHLtK1AQxMQpX0xGJQ7iETf8Sr/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RVyJwSyH5kAWVIf3VaOvVjlLEs65+p5Nn6sBppWPwXen0Du6kcw91EgHNryTf4hf1DwKEB5Zkv+CLUuV8YhwjN+Vty+IWickVvrQDEDk9jrqkqlZEdGfTF4/IqIT1I4369hyKl53ZMvHSwvItI0FFkDKscN1Prjms58Xw8/PhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ji+JPDYX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ji+JPDYX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B830A329C9;
	Fri, 19 Jan 2024 15:09:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OAfA6/7ATyMiSwamHLtK1AQxMQpX0xGJQ7iETf
	8Sr/w=; b=ji+JPDYXbdB/HC5U2fpH/nFxKteWkC7x6qxD/J9VJUlHG4K3/DZt4n
	lE1cIl/hWaY6HFKMPxPIdiFs7pY6gYowc0IdGofKblwR0EJmhjmKgXG0MqAklLoH
	i9wMlEhwI1cWofkIx4uO74O6vd2aMImh5pBJ6bxsyTwVsSPyT9Gng=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B0033329C8;
	Fri, 19 Jan 2024 15:09:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4BB913298B;
	Fri, 19 Jan 2024 15:09:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] sequencer: introduce functions to handle
 autostashes via refs
In-Reply-To: <abcf1f5cf428072d19639dc4209e0c1554f3eb53.1705659748.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 19 Jan 2024 11:40:15 +0100")
References: <cover.1705659748.git.ps@pks.im>
	<abcf1f5cf428072d19639dc4209e0c1554f3eb53.1705659748.git.ps@pks.im>
Date: Fri, 19 Jan 2024 12:09:25 -0800
Message-ID: <xmqqbk9hjdai.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A5BB3CDC-B706-11EE-A54E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We're about to convert the MERGE_AUTOSTASH ref to become non-special,
> using the refs API instead of direct filesystem access to both read and
> write the ref. The current interfaces to write autostashes is entirely
> path-based though, so we need to extend them to also support writes via
> the refs API instead.
>
> Ideally, we would be able to fully replace the old set of path-based
> interfaces. But the sequencer will continue to write state into
> "rebase-merge/autostash". This path is not considered to be a ref at all
> and will thus stay is-is for now, which requires us to keep both path-

"is-is"???

> and refs-based interfaces to handle autostashes.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  sequencer.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++----
>  sequencer.h |  3 +++
>  2 files changed, 64 insertions(+), 5 deletions(-)

The conversion (rather, the introduction to allow refs API to be
used to access them) look correct, but offhand I do not know what
the implication of leaving the file based interface would be.

Thanks.
