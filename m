Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303601FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 04:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750752AbdDAEMU (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 00:12:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51519 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750726AbdDAEMT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 00:12:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 121768343D;
        Sat,  1 Apr 2017 00:12:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3hHDHMrmRM58WvvvDd+86IytTUk=; b=vkaLLQ
        6Op6CpoxPIzMHMP2FRz9pDcnonzeEUDExWT4JKe9tiwExLFJp4VCReaeF/1cYTtO
        C36FKUWO3vjYgwLPytm7f4sXg9rEZS3gJ+VH2ewNDuAwBuj8k4wIZZ8LcqWv2kLY
        U3hmv05451LcRyCfmvCvpwbCZslAjqdveWFEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uOHK8MH1ClJuhQv2Oo+jCguW4WXQs7+R
        USmfI4GMxbWzWWNqAIqnDbyXpV+pm8kKPYPNj5+rvL6vT2ygpYP2Qv5Uft6PZnmt
        bfAkj4efkopF1GWXhcU6qGUHPeoYthq16e4f1muaq+KUSwhXw+90zVfoxnVqF3Wc
        93ypgC4Vft0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E957F8343C;
        Sat,  1 Apr 2017 00:12:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 526B68343B;
        Sat,  1 Apr 2017 00:12:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Kevin Willford <kewillf@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] name-hash: fix buffer overrun
References: <20170331173214.47514-1-git@jeffhostetler.com>
        <20170331173214.47514-2-git@jeffhostetler.com>
        <xmqqo9whxmrq.fsf@gitster.mtv.corp.google.com>
        <xmqqy3vlw3f9.fsf@gitster.mtv.corp.google.com>
        <CAPc5daWU5XDVNiYk_pTFk_qziuDr6W2XDHXXH-0oR49_KiCUYA@mail.gmail.com>
Date:   Fri, 31 Mar 2017 21:12:16 -0700
In-Reply-To: <CAPc5daWU5XDVNiYk_pTFk_qziuDr6W2XDHXXH-0oR49_KiCUYA@mail.gmail.com>
        (Junio C. Hamano's message of "Fri, 31 Mar 2017 16:18:29 -0700")
Message-ID: <xmqqh928wyu7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64B16508-1691-11E7-84C7-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ah, of course. Avoid GNUism to spell HT as "\t" in a sed script.

Here is what I replaced the original patch with.  Let's see how well
it fares with Travis tonight.

-- >8 --
From: Kevin Willford <kewillf@microsoft.com>
Date: Fri, 31 Mar 2017 17:32:14 +0000
Subject: [PATCH] name-hash: fix buffer overrun

Add check for the end of the entries for the thread partition.
Add test for lazy init name hash with specific directory structure

The lazy init hash name was causing a buffer overflow when the last
entry in the index was multiple folder deep with parent folders that
did not have any files in them.

This adds a test for the boundary condition of the thread partitions
with the folder structure that was triggering the buffer overflow.

The fix was to check if it is the last entry for the thread partition
in the handle_range_dir and not try to use the next entry in the cache.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 name-hash.c                             |  4 +++-
 t/t3008-ls-files-lazy-init-name-hash.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100755 t/t3008-ls-files-lazy-init-name-hash.sh

diff --git a/name-hash.c b/name-hash.c
index cac313c78d..39309efb7f 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -342,7 +342,9 @@ static int handle_range_dir(
 	 * Scan forward in the index array for index entries having the same
 	 * path prefix (that are also in this directory).
 	 */
-	if (strncmp(istate->cache[k_start + 1]->name, prefix->buf, prefix->len) > 0)
+	if (k_start + 1 >= k_end)
+		k = k_end;
+	else if (strncmp(istate->cache[k_start + 1]->name, prefix->buf, prefix->len) > 0)
 		k = k_start + 1;
 	else if (strncmp(istate->cache[k_end - 1]->name, prefix->buf, prefix->len) == 0)
 		k = k_end;
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
new file mode 100755
index 0000000000..971975bff4
--- /dev/null
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='Test the lazy init name hash with various folder structures'
+
+. ./test-lib.sh
+
+test_expect_success 'no buffer overflow in lazy_init_name_hash' '
+	(
+	    test_seq 2000 | sed "s/^/a_/"
+	    echo b/b/b
+	    test_seq 2000 | sed "s/^/c_/"
+	    test_seq 50 | sed "s/^/d_/" | tr "\n" "/"; echo d
+	) |
+	sed -e "s/^/100644 $EMPTY_BLOB	/" |
+	git update-index --index-info &&
+	test-lazy-init-name-hash -m
+'
+
+test_done
-- 
2.12.2-752-g2215051a9e

