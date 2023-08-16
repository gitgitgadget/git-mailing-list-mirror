Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16757C001B0
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 16:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbjHPQpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345024AbjHPQom (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 12:44:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09433A84
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 09:44:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C69671AD1EA;
        Wed, 16 Aug 2023 12:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=La7kDswNx5w6+y8dpTATC3FNL0UgSSJf7q+bNM
        sq82g=; b=nKFismjK6K4Ez3JW1Kzwh4jqTdRnVe/G2+Wf1eRa/pY+giKqw2Xjf/
        xbYTa7pEDV94nqaaef2pUVk5AUVq5WIDoQLbnbcheX20Ch6efWjy2azRecRVbsn1
        Duo5J8R4CvNtB5HuuUQiopZADA0Nm5Ew7ouISXihxZTlBG4GhA/bM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD2C31AD1E9;
        Wed, 16 Aug 2023 12:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C76B71AD1E6;
        Wed, 16 Aug 2023 12:44:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] upload-pack: fix exit code when denying fetch of
 unreachable object ID
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
        <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
        <xmqqjztvezen.fsf@gitster.g>
Date:   Wed, 16 Aug 2023 09:44:04 -0700
In-Reply-To: <xmqqjztvezen.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        16 Aug 2023 09:16:00 -0700")
Message-ID: <xmqq8rabey3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DB3B4EA-3C54-11EE-94F1-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The change to the code sounds sensible in that it is a move to
> restore the status quo, and we know that the original never intended
> to "fix" the exit status from 128 to 1.  The test change etches the
> status quo in stone, which is a bit more than that and might be
> debatable, but when we someday formally declare that users should
> not be relying on the exit status that are not documented, we would
> hunt for the uses of test_expect_code in the tests and turn this one
> back, and probably do the same to others that are too strict on the
> exact exit status, so I think that half of the change is OK, at
> least for now.
>
> Comments?

An alternative to make this "fix" without setting any policy is to
do this.  That is, to remove the change to the test part and then to
rephrase the tail end of the proposed commit log message.

I can go either way.  I personally prefer our tests not to be overly
strict about behaviors they test, especially the ones we do not
document.

1:  77d0f01405 ! 1:  5f33a843de upload-pack: fix exit code when denying fetch of unreachable object ID
    @@ Commit message
         seems rather clear that this is an unintended side effect of the change
         given that this change in behaviour was not mentioned at all.
     
    -    Fix this regression by exiting with 128 again and tighten one of our
    -    tests to catch such unintended side effects.
    +    Restore the status-quo by exiting with 128.  The test in t5703 to
    +    ensure that "git fetch" fails by using test_must_fail, which does
    +    not care between exiting 1 and 128, so this changes will not affect
    +    any test.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    - ## t/t5703-upload-pack-ref-in-want.sh ##
    -@@ t/t5703-upload-pack-ref-in-want.sh: test_expect_success 'server is initially ahead - no ref in want' '
    - 	rm -rf local &&
    - 	cp -r "$LOCAL_PRISTINE" local &&
    - 	inconsistency main $(test_oid numeric) &&
    --	test_must_fail git -C local fetch 2>err &&
    -+	test_expect_code 128 git -C local fetch 2>err &&
    - 	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
    - '
    - 
    -
      ## upload-pack.c ##
     @@ upload-pack.c: static void check_non_tip(struct upload_pack_data *data)
      			packet_writer_error(&data->writer,
