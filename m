Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E7FC43219
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1235660F23
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhJKU63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:58:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61791 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbhJKU6V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:58:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22FCBD621F;
        Mon, 11 Oct 2021 16:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QyiFbln4vZVj
        1dmFyvHyEtkTu2qzkzAGQpkmzvMoZL8=; b=rq6FBvnuZIbTvy/IN9YmYBu3+CAt
        pvTRqUgQdKw9gQ7nFvuLZzENqQpTRh1yU7luENO+Ni6iAnkRs1hGsQ348unNF+8P
        44sD7WDYFkUE29HLCft190mFD1JjYwCW/Jub/omcbfEDSsmV99j7m+j7EnjZ+ZGy
        /jYsSs5Q01jouJ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09200D621D;
        Mon, 11 Oct 2021 16:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64D53D621C;
        Mon, 11 Oct 2021 16:56:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>
Subject: Re: [PATCH 2/2] commit: fix duplication regression in permission
 error output
References: <patch-1.2-a5ef8ea47f4-20211009T133354Z-avarab@gmail.com>
        <patch-2.2-56b20f6024b-20211009T133354Z-avarab@gmail.com>
Date:   Mon, 11 Oct 2021 13:56:18 -0700
In-Reply-To: <patch-2.2-56b20f6024b-20211009T133354Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 9 Oct
 2021 15:34:03 +0200")
Message-ID: <xmqq1r4rb7rh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AF049A5A-2AD5-11EC-BB9F-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> So let's add and use that facility with a corresponding HASH_SILENT
> flag, its only user is cache-tree.c's update_one(), which will set it
> if its "WRITE_TREE_SILENT" flag is set.

OK.

> diff --git a/cache.h b/cache.h
> index 3e5658c6dda..088f274fa17 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -887,6 +887,7 @@ int ie_modified(struct index_state *, const struct =
cache_entry *, struct stat *,
>  #define HASH_WRITE_OBJECT 1
>  #define HASH_FORMAT_CHECK 2
>  #define HASH_RENORMALIZE  4
> +#define HASH_SILENT 8

Nice to see this done in a straight-forward way, instead of being a
single step buried in a multi-step series whose early part converts
preprocessor constants into enum and other "clean-ups" that are not
essential (and can be done as a separate series when the codebase
around the area is quiescent).

>  static int write_loose_object(const struct object_id *oid, char *hdr,
>  			      int hdrlen, const void *buf, unsigned long len,
> -			      time_t mtime)
> +			      time_t mtime, unsigned flags)
>  {
>  	int fd, ret;
>  	unsigned char compressed[4096];
> @@ -1887,7 +1887,9 @@ static int write_loose_object(const struct object=
_id *oid, char *hdr,
> =20
>  	fd =3D create_tmpfile(&tmp_file, filename.buf);
>  	if (fd < 0) {
> -		if (errno =3D=3D EACCES)
> +		if (flags & HASH_SILENT)
> +			return -1;

OK.

> diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
> index 998c9d1be69..75c6d5c8b49 100755
> --- a/t/t0004-unwritable.sh
> +++ b/t/t0004-unwritable.sh
> @@ -33,7 +33,6 @@ test_expect_success POSIXPERM,SANITY 'commit should n=
otice unwritable repository
> =20
>  	cat >expect <<-\EOF &&
>  	error: insufficient permission for adding an object to repository dat=
abase .git/objects
> -	error: insufficient permission for adding an object to repository dat=
abase .git/objects
>  	error: Error building trees
>  	EOF

Again, I think it makes it more clear if the test starts out as
expecting a failure and gets turned into expecting a success as a
part of this fix.

Thanks.
