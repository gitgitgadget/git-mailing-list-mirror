Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3110198A38
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656239; cv=none; b=RjpZ5CwSlt0RbE8REGNjjqdysvqaKgFO/G1Oqr5Vf1XtJQaoy1wBNhwI97211DmO9lJ4ODAy2ujyLXiY0SHWBm7yhka7UBswdFMGxAal25SB3VYMIhDB7Wx874rUsAXkDaFRj0e5Y3jjQdKdgPZagcsNeGdu1gEpQqNxldJx4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656239; c=relaxed/simple;
	bh=nyt1HnClyHDrK9TinvVJJV+XFcUxK4fSWVx/8oGJhUc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BJXXCPC/bKkJN8zwgB7BnQRzJIAneVvA8tyKcXEgQgnFWUOPlXINZW/2xkxPwX8JYa9yHxWpO1fZ2XHIUaLF2Td7yz/fWmPfoeHu5Qrzk9//TlJyH4cgaKFB+Eazlmn9sb805jv9g6i3DGKoxbqT2T955nHbpGiLqCJgAQD1hlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pskt+/Ed; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pskt+/Ed"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98E721F14D;
	Mon, 17 Jun 2024 16:30:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nyt1HnClyHDrK9TinvVJJV+XFcUxK4fSWVx/8o
	GJhUc=; b=pskt+/Ed6tqDX/u1M96/LGl40J0nCzLAt/rRd/qO/jimJB/oEKmFyv
	M/Vzo59SooVopo++vc5MXmzRRU+0/JCml0XqMslh18O5Bx214dTqNA5FboiCvfXT
	h6/+KN9jds6JpTYoHP4FEX5SfUx0GYzvvNUPEm5FxJ5/jlIJJ6lo8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 916F91F14C;
	Mon, 17 Jun 2024 16:30:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07F8B1F14B;
	Mon, 17 Jun 2024 16:30:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] attr: fix msan issue in read_attr_from_index
In-Reply-To: <pull.1747.git.1718654424683.gitgitgadget@gmail.com> (Kyle
	Lippincott via GitGitGadget's message of "Mon, 17 Jun 2024 20:00:24
	+0000")
References: <pull.1747.git.1718654424683.gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 13:30:34 -0700
Message-ID: <xmqqcyof5n2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73E9A3B2-2CE8-11EF-92EE-965B910A682E-77302942!pb-smtp2.pobox.com

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The issue exists because `size` is an output parameter from
> `read_blob_data_from_index`, but it's only modified if
> `read_blob_data_from_index` returns non-NULL.

Correct.

> The read of `size` when
> calling `read_attr_from_buf` unconditionally may read from an
> uninitialized value. `read_attr_from_buf` checks that `buf` is non-NULL
> before reading from `size`, but by then it's already too late: the
> uninitialized read will have happened already.

Yes, but it is dubious that reading an uninitialized value that we
know will not be used is a problem, so I am inclined to say that
MSAN is giving a false positive here.

> Furthermore, there's no
> guarantee that the compiler won't reorder things so that it checks
> `size` before checking `!buf`.

This I do not understand.  Are you talking about buf vs length here
in the callee?

        static struct attr_stack *read_attr_from_buf(char *buf, size_t length,
                                                     const char *path, unsigned flags)
        {
                struct attr_stack *res;
                char *sp;
                int lineno = 0;

                if (!buf)
                        return NULL;
                if (length >= ATTR_MAX_FILE_SIZE) {
                        warning(_("ignoring overly large gitattributes blob '%s'"), path);
                        free(buf);
                        return NULL;
                }

At the machine level, a prefetch may happen from both buf and
length, but the program ought to behave the same way as the code is
executed serially as written.  If the compiler allows the outside
world to observe that resulting code checks length even when buf is
NULL, such a compiler is broken.  So I do not think that is what you
are referring to, but then I do not know what problem you are
describing.

Having said all that ...

> Make the call to `read_attr_from_buf` conditional on `buf` being
> non-NULL, ensuring that `size` is not read if it's never set.

... this makes the logic at the caller crystal clear, so even if
there are suboptimal checker that bothers us with false positives,
the change itself justifies itself, I would say.

>  	} else {
>  		buf = read_blob_data_from_index(istate, path, &size);
> -		stack = read_attr_from_buf(buf, size, path, flags);
> +		if (buf)
> +			stack = read_attr_from_buf(buf, size, path, flags);
>  	}
>  	return stack;

Thanks.
