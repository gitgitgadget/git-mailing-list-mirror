Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB9BC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 21:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiFMVzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiFMVzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 17:55:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A6D205EE
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:55:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DDD6134DFA;
        Mon, 13 Jun 2022 17:55:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g1wEO08UxVuZ
        gZgwQxkgVHaB/FO9GK5BY7tOnbjAwSk=; b=j26HKxJr8b37jsJEcoTN3jBdqamq
        wD5fpVvosCa/96OwTj3Jy2ViS4ZPnrRQIaaWluF2pqZZPy6LuXeaUM/1Xz6LYkgH
        K4L/yVGbIjDxzq7IAKE9R7vExeb6LgtvJNAvfeK7QrzBbns3nrgLpMGVM9tBoBzT
        e/Wjei0zkx1nnUo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1564A134DF9;
        Mon, 13 Jun 2022 17:55:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B473134DF8;
        Mon, 13 Jun 2022 17:55:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 5/5] archive-tar: use internal gzip by default
References: <pull.145.git.gitgitgadget@gmail.com>
        <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
        <d9e75b24-c351-e226-011d-5a5cc2e1c858@web.de>
Date:   Mon, 13 Jun 2022 14:55:37 -0700
In-Reply-To: <d9e75b24-c351-e226-011d-5a5cc2e1c858@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 12 Jun 2022 08:19:05 +0200")
Message-ID: <xmqqk09k449y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8F91903E-EB63-11EC-942D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> -test_expect_success GZIP 'git archive --format=3Dtar.gz' '
> +test_expect_success 'git archive --format=3Dtar.gz' '
>  	git archive --format=3Dtar.gz HEAD >j1.tar.gz &&
>  	test_cmp_bin j.tgz j1.tar.gz
>  '

Curiously, this breaks for me.  It is understandable if we are not
producing byte-for-byte identical output with internal gzip.

With the following hack I can force the step pass, so it seems that
the two invocations of internal gzip are not emitting identical
result for the tar stream taken out of HEAD^{tree} object?

diff --git c/t/t5000-tar-tree.sh w/t/t5000-tar-tree.sh
index 1a68e89a55..c0a2cb92d4 100755
--- c/t/t5000-tar-tree.sh
+++ w/t/t5000-tar-tree.sh
@@ -340,14 +340,16 @@ test_expect_success 'only enabled filters are avail=
able remotely' '
 '
=20
 test_expect_success 'git archive --format=3Dtgz' '
-	git archive --format=3Dtgz HEAD >j.tgz
+	git -c tar.tgz.command=3D"gzip -cn" archive --format=3Dtgz HEAD >j.tgz
 '
=20
 test_expect_success 'git archive --format=3Dtar.gz' '
-	git archive --format=3Dtar.gz HEAD >j1.tar.gz &&
+	git -c tar.tar.gz.command=3D"gzip -cn" archive --format=3Dtar.gz HEAD >=
j1.tar.gz &&
 	test_cmp_bin j.tgz j1.tar.gz
 '
=20
+exit
+
 test_expect_success 'infer tgz from .tgz filename' '
 	git archive --output=3Dj2.tgz HEAD &&
 	test_cmp_bin j.tgz j2.tgz

