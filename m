Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134FF7F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CqNRNqFN"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E8101
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 21:37:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A73471C4365;
	Wed,  1 Nov 2023 00:37:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SvXiGYdQ0S69othu1NpC4rSpKMbdP2KIcqMI6x
	wzdqM=; b=CqNRNqFNCeMOsBUyk4eUyOXtrNPyWxnOfdeqK+s0YhWUmepQs674fp
	XQFcOxHP6LP+Ain6gMKWY/QXZ4TnPYybBSezVfZhUyjqoYeNwnoRJKQ1NBvBoU+e
	5W6pliSC4fcgA52s4uabZRl79+MNGv+GRLalDHsUNtH5f/g1jYbQ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F8941C4363;
	Wed,  1 Nov 2023 00:37:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EDCB1C4361;
	Wed,  1 Nov 2023 00:37:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  Dragan Simic <dsimic@manjaro.org>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/4] strbuf: move env-using functions to environment.c
In-Reply-To: <4097385820973b30a78f2e45741444a3f6eee98d.1698791220.git.jonathantanmy@google.com>
	(Jonathan Tan's message of "Tue, 31 Oct 2023 15:28:33 -0700")
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com>
	<cover.1698791220.git.jonathantanmy@google.com>
	<4097385820973b30a78f2e45741444a3f6eee98d.1698791220.git.jonathantanmy@google.com>
Date: Wed, 01 Nov 2023 13:37:16 +0900
Message-ID: <xmqqy1fit7gj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 56AB848C-7870-11EE-A259-25B3960A682E-77302942!pb-smtp2.pobox.com

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/environment.h b/environment.h
> index e5351c9dd9..f801dbe36e 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -229,4 +229,18 @@ extern const char *excludes_file;
>   */
>  int print_sha1_ellipsis(void);
>  
> +/**
> + * Add a formatted string prepended by a comment character and a
> + * blank to the buffer.
> + */
> +__attribute__((format (printf, 2, 3)))
> +void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
> +
> +/**
> + * Add a NUL-terminated string to the buffer. Each line will be prepended
> + * by a comment character and a blank.
> + */
> +void strbuf_add_commented_lines(struct strbuf *out,
> +				const char *buf, size_t size);
> +

What's your plans for globals kept in ident.c for example?

The reason why I ask is because I do not quite see how making the
use of the global comment-line-char variable hidden like this patch
does would help your libification effort.  There are many settings
that are reasonably expected to be used by many places, and if you
want to avoid them, it appears to me that your only way forward
after applying this patch would be to recreate the implementation
the public git has in environment.[ch] in your version of Git.
You'd have to do something similar for what is in ident.c for the
same reason.

The relative size of the logic necessary to split the original
into lines and prefix the comment prefix character (which is much
larger) and the idea that there is a system wide setting of what the
comment prefix character should be (which is miniscule) makes me
wonder if this is going in the right direction.

Thanks.

