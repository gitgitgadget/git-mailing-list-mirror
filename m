Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5A9209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 19:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbdIFTvv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 15:51:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51887 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752306AbdIFTvu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 15:51:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0BF3A2FC6;
        Wed,  6 Sep 2017 15:51:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=HgAI58Ztq2nBqfNd+Xw0xv5JJow=; b=dvaWlK9/cDZSmthakrtN
        k0yzc08u84j5Q1xLxFHcV9nsg+BfvFt9p4xmQWZaDWHmYhwzjpxJVUYA4OQ38BKz
        siat1yGMtzqD25R9EblwZF7f9nPS2u6l25jYvp4PL9tKKeYdidl98TCmAsLHRaAM
        GW49grXH+fI+lLSRII373UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=H0RTGRMqYYceGD6cmk1VETWdzVgRI25H3DZ3bKwybjuxX5
        tRQcc+mbjI4P9xI/L3R+0b5RMgbQnibe/aMwbym9iF173Y9VCxkNlRMoXsvxHL/B
        ZjGPse/vHtGcDX/rfzT91RiqyRn3LpmwPUsKgy2Pon7EMbrYdUzZBBikdJFH8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8C7CA2FC5;
        Wed,  6 Sep 2017 15:51:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F196A2FC3;
        Wed,  6 Sep 2017 15:51:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rene Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/34] clone: release strbuf after use in remove_junk()
References: <20170830175005.20756-1-l.s.r@web.de>
        <20170830175005.20756-7-l.s.r@web.de>
Date:   Thu, 07 Sep 2017 04:51:48 +0900
Message-ID: <xmqq1snj61wr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D23E63E6-933C-11E7-BE55-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rene Scharfe <l.s.r@web.de> writes:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 8d11b570a1..dbddd98f80 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -487,28 +487,28 @@ N_("Clone succeeded, but checkout failed.\n"
> ...
>  	if (junk_git_dir) {
>  		strbuf_addstr(&sb, junk_git_dir);
>  		remove_dir_recursively(&sb, 0);
>  		strbuf_reset(&sb);
>  	}
>  	if (junk_work_tree) {
>  		strbuf_addstr(&sb, junk_work_tree);
>  		remove_dir_recursively(&sb, 0);
> -		strbuf_reset(&sb);
>  	}
> +	strbuf_release(&sb);
>  }

The code definitely needs a _release() at the end, but I feel
lukewarm about the "if we are about to _release(), do not bother to
_reset()" micro-optimization.  Keeping the existing two users that
use sb as a (shared and reused) temporary similar would help those
who add the third one or reuse the pattern in their code elsewhere.

We could flip the "be nice to the next user by clearing after use"
pattern to "clear any potential cruft before you use", i.e.

	if (...) {
		strbuf_reset(&sb);
		strbuf_addstr(&sb, ...);
	}
	if (...) {
		strbuf_reset(&sb);
		strbuf_addstr(&sb, ...);
	}
	strbuf_release(&sb);

but that still tempts us for the same micro-optimization at the
beginning where sb hasn't been used since STRBUF_INIT, so it is not
a real "solution".

So, I dunno.
