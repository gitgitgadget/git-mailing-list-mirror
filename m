Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1B154449
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796885; cv=none; b=PeEQBo2eYYyKf/cBhgWauRLXC/7siiuRZ6aiymoBDPljOEDiXzq+91D3nXPUNuZpTngES/PW67sDze9D08gf7+Y/i3lda0f2DDcytsUc8kqTJtzuOZO0NH6rsxdK4wn7sDiQ2/YRNo3ruv/nUAYToGFeqiUswYSj9VqE085fvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796885; c=relaxed/simple;
	bh=0Pb7IPNvyM2j8T27mgxG2UcCkVPevOnGhWnAwjxSUuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LofTmBvkEh+lZymuXFJXtMDxd9NYA6seG57YZ+rJsTmUvU65oqhmxLjzWKazSL75gWKonj89pZHYyXSr1H3l0XU/bExdlkVgGV4x5f2c4QN+2TPR0kaXGQS9H9nTKwjuQqzuCcNNG7/alWLqHnjPPHMGz22o2mxNu3216Ld9SAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=auvy+XmZ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="auvy+XmZ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CE63018F06;
	Fri,  7 Jun 2024 17:48:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0Pb7IPNvyM2j8T27mgxG2UcCkVPevOnGhWnAwj
	xSUuo=; b=auvy+XmZzevAddzMPiDOQ4HCtPCiDWHJoYvEc/1b8gcnTjBXMhZmlh
	xn6kxEB8gXiNIGShurcCihT301QnB2ztC7sdui13M++OkgFFtaYWVvxEWcNFTEzg
	QgGmcJybWN/FSwr4NBEu55tLb+LQH6AmRj2Vg9+cqsqL1uZA9pIr0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C71BA18F05;
	Fri,  7 Jun 2024 17:48:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D93E318F01;
	Fri,  7 Jun 2024 17:47:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 1/2] commit-graph.c: remove temporary graph layers on exit
In-Reply-To: <ZmN+crXyZOze122U@nand.local> (Taylor Blau's message of "Fri, 7
	Jun 2024 17:41:06 -0400")
References: <cover.1717712358.git.me@ttaylorr.com>
	<25324fea5b7c7f748d7f4e1e40299c0af04006e8.1717712358.git.me@ttaylorr.com>
	<xmqqa5jwg1aj.fsf@gitster.g> <ZmN+crXyZOze122U@nand.local>
Date: Fri, 07 Jun 2024 14:47:58 -0700
Message-ID: <xmqqo78ce86p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9BBC38EC-2517-11EF-9D6C-8F8B087618E4-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>> > -		result = rename(ctx->graph_name, final_graph_name);
>> > +		result = rename_tempfile(&graph_layer, final_graph_name);
>>
>> Before this rename, after the close(fd) we saw in the previous hunk,
>> there is one early error return when we fail to rename the base
>> graph file.  Do we need to do anything there, or an unfinished
>> tempfile getting removed at the process termination is sufficient
>> for cleaning up the mess?
>
> We could explicitly clean it up, but we'll do so implicitly upon exit,
> so I think it's fine to leave it as-is.

I am not worried about cleaning it up.  Upon exit, the underlying
file descriptor will be closed, but this new code never does
fclose() on the FILE* that has a buffer around the underlying file
descriptor.  How are we guaranteeing that we are not losing anything
buffered but not flushed yet?
