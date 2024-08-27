Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DD1CDFA7
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780971; cv=none; b=Ze3MGuUVNU7qz2692rK/dLIGRBJODYBrBjY9FdvgYmcHWuIhFdTByyvDmxa8y55tX4cyEZfCYT4hIDPOsBgkUpm6E4k4R24NXqB45siRX0Im8SVwafngApzMJ3pf42HPjNExuzbEeOa29Myhwb3tBe41rsJboZg+p9cm2bvHEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780971; c=relaxed/simple;
	bh=QpeVsDT96CsgqlIB+sdYiVfzH6HUF2NYJ5yXN/5p8bM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gS3Y5jgLYAZrN4mdYF0AjvFsEw80hSg7hg4QeQ7ZtZk53k3yIUD1FMJGw55FKlqIwQBL8ffSSvhmm+8PdqbYY7QdiXgfNZ592ivzQoeP/QnvfRH95S1/Pju/nkgHQjCVqRJBxkIIABGNiOACe87pegSRngeiZh9jBGNocVUILkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tD/vMbzx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tD/vMbzx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A67931744;
	Tue, 27 Aug 2024 13:49:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QpeVsDT96CsgqlIB+sdYiVfzH6HUF2NYJ5yXN/
	5p8bM=; b=tD/vMbzxMtQH67vm8OWCRtpr9Axjz3jQiHP6p0zAhF5gMLhuZNk5Qz
	7ebmlvHBJ9nqTyuPdWUYRYSUtitinuEVgF79/b89PvAWvyplstFhlXF6LXGfOTus
	71u2QuqkY9nHfrlnBgRbTfTpiBbM5LGdDColjvF+BUkbWIt5KCBXI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 72DA431743;
	Tue, 27 Aug 2024 13:49:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D8B0431716;
	Tue, 27 Aug 2024 13:49:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/4] ref: initialize "fsck_ref_report" with zero
In-Reply-To: <Zs351iV2HbdhNvEz@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 28 Aug 2024 00:07:50 +0800")
References: <Zs348uXMBdCuwF-2@ArchLinux> <Zs351iV2HbdhNvEz@ArchLinux>
Date: Tue, 27 Aug 2024 10:49:18 -0700
Message-ID: <xmqqbk1dc0v5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AFCF2B7C-649C-11EF-82B0-BF444491E1BC-77302942!pb-smtp20.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> The original code explicitly specifies the ".path" field to initialize
> the "fsck_ref_report" structure. However, it introduces confusion how we
> initialize the other fields.

The above description is a bit too strong than what this patch is
actually fixing.  If you explicitly initialize any member of an
aggregate type, other members not mentioned will be implicitly
0-initialized, so the original does not give any confusion to
readers who know what they are reading.

What the patch improves is that the common idiom used in this
code base (and possibly elsewhere) is to use "{ 0 }", instead
of explicitly saying "this particular member is 0-initialized".

    The original code explicitly initializes the "path" member in
    the "struct fsck_ref_report" to NULL (which implicitly
    0-initializes other members in the struct).  It is more
    customary to use "{ 0 }" to express that we are 0-initializing
    everything.

The patch is correct, but spelling it like "{ 0 }" with a space on both
sides is more common [*], and because this patch is all about making it
more idiomatic, let's write it that way.

Thanks.

[Footnote]

 * "git grep -e '{0};' -e '{ 0 };' '*.[ch]'" tells us so.


> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/files-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8d6ec9458d..d6fc3bd67c 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3446,7 +3446,7 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
>  		goto cleanup;
>  
>  	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
> -		struct fsck_ref_report report = { .path = NULL };
> +		struct fsck_ref_report report = {0};
>  
>  		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
>  		report.path = sb.buf;
