Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BFFE2018E
	for <e@80x24.org>; Thu, 25 Aug 2016 21:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754469AbcHYVSo (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 17:18:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59329 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754406AbcHYVRi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 17:17:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E507D395DE;
        Thu, 25 Aug 2016 17:17:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bpg5yqBmPWNXgvd3sZis2vdJUXI=; b=goTRRx
        zaBFTDT4685H5LM4n5jOUiOyqRmLdsQDw2n7uOhc1HlRk6RU868M5mfjXUXqzjVQ
        q5tGqn+Y+KNI+Uh57ep1rs9/nKmox3bG3jqFU3VpaA5M8GZtGZOM2LejRs9N/ROt
        gXGOuXNqHdzSlYRFpqyCSLfyKLGKmIU5J5COU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mIFb+gk/Koc5X4dlV+6lEPxecan+UhR2
        f+g6wqhhaPrkC1u/szxtLQe6UolQt+uE+VnOaFfmxSoCZdpviLrIvohLocIaHer0
        Yft4SRMfgegPFPvyIVUIGTgeCAufSiESK61FAAieHY7VTD0HoB7PH5p52wjHrwfa
        +BguH3WH2zI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE8C4395DD;
        Thu, 25 Aug 2016 17:17:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FAB2395D9;
        Thu, 25 Aug 2016 17:17:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/15] sequencer: lib'ify do_pick_commit()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <92fdb70f3db157f8a3d2442d872e989d81c6756e.1471968378.git.johannes.schindelin@gmx.de>
Date:   Thu, 25 Aug 2016 14:17:34 -0700
In-Reply-To: <92fdb70f3db157f8a3d2442d872e989d81c6756e.1471968378.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 23 Aug 2016 18:06:46 +0200
        (CEST)")
Message-ID: <xmqqh9a8lf9t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5870C182-6B09-11E6-9D3F-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Instead of dying there, you let the caller high up in the callchain
to notice the error and handle it (by dying).  The eventual caller
of do_pick_commit() is sequencer_pick_revisions(), which already
relays an reported error from its helper functions (including this
one), and both of its two callers know how to react to a negative
return correctly.  So this makes do_pick_commit() callable from new
callers that want it not to die, without changing the external
behaviour of anything existing.

Good.

>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 0c8c955..6ac2187 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -464,7 +464,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		 * to work on.
>  		 */
>  		if (write_cache_as_tree(head, 0, NULL))
> -			die (_("Your index file is unmerged."));
> +			return error (_("Your index file is unmerged."));

While you are touching the line, it is a good idea to correct an
obvious style error like this one.  "Do one thing and one thing well
in a commit" is a good discipline, but it is absurd to take it to
the extreme.

>  	} else {
>  		unborn = get_sha1("HEAD", head);
>  		if (unborn)
