Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244FE20986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbcJSW1n (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:27:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54939 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932717AbcJSW1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:27:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EDC3476A7;
        Wed, 19 Oct 2016 18:27:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B/l3K6hGDyP01CVZezZkUa1h5M0=; b=UCBNsq
        nSlEgpB6G+fZRK4bVIujIx5P5jOEj95sWVG6fx+49o3r4JF3BwxjWqUzd1kOFuAY
        M2PkMTpddgHNFfBuJ6uzP/rjkNd5s5cpX4ZYvitKD9M1jJpXMqYt1hQnTz/4ICPF
        yvpeSib/6JnyIwoxfxMbqFrwfilIkf/AhqoqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CCP8apSd5TxPKysCdpIz53TorV530cJI
        WcQ0KlublBhCpKC1MHxNK0Y4fbOo7dauciEjLwdpmNRZ6puh2x99lnhksOv6Cfe1
        kLGs02CX4xT9rlQkbfYR6RgEDKKTEe/TBjfGcQqZbsEeDQdbCcavpOcMepPAuMZl
        eTUMktMFTwA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26C05476A6;
        Wed, 19 Oct 2016 18:27:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 971C2476A5;
        Wed, 19 Oct 2016 18:27:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jan Keromnes <janx@linux.com>, git@vger.kernel.org
Subject: Re: [regression] `make profile-install` fails in 2.10.1
References: <CAA6PgK5vtnZSqqZafMVGoy0Rv38=8e__uQvXaf2SyPePHuPjJA@mail.gmail.com>
        <20161019210519.ubk5q54rrvbafch7@sigill.intra.peff.net>
Date:   Wed, 19 Oct 2016 15:27:35 -0700
In-Reply-To: <20161019210519.ubk5q54rrvbafch7@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 19 Oct 2016 17:05:19 -0400")
Message-ID: <xmqqh988j7oo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D49E678-964B-11E6-A9BA-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I can't reproduce any problems with raciness there, but there is a known
> problem with running the script as root (which I guess you might be
> doing from your "make prefix=/usr" call). There's some discussion in
> http://public-inbox.org/git/20161010035756.38408-1-jeremyhu@apple.com/T/#u,
> but it looks like the patch stalled.

Ouch.  Thanks for a reminder.  How about doing this for now?

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 10 Oct 2016 10:41:51 -0700
Subject: [PATCH] t3700: fix broken test under !SANITY

An "add --chmod=+x" test recently added by 610d55af0f ("add: modify
already added files when --chmod is given", 2016-09-14) used "xfoo3"
as a test file.  The paths xfoo[1-3] were used by earlier tests for
symbolic links but they were expected to have been removed by the
test script reached this new test.

The removal with "git reset --hard" however happened in tests that
are protected by POSIXPERM,SANITY prerequisites.  Platforms and test
environments that lacked these would have seen xfoo3 as a leftover
symbolic link, pointing somewhere else, and chmod test would have
given a wrong result.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3700-add.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 924a266126..53c0cb6dea 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -350,6 +350,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
 '
 
 test_expect_success 'git add --chmod=[+-]x changes index with already added file' '
+	rm -f foo3 xfoo3 &&
 	echo foo >foo3 &&
 	git add foo3 &&
 	git add --chmod=+x foo3 &&
-- 
2.10.1-633-g7f0e449216

