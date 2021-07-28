Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F68C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 04:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A670860C3F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 04:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhG1E3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 00:29:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50953 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhG1E3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 00:29:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F0B3B1396EF;
        Wed, 28 Jul 2021 00:29:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TJw5QhOK2XixHkrFLxl9cNKP4qcms9qgAbPZff
        6G9OE=; b=S/Rl0RJ0Px/dlgoR/jp2vzFukVNX2w43zVA1uUPA49y3gqcibMS6wb
        8bEpjQXGZAKHY+4usny/ILEz23w9Mwuim+/vUMBrOSXiYVYCU34S0hkEzq+J/XOw
        zEWes9/MrKRbQZGRKN9Ub2EpLi91f4kFh8+eF213knXUPGp05E51Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E9FD81396EE;
        Wed, 28 Jul 2021 00:29:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B38D1396ED;
        Wed, 28 Jul 2021 00:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, lilinchao@oschina.cn
Subject: Re: [PATCH] git-apply: fix --3way with binary patch
References: <20210728024434.20230-1-jerry@skydio.com>
Date:   Tue, 27 Jul 2021 21:29:04 -0700
In-Reply-To: <20210728024434.20230-1-jerry@skydio.com> (Jerry Zhang's message
        of "Tue, 27 Jul 2021 19:44:34 -0700")
Message-ID: <xmqqim0vawof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 584FC4AA-EF5C-11EB-B047-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> index 65147efdea..d32748f899 100755
> --- a/t/t4108-apply-threeway.sh
> +++ b/t/t4108-apply-threeway.sh
> @@ -230,4 +230,49 @@ test_expect_success 'apply with --3way --cached and conflicts' '
>  	test_cmp expect.diff actual.diff
>  '
>  
> +test_expect_success 'apply binary file patch' '
> +	git reset --hard main &&
> +	cp $TEST_DIRECTORY/test-binary-1.png bin.png &&

Is it safe to use $TEST_DIRECTORY without quoting?  I doubt it, as
it is $(pwd) of whereever the testing user extracted our source
tarball.  

In other words, you'd need this.

diff --git w/t/t4108-apply-threeway.sh c/t/t4108-apply-threeway.sh
index d32748f899..cc3aa3314a 100755
--- w/t/t4108-apply-threeway.sh
+++ c/t/t4108-apply-threeway.sh
@@ -232,11 +232,11 @@ test_expect_success 'apply with --3way --cached and conflicts' '
 
 test_expect_success 'apply binary file patch' '
 	git reset --hard main &&
-	cp $TEST_DIRECTORY/test-binary-1.png bin.png &&
+	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
 	git add bin.png &&
 	git commit -m "add binary file" &&
 
-	cp $TEST_DIRECTORY/test-binary-2.png bin.png &&
+	cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
 
 	git diff --binary >bin.diff &&
 	git reset --hard &&
@@ -247,11 +247,11 @@ test_expect_success 'apply binary file patch' '
 
 test_expect_success 'apply binary file patch with 3way' '
 	git reset --hard main &&
-	cp $TEST_DIRECTORY/test-binary-1.png bin.png &&
+	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
 	git add bin.png &&
 	git commit -m "add binary file" &&
 
-	cp $TEST_DIRECTORY/test-binary-2.png bin.png &&
+	cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
 
 	git diff --binary >bin.diff &&
 	git reset --hard &&
@@ -262,11 +262,11 @@ test_expect_success 'apply binary file patch with 3way' '
 
 test_expect_success 'apply full-index patch with 3way' '
 	git reset --hard main &&
-	cp $TEST_DIRECTORY/test-binary-1.png bin.png &&
+	cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
 	git add bin.png &&
 	git commit -m "add binary file" &&
 
-	cp $TEST_DIRECTORY/test-binary-2.png bin.png &&
+	cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
 
 	git diff --full-index >bin.diff &&
 	git reset --hard &&
