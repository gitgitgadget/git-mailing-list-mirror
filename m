Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB8C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 21:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbiCaVbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 17:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiCaVbf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 17:31:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DE31C1EEF
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 14:29:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5616B18724C;
        Thu, 31 Mar 2022 17:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MTikUSNZGxbq6ikJoUXaBClLlnEhLDrRBBgBTv
        g36rg=; b=m16HlS5WlDlLCKkahMpfscGR9LZQ72eGgl7vWFthrAsd6UtIJF1QDX
        I56yK5ovbtnDDMxWMaD+6k8U6PEIYq/cSD/T2/L5yvawCTbrdIQWKFOJ3hQzp0+V
        awt3zg9LMriEx/AIV9EBnsH+J6Z+iX4y1kzW2TNsdfp0/AKLcmjFU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5087F18724B;
        Thu, 31 Mar 2022 17:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 92E7118724A;
        Thu, 31 Mar 2022 17:29:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Garrit Franke <garrit@slashdev.space>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bisect.c: remove unused includes
References: <20220331194436.58005-1-garrit@slashdev.space>
Date:   Thu, 31 Mar 2022 14:29:42 -0700
In-Reply-To: <20220331194436.58005-1-garrit@slashdev.space> (Garrit Franke's
        message of "Thu, 31 Mar 2022 21:44:36 +0200")
Message-ID: <xmqqlewpzu7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE3D91FE-B139-11EC-8015-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garrit Franke <garrit@slashdev.space> writes:

> Clean up includes no longer needed by bisect.c.
>
> Signed-off-by: Garrit Franke <garrit@slashdev.space>
> ---
>  bisect.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 9e6a2b7f20..e07e2d215d 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -1,21 +1,12 @@
> -#include "cache.h"

cf. Documentation/CodingGuidelines

The first #include must be <git-compat-util.h>, or <cache.h> or
<builtin.h>, which are well known to include <git-compat-util.h>
first.

Including <git-compat-util.h> indirectly by <config.h> ->
<hashmap.h> -> <hash.h> -> <git-compat-util.h> does not count.

>  #include "config.h"
> -#include "commit.h"

Other headers may indirectly include <commit.h> as their
implementation detail, but what matters is that *we* in this source
file use what <commit.h> gives us ourselves, like the concrete shape
of "struct commit_list".  This change is not wanted.

I'll stop here.  There may be truly leftover "unused" includes among
those removed by the remainder of this patch, but I suspect that
some are like <commit.h> above, i.e. we directly use it, and because
we do not want to be broken by some header file's implementation
detail changing, we MUST include it ourselves.

I think this should give us a useful guideline to sift through the
rest, and an updated patch to remove truly unused ones are very much
welcome.  We may actually find some we are not directly including
ourselves but we should (e.g. I do not see <string-list.h> included
by us, but we clearly use structures and functions declared there,
and probably is depending, wrongly, on some header file we include
happens to indirectly include it).

Thanks.

> -#include "diff.h"
> -#include "revision.h"
>  #include "refs.h"
>  #include "list-objects.h"
>  #include "quote.h"
> -#include "hash-lookup.h"
>  #include "run-command.h"
>  #include "log-tree.h"
>  #include "bisect.h"
> -#include "oid-array.h"
> -#include "strvec.h"
> -#include "commit-slab.h"
>  #include "commit-reach.h"
>  #include "object-store.h"
> -#include "dir.h"
>  
>  static struct oid_array good_revs;
>  static struct oid_array skipped_revs;
