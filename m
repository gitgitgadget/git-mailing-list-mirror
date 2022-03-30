Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56D4C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349384AbiC3Rj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344245AbiC3Rj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:39:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C839CF495
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:37:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4201F125A10;
        Wed, 30 Mar 2022 13:37:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L0PcWVVjic4bx3FVZeoGaiQaqYHQtrCmh0dbiu
        rzgCQ=; b=PnTASUGVYe0b++sJO78fW7t9pcv7mnlu7ft79QNhdToVsjWrWDrPvN
        9mCkuYkkknounNF/yQb6lpkGrzrRMUrZhIosksQKQW/Buap9i53WX6j453ANaAqK
        dIaJaAzwzHVIaPshN1WHwfGsGbW7G+p5D4wbWOyuSbsoaNFI2699g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3670C125A0F;
        Wed, 30 Mar 2022 13:37:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75C72125A0E;
        Wed, 30 Mar 2022 13:37:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 04/14] core.fsyncmethod: batched disk flushes for
 loose-objects
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <9e7ae22fa4a2693fe26659f875dd780080c4cfb2.1648616734.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 10:37:35 -0700
In-Reply-To: <9e7ae22fa4a2693fe26659f875dd780080c4cfb2.1648616734.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 30 Mar 2022 05:05:22
        +0000")
Message-ID: <xmqq4k3f9w9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 169F4624-B050-11EC-B882-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 9da3e5d88f6..3c90ba0b395 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -596,6 +596,14 @@ core.fsyncMethod::
>  * `writeout-only` issues pagecache writeback requests, but depending on the
>    filesystem and storage hardware, data added to the repository may not be
>    durable in the event of a system crash. This is the default mode on macOS.
> +* `batch` enables a mode that uses writeout-only flushes to stage multiple
> +  updates in the disk writeback cache and then does a single full fsync of
> +  a dummy file to trigger the disk cache flush at the end of the operation.
> ++
> +  Currently `batch` mode only applies to loose-object files. Other repository
> +  data is made durable as if `fsync` was specified. This mode is expected to
> +  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
> +  and on Windows for repos stored on NTFS or ReFS filesystems.

Does this format correctly?  I had an impression that the second and
subsequent paragraphs, connected with a line with a single "+" on
it, has to be flushed left without indentation.

> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 8b0fd5c7723..9799d247cad 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -3,15 +3,20 @@
>   */
>  #include "cache.h"
>  #include "bulk-checkin.h"
> +#include "lockfile.h"
>  #include "repository.h"
>  #include "csum-file.h"
>  #include "pack.h"
>  #include "strbuf.h"
> +#include "string-list.h"
> +#include "tmp-objdir.h"
>  #include "packfile.h"
>  #include "object-store.h"
>  
>  static int odb_transaction_nesting;
>  
> +static struct tmp_objdir *bulk_fsync_objdir;

I wonder if this should be added to the bulk_checkin_state structure
as a new member, especially if we fix the erroneous call to
finish_bulk_checkin() as a preliminary fix-up of a bug that existed
even before this series.

> +/*
> + * Cleanup after batch-mode fsync_object_files.
> + */
> +static void do_batch_fsync(void)
> +{
> +	struct strbuf temp_path = STRBUF_INIT;
> +	struct tempfile *temp;
> +
> +	if (!bulk_fsync_objdir)
> +		return;
> +
> +	/*
> +	 * Issue a full hardware flush against a temporary file to ensure
> +	 * that all objects are durable before any renames occur. The code in
> +	 * fsync_loose_object_bulk_checkin has already issued a writeout
> +	 * request, but it has not flushed any writeback cache in the storage
> +	 * hardware or any filesystem logs. This fsync call acts as a barrier
> +	 * to ensure that the data in each new object file is durable before
> +	 * the final name is visible.
> +	 */
> +	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
> +	temp = xmks_tempfile(temp_path.buf);
> +	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
> +	delete_tempfile(&temp);
> +	strbuf_release(&temp_path);
> +
> +	/*
> +	 * Make the object files visible in the primary ODB after their data is
> +	 * fully durable.
> +	 */
> +	tmp_objdir_migrate(bulk_fsync_objdir);
> +	bulk_fsync_objdir = NULL;
> +}

OK.

> +void prepare_loose_object_bulk_checkin(void)
> +{
> +	/*
> +	 * We lazily create the temporary object directory
> +	 * the first time an object might be added, since
> +	 * callers may not know whether any objects will be
> +	 * added at the time they call begin_odb_transaction.
> +	 */
> +	if (!odb_transaction_nesting || bulk_fsync_objdir)
> +		return;
> +
> +	bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
> +	if (bulk_fsync_objdir)
> +		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
> +}

OK.  If we got a failure from tmp_objdir_create(), then we don't
swap and end up creating a new loose object file in the primary
object store.  I wonder if we at least want to note that fact for
later use at "unplug" time.  We may create a few loose objects in
the primary object store without any fsync, then a later call may
successfully create a temporary object directory and we'd create
more loose objects in the temporary one, which are flushed with the
"create a dummy and fsync" trick and migrated, but do we need to do
something to the ones we created in the primary object store before
all that happens?

> +void fsync_loose_object_bulk_checkin(int fd, const char *filename)
> +{
> +	/*
> +	 * If we have an active ODB transaction, we issue a call that
> +	 * cleans the filesystem page cache but avoids a hardware flush
> +	 * command. Later on we will issue a single hardware flush
> +	 * before as part of do_batch_fsync.
> +	 */
> +	if (!bulk_fsync_objdir ||
> +	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
> +		fsync_or_die(fd, filename);
> +	}
> +}

Ah, if we have successfully created the temporary directory, we
don't do full fsync but just writeout-only one, so there is no need
for the worry I mentioned in the previous paragraph.  OK.

> @@ -301,4 +370,6 @@ void end_odb_transaction(void)
>  
>  	if (bulk_checkin_state.f)
>  		finish_bulk_checkin(&bulk_checkin_state);
> +
> +	do_batch_fsync();
>  }

OK.

> @@ -1961,6 +1963,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  	static struct strbuf tmp_file = STRBUF_INIT;
>  	static struct strbuf filename = STRBUF_INIT;
>  
> +	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> +		prepare_loose_object_bulk_checkin();
> +
>  	loose_object_path(the_repository, &filename, oid);
>  
>  	fd = create_tmpfile(&tmp_file, filename.buf);

The necessary change to the "workhorse" code path is surprisingly
small, which is pleasing to see.

Thanks.
