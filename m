Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA147F56
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W/B5S3jh"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7035E3E483;
	Wed, 10 Jan 2024 11:38:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=r0ZBgW5297yVHVDTLaX1Uw1vi1aKNCKINdx6ZF
	dpRaE=; b=W/B5S3jhMMYXXLLTCi0fnPoQdQWiLD7avqER487t7F7XeR9T6Xc5gR
	Ksw7FlH34Z/2X2ZAXkVLc0KIul4Ea3djyt7WkrU20AM/lwVq+518uPkNJGASqcAQ
	+uI5dog7Drq79Zlw4FkQD95ywhnkC+MA6iM1WBf7oJt2lCL/U8NZ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A2BC3E482;
	Wed, 10 Jan 2024 11:38:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 98A463E481;
	Wed, 10 Jan 2024 11:38:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Scott Leggett
 <scott@sl.id.au>
Subject: Re: [PATCH] commit-graph: retain commit slab when closing NULL
 commit_graph
In-Reply-To: <20240110113914.GE16674@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 10 Jan 2024 06:39:14 -0500")
References: <20240105054142.GA2035092@coredump.intra.peff.net>
	<ZZg3YIEDCjbbGyVX@nand.local>
	<20240110113914.GE16674@coredump.intra.peff.net>
Date: Wed, 10 Jan 2024 08:38:18 -0800
Message-ID: <xmqq34v5dtz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AA14677C-AFD6-11EE-A314-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> I think a simpler solution would be that upon clearing the slab, we
> either "finish" each commit (filling in the maybe_tree field) or
> "unparse" it (unsetting the parsed flag, and then doing a regular and/or
> graph lookup if it is accessed again later).

Wow, that's clever.

> It should be easy-ish to iterate through the slab and look at the
> commits that are mentioned in it. Though maybe not? Each commit knows
> its slab-id, but I'm not sure if we have a master list of commits to go
> the other way.

We have table of all in-core objects, don't we?

> +	 * This will throw away the parents list, which is potentially sketchy.
> +	 * A better version of this would just unset commit->object.parsed
> +	 * and then do a minimal version of parse_commit() that _just_ loads
> +	 * the tree data (and/or graph position if available).

Yeah, it is a concern that we may be working with an in-core commit
object whose parent list has already been rewritten during revision
traversal.  Well thought out.

> +	 *
> +	 * Naturally we'd need to drop the "const" from our commit above, too.
> +	 */
> +	unparse_commit(r, &commit->object.oid);
> +	repo_parse_commit(r, commit);
> +
>  	return NULL;
>  }
>  
> I dunno. I do feel like this is a lurking maintenance headache, and
> might even be a triggerable bug. But without knowing of a way that it
> happens in the current code base, it feels like it would be easy to make
> things worse rather than better.

Unfortunately I share the feeling X-<.

Thanks.
