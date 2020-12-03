Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F174C71155
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F6321741
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 00:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgLCAwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 19:52:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62735 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgLCAwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 19:52:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01DCDF00C4;
        Wed,  2 Dec 2020 19:51:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6q10gv8g1LGGJK6ghfn5vXca/2M=; b=UmWC23
        Yk3l5CJDw4aE5TZqKvGaTnnn3L84NAhpNCMaSQ2MpnNmL+W6c+mpuTIS5d+oNuSQ
        UaMhi0vZvT5KF/D58O8o2mQ1tqcXj9yiw6hc76LyOl0drUZ8uTyaDrgsZVImvVYR
        plGG1SXdiXUd72Wt0xAF6I6miw20ZwfWvOMkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=avJ+aoz9nzzTQIttqzedPEcZjSKljAqZ
        fDzbTBT9NG/I0boxc8vraMkWis6670Jf0Lv7Yb8zN5Y38gzkk1JO08rFycQWUZeE
        uTD/9jJx+k/P4QV5rXRhEftwGpuTonYYqznE24TY+rcf8GH9pwN4mIoeKUZVo1np
        WFiEWVAxkKo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFC8BF00C1;
        Wed,  2 Dec 2020 19:51:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 42487F00BA;
        Wed,  2 Dec 2020 19:51:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 04/27] revision: provide implementation for diff
 merges tweaks
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-5-sorganov@gmail.com>
Date:   Wed, 02 Dec 2020 16:51:16 -0800
In-Reply-To: <20201108213838.4880-5-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 9 Nov 2020 00:38:15 +0300")
Message-ID: <xmqqim9jk8zf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A74AAB94-3501-11EB-84F6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> -	if (rev->ignore_merges < 0) {
> -		/* There was no "-m" variant on the command line */
> -		rev->ignore_merges = 0;
> -		if (!rev->first_parent_only && !rev->combine_merges) {
> -			/* No "--first-parent", "-c", or "--cc" */
> -			rev->combine_merges = 1;
> -			rev->dense_combined_merges = 1;
> -		}
> -	}
> +	rev_diff_merges_default_to_dense_combined(rev);

The name makes sense.  "Unless otherwise specified, we do not ignore
merges.  Further, when we are not doing first-parent traversal,
default to dense combined merges, unless told otherwise" is what the
code says, and the name of the helper captures it well.

> @@ -731,8 +723,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
>  	if (!rev->diffopt.output_format && rev->combine_merges)
>  		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
>  
> -	if (rev->first_parent_only && rev->ignore_merges < 0)
> -		rev->ignore_merges = 0;
> +	rev_diff_merges_first_parent_defaults_to_enable(rev);

This on the other hand is not so great a name.  "When we are doing
first-parent traversal, do not exclude merge commits from being
shown" is what log_setup_revisions_tweak() does here.  "default to
enable" is not clear at all what we are enabling.

Is your naming convention that "rev_diff_" is the common prefix?
What's the significance of "_diff" part?  After all, these are about
tweaking the setting in the rev_info structure, so how about

	revinfo_show_merges_in_dense_combined_by_default(rev);
	revinfo_show_merges_by_default_with_first_parent(rev);

perhaps, using just "revinfo_" as the common prefix?
