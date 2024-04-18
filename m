Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EA15E215
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473286; cv=none; b=rxc+ZI6pJ0NcBIr3DchVF7Dwb2JxpXt121x5JJa/V5E/bVVWt71/n+3Fosya7ZjiTPbMtQ4e9Ijbqu98G0U05cdk9hmJUH0RgRpesHCxOVCo1hh6Lu2a8v4SypToqPhvYlUA51/u4xEgZ5u3/nSfednTDnDi9djsxvjhSfe1an8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473286; c=relaxed/simple;
	bh=fVaOJ/ZmK7ZTq++y+CsTzAmzW3sGsJzq+DdB7JMfypo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eTvF8XOHp6zhSOao5aXqfHh72B8/Kk3ykujK/yBWH5jBim+am9NNCN2IOgwXsdVOlVliztzd3nisECYGtV3XsKL8Pgyat6nQ3C+5wS1mQXMWQL7Uh1JkTqAm5ByrX97l9oQ0KERBN/wY1fvssIEUCRI861qEUrC9ESba6YhRp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bD2e26nU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bD2e26nU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E53821E75E3;
	Thu, 18 Apr 2024 16:48:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fVaOJ/ZmK7ZTq++y+CsTzAmzW3sGsJzq+DdB7J
	Mfypo=; b=bD2e26nU5wnvm34OUVnRPB5OfTl47ZY3C2wg/MCi/GtAjI/MhOcqOr
	22kp/iF8OhrscU0DNvNVVudYviZwxJm4KUry009SbAYUcI2jkjnN49Qr5HMXdtZY
	/5tDyep2jfOvAWUSYtRi1r2kIn67xD0ul0Wl1b0D4n5+fpkfLk0Dw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C42D51E75E2;
	Thu, 18 Apr 2024 16:48:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05B9E1E75E1;
	Thu, 18 Apr 2024 16:48:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  David Bimmler <david.bimmler@isovalent.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] sequencer: move current fixups to private context
In-Reply-To: <2e4a2168733cb226a6fd660cb0d0bd700a1e7d86.1713445918.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 18 Apr 2024 14:14:07 +0100")
References: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
	<2e4a2168733cb226a6fd660cb0d0bd700a1e7d86.1713445918.git.phillip.wood@dunelm.org.uk>
Date: Thu, 18 Apr 2024 13:48:01 -0700
Message-ID: <xmqq34ris8hq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F32EBFA2-FDC4-11EE-AF15-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The list of current fixups is an implementation detail of the sequencer
> and so it should not be stored in the public options struct.

It feels curious how 2/5 and 3/5 treat "fixups" and "reflog"
differently.

I would have expected them to be either in a single patch, or if we
really wanted to split them for readability, do a preliminary change
in 2/5 that argues that "fixups" does not really belong to _opts but
is a private state just like "reflog" and moves it from "/* Used by
fixup/squash */" section to the "/* Private use */" section at the
end, and then introduce the _ctx in 3/5 to move these three
together.

The end result would be the same, but I would have found the flow of
thought more straight-forward if presented that way.
