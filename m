Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB6FC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0BC6139D
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbhI1WhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:37:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63736 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbhI1WhR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 18:37:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE201E2312;
        Tue, 28 Sep 2021 18:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kD6Cy9TD+K1fM7dZVH2SobR7nlJjcy2NJs3xKj
        Hqt90=; b=IxPbYL4MGIhjGgpuk6SdQC5q5IRwwntLjrEyybD1yyA33WdTj0JIOK
        tXXwSECfr0s2jB9wBy7QHe6FwJDzrZoxR4s4KSd8PRSeRltLYibm+n8JpHL6/buu
        inCTrM/88m5INsQfIfytkwKcJzrV/VNuip3X33gEwA2EWBiN7c2kY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A543AE2311;
        Tue, 28 Sep 2021 18:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D642E2310;
        Tue, 28 Sep 2021 18:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, newren@gmail.com
Subject: Re: [PATCH v2 2/9] refs: teach arbitrary repo support to iterators
References: <cover.1632242495.git.jonathantanmy@google.com>
        <cover.1632859147.git.jonathantanmy@google.com>
        <ec153eff7b0d5ca3188ec6f43bc40c38609f6a80.1632859148.git.jonathantanmy@google.com>
Date:   Tue, 28 Sep 2021 15:35:34 -0700
In-Reply-To: <ec153eff7b0d5ca3188ec6f43bc40c38609f6a80.1632859148.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 28 Sep 2021 13:10:48 -0700")
Message-ID: <xmqqlf3gib0p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66145912-20AC-11EC-AEB2-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Note that should_pack_ref() is called when writing refs, which is only
> supported for the_repository, hence the_repository is hardcoded there.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  refs.c                | 3 ++-
>  refs/files-backend.c  | 5 ++++-
>  refs/packed-backend.c | 6 ++++--
>  refs/refs-internal.h  | 1 +
>  4 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 6f7b3447a7..5163e064ae 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -255,12 +255,13 @@ int refname_is_safe(const char *refname)
>   * does not exist, emit a warning and return false.
>   */
>  int ref_resolves_to_object(const char *refname,
> +			   struct repository *repo,
>  			   const struct object_id *oid,
>  			   unsigned int flags)
>  {
>  	if (flags & REF_ISBROKEN)
>  		return 0;
> -	if (!has_object_file(oid)) {
> +	if (!repo_has_object_file(repo, oid)) {
>  		error(_("%s does not point to a valid object!"), refname);
>  		return 0;
>  	}

OK.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f0cbea41c9..4d883d9a89 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -730,6 +730,7 @@ struct files_ref_iterator {
>  	struct ref_iterator base;
>  
>  	struct ref_iterator *iter0;
> +	struct repository *repo;
>  	unsigned int flags;
>  };

> @@ -776,6 +776,7 @@ struct packed_ref_iterator {
>  	struct object_id oid, peeled;
>  	struct strbuf refname_buf;
>  
> +	struct repository *repo;
>  	unsigned int flags;
>  };

The two steps so far seems to give the necessary information to code
paths that want them, so it is not wrong per-se, but this makes me
wonder a few things.

 - There may be multiple ref backends and iterators corresponding to
   them.  Is it reasonable to assume that there are backends that do
   not need "repo"?  Otherwise, shouldn't this be added to the base
   class "struct ref_iterator base"?

 - The iterator_begin() and other functions have been taught to take
   the repository in addition to the ref_store in the previous step,
   but

   . Doesn't iterator iterate over a single ref_store?  Shouldn't it
     have a pointer to the ref_store it is iterating over?

   . Doesn't a ref_store belong to a single repository?  Shouldn't
     it have a pointer to the repository it is part of?

   If the answers to both are 'yes', then we wouldn't need to add a
   repository pointer as a new parameter to functions that already
   took a ref store.

In other words, I am wondering if the right pieces of information
are stored in the right structure.

Thanks.


