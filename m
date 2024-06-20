Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C701AF6A9
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904290; cv=none; b=BUgmEmiE5AWkx7HbpVCF83dXcihTFJWRjBdIG2ZO6OmW2sC++MqPBW1uUSBA7tkj3Gjjz9hGAurz7uFINBjSeCg0zuzpBbnHxqA6SDz4INSxC72mYUaxMRAdGgrDu11b+vMKCm63kp5BXoaZ4UR+Hj0QO4PSVOeS1CvQhNB3gNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904290; c=relaxed/simple;
	bh=z38SzbwRrxnAZ44VjNqUrn1+zBmAnst6Z+qLcOKJJDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCJnDktdaBPHi5zmN0xXNnUAQy8I6SCbPp++VxOmIC0kG9xARS8qupIsAVuLRMFmLNvD/xXzq+SPtjze3ocIivQIPbtIs8eB4fV8chhVg4VLNellIaEDbzWX92ZS/8tW+jVrdk5HyrVJVbBjAVCS03fP2VjarMb9BNS5N5+M+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FN+PN1mr; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FN+PN1mr"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 316D52E90C;
	Thu, 20 Jun 2024 13:24:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z38SzbwRrxnAZ44VjNqUrn1+zBmAnst6Z+qLcO
	KJJDc=; b=FN+PN1mrO+XaHU9DRrvino/kQCDEj7mEg7wUiwdKHRyslQeQXXIOT6
	+elQ7ngup+1eCN4OHNkh6qoE+EjTIXq8aCOkj5mLHVf2rPE7baLAa/CFSXnX/GmH
	5Fnop7DI6foOub6EnzgOTaQaeCL/teyksV4TQAPQpuhTuyB4jIIm8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 299A12E90B;
	Thu, 20 Jun 2024 13:24:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF65C2E90A;
	Thu, 20 Jun 2024 13:24:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v4 1/7] fsck: add refs check interfaces to
 interact with fsck error levels
In-Reply-To: <ZnKLja6bSNLukkTR@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 19 Jun 2024 15:41:01 +0800")
References: <ZnKKy52QFO2UhqM6@ArchLinux> <ZnKLja6bSNLukkTR@ArchLinux>
Date: Thu, 20 Jun 2024 10:24:37 -0700
Message-ID: <xmqqmsnfwmqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F8E9BD84-2F29-11EF-989A-C38742FD603B-77302942!pb-smtp20.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> The git-fsck(1) focuses on object database consistency check. It relies
> on the "fsck_options" to interact with fsck error levels. However,
> "fsck_options" aims at checking the object database which contains a lot
> of fields only related to object database.
>
> In order to add ref operations, create a new struct named
> "fsck_refs_options" and a new struct named "fsck_objs_options". Remove
> object-related fields from "fsck_options" to "fsck_objs_options". Change
> the "fsck_options" with three parts of members:
>
> 1. The "fsck_refs_options".
> 2. The "fsck_objs_options".
> 3. The common settings both for refs and objects. Because we leave
>    common settings in "fsck_options". The setup process could be fully
>    reused without any code changing.
>
> Also add related macros to align with the current code. Because we
> remove some fields from "fsck_options" to "fsck_objs_options". Change
> the influenced code to use the "fsck_options.objs_options" instead of
> using "fsck_options" itself.
>
> The static function "report" provided by "fsck.c" aims at reporting the
> problems related to object database which cannot be reused for refs.
> Provide "fsck_refs_report" function to integrate the fsck error levels
> into reference consistency check.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---

This seems to be doing too many things at once, making the result a
lot harder to review than necessary.  At this point, nobody checks
refs and reports problems with refs, so fsck_refs_report() has no
callers and it is impossible to tell if the function signature of
it, iow, the set of parameters it receives, is sufficient, for
example.

Stepping back a bit, it is true that (1) all existing checks are
about "objects", and (2) all checks we want to implement around
"objects" and "refs" can be split cleanly into these two categories?

I am wondering if there are checks and reports that would benefit
from having access to both objects and refs (e.g. when checking a
ref, you may want to see both what the name of the ref is and what
object the ref points at), in which case, being forced to implement
such a check-and-report as "object" or "ref" that has access to only
different subset of information may turn out to be too limiting.

Yes, I am OK with having substructure in fsck_options, but I am
doubting if it is a good idea to have a separate fsck_refs_report()
that can only take "name" that is different from fsck.c::report().

For example, how would we ensure that refs/heads/foo is allowed to
point at a commit object and nothing else, and how would we report a
violation when we find that ref/heads/foo is pointing at a tag,
i.e., "refs/heads/foo points at
f665776185ad074b236c00751d666da7d1977dbe which is a tag".  The
fsck_refs_report() function is not equipped to do that; neither is
.refs_options.error_func() that only takes "name".

> +int fsck_refs_report(struct fsck_options *o,
> +		     const char *name,
> +		     enum fsck_msg_id msg_id,
> +		     const char *fmt, ...)
> ...
> +	va_start(ap, fmt);
> +	strbuf_vaddf(&sb, fmt, ap);
> +	ret = o->refs_options.error_func(o, name, msg_type, msg_id, sb.buf);
> +	strbuf_release(&sb);
> +	va_end(ap);

Perhaps the code and data structure of the entire series may be
capable of supporting such a check-and-report, but the primary point
I am making is that among what [1/7] adds, we cannot sanely judge if
these "refs" related additions are sensible by looking at [1/7].

Thanks.
