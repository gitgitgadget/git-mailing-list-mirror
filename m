Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C1DC04FDF
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjHJQO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjHJQOW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:14:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB392720
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:14:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 602C11C840;
        Thu, 10 Aug 2023 12:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CXaPAvkB6mOyM9ucVoX7eUGsW7bfyex5dAe6xq
        oNduM=; b=W9u9D/I9ZQ5bGgssLQHXdsKJW8zz3DijiaDkFbXkUTFgq8+FoH54ei
        76EsVkbCQ6EMSN34sylS/AUvQI9qHxbaeTkXrhE9m7Aa+q9pBPXn2yaSXIC/9H5Y
        TecusmdIOqinwMAjZbtVqdeZ5/ffBxe3aNJy+VB0bpU38Wc++MBUA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58E7A1C83E;
        Thu, 10 Aug 2023 12:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9724C1C83D;
        Thu, 10 Aug 2023 12:14:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] upload-pack: fix race condition in error messages
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 09:14:16 -0700
In-Reply-To: <pull.1572.git.1691678450757.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Thu, 10 Aug 2023 14:40:50
        +0000")
Message-ID: <xmqqy1iig9if.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4C7B49C-3798-11EE-9B02-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> To reduce the risk of this failure, follow this process instead:
>
> 1. Write an error message to stderr.
> 2. Write an error message across the connection.
> 3. exit(1).
>
> This reorders the events so the error is written entirely before
> the client receives a message from the remote, removing the race
> condition.

Makes sense.  error() eventually goes to our own vreportf() that
flushes, so by the time the call returns, our message should be
already out, and the other message has no chance to be mixed with
it.

Will queue.  Thanks.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     upload-pack: fix race condition in error messages
>     
>     Here is another quick patch that we've been holding in the microsoft/git
>     fork for years because it helped prevent some test flakiness, especially
>     in our more involved functional test environment.
>     
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1572%2Fderrickstolee%2Fupload-pack-race-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1572/derrickstolee/upload-pack-race-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1572
>
>  upload-pack.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 94751477ab2..7b25129f0f6 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -801,11 +801,12 @@ error:
>  	for (i = 0; i < data->want_obj.nr; i++) {
>  		struct object *o = data->want_obj.objects[i].item;
>  		if (!is_our_ref(o, data->allow_uor)) {
> +			error("git upload-pack: not our ref %s",
> +			      oid_to_hex(&o->oid));
>  			packet_writer_error(&data->writer,
>  					    "upload-pack: not our ref %s",
>  					    oid_to_hex(&o->oid));
> -			die("git upload-pack: not our ref %s",
> -			    oid_to_hex(&o->oid));
> +			exit(1);
>  		}
>  	}
>  }
>
> base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
