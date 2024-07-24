Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD1134DE
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857329; cv=none; b=M7SlpHWB2i+i113EVuCem8VBU7sPuBgftqI+DbzH0YQwRDZYHIgM95ezYHVGUoTuTAMmgyV29G9OffiVQdDQJ+haEY66xQysQp/ErbHKdZeI5Vd0biE77ADkq5Kyc1ZFzXK20ESeOJbCZBnSwfCO8VrKElxAfbKC8q0MZM7Ju78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857329; c=relaxed/simple;
	bh=mE9Qc1gxJXCnuEvV8SikafiQiXDxYUA+DOuDV6xR2dk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FpWIenOX7aS9mYnvhZ2bYIgU40+UZe+v9SMOHwgmCVTLqSg454isM5bbzwYpFdgLSxWQZT2ZMyN6J95A93VGMtE61V9hHbcUCZExe+c4PdR0BDLIMDTSw7l045iiaIjgsBMq2BLjBNay/0ml3/ugS9ijcAMJsj3K1kBeT4xYRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cUyX7u29; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cUyX7u29"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4215A1FC95;
	Wed, 24 Jul 2024 17:42:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mE9Qc1gxJXCnuEvV8SikafiQiXDxYUA+DOuDV6
	xR2dk=; b=cUyX7u29MujtO1sXU8FTa1rDDVa+DEKleKxQzLrlNBQ2eNzDpxrCBU
	2cCNNhZE2Jt+/Y6Pwf4ACu9Fv/B5pvpIO+cc03EPZ8nXl0+X4WnG5ApucDuoJJK4
	TsT15vxthL29fCaAnM4OnBchy0w1arD/2I1vwZanz7LGwpDdzQxRs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BA301FC92;
	Wed, 24 Jul 2024 17:42:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3CFB1FC90;
	Wed, 24 Jul 2024 17:41:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Haritha
 <harithamma.d@ibm.com>
Subject: Re: [PATCH v2] Fix to avoid high memory footprint
In-Reply-To: <pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>
	(Haritha via GitGitGadget's message of "Wed, 24 Jul 2024 11:45:03
	+0000")
References: <pull.1744.git.git.1721117039874.gitgitgadget@gmail.com>
	<pull.1744.v2.git.git.1721821503173.gitgitgadget@gmail.com>
Date: Wed, 24 Jul 2024 14:41:57 -0700
Message-ID: <xmqqmsm6sc0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8DE27746-4A05-11EF-A044-9625FCCAB05B-77302942!pb-smtp21.pobox.com

"Haritha  via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: D Harithamma <harithamma.d@ibm.com>
>
> This fix avoids high memory footprint when adding files that require
> conversion.  Git has a trace_encoding routine that prints trace output
> when GIT_TRACE_WORKING_TREE_ENCODING=1 is set. This environment
> variable is used to debug the encoding contents.  When a 40MB file is
> added, it requests close to 1.8GB of storage from xrealloc which can
> lead to out of memory errors.  However, the check for
> GIT_TRACE_WORKING_TREE_ENCODING is done after the string is allocated.
> This resolves high memory footprints even when
> GIT_TRACE_WORKING_TREE_ENCODING is not active.  This fix adds an early
> exit to avoid the unnecessary memory allocation.

The sentences jump around and the logic flow is hard to follow.  The
first sentence makes a claim of what it does (but the readers have
not bee told where that problem comes from).  The second sentence
makes a statement of a fact, but the readers do not yet know at that
point what relevance the fact has to the issue at hand, etc.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.


    When Git needs to add a file that require encoding conversion,
    but tracing of encoding conversion is *not* requested via
    setting GIT_TRACE_WORKING_TREE_ENCODING environment variable,
    the trace_encoding() function still allocated and prepared
    "human readable" copies of the file contents before and after
    conversion to show in the trace.  This wasted a lot of memory
    footprint and runtime cycles without giving any user-visible
    benefit.

    Exit early from the function when we we are not tracing before
    we spend all the effort, not after.

or something, perhaps?

I am wondering if we should be able to test this, but "git grep
GIT_TRACE_WORKING_TREE_ENCODING t/" is not finding any existing test
in the area.

> Signed-off-by: Harithamma D <harithamma.d@ibm.com>

This does not match the "From: " line above.  Please pick one way to
spell your name and identify yourself to this project, and use it
consistently.

Thanks.

> diff --git a/convert.c b/convert.c
> index d8737fe0f2d..c4ddc4de81b 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -324,6 +324,9 @@ static void trace_encoding(const char *context, const char *path,
>  	struct strbuf trace = STRBUF_INIT;
>  	int i;
>  
> +	if (!trace_want(&coe))
> +		return;
> +

The actual fix is so simple and nice ;-)
