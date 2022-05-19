Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D26C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 15:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiESPkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241107AbiESPkb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 11:40:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211FE26542
        for <git@vger.kernel.org>; Thu, 19 May 2022 08:40:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0AB9114592;
        Thu, 19 May 2022 11:40:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gL+Vi/LEzFtY
        NfwyM48y6+8DRKTe1XneR7Je6uNkHCc=; b=C1jRHqIEyjg/ntuuuAgao1l/cu//
        g6IfC4/NFVjUoeNWQ/+XrH3tFCNntogabK32b1hXUb6N1arvN9bpQ8SbKCJOPX6T
        1Lj1xSaI/JgCvP9rMp4GVtQfRJqou7+GXtu1/Cy9cVc+WI64/hu+klBHxrXPZw4t
        gaDPjstWeQlaOv8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8129114591;
        Thu, 19 May 2022 11:40:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3260011458E;
        Thu, 19 May 2022 11:40:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [RFC PATCH 1/2] packfile API: add and use a pack_name_to_ext()
 utility function
References: <cover.1652915424.git.me@ttaylorr.com>
        <RFC-cover-0.2-00000000000-20220519T113538Z-avarab@gmail.com>
        <RFC-patch-1.2-d8c3c03e90f-20220519T113538Z-avarab@gmail.com>
Date:   Thu, 19 May 2022 08:40:27 -0700
In-Reply-To: <RFC-patch-1.2-d8c3c03e90f-20220519T113538Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 19 May
 2022 13:42:27
        +0200")
Message-ID: <xmqqilq1r0no.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 02181FC6-D78A-11EC-9842-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add and use a pack_name_to_ext() utility function for the copy/pasted
> cases of creating a FOO.ext file given a string like FOO.pack.

I agree that "remove .pack extension and replace it with .foo
extention" is a common thing to do and it would be a welcome
simplification.

But pack_name_to_ext() sounds like taking pack-123456...9876.pack
and returning its extension (i.e. ".pack") that will become useful
when we introduce a drastically different naming convention and
start calling packfiles in newer format with different extensions
like ".pac4".

I wonder if this has easier-to-understand name that would be equally
(or slightly more) useful?

	char *replace_ext(const char *name, const char *src, const char *dst)
	{
		size_t len;

		if (!strip_suffix(name, src, &len))
			BUG("name '%s' does not end in suffix '%s'", name, src);
		return xstrfmt("%.*s.%s", (int)len, name, dst);
	}




> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  pack-bitmap.c   |  6 +-----
>  pack-revindex.c |  5 +----
>  packfile.c      | 14 ++++++++++----
>  packfile.h      |  9 +++++++++
>  4 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 97909d48da3..0c3770d038d 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -302,11 +302,7 @@ char *midx_bitmap_filename(struct multi_pack_index=
 *midx)
> =20
>  char *pack_bitmap_filename(struct packed_git *p)
>  {
> -	size_t len;
> -
> -	if (!strip_suffix(p->pack_name, ".pack", &len))
> -		BUG("pack_name does not end in .pack");
> -	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
> +	return pack_name_to_ext(p->pack_name, "bitmap");
>  }
> =20
>  static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
> diff --git a/pack-revindex.c b/pack-revindex.c
> index 08dc1601679..69dc5688796 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -179,10 +179,7 @@ static int create_pack_revindex_in_memory(struct p=
acked_git *p)
> =20
>  static char *pack_revindex_filename(struct packed_git *p)
>  {
> -	size_t len;
> -	if (!strip_suffix(p->pack_name, ".pack", &len))
> -		BUG("pack_name does not end in .pack");
> -	return xstrfmt("%.*s.rev", (int)len, p->pack_name);
> +	return pack_name_to_ext(p->pack_name, "rev");
>  }
> =20
>  #define RIDX_HEADER_SIZE (12)
> diff --git a/packfile.c b/packfile.c
> index 835b2d27164..bd6ad441bf5 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -191,15 +191,12 @@ int load_idx(const char *path, const unsigned int=
 hashsz, void *idx_map,
>  int open_pack_index(struct packed_git *p)
>  {
>  	char *idx_name;
> -	size_t len;
>  	int ret;
> =20
>  	if (p->index_data)
>  		return 0;
> =20
> -	if (!strip_suffix(p->pack_name, ".pack", &len))
> -		BUG("pack_name does not end in .pack");
> -	idx_name =3D xstrfmt("%.*s.idx", (int)len, p->pack_name);
> +	idx_name =3D pack_name_to_ext(p->pack_name, "idx");
>  	ret =3D check_packed_git_idx(idx_name, p);
>  	free(idx_name);
>  	return ret;
> @@ -2266,3 +2263,12 @@ int is_promisor_object(const struct object_id *o=
id)
>  	}
>  	return oidset_contains(&promisor_objects, oid);
>  }
> +
> +char *pack_name_to_ext(const char *pack_name, const char *ext)
> +{
> +	size_t len;
> +
> +	if (!strip_suffix(pack_name, ".pack", &len))
> +		BUG("pack_name does not end in .pack");
> +	return xstrfmt("%.*s.%s", (int)len, pack_name, ext);
> +}
> diff --git a/packfile.h b/packfile.h
> index a3f6723857b..6890c57ebdb 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -195,4 +195,13 @@ int is_promisor_object(const struct object_id *oid=
);
>  int load_idx(const char *path, const unsigned int hashsz, void *idx_ma=
p,
>  	     size_t idx_size, struct packed_git *p);
> =20
> +/**
> + * Given a string like "foo.pack" and "ext" returns an xstrdup()'d
> + * "foo.ext" string. Used for creating e.g. PACK.{bitmap,rev,...}
> + * filenames from PACK.pack.
> + *
> + * Will BUG() if the expected string can't be created from the
> + * "pack_name" argument.
> + */
> +char *pack_name_to_ext(const char *pack_name, const char *ext);
>  #endif
