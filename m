Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BB8C56202
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5234B20721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mR8qoNd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgKWXpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:45:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55654 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgKWXps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:45:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 78B9810A889;
        Mon, 23 Nov 2020 18:45:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UeQFsDYjZxl5VK9YNhKHmT8H7/8=; b=mR8qoN
        d+PN+bICjPZQwELNG1GUONKc0qNkWxqpuuN+QoEbTcbyz4BMttQX2TZmELjaHlgM
        po2oSXTillKXfooi2FzhQSE7pwd2mSYI2nP/NO1LaCNXpeo54Q8X6ovIhm987mct
        apKWLLFHL93Arc++38zq13hp8Ll+iBJ89n2Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HPfokV0EMQAEcgR7LmD79qDMWYXX8Tdq
        op98AkK+A/fX12vRMuwuM5WlDZNN8iw2QQJSaDmpgpaYpj7zwNcgFpbVTC475xef
        GlzESPqJAf58XVQ2HvIf/uEuT8flvzjpLXGrIvmMs3hYNlR8slWobxFhOr/aq1yJ
        RkbIDaI+Kf8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70E4810A888;
        Mon, 23 Nov 2020 18:45:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B87EE10A886;
        Mon, 23 Nov 2020 18:45:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/4] branch -m: allow renaming a yet-unborn branch
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
        <8de0c0eb228c8d9608d3a78c992cbd6829cb9329.1606173607.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 15:45:41 -0800
In-Reply-To: <8de0c0eb228c8d9608d3a78c992cbd6829cb9329.1606173607.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 23 Nov 2020
        23:20:05 +0000")
Message-ID: <xmqqd003ljru.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 006B8540-2DE6-11EB-A371-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -538,7 +538,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
>  			    oldref.buf, newref.buf);
>  
> -	if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
> +	if (!copy && (oldname != head || !is_null_oid(&head_oid)) &&

It always makes readers uneasy to see pointer comparison of two
strings.  

Does this mean, after "git -c init.defaultbranch=master init",

	git branch -m master main

would not work while

	git branch -m main

would?  It would be easy to see with the attached patch to the test,
I guess.

> +	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
>  		die(_("Branch rename failed"));
>  	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
>  		die(_("Branch copy failed"));
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 69a320489f..69c5ad179c 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -571,4 +571,10 @@ test_expect_success 'invalid default branch name' '
>  	test_i18ngrep "invalid branch name" err
>  '
>  
> +test_expect_success 'branch -m with the initial branch' '
> +	git init rename-initial-branch &&
> +	git -C rename-initial-branch branch -m renamed &&
> +	test renamed = $(git -C rename-initial-branch symbolic-ref --short HEAD)
> +'
> +
>  test_done

Thanks.


 t/t0001-init.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git c/t/t0001-init.sh w/t/t0001-init.sh
index 69c5ad179c..07c34431d9 100755
--- c/t/t0001-init.sh
+++ w/t/t0001-init.sh
@@ -577,4 +577,10 @@ test_expect_success 'branch -m with the initial branch' '
 	test renamed = $(git -C rename-initial-branch symbolic-ref --short HEAD)
 '
 
+test_expect_success 'branch -m with the initial branch' '
+	git -c init.defaultBranch=initial init rename-unborn-branch &&
+	git -C rename-unborn-branch branch -m initial renamed &&
+	test renamed = $(git -C rename-unborn-branch symbolic-ref --short HEAD)
+'
+
 test_done
