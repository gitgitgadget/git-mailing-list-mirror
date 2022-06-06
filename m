Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD87AC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 18:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiFFSpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 14:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiFFSpp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 14:45:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8443492
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 11:45:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE8B018FBC1;
        Mon,  6 Jun 2022 14:45:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bCK0VBOGH8es
        RoDPSgBB8UjgQcKwBCPFjyy5EtNfJXQ=; b=adPU6CIvcCX2zRuxNrZdGQ4ihvSv
        Bp/+ypkXDaJRUgFlUMSlcYLytSPjCxvqR7UN2Bg5qVNMpnNBpCidFAnd0IudBE3i
        e6X8iiruR1/42BpAMRYNaJOnUIHoeVJS7MAXIVtUzoiJt64edVlxNiwO0+cGypZd
        pVdFEVkRDSdp++U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C651418FBC0;
        Mon,  6 Jun 2022 14:45:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 452FD18FBBF;
        Mon,  6 Jun 2022 14:45:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v13 2/7] object-file.c: do fsync() and close() before
 post-write die()
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
        <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
        <patch-v13-2.7-b3568f0c5c0-20220604T095113Z-avarab@gmail.com>
Date:   Mon, 06 Jun 2022 11:45:38 -0700
In-Reply-To: <patch-v13-2.7-b3568f0c5c0-20220604T095113Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 4 Jun
 2022 12:10:23
        +0200")
Message-ID: <xmqqilpd7hrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DC3F3800-E5C8-11EC-B54A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change write_loose_object() to do an fsync() and close() before the
> oideq() sanity check at the end. This change re-joins code that was
> split up by the die() sanity check added in 748af44c63e (sha1_file: be
> paranoid when creating loose objects, 2010-02-21).
>
> I don't think that this change matters in itself, if we called die()
> it was possible that our data wouldn't fully make it to disk, but in
> any case we were writing data that we'd consider corrupted. It's
> possible that a subsequent "git fsck" will be less confused now.

write_loose_object()=20

 - prepares a temporary file
 - deflates into the temporary file
 - closes and syncs it
 - moves the temporary file to the final locaiton

And any die() inserted in between any of these steps will cause the
corrupt temporary file not to become the final loose object file.

So, "git fsck" does not need this change at all.

> The real reason to make this change is that in a subsequent commit
> we'll split this code in write_loose_object() into a utility function,
> all its callers will want the preceding sanity checks, but not the
> "oideq" check. By moving the close_loose_object() earlier it'll be
> easier to reason about the introduction of the utility function.

If a "split" relies on the "close and sync" step being in any
particular place, that smells really fishy.  Is the series loosening
the object integrity check?  Are we adding some exploitable hole
into our codebase without people knowing, or something?  I am not
sure if I am following the above logic.



> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  object-file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 79eb8339b60..e4a83012ba4 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2012,12 +2012,12 @@ static int write_loose_object(const struct obje=
ct_id *oid, char *hdr,
>  		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
>  		    ret);
>  	the_hash_algo->final_oid_fn(&parano_oid, &c);
> +	close_loose_object(fd, tmp_file.buf);
> +
>  	if (!oideq(oid, &parano_oid))
>  		die(_("confused by unstable object source data for %s"),
>  		    oid_to_hex(oid));
> =20
> -	close_loose_object(fd, tmp_file.buf);
> -
>  	if (mtime) {
>  		struct utimbuf utb;
>  		utb.actime =3D mtime;
