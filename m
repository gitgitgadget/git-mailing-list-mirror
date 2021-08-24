Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89580C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6AC6127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhHXWHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:07:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63027 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbhHXWHo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 18:07:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9D0A144F1A;
        Tue, 24 Aug 2021 18:06:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vIkxg7AVtMrAkhNMUOhjPvZiZAsXcdZioiz6hZ
        EoAzA=; b=Fs1ackj5dL+ID9CQ/KBRlFj/GIHiIMaxqPmLRRszyTtpTB9JYiUHat
        wBuDn6Tn4eD9M4grmPnZ8U0BkYngdO0zI46VLlQUFR15b8eERxdiGsVSqqqqhO2f
        XiwfPspBk5G74Ow8ODts1MZYHfFVBafPavMGjWzfP03Tq2YnwZ+WI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EA97144F19;
        Tue, 24 Aug 2021 18:06:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CFDA0144F15;
        Tue, 24 Aug 2021 18:06:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <cover.1617991824.git.me@ttaylorr.com>
        <cover.1629821743.git.me@ttaylorr.com>
        <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
        <xmqqa6l6oafd.fsf@gitster.g> <YSVX18UXh9vX+Zhp@nand.local>
        <xmqqr1eimtrp.fsf@gitster.g> <YSVjnSDaBXgXvT9W@nand.local>
        <xmqq35qymrcn.fsf@gitster.g>
Date:   Tue, 24 Aug 2021 15:06:55 -0700
In-Reply-To: <xmqq35qymrcn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        24 Aug 2021 15:04:56 -0700")
Message-ID: <xmqqy28qlcow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98E54072-0527-11EC-BAE5-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> FWIW, here is what I have somewhere in 'seen' where two topics meet.

Oops, one change missed.

diff --cc midx.c
index c0209751b5,4574e6d411..0000000000
--- i/midx.c
+++ w/midx.c
@@@ -947,11 -1136,29 +1136,29 @@@ static int write_midx_internal(const ch
  	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
  	stop_progress(&ctx.progress);
  
- 	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
- 		goto cleanup;
+ 	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop) {
+ 		struct bitmap_index *bitmap_git;
+ 		int bitmap_exists;
+ 		int want_bitmap = flags & MIDX_WRITE_BITMAP;
+ 
+ 		bitmap_git = prepare_midx_bitmap_git(the_repository, ctx.m);
+ 		bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
+ 		free_bitmap_index(bitmap_git);
+ 
+ 		if (bitmap_exists || !want_bitmap) {
+ 			/*
+ 			 * The correct MIDX already exists, and so does a
+ 			 * corresponding bitmap (or one wasn't requested).
+ 			 */
+ 			if (!want_bitmap)
 -				clear_midx_files_ext(the_repository, ".bitmap",
++				clear_midx_files_ext(object_dir, ".bitmap",
+ 						     NULL);
+ 			goto cleanup;
+ 		}
+ 	}
  
- 	ctx.preferred_pack_idx = -1;
  	if (preferred_pack_name) {
+ 		int found = 0;
  		for (i = 0; i < ctx.nr; i++) {
  			if (!cmp_idx_or_pack_name(preferred_pack_name,
  						  ctx.info[i].pack_name)) {
@@@ -1090,6 -1351,9 +1351,9 @@@
  
  	commit_lock_file(&lk);
  
 -	clear_midx_files_ext(the_repository, ".bitmap", midx_hash);
 -	clear_midx_files_ext(the_repository, ".rev", midx_hash);
++	clear_midx_files_ext(object_dir, ".bitmap", midx_hash);
++	clear_midx_files_ext(object_dir, ".rev", midx_hash);
+ 
  cleanup:
  	for (i = 0; i < ctx.nr; i++) {
  		if (ctx.info[i].p) {
@@@ -1165,7 -1429,8 +1429,8 @@@ void clear_midx_file(struct repository 
  	if (remove_path(midx))
  		die(_("failed to clear multi-pack-index at %s"), midx);
  
 -	clear_midx_files_ext(r, ".bitmap", NULL);
 -	clear_midx_files_ext(r, ".rev", NULL);
++	clear_midx_files_ext(r->objects->odb->path, ".bitmap", NULL);
 +	clear_midx_files_ext(r->objects->odb->path, ".rev", NULL);
  
  	free(midx);
  }
