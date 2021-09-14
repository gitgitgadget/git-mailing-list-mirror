Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F23C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F31660E9B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhINTfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:35:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57128 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhINTfa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:35:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 808D2DE460;
        Tue, 14 Sep 2021 15:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DgPDJ6Y9DjtNnMMg3VdVkO7HpyQXuRAqovby81
        uH30w=; b=Eb6A6CmYVDGiYxNKOlkzsLI/dlbi4QFQa48WzRW5szYAlAO008c3ta
        MIxeRdKIR4yWLhZVFdk8dB2O8Y/G0thckOgW0GBa5SnFUGv01BdkfL9dUTF/IRib
        2JarI0lX9LNls1WL8bARZ1zD3kN5w5oec3Cs+KOKv+RO17Poo1+NE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78ECBDE45F;
        Tue, 14 Sep 2021 15:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04C4EDE45D;
        Tue, 14 Sep 2021 15:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 2/6] core.fsyncobjectfiles: batched disk flushes
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <f8b5b709e9edc363b2de7d4afa443deec0120ca0.1631590725.git.gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 12:34:11 -0700
In-Reply-To: <f8b5b709e9edc363b2de7d4afa443deec0120ca0.1631590725.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Tue, 14 Sep 2021 03:38:41
        +0000")
Message-ID: <xmqqfsu70x58.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCE8A7CC-1592-11EC-9DD5-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/config.c b/config.c
> index cb4a8058bff..9fe3602e1c4 100644
> --- a/config.c
> +++ b/config.c
> @@ -1509,7 +1509,13 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>  	}
>  
>  	if (!strcmp(var, "core.fsyncobjectfiles")) {
> -		fsync_object_files = git_config_bool(var, value);
> +		if (!value)
> +			return config_error_nonbool(var);
> +		if (!strcasecmp(value, "batch"))
> +			fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
> +		else
> +			fsync_object_files = git_config_bool(var, value)
> +				? FSYNC_OBJECT_FILES_ON : FSYNC_OBJECT_FILES_OFF;
>  		return 0;

The original code used to allow the short-and-sweet valueless true

	[core]
		fsyncobjectfiles

but it no longer does by calling it a nonbool error.  This breaks
existing users' repositories that have been happily working, doesn't
it?

Perhaps

	if (value && !strcmp(value, "batch"))
		fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
	else if (git_config_bool(var, value))
		fsync_object_files = FSYNC_OBJECT_FILES_ON;
	else
		fsync_object_files = FSYNC_OBJECT_FILES_OFF;

> -/* Finalize a file on disk, and close it. */
> -static void close_loose_object(int fd)
> -{
> -	if (fsync_object_files)
> -		fsync_or_die(fd, "loose object file");
> -	if (close(fd) != 0)
> -		die_errno(_("error when closing loose object file"));
> -}
> -
>  /* Size of directory component, including the ending '/' */
>  static inline int directory_size(const char *filename)
>  {
> @@ -1973,17 +1964,8 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  		die(_("confused by unstable object source data for %s"),
>  		    oid_to_hex(oid));
>  
> -	close_loose_object(fd);
> -
> -	if (mtime) {
> -		struct utimbuf utb;
> -		utb.actime = mtime;
> -		utb.modtime = mtime;
> -		if (utime(tmp_file.buf, &utb) < 0)
> -			warning_errno(_("failed utime() on %s"), tmp_file.buf);
> -	}
> -
> -	return finalize_object_file(tmp_file.buf, filename.buf);
> +	return fsync_and_close_loose_object_bulk_checkin(fd, tmp_file.buf,
> +							 filename.buf, mtime);
>  }

This block of code looked familiar and I was about to complain "why
add it in one step and remove it in another?"

But it is a different instance from the one that was added in one of
the previous patches ;-).  

> +int git_fsync(int fd, enum fsync_action action)
> +{
> +	if (action == FSYNC_WRITEOUT_ONLY) {
> +#ifdef __APPLE__
> +		/*
> +		 * on Mac OS X, fsync just causes filesystem cache writeback but does not
> +		 * flush hardware caches.
> +		 */
> +		return fsync(fd);
> +#endif
> +
> +#ifdef HAVE_SYNC_FILE_RANGE
> +		/*
> +		 * On linux 2.6.17 and above, sync_file_range is the way to issue
> +		 * a writeback without a hardware flush. An offset of 0 and size of 0
> +		 * indicates writeout of the entire file and the wait flags ensure that all
> +		 * dirty data is written to the disk (potentially in a disk-side cache)
> +		 * before we continue.
> +		 */
> +
> +		return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
> +						 SYNC_FILE_RANGE_WRITE |
> +						 SYNC_FILE_RANGE_WAIT_AFTER);
> +#endif
> +
> +		errno = ENOSYS;
> +		return -1;
> +	}

This allows the caller that can take advantage of writeout-only mode
to naturally fall back on the full sync per each file if we cannot do
a writeout-only sync.  OK.

> +#ifdef __APPLE__
> +	return fcntl(fd, F_FULLFSYNC);
> +#else
> +	return fsync(fd);
> +#endif
> +}

If we are introducing "enum fsync_action", we should have some way
to make it clear that we are covering all the possible values of
"action".

Switching on action, i.e.

	switch (action) {
	case FSYNC_WRITEOUT_ONLY:
		...
		break;
	case FSYNC_HARDWARE_FLUSH:
		...
		break;
	default:
		BUG("unexpected git_fsync(%d) call", action);
	}

would be one way to do so.

Thanks.
