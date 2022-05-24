Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CCDC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbiEXVZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiEXVZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:25:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BC37A80E
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:25:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8C2C18D391;
        Tue, 24 May 2022 17:25:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GNLY/ztrQfdY4kxRzxjNHrqogewei7CYIpM+OQ
        RA3Ls=; b=czTdqI7jtQA2llHsVR/joI6faWw4ysWZR02AwlroX/Wwg7+HX0tlOT
        Zrs6uKx+FKR3dHGuQmz/UrupiM5Uro0B82cpyEiZ3JBIY0sRHSkfadzmHWUot3K5
        Rf3yhW6/RbM/YeUGJLC+MMRYuJsGEH6o0HjKSqdx6C5CbV2NNIMEw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E107D18D390;
        Tue, 24 May 2022 17:25:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86C4618D38F;
        Tue, 24 May 2022 17:25:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Locke <kevin@kevinlocke.name>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4] setup: don't die if realpath(3) fails on getcwd(3)
References: <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
        <8b20840014d214023c50ee62439147f798e6f9cc.1653419993.git.kevin@kevinlocke.name>
Date:   Tue, 24 May 2022 14:25:22 -0700
In-Reply-To: <8b20840014d214023c50ee62439147f798e6f9cc.1653419993.git.kevin@kevinlocke.name>
        (Kevin Locke's message of "Tue, 24 May 2022 13:20:12 -0600")
Message-ID: <xmqqk0aafwsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 058BB5C4-DBA8-11EC-92BA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Locke <kevin@kevinlocke.name> writes:

>  	/* Normalize the directory */
> -	strbuf_realpath(&tmp, tmp_original_cwd, 1);
> +	if (!strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
> +		trace2_data_string("setup", the_repository,
> +				   "realpath-path", tmp_original_cwd);
> +		trace2_data_string("setup", the_repository,
> +				   "realpath-failure", strerror(errno));
> +		free((char*)tmp_original_cwd);
> +		tmp_original_cwd = NULL;
> +		return;
> +	}
> +
>  	free((char*)tmp_original_cwd);
>  	tmp_original_cwd = NULL;
>  	startup_info->original_cwd = strbuf_detach(&tmp, NULL);

It is somewhat sad that we cannot readily use FREE_AND_NULL() here.
If it casted away the constness (see the attached at the end), we
could have saved two lines from the above snippet.

The startup_info->original_cwd member is initialized to NULL, and
I think it is a safe assumption that it still is so when the control
reaches here.  Otherwise, the assignment of strbuf_detach() to it
without first freeing the current value we see in the post context
is leaking already.

So, overall this looks good to me.  Anybody else who have already
spent cycles to review this want to add Reviewed-by: to it?

Thanks.

diff --git i/git-compat-util.h w/git-compat-util.h
index 58fd813bd0..56c6c48461 100644
--- i/git-compat-util.h
+++ w/git-compat-util.h
@@ -976,7 +976,7 @@ int xstrncmpz(const char *s, const char *t, size_t len);
  * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
  * that ptr is used twice, so don't pass e.g. ptr++.
  */
-#define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
+#define FREE_AND_NULL(p) do { free((void*)p); (p) = NULL; } while (0)
 
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
