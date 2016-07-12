Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71AA31FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 18:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbcGLSju (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 14:39:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750744AbcGLSjt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 14:39:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EACE2AACC;
	Tue, 12 Jul 2016 14:39:48 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pnSy/gXf+LRn
	SXpsykFBK7JQdOc=; b=rwNSrD9GgUMaCx9aAn7W3hDPnyKK1rNS83kez+FHmJwP
	QNzScAj43EJUUxuJ6gnZery0xbWXvPwzMGcgDvzaY45TW5O9kEl/ldiGFSsrkMOB
	jF9nP484tqXkdHzwHHQ+Lt6MTmQ4Im5UNjwW9OdW6Br4PDtSuJmP2S988oe4Aa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=egZkOc
	RhCbyPdJGvIgUIFINEP49IxXZv/5xjiuomPyMssVpyNfMBXK2QVk3P27wVUtf2w2
	xjOfQlcNUe9Y+jyevS1Ng7vTotOCLb1Svy0R9s9bM+6+/owXrb6B5MiTCUwXyqtn
	3aCrJoaX2eAq11ZYeafXsL3KIOhwnfx4JsWn0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 37B0E2AACB;
	Tue, 12 Jul 2016 14:39:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B513F2AACA;
	Tue, 12 Jul 2016 14:39:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH 7/5] fsck: use streaming interface for large blobs in pack
References: <20160705170558.10906-1-pclouds@gmail.com>
	<20160710104555.27478-1-pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 11:39:45 -0700
In-Reply-To: <20160710104555.27478-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Sun, 10 Jul 2016 12:45:55 +0200")
Message-ID: <xmqq7fcq66q6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 02821620-4860-11E6-B94B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> For this particular operation, not unpacking the blob and letting
> check_sha1_signature, which supports streaming interface, do the job
> is sufficient.

That reasoning is sound, I would think, but...

> We will call the callback function "fn" with NULL as "data". The only
> callback of this function is fsck_obj_buffer(), which does not touch
> "data" at all if it's a blob.

... this may be a bit too magical that the assumption needs to be
left in an in-code comment to warn people against temptation to
using "data" over there, not just where the type of verify_fn is
declared.  Essentially, you are changing the expectation from
existing functions of that type.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  pack-check.c | 15 +++++++++++++--
>  pack.h       |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/pack-check.c b/pack-check.c
> index 1da89a4..0777766 100644
> --- a/pack-check.c
> +++ b/pack-check.c
> @@ -105,6 +105,8 @@ static int verify_packfile(struct packed_git *p,
>  		void *data;
>  		enum object_type type;
>  		unsigned long size;
> +		off_t curpos;
> +		int data_valid = 0;
>  
>  		if (p->index_version > 1) {
>  			off_t offset = entries[i].offset;
> @@ -116,8 +118,17 @@ static int verify_packfile(struct packed_git *p,
>  					    sha1_to_hex(entries[i].sha1),
>  					    p->pack_name, (uintmax_t)offset);
>  		}
> -		data = unpack_entry(p, entries[i].offset, &type, &size);
> -		if (!data)
> +
> +		curpos = entries[i].offset;
> +		type = unpack_object_header(p, w_curs, &curpos, &size);
> +		unuse_pack(w_curs);

This made me wonder where this "unuse" comes from; w_curs's in-use
count is incremented by calling unpack_object_header() and we are
done with that access at this point, hence we have unuse here.

> +		if (type != OBJ_BLOB || size < big_file_threshold) {
> +			data = unpack_entry(p, entries[i].offset, &type, &size);
> +			data_valid = 1;

This codepath slurps the data in-core to hash and data is later
freed, i.e. non-blob objects and small ones are handled as before.

> +		}
> +
> +		if (data_valid && !data)
>  			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
>  				    sha1_to_hex(entries[i].sha1), p->pack_name,
>  				    (uintmax_t)entries[i].offset);

Otherwise, we'd go to check_sha1_signature() with map==NULL.  And
that is exactly what we want---map==NULL is the way we tell the
function to use the streaming interface to check.

Good.

> diff --git a/pack.h b/pack.h
> index 3223f5a..0e77429 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -74,6 +74,7 @@ struct pack_idx_entry {
>  
>  
>  struct progress;
> +/* Note, the data argument could be NULL if object type is blob */
>  typedef int (*verify_fn)(const unsigned char*, enum object_type, unsigned long, void*, int*);
>  
>  extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
