Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99089EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 23:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGTXKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 19:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTXKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 19:10:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B02D4B
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 16:10:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15E48190ADA;
        Thu, 20 Jul 2023 19:10:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tRt9VxN9/2dGVSwK7S4PAgtzKMugPSbhEN3snJ
        pdYF8=; b=d9iBNZ6Hp9+o7Oh2eV42tvJnS52YUhGMJ7IHc37Ki+qiM6gmhuoQVg
        a5P7XmzgZXGddw6ctawRpFy/p0n9sZMlSwyb+zPnFt7HUo45lmsdJ3psmbDJclRu
        lLcZJ7yzwL4bz+vhlbXpwDW/10ZKxKh+0hU3l/ksfDhOfF389PZ4A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DC65190AD7;
        Thu, 20 Jul 2023 19:10:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4537B190AD6;
        Thu, 20 Jul 2023 19:10:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 0/2] Add new "describe" atom
References: <20230714194249.66862-1-five231003@gmail.com>
        <20230719162424.70781-1-five231003@gmail.com>
        <xmqqr0p219ib.fsf@gitster.g>
Date:   Thu, 20 Jul 2023 16:10:09 -0700
In-Reply-To: <xmqqr0p219ib.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        20 Jul 2023 15:52:12 -0700")
Message-ID: <xmqqjzuu18oe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93A5C84E-2752-11EE-97FD-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The linux-gcc job is where we force the initial branch name to be
> 'main' and not 'master', so if your tests assume that the initial &
> primary branch name is 'master', that may be something you need to
> fix.

Perhaps something along the line of the attached patch?

The primary test repository t6300 uses is aware of the "problem"
where the tester may set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
to 'main' and hacks it around by using

	git branch -M main

as one of the first things it does, to _force_ the primary branch
name always to 'main', whether the tester's environment forces "git"
to start with 'main' or 'master', and existing tests in the script
relies on 'main' being the primary branch.

But your tests are done in a repository newly created with your own
"git init", so depending on the tester's environment, the primary
branch may be 'master' or 'main'.  The way your new tests are
written, however, things will fail if "refs/heads/master" is not the
primary branch.


 t/t6300-for-each-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/t/t6300-for-each-ref.sh w/t/t6300-for-each-ref.sh
index 4bbba76874..489f4d9186 100755
--- c/t/t6300-for-each-ref.sh
+++ w/t/t6300-for-each-ref.sh
@@ -563,7 +563,7 @@ test_expect_success 'color.ui=always does not override tty check' '
 '
 
 test_expect_success 'setup for describe atom tests' '
-	git init describe-repo &&
+	git init -b master describe-repo &&
 	(
 		cd describe-repo &&
 
