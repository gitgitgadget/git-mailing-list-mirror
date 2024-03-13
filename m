Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424E45BEC
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343348; cv=none; b=AQet/t/ekAR8l5RNSSZ7ili0LsZxBB5F1UszKNgwciFy3/bGSxSTpGkDltV+qWus9eSHRMh4UZtAlz9aetm+GV6sL/KzDlLHJn27frUs/NgVZh0jvgQrD97gIoc7NzTPjmFa5TyFsXjpkZ/h4cKt+JjSkr0gygSOV8cTw0ptvkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343348; c=relaxed/simple;
	bh=neNnKDP5TkPmbY/uRPK/1a4x+NYWX77F8kP/SeA4s24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nm1gOYxZQ37pOy9UNM5W/WQLRz8m08vRP3OY5Jle49+MfCD9bH5+iSdcwrlf5AuDOwwXbHYSgOEMwetKMMc+lhr1+bLgfhXqKk2jZWP6nDjWJekgxLvCRvHXTRFw399xkFnHGATUiboxkZ8ZXQzXM9yTDxfkm8cV3NGVarRPp+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gDzWEDPZ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gDzWEDPZ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6446618B41;
	Wed, 13 Mar 2024 11:22:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=neNnKDP5TkPmbY/uRPK/1a4x+NYWX77F8kP/Se
	A4s24=; b=gDzWEDPZVjn9zOo53BY6T1eP2/HaVAg3x17FxpIe287c3oE2nvGsoB
	gc5C/qEECejqmqMaAvMqa7ZuJZpco3/KpQkOPc0fY5n17gN8g/1ZNDDMlSvcDs42
	dDajynMLS/9TPzkahRTrJf0f1KqSYSKq/lZuYlYXHrNfhP/SClLiU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C4C718B40;
	Wed, 13 Mar 2024 11:22:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0AA3B18B3F;
	Wed, 13 Mar 2024 11:22:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] cat-file: avoid verifying submodules' OIDs
In-Reply-To: <20240312221758.GA109417@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 12 Mar 2024 18:17:58 -0400")
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
	<951f73397c15f76da75bbd74a02f36da0116623f.1710183362.git.gitgitgadget@gmail.com>
	<xmqqh6hbl2mz.fsf@gitster.g>
	<20240312221758.GA109417@coredump.intra.peff.net>
Date: Wed, 13 Mar 2024 08:22:16 -0700
Message-ID: <xmqqmsr2f97b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7A988480-E14D-11EE-A43F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> I think you could make an argument that the problem is
> shoe-horning new, slightly-mismatched functionality into
> cat-file. But there are lots of practical reasons to want to do
> so, as we discussed elsewhere.  Since gitlinks are the only place
> where we'd expect an object to be missing, "simulating" them here
> isn't too bad.

100% agreed.  This is something we should be asking about "HEAD:"
tree object, not about "HEAD:sha1collisiondetection" object, if we
are to ask cat-file.  After all "cat-file p HEAD:" tells us that the
thing is a submodule already.  But unfortunately the "--batch" thing
is limited to "give me an object and what you want to know about the
object, and I'll tell you what I know about it" exchange, so it is a
very bad match when you cannot really give it an object (which you
do not have, like the target of the gitlink).  So...

> But I suspect there's a more
> general solution where cat-file learns to print dummy values for any
> missing object, letting the caller see what we _could_ find out. And
> then the submodule case just falls out naturally. I doubt we could make
> it the default for historical compatibility; we'd need a new option.

... "--batch" obviously needs to be extended, and %(objectmode) may
be one direction to do so, but it would also work to allow us to ask
about "HEAD:" and what it has at paths, which match a pathspec
"sha1collisiondetection", an equivalent to give "cat-file --batch" a
command to drive "ls-tree".

> This is all speculative on my part, of course. Probably Dscho or
> Victoria can explain their use case better. :)

Likewise.
