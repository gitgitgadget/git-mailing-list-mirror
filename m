Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0653CC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 17:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbiCURcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 13:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242642AbiCURcI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 13:32:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C8EA5EA0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 10:30:41 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 513F71278EF;
        Mon, 21 Mar 2022 13:30:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KfvjB1zPsfayL9c+Rh4kr8XoK6WGY3kwXk+Kv4
        /YRuA=; b=NNo5zjGXZT4Cvdg+mSGAGstNKUxityzC2wIiLH9GOi8txRdCFTj579
        skTzIaqQb2zMo7Xzx2l7upkgnNyYHf40L/l3L8z3sECyPtxW+5mKut3jAMalrU4q
        1eBUUcA/94zIG6/2svZV5keYfY5534TB1XM+m1Z2Xx5ng5/HLpq+k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 467EE1278EE;
        Mon, 21 Mar 2022 13:30:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D08D1278ED;
        Mon, 21 Mar 2022 13:30:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for
 loose-objects
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 10:30:39 -0700
In-Reply-To: <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Sun, 20 Mar 2022 07:15:55
        +0000")
Message-ID: <xmqqee2v1adc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A10AC2D6-A93C-11EC-9CC9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +* `batch` enables a mode that uses writeout-only flushes to stage multiple
> +  updates in the disk writeback cache and then does a single full fsync of
> +  a dummy file to trigger the disk cache flush at the end of the operation.

It is unfortunate that we have a rather independent "unplug" that is
not tied to the "this is the last operation in the batch"---if there
were we didn't have to invent a dummy but a single full sync on the
real file who happened to be the last one in the batch would be
sufficient.  It would not matter, if the batch is any meaningful
size, hopefully.

> +/*
> + * Cleanup after batch-mode fsync_object_files.
> + */
> +static void do_batch_fsync(void)
> +{
> +	/*
> +	 * Issue a full hardware flush against a temporary file to ensure
> +	 * that all objects are durable before any renames occur.  The code in
> +	 * fsync_loose_object_bulk_checkin has already issued a writeout
> +	 * request, but it has not flushed any writeback cache in the storage
> +	 * hardware.
> +	 */
> +
> +	if (needs_batch_fsync) {
> +		struct strbuf temp_path = STRBUF_INIT;
> +		struct tempfile *temp;
> +
> +		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
> +		temp = xmks_tempfile(temp_path.buf);
> +		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
> +		delete_tempfile(&temp);
> +		strbuf_release(&temp_path);
> +		needs_batch_fsync = 0;
> +	}
> +
> +	if (bulk_fsync_objdir) {
> +		tmp_objdir_migrate(bulk_fsync_objdir);
> +		bulk_fsync_objdir = NULL;

The struct obtained from tmp_objdir_create() is consumed by
tmp_objdir_migrate() so the only clean-up left for the caller to do
is to clear it to NULL.  OK.

> +	}

This initially made me wonder why we need two independent flags.
After applying this patch but not any later steps, upon plugging, we
create the tentative object directory, and any loose object will be
created there, but because nobody calls the writeout-only variant
via fsync_loose_object_bulk_checkin() yet, needs_batch_fsync may not
be turned on.  But even in that case, any new loose objects are in
the tentative object directory and need to be migrated to the real
place.

And we may not cover all the existing code paths at the end of the
series, or any new code paths right away after they get introduced,
to be aware of the fsync_loose_object_bulk_checkin() when they
create a loose object file, so it is most likely that these two if
statements will be with us forever.

OK.

> @@ -274,6 +311,24 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
>  	return 0;
>  }
>  
> +void fsync_loose_object_bulk_checkin(int fd)
> +{
> +	/*
> +	 * If we have a plugged bulk checkin, we issue a call that
> +	 * cleans the filesystem page cache but avoids a hardware flush
> +	 * command. Later on we will issue a single hardware flush
> +	 * before as part of do_batch_fsync.
> +	 */
> +	if (bulk_checkin_plugged &&
> +	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
> +		assert(bulk_fsync_objdir);
> +		if (!needs_batch_fsync)
> +			needs_batch_fsync = 1;

Except for when we unplug, do we ever flip needs_batch_fsync bit
off, once it is set?  If the answer is no, wouldn't it be clearer to
unconditionally set it, instead of "set it only for the first time"?

> +	} else {
> +		fsync_or_die(fd, "loose object file");
> +	}
> +}
> +
>  int index_bulk_checkin(struct object_id *oid,
>  		       int fd, size_t size, enum object_type type,
>  		       const char *path, unsigned flags)
> @@ -288,6 +343,19 @@ int index_bulk_checkin(struct object_id *oid,
>  void plug_bulk_checkin(void)
>  {
>  	assert(!bulk_checkin_plugged);
> +
> +	/*
> +	 * A temporary object directory is used to hold the files
> +	 * while they are not fsynced.
> +	 */
> +	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT)) {
> +		bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
> +		if (!bulk_fsync_objdir)
> +			die(_("Could not create temporary object directory for core.fsyncobjectfiles=batch"));
> +
> +		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
> +	}
> +
>  	bulk_checkin_plugged = 1;
>  }
>  
> @@ -297,4 +365,6 @@ void unplug_bulk_checkin(void)
>  	bulk_checkin_plugged = 0;
>  	if (bulk_checkin_state.f)
>  		finish_bulk_checkin(&bulk_checkin_state);
> +
> +	do_batch_fsync();
>  }
> diff --git a/bulk-checkin.h b/bulk-checkin.h
> index b26f3dc3b74..08f292379b6 100644
> --- a/bulk-checkin.h
> +++ b/bulk-checkin.h
> @@ -6,6 +6,8 @@
>  
>  #include "cache.h"
>  
> +void fsync_loose_object_bulk_checkin(int fd);
> +
>  int index_bulk_checkin(struct object_id *oid,
>  		       int fd, size_t size, enum object_type type,
>  		       const char *path, unsigned flags);
> diff --git a/cache.h b/cache.h
> index 3160bc1e489..d1ae51388c9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1040,7 +1040,8 @@ extern int use_fsync;
>  
>  enum fsync_method {
>  	FSYNC_METHOD_FSYNC,
> -	FSYNC_METHOD_WRITEOUT_ONLY
> +	FSYNC_METHOD_WRITEOUT_ONLY,
> +	FSYNC_METHOD_BATCH
>  };

Style.

These days we allow trailing comma to enum definitions.  Perhaps
give a trailing comma after _BATCH so that the next update patch
will become less noisy?

Thanks.
