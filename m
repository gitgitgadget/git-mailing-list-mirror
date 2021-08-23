Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51139C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338DE613A6
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 22:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhHWWpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 18:45:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58559 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHWWpH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 18:45:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4130CC99D7;
        Mon, 23 Aug 2021 18:44:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bu2TJffEOeckIKVds4o0FzzTm154mwBik9/v4H
        p0k2o=; b=qiPigCa59uZSjQPIb/KLqgH7FvMH+th96G/zz0QfmS7O6oPhvI6qAj
        Bty101IeGVZXCGZvnLmFvYOEvw6Rxeh28NynpPjfwbb7jT+FEf4fqI35tMteRhny
        Xfcb8pbk8aUdabL533kvTz/P1CLkgyuPkb6BWaGMxJ3F/obd4F+Mo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3888BC99D6;
        Mon, 23 Aug 2021 18:44:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B53ECC99D5;
        Mon, 23 Aug 2021 18:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] multi-pack-index: fix *.rev cleanups with --object-dir
References: <20210823171011.80588-1-johannes@sipsolutions.net>
Date:   Mon, 23 Aug 2021 15:44:23 -0700
In-Reply-To: <20210823171011.80588-1-johannes@sipsolutions.net> (Johannes
        Berg's message of "Mon, 23 Aug 2021 19:10:11 +0200")
Message-ID: <xmqqeeajpyrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9BC1214-0463-11EC-AEA2-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> If using --object-dir to point into a repo while the current
> working dir is outside, such as
>
>   git init /repo
>   git -C /repo ... # add some objects
>   cd /non-repo
>   git multi-pack-index --object-dir /repo/.git/objects/ write
>
> the binary will segfault trying to access the object-dir via
> the repo it found, but that's not fully initialized. Fix it

OK, so write_midx_internal() was given an object_dir to work in,
made various changes to that directory, but at the very end of the
sequence, instead of clearing the revindex in the object_dir we have
been working in, cleared the odb associated with the repository.

Initialized or not, that indeed is very wrong.

And the new code looks obviously correct, with minimal changes.

Thanks for finding and fixing.

> to use the object_dir properly to clean up the *.rev files,
> this avoids the crash and cleans up the *.rev files for the
> now rewritten multi-pack-index properly.
>
> Fixes: 38ff7cabb6b8 ("pack-revindex: write multi-pack reverse indexes")
> Cc: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> v3:
>  - use nongit
> ---
>  midx.c                      | 10 +++++-----
>  t/t5319-multi-pack-index.sh | 15 +++++++++++++++
>  2 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 321c6fdd2f18..902e1a7a7d9d 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -882,7 +882,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
>  	strbuf_release(&buf);
>  }
>  
> -static void clear_midx_files_ext(struct repository *r, const char *ext,
> +static void clear_midx_files_ext(const char *object_dir, const char *ext,
>  				 unsigned char *keep_hash);
>  
>  static int midx_checksum_valid(struct multi_pack_index *m)
> @@ -1086,7 +1086,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  
>  	if (flags & MIDX_WRITE_REV_INDEX)
>  		write_midx_reverse_index(midx_name, midx_hash, &ctx);
> -	clear_midx_files_ext(the_repository, ".rev", midx_hash);
> +	clear_midx_files_ext(object_dir, ".rev", midx_hash);
>  
>  	commit_lock_file(&lk);
>  
> @@ -1135,7 +1135,7 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len,
>  		die_errno(_("failed to remove %s"), full_path);
>  }
>  
> -static void clear_midx_files_ext(struct repository *r, const char *ext,
> +static void clear_midx_files_ext(const char *object_dir, const char *ext,
>  				 unsigned char *keep_hash)
>  {
>  	struct clear_midx_data data;
> @@ -1146,7 +1146,7 @@ static void clear_midx_files_ext(struct repository *r, const char *ext,
>  				    hash_to_hex(keep_hash), ext);
>  	data.ext = ext;
>  
> -	for_each_file_in_pack_dir(r->objects->odb->path,
> +	for_each_file_in_pack_dir(object_dir,
>  				  clear_midx_file_ext,
>  				  &data);
>  
> @@ -1165,7 +1165,7 @@ void clear_midx_file(struct repository *r)
>  	if (remove_path(midx))
>  		die(_("failed to clear multi-pack-index at %s"), midx);
>  
> -	clear_midx_files_ext(r, ".rev", NULL);
> +	clear_midx_files_ext(r->objects->odb->path, ".rev", NULL);
>  
>  	free(midx);
>  }
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 3d4d9f10c31b..665c6d64a0ab 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -201,6 +201,21 @@ test_expect_success 'write midx with twelve packs' '
>  
>  compare_results_with_midx "twelve packs"
>  
> +test_expect_success 'multi-pack-index *.rev cleanup with --object-dir' '
> +	git init objdir-test-repo &&
> +	test_when_finished "rm -rf objdir-test-repo" &&
> +	(
> +		cd objdir-test-repo &&
> +		test_commit base &&
> +		git repack -d
> +	) &&
> +	rev="objdir-test-repo/$objdir/pack/multi-pack-index-abcdef123456.rev" &&
> +	touch $rev &&
> +	nongit git multi-pack-index --object-dir="$(pwd)/objdir-test-repo/$objdir" write &&
> +	test_path_is_file objdir-test-repo/$objdir/pack/multi-pack-index &&
> +	test_path_is_missing $rev
> +'
> +
>  test_expect_success 'warn on improper hash version' '
>  	git init --object-format=sha1 sha1 &&
>  	(
