Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBCEC433E3
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7225F2067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IBufsgKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgHXRdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:33:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57505 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgHXRd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:33:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87C6A6A764;
        Mon, 24 Aug 2020 13:33:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p6g3ZZ7/1qJTmqgkHR5iFBK5MEQ=; b=IBufsg
        KzixOb63YyF8yEtZUK6DagsnBpH7u1r4NksZvoAOGRzJSZrnKWF44gEy6CDrzpeL
        21n65U3U7vfdVwoS/5MCm0q7xslrIeoLStFLzoMPFuL5Kc+4L57su8/a91yg7igk
        xkllmRr3wFcSCV5ajCkkkei4GCwBRL95ahZ1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=glPU+HATPpVvLbt8rVBSYkY483ESr2zw
        B0/e1FoTGK6AhjayjYtUOxKwWRxeKkKJRUikTU/UHcdgaLB8P6/bz6zh3t9woSud
        Ue+Xo4L8sWe8bwQt/ZxJvAJHHHpVoxEPJya/eFIitXpco1YOe7CClypUcsq+lHcG
        rtDUC2m1PKo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D87E6A761;
        Mon, 24 Aug 2020 13:33:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF28A6A760;
        Mon, 24 Aug 2020 13:33:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ori Bernstein <ori@eigenstate.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
References: <20200823005236.10386-1-ori@eigenstate.org>
        <20200823031151.10985-1-ori@eigenstate.org>
Date:   Mon, 24 Aug 2020 10:33:21 -0700
In-Reply-To: <20200823031151.10985-1-ori@eigenstate.org> (Ori Bernstein's
        message of "Sat, 22 Aug 2020 20:11:52 -0700")
Message-ID: <xmqqsgcc54pq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E89CF456-E62F-11EA-BA30-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ori Bernstein <ori@eigenstate.org> writes:

> diff --git a/packfile.c b/packfile.c
> index 6ab5233613..321e002c50 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1715,6 +1716,12 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>  			break;
>  		}
>  
> +		if (delta_stack_nr > UNPACK_ENTRY_STACK_LIMIT) {
> +			error("overlong delta chain at offset %jd from %s",
> +			      (uintmax_t)curpos, p->pack_name);

The "j" length field is not used anywhere in the codebase for
portability concerns, I think.  "d" is for signed, but curpos
is an unsigned off_t.  I think

	"... %"PRIuMAX" from %s", (uintmax_t)curpos, ...

would match how we write this kind of thing everywhere else in the
code, e.g. showing obj_offset in packed_to_object_type() in the same
file in an error message.

> @@ -1633,6 +1633,7 @@ static void write_pack_access_log(struct packed_git *p, off_t obj_offset)
>  
>  int do_check_packed_object_crc;
>  
> +#define UNPACK_ENTRY_STACK_LIMIT 10000
>  #define UNPACK_ENTRY_STACK_PREALLOC 64
>  struct unpack_entry_stack_ent {
>  	off_t obj_offset;

What escape hatch would the end-users have when they have a
legitimate packfile that has a truly deep delta chain, by the way?

Thanks.
