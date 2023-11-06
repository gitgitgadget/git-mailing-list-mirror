Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74632EB1F
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V2fmZoNg"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E09270C
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 15:19:08 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 867B53B9C8;
	Mon,  6 Nov 2023 18:19:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Z/WDGtIqe+TF+Fmkhf3wKRzO6Ra7mPI7mOGfX2
	k5Y8A=; b=V2fmZoNgCZ0EuG+LTvwWqThgeZSgVgHXsN2/BltV8em4QFSgIqAMC+
	5/eCp7QdmXaERRk8fGWNkUUlki4oaG95Q0WM0d92n143To8BV4Qzw1omXe6VxNEE
	T6omiTCdTFO4+i5YIC1aCB/VxRpVG6jpIBqVl45LwteJytwLxr0pg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DF053B9C7;
	Mon,  6 Nov 2023 18:19:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 173103B9C6;
	Mon,  6 Nov 2023 18:19:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  "Eric W. Biederman" <ebiederm@gmail.com>,  Jeff King
 <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/5] merge-ort: implement support for packing objects
 together
In-Reply-To: <0ac32374-7d52-8f0c-8583-110de678291e@gmx.de> (Johannes
	Schindelin's message of "Mon, 6 Nov 2023 16:46:32 +0100 (CET)")
References: <cover.1697736516.git.me@ttaylorr.com>
	<cover.1698101088.git.me@ttaylorr.com> <xmqqo7go7w63.fsf@gitster.g>
	<0ac32374-7d52-8f0c-8583-110de678291e@gmx.de>
Date: Tue, 07 Nov 2023 08:19:02 +0900
Message-ID: <xmqqr0l2cvx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E041865E-7CFA-11EE-A9E1-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> What I have in mind is more along Elijah's suggestion at the Contributor
> Summit to use the `tmp_objdir*()` machinery. But instead of discarding the
> temporary object database, the contained objects would be repacked and the
> `.pack`, (maybe `.rev`) and the `.idx` file would then be moved (in that
> order) before discarding the temporary object database.

That may be more involved but does indeed sound like an approach
more generally applicable.  Back when the bulk-checkin machinery was
invented, I envisioned that we would be adding annotations to
various codepaths so that object creation machinery can say "now we
are plugged, in anticipation for creating many objects at once" and
"now the flood of new object creation is done, time to wrap up" for
that kind of optimization.  

The callsites to {begin,end}_odb_transaction() functions haven't
grown beyond the original "add" and "update-index" (because the user
can add the entire working tree worth of files to the object
database), "unpack-objects" (because a fetch can bring in many
objects), and "cache-tree" (because a tree creation can cascade up
to create many objects), but I agree "merge" and "replay" are prime
candidates to benefit from the optimization of the same kind (so is
"fast-import").  They are about creating many objects at once, and
give us an opportunity for such an optimization.
