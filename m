Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E68EC433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 05:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiDNFSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 01:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiDNFSi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 01:18:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971EE237E6
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 22:16:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB82E19F49C;
        Thu, 14 Apr 2022 01:16:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qFLo077klmPk2e5bN+fRNN+FkwMdvzk8f99OHQ
        ba160=; b=tRCxc3XWjErK0mKgmA3v9riRLR2Mk/8Wjfsh4u15Ur6e+0bz5MaZZp
        HVRansEyNyhheKY8TQk+1AH8aaQuMeZMOQhuuA9OcFJ0K8I41NHAc9CtEd/jFU/Y
        Muo2S8/3n2TfKBp28aP/sLvEeYPmpSuvVYrqGB5l7nbX8Je7cXyKE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B766119F49B;
        Thu, 14 Apr 2022 01:16:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9845819F49A;
        Thu, 14 Apr 2022 01:16:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] Makefile: add a prerequisite to the coverage-report
 target
References: <20220414022513.31465-1-gitter.spiros@gmail.com>
Date:   Wed, 13 Apr 2022 22:16:10 -0700
In-Reply-To: <20220414022513.31465-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Thu, 14 Apr 2022 02:25:13 +0000")
Message-ID: <xmqqlew82qjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFC55390-BBB1-11EC-A2DB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> @@ -3421,13 +3422,18 @@ coverage-compile:
>  coverage-test: coverage-clean-results coverage-compile
>  	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
>  		DEFAULT_TEST_TARGET=test -j1 test
> +	touch coverage-test.made
> +
> +coverage-test.made:
> +	@make coverage-test
> +	touch coverage-test.made

As this target runs "$(MAKE) coverage-test", at the end of which the
.made file is touched anyway, I wonder if we need the second line
here.

I just tried to run this sequence:

    $ make distclean
    $ make coverage-report
    $ make coverage-report
    $ make coverage-test

without the "touch" in the recipe for the coverage-test.made target,
and it behaved as I expected them to, i.e.

    * got an pristine tree
    * built, ran tests and showed report
    * showed report without building or running testing
    * cleared the gcov files, ran tests and showed report

So, perhaps this patch on top?

Thanks.

 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git i/Makefile w/Makefile
index fa8cc86276..72ae7fa886 100644
--- i/Makefile
+++ w/Makefile
@@ -3416,8 +3416,7 @@ coverage-test: coverage-clean-results coverage-compile
 	touch coverage-test.made
 
 coverage-test.made:
-	@make coverage-test
-	touch coverage-test.made
+	$(MAKE) coverage-test
 
 coverage-prove: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \

