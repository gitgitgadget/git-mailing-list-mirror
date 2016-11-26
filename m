Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A2A1FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 12:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbcKZMsa (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 07:48:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:50549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbcKZMs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 07:48:28 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeNGL-1cVA310lKf-00q9dE; Sat, 26
 Nov 2016 13:48:22 +0100
Date:   Sat, 26 Nov 2016 13:48:06 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Klein <markus.klein@reelworx.at>
Subject: [PATCH v2 2/2] Avoid a segmentation fault with renaming merges
In-Reply-To: <cover.1480164459.git.johannes.schindelin@gmx.de>
Message-ID: <d1571a25e8f3860a2867b00994d4d6938aa602ec.1480164459.git.johannes.schindelin@gmx.de>
References: <cover.1480091758.git.johannes.schindelin@gmx.de> <cover.1480164459.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ximeSBdkHBNA91PDfk8Ayl3P+Brpb3nJeIM27JE7e1HIefVXNCZ
 qKFYDb/z8DJ3Tzm2YZFEfZWmDY5Xxzbghjs/PflcLe182Hv/uuY2Py0S+K0AWWm1qpBJOyB
 N1+1xWNdiyf0XJCwlG+18VSkz5O+gjk+V4nb+/zP3xM1YhxM/zy84tRK6OfhcQ8bZWT1Je7
 GDG3zIysuzfq0yZsUz5YA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AcZs+CHYmpA=:qrdOu8XAJp5pRSZyGenMb5
 UCOV8Am9D3AbuZsf3Qj82hkmXEqt03cURZoEibqTtrnsqxN3qIaZqTT+D637odyR1+Wk7fDi1
 WY7KcQizmNmuLjxrCcCAV/do05I2mHnrZtLTIVk03jNkLO9eaEyZ+FWRfRJSHv6tlkDFz6JU6
 GJQc3SXQ2LDXo1fKh0cF937xY5zSCxgRkPN1cA5OsspZBqExsAVIjISlZxTV1hHu5QsmDDjl4
 o1i14E8L7To19q7miSVBENVzypch4dSZa92DHCQdcQLoKLQFqGdCyP1nDw4DWQf80lv0dg+4T
 yHDG7WY7NEV7lSioHrdTEBqavh1+6HYB7s7oZR6lhQJUR3YFjf6J3BRu9hso39pSSSAM+yVrj
 oztGAqrHnxVj4bukyQzsSPULjvcepDcGTPmgEGeA6CWfnu+Yejay1x1IWyC3RyucKeOd2rM+d
 lsWyKJnseFkSjgqCMLRjQLcrgp4pQWfFDRw+zcOfgq+wgKogwnW9hiyAOhARJvu3kPQ2MRKXd
 8lbKz+YnrmRude2yniz+0GNZw2gux3MYxrh5epoEd4/TPmlknQizYzWusbS2uClgsMHIiy4Y4
 ksWlpXniplindNl/OR2nkXjL7Ps/1OMKl+cYjdU37gxpvo4kodT4HXvVwz6UU/uNzlTRVX/I7
 KITtAPsUQhgpyUovu87Wg9IL8RKVJjI3CMbFadv7IWcbSZ8tGFM3zF4vJLOiz3ptnqzp5x/iK
 cmztNlBvw4uCk0bE1TlvZg/IJmlar7jRRog2uDUxwqnPOATtT0LrCp9xXMBamuSJ8eiNx5KNf
 eOP6V1G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Under very particular circumstances, merge-recursive's `add_cacheinfo()`
function gets a `NULL` returned from `refresh_cache_entry()` without
expecting it, and subsequently passes it to `add_cache_entry()` which
consequently crashes.

Let's not crash.

This fixes https://github.com/git-for-windows/git/issues/952

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c             | 2 ++
 t/t3501-revert-cherry-pick.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9041c2f149..609061f58a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -235,6 +235,8 @@ static int add_cacheinfo(struct merge_options *o,
 		struct cache_entry *nce;
 
 		nce = refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
+		if (!nce)
+			return err(o, _("addinfo: '%s' is not up-to-date"), path);
 		if (nce != ce)
 			ret = add_cache_entry(nce, options);
 	}
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index d7b4251234..4f2a263b63 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with arguments' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'cherry-pick works with dirty renamed file' '
+test_expect_success 'cherry-pick works with dirty renamed file' '
 	test_commit to-rename &&
 	git checkout -b unrelated &&
 	test_commit unrelated &&
-- 
2.11.0.rc3.windows.1
