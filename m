Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3940BC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 21:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIZVzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIZVzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 17:55:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D46E6052F
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 14:55:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9B33144E89;
        Mon, 26 Sep 2022 17:55:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6CKKmbILecGnxaiNCENr9KJNpwuIl1fbjytlYT
        Mso6g=; b=Jcj9h/CtnxtrbZhqD1hUGfboUcU7gWYSt9ExpZrFvywoSQCWrUnOzj
        l2Q1r9rrdmFRp6plM7xm+lxjmnKyneIAL48B4ilPo0pDAgG4q+Pb0PvbXwq1BE+I
        JETsFs8/FcntwD3mUQvtqK3K1ByWzabQMS2wDU0CB+U2B28qxNnbo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B04CA144E88;
        Mon, 26 Sep 2022 17:55:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C5AD144E87;
        Mon, 26 Sep 2022 17:55:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 1/3] maintenance: add 'unregister --force'
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
        <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
        <8a8bffaec89e55da0c5bcac2f04331e0d4e69790.1664218087.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 14:55:39 -0700
In-Reply-To: <8a8bffaec89e55da0c5bcac2f04331e0d4e69790.1664218087.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 26 Sep 2022
        18:48:04 +0000")
Message-ID: <xmqqa66lby1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6894032-3DE5-11ED-9FB7-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1538,11 +1546,23 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>  		usage_with_options(builtin_maintenance_unregister_usage,
>  				   options);
>  
> -	config_unset.git_cmd = 1;
> -	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
> -		     "--fixed-value", "maintenance.repo", maintpath, NULL);
> +	for_each_string_list_item(item, list) {
> +		if (!strcmp(maintpath, item->string)) {
> +			found = 1;
> +			break;
> +		}
> +	}

Just out of curiosity, I ran this in a fresh repository and got a
segfault.  An attached patch obviously fixes it, but I am wondering
if a better "fix" is to teach for_each_string_list_item() that it is
perfectly reasonable to see a NULL passed to it as the list, which
is a mere special case that the caller has a string list with 0
items on it.

Thoughts?

Thanks.



diff --git a/builtin/gc.c b/builtin/gc.c
index 4c59235950..67f41fad4b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1549,6 +1549,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
+	if (list)
 	for_each_string_list_item(item, list) {
 		if (!strcmp(maintpath, item->string)) {
 			found = 1;
-- 
2.38.0-rc1-123-g02867222b8

