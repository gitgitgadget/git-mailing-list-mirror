Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E3C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 06:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346698AbiCKGlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 01:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbiCKGlO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 01:41:14 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99FC47AED
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 22:40:11 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F4E618760A;
        Fri, 11 Mar 2022 01:40:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rVWsR+bjd0gzPu8L7XcQ9kM0Zq7X68bTnSsA7h
        dxc48=; b=KeI63KW/v0RsbRhTr5u6PW4pK2F8k7vQsG037Ezq8UbV/MqyHG9Q4N
        d/aAHolbDenDqCLqp1LEIOOQYQLN9gpeF4LDsL62Z/abIkIYg4CD262UpxNk87jW
        oPQaTUlzOzVi/c6UX9L05CgWpfjCSd8WL1w6CIx6x5G+VkHk/+1no=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26D3B187609;
        Fri, 11 Mar 2022 01:40:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A70DC187608;
        Fri, 11 Mar 2022 01:40:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 7/8] core.fsync: new option to harden loose references
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <f1e8a7bb3bf0f4c0414819cb1d5579dc08fd2a4f.1646905589.git.ps@pks.im>
Date:   Thu, 10 Mar 2022 22:40:07 -0800
In-Reply-To: <f1e8a7bb3bf0f4c0414819cb1d5579dc08fd2a4f.1646905589.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 10 Mar 2022 10:53:21 +0100")
Message-ID: <xmqqzglx9em0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 180CD12E-A106-11EC-A081-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> @@ -1504,6 +1513,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
>  	oidcpy(&lock->old_oid, &orig_oid);
>  
>  	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
> +	    files_sync_loose_ref(lock, &err) ||
>  	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
>  		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
>  		strbuf_release(&err);

Given that write_ref_to_lockfile() on the success code path does this:

	fd = get_lock_file_fd(&lock->lk);
	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
	    write_in_full(fd, &term, 1) < 0 ||
	    close_ref_gently(lock) < 0) {
		strbuf_addf(err,
			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
		unlock_ref(lock);
		return -1;
	}
	return 0;

the above unfortunately does not work.  By the time the new call to
files_sync_loose_ref() is made, lock->fd is closed by the call to
close_lock_file_gently() made in close_ref_gently(), and because of
that, you'll get an error like this:

    Writing objects: 100% (3/3), 279 bytes | 279.00 KiB/s, done.
    Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
    remote: error: could not sync loose ref 'refs/heads/client_branch':
    Bad file descriptor     

when running "make test" (the above is from t5702 but I wouldn't be
surprised if this broke ALL ref updates).

Just before write_ref_to_lockfile() calls close_ref_gently() would
be a good place to make the fsync_loose_ref() call, perhaps?


Thanks.
