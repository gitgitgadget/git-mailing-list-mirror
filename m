Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5ADC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACAA6103E
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbhIITaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:30:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60082 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhIITaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:30:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E7771559C3;
        Thu,  9 Sep 2021 15:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yenSBIWSNLrnUFaUwgCuKZJkvKfYZG+5uqEGRt
        gZHHk=; b=e6oi/5fwZmyqjjPiiyHCdEP7J/tVKhclNcfk4QU7GobAE7AbbKWTPB
        xbyKS5rQwqw2iDjOVfqXvi+24cWXZjuoFNsaGhdl9ik3Q26nwE+gXFyOvV9k50BU
        hWKtx1D3/pGwTRxGcFyBURmVPZTlctXDH/t8tqdw4VtGbMLtNrek8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 070AE1559C2;
        Thu,  9 Sep 2021 15:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5814F1559C1;
        Thu,  9 Sep 2021 15:29:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 3/9] pack-write: refactor renaming in finish_tmp_packfile()
References: <cover.1630461918.git.me@ttaylorr.com>
        <cover.1631157880.git.me@ttaylorr.com>
        <35052ef494dbc55119614f3e22742d8d814b21b1.1631157880.git.me@ttaylorr.com>
Date:   Thu, 09 Sep 2021 12:29:01 -0700
In-Reply-To: <35052ef494dbc55119614f3e22742d8d814b21b1.1631157880.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 8 Sep 2021 23:24:55 -0400")
Message-ID: <xmqqk0jpzgxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30DD2A7E-11A4-11EC-8BD0-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> @@ -1250,8 +1251,9 @@ static void write_pack_file(void)
>  					    &pack_idx_opts, hash);
>  
>  			if (write_bitmap_index) {
> -				strbuf_addf(&tmpname, "%s.bitmap", hash_to_hex(hash));
> +				size_t tmpname_len = tmpname.len;
>  
> +				strbuf_addstr(&tmpname, "bitmap");
>  				stop_progress(&progress_state);
>  
>  				bitmap_writer_show_progress(progress);
> @@ -1260,6 +1262,7 @@ static void write_pack_file(void)
>  				bitmap_writer_finish(written_list, nr_written,
>  						     tmpname.buf, write_bitmap_options);
>  				write_bitmap_index = 0;
> +				strbuf_setlen(&tmpname, tmpname_len);
>  			}
>  
>  			strbuf_release(&tmpname);

This runs setlen on tmpname strbuf and immediately releases (the
close brace before release closes the "if (write_bitmap_index)", not
any loop.  If we plan to insert more code to use tmpname where the
blank line we see above is in the future, it may make sense, but
even in such a case, adding setlen() only when it starts to matter
may make it easier to follow.

In any case, the above correctly adjusts tmpname to have a <hash>
plus '.' at the end of tmpname to call finish_tmp_packfile().

> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 6283bc8bd9..c19d471f0b 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -46,7 +46,8 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  		close(fd);
>  	}
>  
> -	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
> +	strbuf_addf(&packname, "%s/pack/pack-%s.", get_object_directory(),
> +		    hash_to_hex(hash));
>  	finish_tmp_packfile(&packname, state->pack_tmp_name,
>  			    state->written, state->nr_written,
>  			    &state->pack_idx_opts, hash);

OK.

> diff --git a/pack-write.c b/pack-write.c
> index 2767b78619..95b063be94 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -458,6 +458,18 @@ struct hashfile *create_tmp_packfile(char **pack_tmp_name)
>  	return hashfd(fd, *pack_tmp_name);
>  }
>  
> +static void rename_tmp_packfile(struct strbuf *nb, const char *source,
> +				const char *ext)
> +{
> +	size_t nb_len = nb->len;
> +
> +	strbuf_addstr(nb, ext);
> +	if (rename(source, nb->buf))
> +		die_errno("unable to rename temporary '*.%s' file to '%s'",
> +			  ext, nb->buf);

I do not like '*.%s' here.  Without '*' it is clear enough, and
because nb->buf has already the same ext information, 

	unable to rename temporary file to '%s'.

would be even simpler without losing any information than this
rewrite does.

The original explicitly used the more human-facing terms like "pack
file", so we are losing information by this refactoring, but the
loss is not too bad.  In one case, namely ".idx" files, it is even
better, as the original says "temporary index file" to refer to the
new .idx file, which makes it ambiguous with _the_ index file.

> +	strbuf_setlen(nb, nb_len);
> +}

In the longer term if we were to add more auxiliary files next to
each of the .pack file, it makes perfect sense that the common
prefix is fed to rename_tmp_packfile() and the function reverts
contents of the prefix buffer back when it is done with it.  But it
would be more friendly to those adding more calls to this function
in the future to document the convention in a comment before the
function.

Also, the name "nb" would need rethinking.  As far as the callers
are concerned, that is not a full name, but they are supplying the
common prefix to the function.  Perhaps "struct strbuf *name_prefix"
or soemthing might be better?  I dunno.

>  void finish_tmp_packfile(struct strbuf *name_buffer,
>  			 const char *pack_tmp_name,
>  			 struct pack_idx_entry **written_list,
> @@ -466,7 +478,6 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
>  			 unsigned char hash[])
>  {
>  	const char *idx_tmp_name, *rev_tmp_name = NULL;
> -	int basename_len = name_buffer->len;
>  
>  	if (adjust_shared_perm(pack_tmp_name))
>  		die_errno("unable to make temporary pack file readable");
> @@ -479,26 +490,10 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
>  	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
>  				      pack_idx_opts->flags);

It is unfortunate that write_idx_file() and write_rev_file() take
hash and come up with the temporary filename on their own (which
means their resulting filenames may not share the same prefix as
.pack and .idx files), but it is just the naming of temporaries and
inconsistencies among them is, eh, temporary, so it is OK.

> +	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
> +	rename_tmp_packfile(name_buffer, idx_tmp_name, "idx");
> +	if (rev_tmp_name)
> +		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
>  
>  	free((void *)idx_tmp_name);
>  }
