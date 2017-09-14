Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21F620A21
	for <e@80x24.org>; Thu, 14 Sep 2017 13:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdINNPh (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 09:15:37 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52493 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdINNPg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 09:15:36 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue101
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LoYQs-1dC1d50NkQ-00gVKf; Thu, 14
 Sep 2017 15:15:29 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/3] merge-base: return fork-point outside reflog
Date:   Thu, 14 Sep 2017 15:15:19 +0200
Message-Id: <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.712.gda4591c8a2
In-Reply-To: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
In-Reply-To: <cover.1505394278.git.git@grubix.eu>
References: <cover.1505394278.git.git@grubix.eu>
X-Provags-ID: V03:K0:y5jXGQBVF8FO0S5CxiBHfh0RSjAtMukCLKLWYqS0aGu07iRh8AG
 1XWGJv8QBkUBWlPX//LZuqVCzU2YrUMzzarwCoqRZ3wq0PkCzRbYnVr31+TEh1Th1gskH3k
 DHdUtEgP3x8q+MJ6MviKc8KG+FqoQj+DsiY5j3ljd/Y3t7Ys30UNdAD1/5pqbM+qMFj0s4k
 1rfmepHhJBmWrWEHzkbyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rgeZ4YJUSJM=:UTTrJU+739jfoAJ+z0wBxa
 F10DIIqwTUK1TfhTQJBb/i/B3yVm6xwpkeWt62rW04/GQXN0NfIs3r6fA1+A+83BlgsFgHcfJ
 2BBPgaAqCQfzfqAzVgb35R0/qox6i+u02awyjdCF+Wwb/Ck98RYBfvIgMR7Mp1AXt3Hw5HGd/
 xecBQbFyKibf2GlqdGfIeBVhSgusdX2dHC8y+8it76C+gKrTX4KgSNXOdqJcKQMaaCMLO2ulh
 6gIxu+0MdQxhKC9ll4z04JB+fM788pqenBuH2BCIrg9HOLSP+sKaVzSCV78/VOdTc7n3w0/6t
 f7+R8P2bJ0IF5Kz7YUqYSIydFQRfa5GSkaatOIbFo/Qiv6lfKW9BOXdV5pcxkuRcag1buIaD+
 41J44qMDGi0VmCD/KPEGsCMCIxmdQ/Yneqshu38HYyD/3pCzpIzEk8b5uTx/aakZuBZ+2oyce
 5CJ7oHpWA2UK9+hkELZS/gmdj5WPUfbXOi9fW7ku0ZTiFnYWY18+STOvhVOpTttQG+fvypF45
 dDDQyXFnWoY4snEYRvKli5kI6IDvvMNR7J2i6zQ0pDdonCK+uma09BCCiYWjusnITVxS2M6rF
 uatD8DZqw+0lwlcQk/c3TUmsLq2CZMnyyseIfaJTRNOVYj7HES2BgU2VBsxkLcZKJIMOhWlK7
 zg6oIzm1/7v8R3QlLiwlfKx6EDB03iCs74ra9ClCcHtYqlykJXfiU/tnZI4dAI2YYyP+JKcpW
 SxCckTgTkBFn8TetGcMBYYefFyXwA6+0nJTiBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

4f21454b55 ("merge-base: handle --fork-point without reflog",
2016-10-12) fixed the case without reflog, but only partially:
The original code checks whether the merge base candidates are from the
list that we started with, which was the list of reflog entries before
4f21454b55 and the list of reflog entries - or the ref itself if empty -
after. The test from 4f21454b55 tested in a situation where the merge
base candidate equalled the commit at refname, so it was on this (1
item) list by accident.

In fact, per documentation "--fork-point" looks at the reflog in
addition to doing the usual walk from the tip. The original design
description in d96855ff51 ("merge-base: teach "--fork-point" mode",
2013-10-23) describes this as computing from a virtual merge-base of all
the historical tips of refname. They may or may not all be present in
the reflog (think pruning, non-ff fetching, fast forwarding etc.),
so filtering by the current contents of the reflog is potentially
harmful, and it does not seem to fulfill any purpose in the original
design.

Remove the filtering and add a test for an out-of-reflog merge base.

Reported-by: Ekelhart Jakob <jakob.ekelhart@fsw.at>
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/merge-base.c  | 18 +++---------------
 t/t6010-merge-base.sh |  8 ++++++++
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 6dbd167d3b..926a7615ea 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -186,23 +186,11 @@ static int handle_fork_point(int argc, const char **argv)
 	 * There should be one and only one merge base, when we found
 	 * a common ancestor among reflog entries.
 	 */
-	if (!bases || bases->next) {
+	if (!bases || bases->next)
 		ret = 1;
-		goto cleanup_return;
-	}
-
-	/* And the found one must be one of the reflog entries */
-	for (i = 0; i < revs.nr; i++)
-		if (&bases->item->object == &revs.commit[i]->object)
-			break; /* found */
-	if (revs.nr <= i) {
-		ret = 1; /* not found */
-		goto cleanup_return;
-	}
-
-	printf("%s\n", oid_to_hex(&bases->item->object.oid));
+	else
+		printf("%s\n", oid_to_hex(&bases->item->object.oid));
 
-cleanup_return:
 	free_commit_list(bases);
 	return ret;
 }
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 17fffd7998..850463d4f2 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -267,6 +267,14 @@ test_expect_success '--fork-point works with empty reflog' '
 	test_cmp expect actual
 '
 
+test_expect_success '--fork-point works with merge-base outside reflog' '
+	git -c core.logallrefupdates=false checkout no-reflog &&
+	git -c core.logallrefupdates=false commit --allow-empty -m "Commit outside reflogs" &&
+	git rev-parse base >expect &&
+	git merge-base --fork-point no-reflog derived >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'merge-base --octopus --all for complex tree' '
 	# Best common ancestor for JE, JAA and JDD is JC
 	#             JE
-- 
2.14.1.712.gda4591c8a2

