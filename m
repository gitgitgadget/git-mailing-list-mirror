Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161A8C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 00:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbiEZAbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 20:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345578AbiEZAaa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 20:30:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7429CA7E1B
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:30:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94D7E1315C9;
        Wed, 25 May 2022 20:30:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aXhBt0kdc2Tye0DXpPj4c33Zr1RmbP4EWr4+1c
        KxVvY=; b=msgWdtgvgfsvwExk/QIP5mmKoarI/Y5OF/S1qjjVbGPn+Jf5ZZZNy+
        tlvYcRT2xlLa5+wvLjL++4UrCYB2Nzq5MFdWS2d2mhLfUoJ56IzK7g1rmLbSSCDv
        2J25zc69AIDiaEw6LhKEELd2sNWa/L+460+YLzVSouVHCrapku4I8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BAC11315C8;
        Wed, 25 May 2022 20:30:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED9791315C7;
        Wed, 25 May 2022 20:30:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1653088640.git.me@ttaylorr.com>
        <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
        <Yo61aqaQ/tXh+moi@nand.local>
Date:   Wed, 25 May 2022 17:30:26 -0700
In-Reply-To: <Yo61aqaQ/tXh+moi@nand.local> (Taylor Blau's message of "Wed, 25
        May 2022 19:02:02 -0400")
Message-ID: <xmqqleup3zkt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AB64378-DC8B-11EC-94C0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/pack-mtimes.c b/pack-mtimes.c
> index 46ad584af1..0e0aafdcb0 100644
> --- a/pack-mtimes.c
> +++ b/pack-mtimes.c
> @@ -1,3 +1,4 @@
> +#include "git-compat-util.h"
>  #include "pack-mtimes.h"
>  #include "object-store.h"
>  #include "packfile.h"
> @@ -7,12 +8,10 @@ static char *pack_mtimes_filename(struct packed_git *p)
>  	size_t len;
>  	if (!strip_suffix(p->pack_name, ".pack", &len))
>  		BUG("pack_name does not end in .pack");
> -	/* NEEDSWORK: this could reuse code from pack-revindex.c. */
>  	return xstrfmt("%.*s.mtimes", (int)len, p->pack_name);
>  }
>
>  #define MTIMES_HEADER_SIZE (12)
> -#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 * the_hash_algo->rawsz))
>
>  struct mtimes_header {
>  	uint32_t signature;
> @@ -26,10 +25,9 @@ static int load_pack_mtimes_file(char *mtimes_file,
>  {
>  	int fd, ret = 0;
>  	struct stat st;
> -	void *data = NULL;
> -	size_t mtimes_size;
> +	uint32_t *data = NULL;
> +	size_t mtimes_size, expected_size;
>  	struct mtimes_header header;
> -	uint32_t *hdr;
>
>  	fd = git_open(mtimes_file);
>
> @@ -44,21 +42,16 @@ static int load_pack_mtimes_file(char *mtimes_file,
>
>  	mtimes_size = xsize_t(st.st_size);
>
> -	if (mtimes_size < MTIMES_MIN_SIZE) {
> +	if (mtimes_size < MTIMES_HEADER_SIZE) {
>  		ret = error(_("mtimes file %s is too small"), mtimes_file);
>  		goto cleanup;
>  	}
>
> -	if (mtimes_size - MTIMES_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {
> -		ret = error(_("mtimes file %s is corrupt"), mtimes_file);
> -		goto cleanup;
> -	}
> +	data = xmmap(NULL, mtimes_size, PROT_READ, MAP_PRIVATE, fd, 0);
>
> -	data = hdr = xmmap(NULL, mtimes_size, PROT_READ, MAP_PRIVATE, fd, 0);
> -
> -	header.signature = ntohl(hdr[0]);
> -	header.version = ntohl(hdr[1]);
> -	header.hash_id = ntohl(hdr[2]);
> +	header.signature = ntohl(data[0]);
> +	header.version = ntohl(data[1]);
> +	header.hash_id = ntohl(data[2]);

So, instead of assuming that the size of the file is cast in stone
to match the size the current implementation happens to give and
reject a file from a future version, we check the header first to
give a more readable error when we see a version of the file that
we do not understand.

Makes sense.

At least, "here is a small fixup!" should have been accompanied by a
brief explanation to say something like that, i.e. why a fixup is
needed, what shortcoming in the original it is meant to address,
etc.

Will queue between 2/17 and 3/17 without squashing (yet).

Thanks.

>  	if (header.signature != MTIMES_SIGNATURE) {
>  		ret = error(_("mtimes file %s has unknown signature"), mtimes_file);
> @@ -77,13 +70,23 @@ static int load_pack_mtimes_file(char *mtimes_file,
>  		goto cleanup;
>  	}
>
> +
> +	expected_size = MTIMES_HEADER_SIZE;
> +	expected_size = st_add(expected_size, st_mult(sizeof(uint32_t), num_objects));
> +	expected_size = st_add(expected_size, 2 * (header.hash_id == 1 ? GIT_SHA1_RAWSZ : GIT_SHA256_RAWSZ));
> +
> +	if (mtimes_size != expected_size) {
> +		ret = error(_("mtimes file %s is corrupt"), mtimes_file);
> +		goto cleanup;
> +	}
> +
>  cleanup:
>  	if (ret) {
>  		if (data)
>  			munmap(data, mtimes_size);
>  	} else {
>  		*len_p = mtimes_size;
> -		*data_p = (const uint32_t *)data;
> +		*data_p = data;
>  	}
>
>  	close(fd);
> diff --git a/pack-mtimes.h b/pack-mtimes.h
> index 38ddb9f893..cc957b3e85 100644
> --- a/pack-mtimes.h
> +++ b/pack-mtimes.h
> @@ -8,8 +8,19 @@
>
>  struct packed_git;
>
> +/*
> + * Loads the .mtimes file corresponding to "p", if any, returning zero
> + * on success.
> + */
>  int load_pack_mtimes(struct packed_git *p);
>
> +/* Returns the mtime associated with the object at position "pos" (in
> + * lexicographic/index order) in pack "p".
> + *
> + * Note that it is a BUG() to call this function if either (a) "p" does
> + * not have a corresponding .mtimes file, or (b) it does, but it hasn't
> + * been loaded
> + */
>  uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos);
>
>  #endif
> --
> 2.36.1.94.gb0d54bedca
>
> --- >8 ---
