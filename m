Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3607FC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbiCJS1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiCJS1I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:27:08 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC01C158D96
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:26:03 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09915181CC6;
        Thu, 10 Mar 2022 13:26:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nkZ3Q4ymEIAI
        qT2EW7mmRSWLULRYtVqGQG35YycBAGI=; b=GPAb9b/G+18LSG3fRPGhQq68jaI5
        v2pV8YNLwl7wUGoon6xFerROJgkPUZv71nuTKNYuU3CGyh0eWsmk0oVEct17qQLb
        QbqHh2wTju6U0shIVjsLH8pMfc2cndorXajvvUARFv8RDADkwH8H8x+trRTUUxEY
        vjIK0OXO+n1+tyY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E71E6181CC5;
        Thu, 10 Mar 2022 13:26:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32F61181CBF;
        Thu, 10 Mar 2022 13:26:00 -0500 (EST)
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
Date:   Thu, 10 Mar 2022 10:25:59 -0800
In-Reply-To: <f1e8a7bb3bf0f4c0414819cb1d5579dc08fd2a4f.1646905589.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 10 Mar 2022 10:53:21 +0100")
Message-ID: <xmqq4k45fyvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 891D0F44-A09F-11EC-8F7E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/Documentation/config/core.txt b/Documentation/config/core.=
txt
> index 973805e8a9..b67d3c340e 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -564,8 +564,10 @@ core.fsync::
>  * `pack-metadata` hardens packfile bitmaps and indexes.
>  * `commit-graph` hardens the commit graph file.
>  * `index` hardens the index when it is modified.
> +* `loose-ref` hardens references modified in the repo in loose-ref for=
m.
>  * `objects` is an aggregate option that is equivalent to
>    `loose-object,pack`.
> +* `refs` is an aggregate option that is equivalent to `loose-ref`.

Aggregate of one feels strange.  I do not see a strong reason to
have two separate classes loose vs packed and allow them be
protected to different robustness, but that aside, if we were to
have two, this "aggregate" is better added when the second one is.

Having said that, given that a separate ref backend that has no
distinction between loose or packed is on horizen, I think we would
rather prefer to see a single "ref" component that governs all
backends.

> @@ -1026,7 +1029,8 @@ enum fsync_component {
>  			      FSYNC_COMPONENT_PACK | \
>  			      FSYNC_COMPONENT_PACK_METADATA | \
>  			      FSYNC_COMPONENT_COMMIT_GRAPH | \
> -			      FSYNC_COMPONENT_INDEX)
> +			      FSYNC_COMPONENT_INDEX | \
> +			      FSYNC_COMPONENT_LOOSE_REF)

OK.

> +static int files_sync_loose_ref(struct ref_lock *lock, struct strbuf *=
err)

This file-scope static function will not be in the vtable (in other
words, it is not like "sync_loose_ref" method must be defined across
all ref backends and this function is called as the implementation
of the method for the files backend), so we do not have to give it
"files_" prefix if we do not want to.

sync_loose_ref() may be easier to read, perhaps?

> +{
> +	int ret =3D fsync_component(FSYNC_COMPONENT_LOOSE_REF, get_lock_file_=
fd(&lock->lk));
> +	if (ret)
> +		strbuf_addf(err, "could not sync loose ref '%s': %s", lock->ref_name=
,
> +			    strerror(errno));
> +	return ret;
> +}

OK.

Good illustration how the new helper in 6/8 is useful.  It would be
nice if the reroll of the base topic by Neeraj reorders the patches
to introduce fsync_component() much earlier, at the same time it
introduces the fsync_component_or_die().

> @@ -1504,6 +1513,7 @@ static int files_copy_or_rename_ref(struct ref_st=
ore *ref_store,
>  	oidcpy(&lock->old_oid, &orig_oid);
> =20
>  	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
> +	    files_sync_loose_ref(lock, &err) ||
>  	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
>  		error("unable to write current sha1 into %s: %s", newrefname, err.bu=
f);
>  		strbuf_release(&err);
> @@ -1524,6 +1534,7 @@ static int files_copy_or_rename_ref(struct ref_st=
ore *ref_store,
>  	flag =3D log_all_ref_updates;
>  	log_all_ref_updates =3D LOG_REFS_NONE;
>  	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
> +	    files_sync_loose_ref(lock, &err) ||
>  	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
>  		error("unable to write current sha1 into %s: %s", oldrefname, err.bu=
f);
>  		strbuf_release(&err);

We used to skip commit_ref_update() and gone to the error code path
upon write failure, and we do the same upon fsync failure now.  The
error code path will do the rollback the same way as before.

OK, these look sensible.

> @@ -2819,6 +2830,24 @@ static int files_transaction_prepare(struct ref_=
store *ref_store,
>  		}
>  	}
> =20
> +	/*
> +	 * Sync all lockfiles to disk to ensure data consistency. We do this =
in
> +	 * a separate step such that we can sync all modified refs in a singl=
e
> +	 * step, which may be more efficient on some filesystems.
> +	 */
> +	for (i =3D 0; i < transaction->nr; i++) {
> +		struct ref_update *update =3D transaction->updates[i];
> +		struct ref_lock *lock =3D update->backend_data;
> +
> +		if (!(update->flags & REF_NEEDS_COMMIT))
> +			continue;
> +
> +		if (files_sync_loose_ref(lock, err)) {
> +			ret  =3D TRANSACTION_GENERIC_ERROR;
> +			goto cleanup;
> +		}
> +	}

An obvious alternative that na=C3=AFvely comes to mind is to keep going
after seeing the first failure to sync and attempt to sync all the
rest, but remember that we had an error.  But I think what this
patch does makes a lot more sense, as the error code path will just
cleans the transaction up.  If any of them fails, there is no reason
to spend more effort.

Thanks.

>  cleanup:
>  	free(head_ref);
>  	string_list_clear(&affected_refnames, 0);
