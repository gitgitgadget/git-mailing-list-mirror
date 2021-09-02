Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A98C433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 21:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433E1610A1
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 21:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347069AbhIBVpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 17:45:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59578 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245379AbhIBVp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 17:45:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCD53152EE1;
        Thu,  2 Sep 2021 17:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PIH0ZkTefvW3ErJ6FBhD23REQLX8t4lZ7zuthQ
        ZeFx8=; b=eJCsg+8ilfNw9Ra2Vgrsfdiw7qjgFyILkTIJxGnckckAmEwzKs/29N
        3DSi1ekq9RJBSb9M/Sg+viQUUlrXCcj7iPPGBAhoom0ZraEwYYgFS8n/3ttk9eyY
        4GUfSqH6riRClfSZot1CXpmtpZgXwDeRrPq68GhBca95hvrO06DpA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6340152EDF;
        Thu,  2 Sep 2021 17:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6839B152EDE;
        Thu,  2 Sep 2021 17:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 1/6] t6030-bisect-porcelain: add tests to control
 bisect run exit cases
References: <20210902090421.93113-1-mirucam@gmail.com>
        <20210902090421.93113-2-mirucam@gmail.com>
Date:   Thu, 02 Sep 2021 14:44:24 -0700
In-Reply-To: <20210902090421.93113-2-mirucam@gmail.com> (Miriam Rubio's
        message of "Thu, 2 Sep 2021 11:04:16 +0200")
Message-ID: <xmqqv93iirev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1B2BC1E-0C36-11EC-A354-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> There is a gap on bisect run test coverage related with error exits.
> Add two tests to control these error cases.
>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  t/t6030-bisect-porcelain.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index a1baf4e451..e61b8143fd 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -962,4 +962,15 @@ test_expect_success 'bisect handles annotated tags' '
>  	grep "$bad is the first bad commit" output
>  '
>  
> +test_expect_success 'bisect run fails with exit code equals or greater than 128' '
> +	write_script test_script.sh <<-\EOF &&
> +	exit 128 >/dev/null
> +	EOF
> +	test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt &&
> +	write_script test_script.sh <<-\EOF &&
> +	exit 255 >/dev/null
> +	EOF
> +	test_must_fail git bisect run ./test_script.sh >> my_bisect_log.txt
> +'

Two and a half glitches.

 * It is not obvious why you need to redirect output from "exit" to
   /dev/null; drop them or explain the reason in the proposed log
   message, perhaps.

 * The contents of my_bisect_log.txt is never inspected.  If it does
   not matter how the command fails, not inspecting is perfectly OK,
   but then perhaps not capturing it is the right thing to do?  We
   do not even want to redirect the output to /dev/null, as the
   output from the commands run in these test pieces will not be
   shown unless the test scripts are run under an option for
   debugging purposes.

 * Style: no space after ">" or ">>" before my_bisect_log.txt

Thanks.
