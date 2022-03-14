Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C8AC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 20:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiCNUfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiCNUfT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 16:35:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5766C193FF
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 13:34:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C63F81888F2;
        Mon, 14 Mar 2022 16:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5WClgZ9h92cI9rIKLAbpk8tBpvWbNj8PpC+HDb
        qgZek=; b=qrB2BmxBxVGVgbM5CSv3vKo3flH7gfa36t+xmQ177sJbaOfKrqrf92
        R3Foov07JHMtcMP1n8dp42m2dgo0nfvpeLf5aFGZbRN7CJcNSzuy5q3ipfSquz1H
        5SB6pq4QHunr0+snhAmBJNjcZ33FJ5NaeNhJ6a5G7Xuvxgz+bM558=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBFE91888F1;
        Mon, 14 Mar 2022 16:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 298B81888F0;
        Mon, 14 Mar 2022 16:34:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/9] sparse-checkout: make --cone the default
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <a53179764bc5d411726a095a587ea728aa9a20d3.1647054681.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 20:34:04 +0000
In-Reply-To: <a53179764bc5d411726a095a587ea728aa9a20d3.1647054681.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 12 Mar 2022
        03:11:14 +0000")
Message-ID: <xmqq8rtcqnnn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 175BD626-A3D6-11EC-9AD2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  The subset of files is chosen by providing a list of directories in
> -cone mode (which is recommended), or by providing a list of patterns
> -in non-cone mode.
> +cone mode (the default), or by providing a list of patterns in
> +non-cone mode.

OK.

> @@ -60,7 +60,7 @@ When the `--stdin` option is provided, the directories or patterns are
>  read from standard in as a newline-delimited list instead of from the
>  arguments.
>  +
> -When `--cone` is passed or `core.sparseCheckoutCone` is enabled, the
> +When `--cone` is passed or `core.sparseCheckoutCone` is not false, the
>  input list is considered a list of directories.  This allows for


I expected a change to Documentation/config/core.txt in this step,
because the default value for core.sparseCheckoutCone becomes true
if unspecified with this step, and the normal expectation by the
readers is what is not explicitly set to true is either 'false' or
'unspecified' (when 'unspecified' has its own meaning, like in
gitattributes).

Something like this?

diff --git i/Documentation/config/core.txt w/Documentation/config/core.txt
index c04f62a54a..03cf075821 100644
--- i/Documentation/config/core.txt
+++ w/Documentation/config/core.txt
@@ -615,8 +615,10 @@ core.sparseCheckout::
 
 core.sparseCheckoutCone::
 	Enables the "cone mode" of the sparse checkout feature. When the
-	sparse-checkout file contains a limited set of patterns, then this
-	mode provides significant performance advantages. See
+	sparse-checkout file contains a limited set of patterns, this
+	mode provides significant performance advantages. The "non
+	cone mode" can be requested to allow specifying a more flexible
+	patterns by setting this variable to 'false'. See
 	linkgit:git-sparse-checkout[1] for more information.
 
 core.abbrev::

> -When `--no-cone` is passed or `core.sparseCheckoutCone` is not enabled,
> +When `--no-cone` is passed or `core.sparseCheckoutCone` is false,

"is set to 'false'" would make it clearer.

> +If `core.sparseCheckoutCone=true` (set by default or with an explicit
> +`--cone`), then Git will parse the sparse-checkout file expecting

"Unless `core.sparseCheckoutCone` is explicitly set to `false`"
might be clearer, but I am not sure.  It is just that I found the
phrase "set by default" confusing.

>  	/* Set cone/non-cone mode appropriately */
>  	core_apply_sparse_checkout = 1;
> -	if (*cone_mode == 1) {
> +	if (*cone_mode) { /* also handles "not specified" (value of -1) */

The comment is correct, but if we can make the code not to require
such a comment, that would be even better.  Are there very small
number of choke points where we always pass, after parsing
configuration variables and options, that we ought to know which
mode to use before the control comes here, and commit the choice
with "if (cone_mode < 0) cone_mode = 1"?

We see beyond precontext of this hunk an assignment to *cone_mode to
tell the choice we made to our caller.  Shouldn't we be doing the
same in this if/else that still assumes we can get "undecided"?

>  		mode = MODE_CONE_PATTERNS;
>  		core_sparse_checkout_cone = 1;
>  	} else {
