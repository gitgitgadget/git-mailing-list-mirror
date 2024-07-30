Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727791917E5
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377202; cv=none; b=K5BWH0w92APOhnkLDdN4bRlhrSudMbx0qoozwtRf1eUBOn2BQ8BEcCiulhik2J9jJgORKugaQT9AydHVisoBpYsX/be0zO0rp0ZoN3gLcwNyOn/t6S9QgfeYnvuxiNQY6UlfFCpDM1UMfGeWNOdDOUMWVYO7xSvIhwJ5u/lEPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377202; c=relaxed/simple;
	bh=+hSFuVd/nhsRZlOGAQq0kUqZcd170gmV+2irPi1aNcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QSUQJJLsr1k2XBh+Bwtz8FtOellqvAn7ZFDbiOaW3y063tQXnLWxPjvWL/SmMakN9UMkaOKPDSqnfRfM2pQLIFHQNbpOoYGMVsuTJytaexSAMkg5F5fQ1Xg2jI5JpPamkNb1W6xlqPqDb53wPATDjVhXcUGedvdxYy+geykyC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TGei85Oo; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TGei85Oo"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C82E31A0B;
	Tue, 30 Jul 2024 18:06:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+hSFuVd/nhsRZlOGAQq0kUqZcd170gmV+2irPi
	1aNcE=; b=TGei85OokN0ineS4GF7DV9dZLhIhsfaRV5FPPUQuz+J/K8VVrEz0Ks
	Hma2ADtI9jvE4JXaNVRsHjSVxb6Q2qKkEwekdoOaox6412GxmKn3+z6FTGuLF5B6
	NRWl/wQWZupaUJ4Hc5U2IT3uI6+VHiNtKEF6p7WPGT517CS7rAB+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 22B8231A0A;
	Tue, 30 Jul 2024 18:06:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87DA131A09;
	Tue, 30 Jul 2024 18:06:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 10/10] fsck: add ref content check for files
 backend
In-Reply-To: <ZqeY3Dhj-Fo-bZ2k@ArchLinux> (shejialuo@gmail.com's message of
	"Mon, 29 Jul 2024 21:27:56 +0800")
References: <ZqeXrPROpEg_pRS2@ArchLinux> <ZqeY3Dhj-Fo-bZ2k@ArchLinux>
Date: Tue, 30 Jul 2024 15:06:37 -0700
Message-ID: <xmqqh6c6a61e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE681A20-4EBF-11EF-A680-BAC1940A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> +static int files_fsck_refs_content(struct fsck_options *o,
> +				   const char *gitdir,
> +				   const char *refs_check_dir,
> +				   struct dir_iterator *iter)
> +{
> + ...
> +	if (parse_loose_ref_contents(ref_content.buf, &oid,
> +				     &referent, &type,
> +				     &failure_errno, &trailing)) {

The function parse_loose_ref_contents() needs to know what the hash
algorithm is, and it used to implicitly assume that the_repository's
hash algorithm was an OK thing to use.  Patrick's recent clean-up
series instead passes "struct ref_store *refs" throughout the call
chain so that "ref->repo->hash_algo"  can be used.  This needs some
matching change, which means ...

>  	files_fsck_refs_fn fsck_refs_fns[]= {
>  		files_fsck_refs_name,
> +		files_fsck_refs_content,
>  		NULL
>  	};

... the function signature for files_fsck_refs_fn must change to
have something that lets you access repo->hash_algo.


By the way, unless the most common use of an array is to pass it
around as a collection of items and operate on the collection, it is
a better practice to name an array with a singular noun.  Name the
array as fsck_refs_fn[] not _fns[].  This is so that you can refer
to a single element in a more grammatical way.  E.g. with

  struct dog dog[] = { { .breed="shiba" }, { .breed="beagle" } };

you can say "dog[0] has brown fur" instead of "dogs[0] has ...".

In this case, you do not treat the collection of functions as a one
thing and do something to the collection.  Instead you'd repeat over
the functions in a loop and individually call them, perhaps like so:

	for (i = 0; fsck_fn[i] != NULL; i++)
		fsck_fn[i](...);

so it is very much more appropriate to name the array itself as
singular to allow you to say "first fsck_fn", "next fsck_fn", etc.


