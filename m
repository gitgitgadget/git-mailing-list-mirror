Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58EBF20970
	for <e@80x24.org>; Thu, 13 Apr 2017 06:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756055AbdDMG1D (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 02:27:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50300 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755882AbdDMG1C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 02:27:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7054781B26;
        Thu, 13 Apr 2017 02:27:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L36yEJdz7N7fa7DRfyEP1jePdfs=; b=FXdhTF
        qricdwrsts2OUX2gxUqcmPH3uPJTdglqwa0gz2AQXDuFrJDfLwrq7SBIFPgGlX3x
        nNSmx4ybujeHCQKyXnmiqe9ccAXdINY9b3GyaHOHVafBbYlXqTS+WrTMrqou5/O7
        J94nU4jFc6qS69KiTFkexfzeRhCCTmEq3sbdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k5W4U2pyb1eo6C4Olu3EKgBWsd3qrN+Z
        tR1NpUxypWOD/SB/cWHOidHxGdr0sm+oOzhbFbRqTVHqhVrdtP8pbxoHhZfoade4
        PeHVUxjrmJQOlyn9VjooKUyVTv4dkKM2CaaqCHzVmnUSv5P/FJdNkY0JlMnDqHs+
        CGouAO5VKs8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6237F81B25;
        Thu, 13 Apr 2017 02:27:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3A9281B24;
        Thu, 13 Apr 2017 02:26:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net, ramsay@ramsayjones.plus.com,
        Kevin Willford <kewillf@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 2/2] name-hash: fix buffer overrun
References: <20170403151642.2889-1-git@jeffhostetler.com>
        <20170403151642.2889-3-git@jeffhostetler.com>
Date:   Wed, 12 Apr 2017 23:26:58 -0700
In-Reply-To: <20170403151642.2889-3-git@jeffhostetler.com>
        (git@jeffhostetler.com's message of "Mon, 3 Apr 2017 15:16:42 +0000")
Message-ID: <xmqqfuhcq0ul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 332C9D6A-2012-11E7-A247-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> From: Kevin Willford <kewillf@microsoft.com>
>
> Add check for the end of the entries for the thread partition.
> Add test for lazy init name hash with specific directory structure
>
> The lazy init hash name was causing a buffer overflow when the last
> entry in the index was multiple folder deep with parent folders that
> did not have any files in them.
>
> This adds a test for the boundary condition of the thread partitions
> with the folder structure that was triggering the buffer overflow.
> The test is skipped on single-cpu machines because the original code
> path is used in name-hash.c
>
> The fix was to check if it is the last entry for the thread partition
> in the handle_range_dir and not try to use the next entry in the cache.

As I merged the older one already to 'next', I'll queue 1/2 of v2 on
top of them and then the following (which is incremental between v1
and this v2 2/2) on top.

-- >8 --
From: Kevin Willford <kewillf@microsoft.com>
Date: Mon, 3 Apr 2017 15:16:42 +0000
Subject: [PATCH] t3008: skip lazy-init test on a single-core box

The lazy-init codepath will not be exercised uniless threaded.  Skip
the entire test on a single-core box.  Also replace a hard-coded
constant of 2000 (number of cache entries to manifacture for tests)
with a variable with a human readable name.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3008-ls-files-lazy-init-name-hash.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 971975bff4..bdf5198b7e 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -4,14 +4,22 @@ test_description='Test the lazy init name hash with various folder structures'
 
 . ./test-lib.sh
 
+if test 1 -eq $($GIT_BUILD_DIR/t/helper/test-online-cpus)
+then
+	skip_all='skipping lazy-init tests, single cpu'
+	test_done
+fi
+
+LAZY_THREAD_COST=2000
+
 test_expect_success 'no buffer overflow in lazy_init_name_hash' '
 	(
-	    test_seq 2000 | sed "s/^/a_/"
+	    test_seq $LAZY_THREAD_COST | sed "s/^/a_/"
 	    echo b/b/b
-	    test_seq 2000 | sed "s/^/c_/"
+	    test_seq $LAZY_THREAD_COST | sed "s/^/c_/"
 	    test_seq 50 | sed "s/^/d_/" | tr "\n" "/"; echo d
 	) |
-	sed -e "s/^/100644 $EMPTY_BLOB	/" |
+	sed "s/^/100644 $EMPTY_BLOB	/" |
 	git update-index --index-info &&
 	test-lazy-init-name-hash -m
 '
-- 
2.12.2-776-gded3dc243c

