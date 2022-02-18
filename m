Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB377C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 00:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiBRAC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 19:02:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiBRACy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 19:02:54 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084264D277
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 16:02:23 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0824F104DC4;
        Thu, 17 Feb 2022 19:01:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+q1lv7ovjfv+U544J3YbxM4D63WwpTHCreMlA9
        HLuVQ=; b=wWBWQbKSsvi8ee35WqVxranQxLdzZ+pvd1mybqOM6nE1yMZt8sGh25
        OklG66V0UzEBrBccDOqvQJHFZ5YcZf2T4zYfBuoKltx5xWZyE+c1YWbcCdlggajk
        xZ2pV162iiLl5H2aBQeEsikaxNBeeHWQX+dNSSjOQN+I3bP0GIucA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3C36104DC3;
        Thu, 17 Feb 2022 19:01:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57525104DC1;
        Thu, 17 Feb 2022 19:01:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/7] reftable: ensure that obj_id_len is >= 2 on writing
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <2bd3d44ba57ddb43c09367b45a8f056233d465e9.1645106124.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 16:01:52 -0800
In-Reply-To: <2bd3d44ba57ddb43c09367b45a8f056233d465e9.1645106124.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 17 Feb 2022
        13:55:22 +0000")
Message-ID: <xmqq8ru959fz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAA678A6-904D-11EC-A710-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/reftable/writer.c b/reftable/writer.c
> index d54215a50dc..5e4e6e93416 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -515,7 +515,9 @@ static void object_record_free(void *void_arg, void *key)
>  static int writer_dump_object_index(struct reftable_writer *w)
>  {
>  	struct write_record_arg closure = { .w = w };
> -	struct common_prefix_arg common = { NULL };
> +	struct common_prefix_arg common = {
> +		.max = 1,		/* obj_id_len should be >= 2. */
> +	};

It feels somewhat strange that we have to set .max to set the floor
for the minimum length, but given the way update_common() uses and
maintains the member, it is more like "max size we have seen so
far", and by pretending that we have already seen common prefix of
length 1, we'd force ourselves that we need at least 2 to
differentiate.

>  	if (w->obj_index_tree) {
>  		infix_walk(w->obj_index_tree, &update_common, &common);
>  	}
