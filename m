Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xR6XuH8O"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07511F
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 10:17:19 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ACE8B1B792;
	Fri,  8 Dec 2023 13:17:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TSgbFzQcUe968DqVSnWJ3XIicxqBUUias5ksxM
	BA2ZM=; b=xR6XuH8OVljWHXYNOkNYq/vuy03B2Xy9T+pTtebz0oS+XzN1AOEVN/
	7lQhQ62zXu+7dEPjVGoLpNZUdnEJJyrgooX0ME/u9u0k7OhPqpvb/3Yevr11F5Z8
	YRh7VdSJ8yULK7VGqeU3qfK9DE/nEuv0+IaofiHFbVa2PZg0ziwOo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 92AF11B791;
	Fri,  8 Dec 2023 13:17:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 374481B78E;
	Fri,  8 Dec 2023 13:17:15 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Adam Majer <adamm@zombino.com>,  git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
In-Reply-To: <20231128190446.GA10477@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 28 Nov 2023 14:04:46 -0500")
References: <20231117203253.21143-1-adamm@zombino.com>
	<20231128142845.11523-1-adamm@zombino.com>
	<20231128190446.GA10477@coredump.intra.peff.net>
Date: Sat, 09 Dec 2023 03:17:13 +0900
Message-ID: <xmqqfs0c36fq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 03BF06BA-95F6-11EE-864D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> So with regards to the loosening in your patch, my questions would be:
>
>   - if we are going to change the rules for repository detection, is
>     this where we want to end up? We haven't changed them (yet) for
>     reftables. If we are going to do so, should we have a scheme that
>     will work for that transition, too? The "refs is an empty file"
>     scheme would fix your use case, too (though see below).
>
>   - is the rest of Git ready to handle a missing "refs/" directory? It
>     looks like making a ref will auto-create it (since we may have to
>     make refs/foo/bar/... anyway).
>
>   - what about other implementations? Your embedded repos will
>     presumably not work with libgit2, jgit, etc, until they also get
>     similar patches.
>
>   - what about empty repositories? In that case there will be no "refs/"
>     file and no "packed-refs" file (such a repository is less likely, of
>     course, but it may contain objects but no refs, or the point may be
>     to have an empty repo as a test vector). Likewise, it is possible
>     for a repository to have an empty "objects" directory (even with a
>     non-empty refs directory, if there are only symrefs), and your patch
>     doesn't address that.

All good points.

> Getting back to your use case, I'd suggest one of:
>
>   - do the usual "touch refs/.gitignore" trick to explicitly track the
>     empty directory. It looks like the ref code will ignore this (we
>     don't allow ref names to start with "." in a path component)
>
>   - whatever is consuming the embedded repos could "mkdir -p refs
>     objects" as needed. This is a minor pain, but I think in the long
>     term we are moving to a world where you have to explicitly do
>     "GIT_DIR=$PWD/embedded.git" to access an embedded bare repo. So
>     they're already special and require some setup; adding an extra step
>     may not be so bad.

Yeah, it truly is caused by the combination of the fact that we do
not "track" empty directories and that skeleton Git repository
structure does rely on possibly empty directories.  The above two
are reasonable workarounds when you are dealing with any medium that
does not allow empty directories, not just working tree managed by
Git.
