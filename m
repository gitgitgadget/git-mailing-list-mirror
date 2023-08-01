Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65858C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 17:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjHARYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjHARYO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 13:24:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342952D55
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 10:23:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4385D18C781;
        Tue,  1 Aug 2023 13:23:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6v0JDKYsRghyUva6uz9WIKHis804lQY/8UlvLc
        SsdWc=; b=J1rmZv/X7No4pTIJS7SLeOffvv+WH6R1+vuQeazbEkj1oYMEgnZ8R4
        9w4MZMMaLaXCJKNAXWNX1X1iZz7mGAJ1EOukCfqgnQXnHuNpPWMxRm1lHmOW301d
        AI4hNDQrb/t0Bve7KqpoEni1pAFXbiT9zce+ViG9elRhTGf/9FlrQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39D7118C780;
        Tue,  1 Aug 2023 13:23:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7913818C77F;
        Tue,  1 Aug 2023 13:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 3/7] sequencer: use rebase_path_message()
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <8f6c0e4056742951ce84acbdb07b0518f7607b2a.1690903412.git.gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 10:23:26 -0700
In-Reply-To: <8f6c0e4056742951ce84acbdb07b0518f7607b2a.1690903412.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Tue, 01 Aug 2023 15:23:28
        +0000")
Message-ID: <xmqq4jlid6cx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2094DF24-3090-11EE-A40F-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Rather than constructing the path in a struct strbuf use the ready
> made function to get the path name instead. This was the last
> remaining use of the strbuf so remove it as well.

The same comment about "get_dir() vs hardcoded rebase-merge" applies
here, I think.  And the same (1) assertion to ensure that we are in
"rebase -i" when make_patch() is called should give us a sufficient
safety valve, or (2) instead of hardcoding rebase_path_message(),
call it sequencer_path_message() and switch at runtime behaving the
same way as get_dir(opts) based version, would also work.

Thanks.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 70b0a7023b0..dbddd19b2c2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3501,7 +3501,6 @@ static int make_patch(struct repository *r,
>  		      struct commit *commit,
>  		      struct replay_opts *opts)
>  {
> -	struct strbuf buf = STRBUF_INIT;
>  	struct rev_info log_tree_opt;
>  	const char *subject;
>  	char hex[GIT_MAX_HEXSZ + 1];
> @@ -3529,18 +3528,16 @@ static int make_patch(struct repository *r,
>  		fclose(log_tree_opt.diffopt.file);
>  	}
>  
> -	strbuf_addf(&buf, "%s/message", get_dir(opts));
> -	if (!file_exists(buf.buf)) {
> +	if (!file_exists(rebase_path_message())) {
>  		const char *encoding = get_commit_output_encoding();
>  		const char *commit_buffer = repo_logmsg_reencode(r,
>  								 commit, NULL,
>  								 encoding);
>  		find_commit_subject(commit_buffer, &subject);
> -		res |= write_message(subject, strlen(subject), buf.buf, 1);
> +		res |= write_message(subject, strlen(subject), rebase_path_message(), 1);
>  		repo_unuse_commit_buffer(r, commit,
>  					 commit_buffer);
>  	}
> -	strbuf_release(&buf);
>  	release_revisions(&log_tree_opt);
>  
>  	return res;
