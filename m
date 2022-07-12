Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F1C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 16:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiGLQHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiGLQGw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 12:06:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BFBC8E92
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:06:44 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6E851327C2;
        Tue, 12 Jul 2022 12:06:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M2Q9ix8yN2hxZJxGPXoW8nq6X2HwC1gLdW1J/w
        3PpzQ=; b=lYbA80Dz0V8OTIoJ+dfmyDhUmglOxxZhiFnjAdIS00nnvq0dGY6s8T
        BIMBGuE7cwpiwjlt1iZ+omPVtTASmp0Q/ep5wwQ6AlNtLx+uNqtWz93GbSqh87nR
        fEVpEevaDAjjwG8bX8+gErgAqjtchKD7zRTotpH4RAvBCRAYnpWoU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD2CF1327C0;
        Tue, 12 Jul 2022 12:06:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 215711327BF;
        Tue, 12 Jul 2022 12:06:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com, avarab@gmail.com,
        johncai86@gmail.com
Subject: Re: [PATCH v3 0/4] Add support for mailmap in cat-file
References: <20220707161554.6900-1-siddharthasthana31@gmail.com>
        <20220709154149.165524-1-siddharthasthana31@gmail.com>
        <xmqqv8s5sf8x.fsf@gitster.g>
        <50s3714q-8p5n-2379-65r4-17304426rp93@tzk.qr>
        <xmqqwnciifgv.fsf@gitster.g>
Date:   Tue, 12 Jul 2022 09:06:41 -0700
In-Reply-To: <xmqqwnciifgv.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        12 Jul 2022 07:16:16 -0700")
Message-ID: <xmqqy1wygvse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E89A356-01FC-11ED-A511-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The cat-file tests does not have to use the "map" file to do its
> thing at all.  In fact, these tests prepare their own .mailmap file
> inside them.  But because it chose to run in the history prepared by
> previous tests, it broke, because without SYMLINKS, the sought-for
> commit does not get created.

So, an alternative solution is to keep the existing tests on
symlinks totally unrelated to these new tests.  These cat-file tests
can prepare the commit to munge at the beginning of the sequence,
and then do its thing.  This way, a platform without symlink support
does not have to create the "map" file that nobody uses, something
like the attached.

I do not have strong preference either way, though.

 t/t4203-mailmap.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/t/t4203-mailmap.sh w/t/t4203-mailmap.sh
index c60a90615c..cd1cab3e54 100755
--- c/t/t4203-mailmap.sh
+++ w/t/t4203-mailmap.sh
@@ -963,6 +963,11 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'prepare for cat-file --mailmap' '
+	rm -f .mailmap &&
+	git commit --allow-empty -m foo --author="Orig <orig@example.com>"
+'
+
 test_expect_success '--no-use-mailmap disables mailmap in cat-file' '
 	test_when_finished "rm .mailmap" &&
 	cat >.mailmap <<-EOF &&
