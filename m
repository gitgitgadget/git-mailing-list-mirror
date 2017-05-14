Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C64A201A7
	for <e@80x24.org>; Sun, 14 May 2017 08:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbdENILJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 04:11:09 -0400
Received: from [195.159.176.226] ([195.159.176.226]:39860 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdENILH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 04:11:07 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1d9ocF-0002mM-Fk
        for git@vger.kernel.org; Sun, 14 May 2017 10:10:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 04/22] blame: move origin and entry structures to header
Date:   Sun, 14 May 2017 17:10:55 +0900
Message-ID: <xmqq8tlz504w.fsf@gitster.mtv.corp.google.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
        <20170514031513.9042-1-whydoubt@gmail.com>
        <20170514031513.9042-5-whydoubt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
Cancel-Lock: sha1:vg3gDS5NxSW65WS2oi3F7OjzVDg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> The origin and blame_entry structures are core to the blame interface
> and reference each other. Since origin will be more exposed, rename it
> to blame_origin to clarify what it is a part of.
>
> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
> ---
>  blame.h         |  86 ++++++++++++++++++++++++++
>  builtin/blame.c | 185 +++++++++++++++++---------------------------------------
>  2 files changed, 140 insertions(+), 131 deletions(-)
>  create mode 100644 blame.h
>
> diff --git a/blame.h b/blame.h
> new file mode 100644
> index 0000000..f52d0fc
> --- /dev/null
> +++ b/blame.h
> @@ -0,0 +1,86 @@
> +#ifndef BLAME_H
> +#define BLAME_H
> +
> +#include "cache.h"
> +#include "commit.h"
> +#include "xdiff-interface.h"
> +
> +/*
> + * One blob in a commit that is being suspected
> + */
> +struct blame_origin {
> +	int refcnt;
> +...
>   ...
> -/*
> - * One blob in a commit that is being suspected
> - */
> -struct origin {
> -	int refcnt;

I hate to say this AFTER you sent your second attempt, but could you
have another preparetory step before this patch, that does many
renames of symbols (e.g. s/origin/blame_origin/) and nothing else,
while the lines are still in builtin/blame.c?

To review a step like yoru 04/22 to make sure nothing else other
than moving the lines is going on, an easy way to do so is to run
"blame -C" on the resulting blame.h file---that lets the reviewers'
eyes coast over the lines that came from contiguous region of the
original builtin/blame.c and concentrate on things like what used to
be static to the file now getting extern.

If you rename symbols while moving lines across files, that becomes
impossible because many lines are now different (i.e. a line that
talked about "origin" in builtin/blame.c in the preimage may now
talk about "blame_origin" in blame.h, hence attributed to the
new commit's blame.h).

It may even be OK to do the "rename the symbols" step in a single
patch (e.g. your 04/22 and 05/22 are separate patches and the former
renames "origin" while the latter does "scoreboard"---I am saying
that the preparatory step that renames the symbols without
introducing the new "blame.h" may not have to have these two as
separate patches).

If rename of symbols are done first while the lines are still in the
original file, mechanical moving of lines gets much easier to
review.  Of course, a patch that only renames symbols is also much
easier to review, even if it is a large one.

Thanks.




