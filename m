Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E19C32771
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiIUWZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIUWZD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:25:03 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B582D3A
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:25:01 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E0561425EC;
        Wed, 21 Sep 2022 18:25:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j6m4M8klWjU4lOXNWN0+dEU+RI1NsHwlZ6YNlp
        Uvzi8=; b=Mx4hVeU9YWcIZWQ+0JFvVDutAdZ8OqFB2mzJ25tBvoU0iy9hw6prLm
        ZqEVvBZGSN5OxdvZwqK59g7xHhfiPHGGBGFf1IYzCq7kD4XGaVvlgmhhN1yJMA8P
        FONVDNkxAO+diQ4whb8/hB/OcbhfjDCWGLUf7CzGN5WHoeiAyFKgg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 723B71425E9;
        Wed, 21 Sep 2022 18:25:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDDB01425E7;
        Wed, 21 Sep 2022 18:24:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] merge-tree: fix segmentation fault in read-only
 repositories
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com>
        <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com>
Date:   Wed, 21 Sep 2022 15:24:58 -0700
In-Reply-To: <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 21 Sep 2022 22:08:03
        +0000")
Message-ID: <xmqqfsgk1i2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AB75476-39FC-11ED-B596-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +	const struct object_id *tree_oid;
>  
>  	parent1 = get_merge_parent(branch1);
>  	if (!parent1)
> @@ -446,7 +447,8 @@ static int real_merge(struct merge_tree_options *o,
>  	if (o->show_messages == -1)
>  		o->show_messages = !result.clean;
>  
> -	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
> +	tree_oid = result.tree ? &result.tree->object.oid : null_oid();
> +	printf("%s%c", oid_to_hex(tree_oid), line_termination);

As we are not using tree_oid anywhere else, it might be cleaner to
switch on result.tree more explicitly, especially given that the
return statement also uses result.tree to decide what exit status to
use, e.g.

	if (result.tree)
		fputs(oid_to_hex(&result.tree->object.oid), stdout);
	else
		fputs(oid_to_hex(null_oid()), stdout);
	fputc(line_termination, stdout);
	
but that is merely "might be cleaner".

> -	return !result.clean; /* result.clean < 0 handled above */
> +	return !result.tree || !result.clean; /* result.clean < 0 handled above */

The original returned 1 when we failed to cleanly merge and 0 when
we cleanly merged.  Now, if we failed to come up with a merged tree,
result.tree would be NULL and we return 1 from the function, because
we failed to cleanly merge.

OK.  These negations make my head spin X-<.

