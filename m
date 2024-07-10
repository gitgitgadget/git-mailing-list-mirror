Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DA1957EA
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631201; cv=none; b=mVRyles6YL/FJiwehnZCmQJSTL80+gSIP4rAv6UX6kedQigRln8Oma8FDkkaEctafwQK1hi6CeeHdi5ORQU7wf4rB9Wh+ziqGfcDZ1RggESe4xZCtf9d9SQI1Bu0QdwCmGlViFgYBbH9tCvdJq1H0wcO9QIZQ6JWEJKTkq6o7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631201; c=relaxed/simple;
	bh=OLmxEhcU3Ab3tYYabGTQbM9/4QOcvbhi/Czjn8Y2xlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFp0G+Hmuic0oswsEBfl4MMfDnR1QvPKTRuHYtd0d1CDq5S38SZqAPO1aIYqXnKEI16UTuzLNaTc4Tw3vgfgddSU31+n1joay7HgZHlHOlOmEK7qCfzc12BRcoNGLkFpzce7atyPc9Xmyff1NQy6ttnZqCSHvxpYIujURtZJ8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D/Krjbuh; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D/Krjbuh"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C63511BDF6;
	Wed, 10 Jul 2024 13:06:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OLmxEhcU3Ab3tYYabGTQbM9/4QOcvbhi/Czjn8
	Y2xlg=; b=D/KrjbuhTNc9Wi6gNur50YyG4W4PNQ5McdVfc9mM09qFB7zb3CV/M3
	21awdIqibUxnmUsfr7cx7qqQtV84S1kK83t4rCQmIcQS3VCTQrg1YOFXlfo2mLxf
	Ukz6JzGSXFkdKD8reFLN1gTCXtzbJ73xsY+nHq4AiAZLyDR+SBh8U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BEA9C1BDF5;
	Wed, 10 Jul 2024 13:06:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4774A1BDF4;
	Wed, 10 Jul 2024 13:06:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Ilya Tumaykin
 <itumaykin@gmail.com>,  git@vger.kernel.org,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
In-Reply-To: <20240710093610.GA2076910@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 10 Jul 2024 05:36:10 -0400")
References: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
	<ab974e62-098c-4200-bee3-7de8d9115516@gmail.com>
	<xmqq4j937pyf.fsf@gitster.g>
	<20240710093610.GA2076910@coredump.intra.peff.net>
Date: Wed, 10 Jul 2024 10:06:28 -0700
Message-ID: <xmqqed81xjl7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C0621F64-3EDE-11EF-860A-C38742FD603B-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> I'm a little worried that this creates ambiguities, since I don't think
> we are careful about following the hunk header's line counts. Imagine
> you had an input like this:
>
>   @@ -1,2 +1,2 @@
>   -old
>   +new
>    stuff
>
>   some garbage

True.  Especially if you allow editing of hunks, the only thing you
could make available to you are the version you gave the user and
the version you got back from the user, but comparing them would not
help resolve the ambiguity to correct the hunk header all that much.
"diff" edit mode various editors may have _could_ help as they know
each and every keystroke by the user and how the modified patch was
constructed to guess the intention better than a mere comparison of
before- and after- shape of the patch (but the last time I checked,
diff edit mode of GNU Emacs did not adjust the hunk header correctly
in some corner cases).

> I don't think we'd ever generate this ourselves, but could somebody
> manually edit a hunk into this shape? When I tried it in practice, it
> looks like we fail to apply the result even before my patch, though. I'm
> not sure why that is. If I put "some garbage" without the blank line, we
> correctly realize it should be discarded. It's possible I'm just holding
> it wrong.

I've given up on the "hunk edit" doing wrong things to a patch
already.  

The "edit" codepath used to be a lot less careless before Phillip
whipped it into a much better shape with the series that ended at
436d18f2 (Merge branch 'pw/add-p-recount', 2018-03-14), that
introduced recount_edited_hunk() that special cases "+/-/ ".  It
already knows that a completely empty line in a patch is an empty
and unmodified line (which was ported from f4d35a6b (add -p: fix
counting empty context lines in edited patches, 2018-06-11)), so
this patch does not have to do anything new there.

But "recounting" will be fooled by garbage left in the edited
result, so I think we have done all we can do to resolve possible
ambiguities.  The patch under discussion is not adding anything new
and making it any worse, I would say.

> diff --git a/add-patch.c b/add-patch.c
> index 6e176cd21a..7beead1d0a 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -588,7 +588,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  			    (int)(eol - (plain->buf + file_diff->head.start)),
>  			    plain->buf + file_diff->head.start);
>  
> -		if ((marker == '-' || marker == '+') && *p == ' ')
> +		if ((marker == '-' || marker == '+') && (*p == ' ' || *p == '\n'))
>  			hunk->splittable_into++;
>  		if (marker && *p != '\\')
>  			marker = *p;
> @@ -964,7 +964,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
>  		 * Is this the first context line after a chain of +/- lines?
>  		 * Then record the start of the next split hunk.
>  		 */
> -		if ((marker == '-' || marker == '+') && ch == ' ') {
> +		if ((marker == '-' || marker == '+') && (ch == ' ' || ch == '\n')) {
>  			first = 0;
>  			hunk[1].start = current;
>  			if (colored)
> @@ -979,14 +979,14 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
>  		 * Then just increment the appropriate counter and continue
>  		 * with the next line.
>  		 */
> -		if (marker != ' ' || (ch != '-' && ch != '+')) {
> +		if ((marker != ' ' && marker != '\n') || (ch != '-' && ch != '+')) {
>  next_hunk_line:
>  			/* Comment lines are attached to the previous line */
>  			if (ch == '\\')
>  				ch = marker ? marker : ' ';
>  
>  			/* current hunk not done yet */
> -			if (ch == ' ')
> +			if (ch == ' ' || ch == '\n')
>  				context_line_count++;
>  			else if (ch == '-')
>  				header->old_count++;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 5d78868ac1..92c8e6dc8c 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -1164,4 +1164,36 @@ test_expect_success 'reset -p with unmerged files' '
>  	test_must_be_empty staged
>  '
>  
> +test_expect_success 'splitting handles diff.suppressBlankEmpty' '
> +	test_when_finished "git reset --hard" &&
> +	cat >file <<-\EOF &&
> +	1
> +	2
> +
> +	3
> +	4
> +	EOF
> +	git add file &&
> +
> +	cat >file <<-\EOF &&
> +	one
> +	two
> +
> +	three
> +	four
> +	EOF
> +	test_write_lines s n y |
> +	git -c diff.suppressBlankEmpty=true add -p &&
> +
> +	git cat-file blob :file >actual &&
> +	cat >expect <<-\EOF &&
> +	1
> +	2
> +
> +	three
> +	four
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_done
