Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9ACC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 10:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347033AbiCOKZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347006AbiCOKZI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 06:25:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A7134BA0
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:23:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1757118C7D;
        Tue, 15 Mar 2022 06:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=wTWcKWSuaV6g/kbVMEj0r6VRwVUVkZjT4XfqJaw7sWA=; b=yeNS
        BNbFHLYQYMK7caVIeezj0rr7oejQCg5jOdcLVWMNaMzF7TINovIzryNS1jfPfJ85
        vOFdp+pkbB1vRLLszH+QrsZKMjKPxMVFK03rIxvP8FnPGrNILQwu3gf9fruo7s9+
        +zEGoFgE9Zpzmo7B7lpSIUODzpz32RG25jQ5WBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9251118C7C;
        Tue, 15 Mar 2022 06:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 425CE118C7B;
        Tue, 15 Mar 2022 06:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 5/5] stash: make internal resets quiet and refresh index
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
        <4c45351a0c4b8b955a9101ed9445a763750ca3c3.1647308982.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 03:23:53 -0700
Message-ID: <xmqqee33h5ty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03FA1592-A44A-11EC-987B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success 'apply --index -q is quiet' '

Hmph.  So being quiet and refreshing index are tested separately in
different tests, and this one is only about being quiet?

I wonder if a single test that checks chattiness and refreshing of
"git stash -q" and "git apply --index -q" (that's 2x2 which is 4)
would be sufficient?

> +	# Added file, deleted file, modified file all staged for commit
> +	echo foo >new-file &&
> +	echo test >file &&
> +	git add new-file file &&
> +	git rm other-file &&
> +
> +	git stash &&

As this is only about chattiness about "apply --index -q", this
command goes unchecked (4 - 2 = 2).

> +	git stash apply --index -q >output.out 2>&1 &&

And this is only about chattiness so we do not test if the index
gets refreshed after this operation (2 - 1 = 1).

> +	test_must_be_empty output.out

This ensures that "git stash apply --index -q" is silent, as that is
the main objective of this step: make sure reset won't chatter,
especially when stash is told to be --quiet, which is good.

But with a few more lines, this set-up can also test the other three
with minimum additional effort, no?

> +'
> +
>  test_expect_success 'save -q is quiet' '
>  	git stash save --quiet >output.out 2>&1 &&
>  	test_must_be_empty output.out
> @@ -291,6 +303,27 @@ test_expect_success 'drop -q is quiet' '
>  	test_must_be_empty output.out
>  '
>  
> +test_expect_success 'stash push -q --staged refreshes the index' '
> +	git reset --hard &&
> +	echo test >file &&
> +	git add file &&
> +	git stash push -q --staged &&

"git stash" and "git stash push -q --staged" may do different
things, so leaving the plain "git stash" untested for refreshing in
an earlier test, and "git stash" with different options being tested
for refreshing here, makes me wonder about a gap in test coverage.

The overall theme of the whole topic was that chatty output from
"git reset" run as an implementation detail seeps through from "git
stash", IIUC.  So, making sure that our index is refreshed after the
operation is good, but at the same time, wouldn't we want to see
what the output of this command says (or be silent)?
