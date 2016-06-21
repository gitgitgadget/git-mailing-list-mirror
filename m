Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9950F1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 22:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbcFUWWK (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 18:22:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751380AbcFUWWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 18:22:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6254F27D87;
	Tue, 21 Jun 2016 18:22:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=21XBk6j7/LLWqKnsdZ6B+llW8Kc=; b=w1uoaF
	9PNZzasPvrFbej7sD2+pclSytwdQWW8hzXPq17H4u8oNey3VFAwr8RYdDmY398JJ
	K9YkqsQo/t/YYwStCg37WCa/SFyiz3jZJgyXIWIRqD+w17yPLXeV/k+uylZLgOAn
	LFTsaDTRGgNLOdBr34+Orq3rF4PKZIcfZlDGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lscjRX95hBUB9x1+QT+ucTng2qZyakNc
	Jp1/UgOat2DA984eq10i53UelSOW2wNK4zuWFr+MZpQ81FfEYV3jErap3LwLyYSQ
	3BaK3rVRmChydcs5CZN/a2gJLW36mF2e09/f1b6giPH23Zn34+k9sZxvVt/rJvH/
	Qd6m1aOwicg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A5B227D86;
	Tue, 21 Jun 2016 18:22:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D598227D85;
	Tue, 21 Jun 2016 18:22:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
Cc:	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/8] Convert struct diff_filespec to struct object_id
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
	<20160618221407.1046188-4-sandals@crustytoothpaste.net>
Date:	Tue, 21 Jun 2016 15:22:04 -0700
In-Reply-To: <20160618221407.1046188-4-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 18 Jun 2016 22:14:02 +0000")
Message-ID: <xmqqmvmenpwz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96938CD0-37FE-11E6-942A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

I was trying to make sure there is no misconversion, but some lines
that got wrapped were distracting.  For example:

> @@ -2721,7 +2722,8 @@ static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
>  	if (s->dirty_submodule)
>  		dirty = "-dirty";
>  
> -	strbuf_addf(&buf, "Subproject commit %s%s\n", sha1_to_hex(s->sha1), dirty);
> +	strbuf_addf(&buf, "Subproject commit %s%s\n",
> +		    oid_to_hex(&s->oid), dirty);

This would have been

> -	strbuf_addf(&buf, "Subproject commit %s%s\n", sha1_to_hex(s->sha1), dirty);
> +	strbuf_addf(&buf, "Subproject commit %s%s\n", oid_to_hex(&s->oid), dirty);

which the conversion made the line _shorter_.  If the original's
line length was acceptable, there is no reason to wrap the result.

> -				die("unable to read %s", sha1_to_hex(s->sha1));
> +				die("unable to read %s",
> +				    oid_to_hex(&s->oid));

Likewise.

> @@ -2937,7 +2940,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
>  			if (!one->sha1_valid)
>  				sha1_to_hex_r(temp->hex, null_sha1);
>  			else
> -				sha1_to_hex_r(temp->hex, one->sha1);
> +				sha1_to_hex_r(temp->hex, one->oid.hash);

This suggests that oid_to_hex_r() is needed, perhaps?

> @@ -2952,7 +2955,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
>  		if (diff_populate_filespec(one, 0))
>  			die("cannot read data blob for %s", one->path);
>  		prep_temp_blob(name, temp, one->data, one->size,
> -			       one->sha1, one->mode);
> +			       one->oid.hash, one->mode);

prep_temp_blob() is a file-scope static with only two callers.  It
probably would not take too much effort to make it take &one->oid
instead?

> @@ -3075,8 +3078,8 @@ static void fill_metainfo(struct strbuf *msg,
>  				abbrev = 40;
>  		}
>  		strbuf_addf(msg, "%s%sindex %s..", line_prefix, set,
> -			    find_unique_abbrev(one->sha1, abbrev));
> -		strbuf_addstr(msg, find_unique_abbrev(two->sha1, abbrev));
> +			    find_unique_abbrev(one->oid.hash, abbrev));
> +		strbuf_addstr(msg, find_unique_abbrev(two->oid.hash, abbrev));

Good.  As more and more callers of find_unique_abbrev() is converted
to pass oid.hash to it, eventually we will have only a handful of
callers that have a raw "const unsigned char sha1[20]" to pass it,
and we can eventually make the function take &oid.  It seems we are
not quite there yet, by the looks of 'git grep find_unique_abbrev'
output, but we are getting closer.

> @@ -3134,17 +3137,17 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
>  		if (!one->sha1_valid) {
>  			struct stat st;
>  			if (one->is_stdin) {
> -				hashcpy(one->sha1, null_sha1);
> +				hashcpy(one->oid.hash, null_sha1);
>  				return;
>  			}

oidclr()?

Perhaps a preparatory step of

	unsigned char *E1;

	-hashcpy(E1, null_sha1);
        +hashclr(E1)

would help?

> @@ -902,13 +904,13 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
>  		result.clean = 0;
>  		if (S_ISREG(a->mode)) {
>  			result.mode = a->mode;
> -			hashcpy(result.sha, a->sha1);
> +			hashcpy(result.sha, a->oid.hash);
>  		} else {
>  			result.mode = b->mode;
> -			hashcpy(result.sha, b->sha1);
> +			hashcpy(result.sha, b->oid.hash);

merge_file_info is a file-scope-static type, and it shouldn't take
too much effort to replace its sha1 with an oid, I would think.

> -		if (!sha_eq(a->sha1, one->sha1) && !sha_eq(b->sha1, one->sha1))
> +		if (!sha_eq(a->oid.hash, one->oid.hash) && !sha_eq(b->oid.hash, one->oid.hash))

sha_eq() knows that either of its two parameters could be NULL, but
a->sha1 is diff_filespec.sha1 which cannot be NULL.

So !sha_eq() here can become oidcmp().  There are some calls to
sha_eq() that could pass NULL (e.g. a_sha could be NULL in
blob_unchanged()), but many other sha_eq() can become !oidcmp().

Am I reading the conversion correctly?

I'll stop here for now and will come back to the remainder of this
patch sometime later.  Thanks.

> diff --git a/notes-merge.c b/notes-merge.c
> index 34bfac0c..62c23d8a 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
