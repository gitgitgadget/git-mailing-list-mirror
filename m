Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8372EC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 23:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiBHXnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiBHXnc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 18:43:32 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA63C06157B
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 15:43:32 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DF09106678;
        Tue,  8 Feb 2022 18:43:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0WvovWQAg8MN5ZukbDCwpCEBVe947fItARFOvs
        HO+cU=; b=L9eOcIMExH+rJB5OfibZNRxQ5VxqgctyXtrSBEImKWKZR/7ntWdp2K
        A0Lka504wR4o4SGJ2E0MULMfPlIMSXDOVZWgMEacvsJ4QG/qRFIMXhA8YiHAExe2
        fKkaVK+ahyFA8o2AKBMNE0GJDAWCXvrpqmKUDz0clYwufn/8TNgYM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33280106677;
        Tue,  8 Feb 2022 18:43:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85C15106676;
        Tue,  8 Feb 2022 18:43:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 2/3] cat-file: introduce batch_command enum to
 replace print_contents
References: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
        <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
        <ae2dfa512a760446bf6d40c456cb4126e952db98.1644353884.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 15:43:29 -0800
In-Reply-To: <ae2dfa512a760446bf6d40c456cb4126e952db98.1644353884.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Tue, 08 Feb 2022 20:58:03
        +0000")
Message-ID: <xmqqk0e4c4bi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB9BA064-8938-11EC-BF44-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +enum batch_command {
> +	BATCH_COMMAND_CONTENTS,
> +	BATCH_COMMAND_INFO,
> +};
> +
>  struct batch_options {
>  	int enabled;
>  	int follow_symlinks;
> -	int print_contents;
> +	enum batch_command command_mode;
>  	int buffer_output;
>  	int all_objects;
>  	int unordered;
> @@ -386,7 +391,7 @@ static void batch_object_write(const char *obj_name,
>  	strbuf_addch(scratch, '\n');
>  	batch_write(opt, scratch->buf, scratch->len);
>  
> -	if (opt->print_contents) {
> +	if (opt->command_mode == BATCH_COMMAND_CONTENTS) {
>  		print_object_or_die(opt, data);
>  		batch_write(opt, "\n", 1);
>  	}

Nice.

> @@ -536,7 +541,7 @@ static int batch_objects(struct batch_options *opt)
>  	 * If we are printing out the object, then always fill in the type,
>  	 * since we will want to decide whether or not to stream.
>  	 */
> -	if (opt->print_contents)
> +	if (opt->command_mode == BATCH_COMMAND_CONTENTS)
>  		data.info.typep = &data.type;
>  
>  	if (opt->all_objects) {
> @@ -635,7 +640,12 @@ static int batch_option_callback(const struct option *opt,
>  	}
>  
>  	bo->enabled = 1;
> -	bo->print_contents = !strcmp(opt->long_name, "batch");
> +
> +	if (!strcmp(opt->long_name, "batch"))
> +		bo->command_mode = BATCH_COMMAND_CONTENTS;
> +	if (!strcmp(opt->long_name, "batch-check"))
> +		bo->command_mode = BATCH_COMMAND_INFO;

This may want to become if / else if / else cascade, whose last
"else" clause would say

	BUG("%s given to batch-option-callback", opt->long_name);

perhaps, but it is so minor that there is no need to reroll only for
this.

Looking good.
