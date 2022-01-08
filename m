Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A57C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 00:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiAHA5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 19:57:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61029 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiAHA5i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 19:57:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 853EEFB066;
        Fri,  7 Jan 2022 19:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dIlWZCxc+unx
        CUy9Z+mQCVuMzerx0oZeFmQ6D5CU108=; b=LWjebv+cx4NHGKwSpID3JvD1BjFq
        YK8m6jxiyW/M/DrVHFc6UzdVwvE2M2C8Cxa7Y7EsP5zwZDv9jso7VpA1uiE17gJ/
        G3sAhxVBE5EdZzWEtBETdf2u+fvwBtnU6bLXNIISwNb3vTQDaTIB+ItQnfDQ/rSc
        gqC05tSRg6audJY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C5D2FB065;
        Fri,  7 Jan 2022 19:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E45D0FB064;
        Fri,  7 Jan 2022 19:57:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 1/6] refs: open-code deletion of packed refs
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im>
        <0739f085b266e65b423ccc14f70cc00c88744459.1641556319.git.ps@pks.im>
Date:   Fri, 07 Jan 2022 16:57:35 -0800
In-Reply-To: <0739f085b266e65b423ccc14f70cc00c88744459.1641556319.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 7 Jan 2022 12:55:13 +0100")
Message-ID: <xmqqo84n3uyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F8A427B0-701D-11EC-80CF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

This breaks the static analysis job at
https://github.com/git/git/runs/4744820766

>  refs/packed-backend.h |  6 ++++++
> diff --git a/refs/packed-backend.h b/refs/packed-backend.h
> index f61a73ec25..5e0dd7d08e 100644
> --- a/refs/packed-backend.h
> +++ b/refs/packed-backend.h
> @@ -27,6 +27,12 @@ int packed_refs_lock(struct ref_store *ref_store, in=
t flags, struct strbuf *err)
>  void packed_refs_unlock(struct ref_store *ref_store);
>  int packed_refs_is_locked(struct ref_store *ref_store);
> =20
> +int packed_refs_delete_refs(struct ref_store *ref_store,
> +			    struct ref_transaction *transaction,
> +			    const char *msg,
> +			    struct string_list *refnames,
> +			    unsigned int flags);
> +
>  /*
>   * Return true if `transaction` really needs to be carried out against
>   * the specified packed_ref_store, or false if it can be skipped

    HDR reftable/block.h
In file included from refs/packed-backend.hcc:2:0:
./refs/packed-backend.h:33:15: error: =E2=80=98struct string_list=E2=80=99=
 declared inside parameter list will not be visible outside of this defin=
ition or declaration [-Werror]
        struct string_list *refnames,
               ^~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [refs/packed-backend.hco] Error 1
make: *** Waiting for unfinished jobs....
Makefile:3029: recipe for target 'refs/packed-backend.hco' failed
Error: Process completed with exit code 1.
