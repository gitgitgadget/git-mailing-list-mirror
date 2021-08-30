Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B51BC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDA360F5B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhH3U4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:56:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61260 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhH3U4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:56:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 288F814EF7D;
        Mon, 30 Aug 2021 16:55:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BJCtWMzPsTezmuDMkusiB7lb+JhKmb96lJUuzb
        06ulc=; b=wqmsIlSigHryyjj3nmmNPG7xuYZD/q7nNeRYEdDymFwF4r3E7l8fKE
        GVA5bQ4/r56Ap8z8SO6J/FqcxDD49FbcEpJYXMkZFQV/bV6USPg9b1COfhjcDfAD
        SxuTtLn7g7KO2ka0iMZI9h7TEM9/0ZrtyTw0S1H9SM52oat8t+kzA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21E0614EF7C;
        Mon, 30 Aug 2021 16:55:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 670E614EF7A;
        Mon, 30 Aug 2021 16:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/4] t1400: use test-helper ref-store to inspect reflog
 contents
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
        <dab8e115faf35529b086f102662ff86ca57a9748.1630334929.git.gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 13:55:24 -0700
In-Reply-To: <dab8e115faf35529b086f102662ff86ca57a9748.1630334929.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 30 Aug 2021
        14:48:46 +0000")
Message-ID: <xmqqlf4i3b5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A149EBE-09D4-11EC-B8A7-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +TAB='	'
>  cat >expect <<EOF
>  $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
>  $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
> -$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
> +$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000$TAB
>  EOF
>  test_expect_success "verifying $m's log (logged by touch)" '
> -	test_when_finished "rm -rf .git/$m .git/logs expect" &&
> -	test_cmp expect .git/logs/$m
> +	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
> +	test-tool ref-store main for-each-reflog-ent $m > actual &&

Nice.  So the file backend may omit the trailing tab for an empty
message at the storage level, but the test-tool consistently gives
the same format for entries with empty and non-empty messages, and
that is shown in the above.  Makes sense.

> +	test_cmp actual expect
>  '
>  
>  test_expect_success "create $m (logged by config)" '
> @@ -347,11 +349,12 @@ test_expect_success "set $m (logged by config)" '
>  cat >expect <<EOF
>  $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
>  $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
> -$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
> +$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000$TAB
>  EOF
>  test_expect_success "verifying $m's log (logged by config)" '
> -	test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
> -	test_cmp expect .git/logs/$m
> +	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
> +	test-tool ref-store main for-each-reflog-ent $m > actual &&
> +	test_cmp actual expect
>  '

Ditto.

Looks good to me.

