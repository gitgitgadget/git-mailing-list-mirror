Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1BC1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 17:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeIDWFZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 18:05:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:48097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbeIDWFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 18:05:25 -0400
Received: from localhost.localdomain ([185.190.160.130]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0ME33j-1g6vog1d6t-00HQqY for <git@vger.kernel.org>; Tue, 04 Sep 2018 19:39:17
 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Subject: [RFC PATCH] Allow aliases that include other aliases
Date:   Tue,  4 Sep 2018 19:39:15 +0200
Message-Id: <20180904173915.2393-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.0.rc1.2.g7460ee143
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N6LNcRDGuHtjZUtExa7q+NcBtBYtnqLUNzM6dfm87SEWHdfGi3n
 AsHbJr4IO3pguK7kHSs6CutsJ6nCra9Je7FgR+uYo2wqkUNQ6/Iaq7OGcBKjyLDPDUKaVTy
 OlSEF5enusCadu5LKG2v/mOfTuD3oyytlBr0/MoBIqs6LwkAaAuIb7i+dBuIWAmgV/UMOYt
 if5JWZj0v0uJ/UoXkmovw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YBMg3r0hqk0=:dDxyZ88xegtgnYebtCsIfi
 V85jWsVwGrCwZXFfR8ZCL4jV0QR3RdbIanW5yQTHpXmWAjs21np4OpRYbuJKiIOrqpXwwhrQj
 Ii+LQ3mxmPgtQ1ZG4rBTu+7S1vwaEUp7bqsQ2b/Q7GIIMwA9N3V1BieCFA+ucY8PgckU24Gjp
 hvb8ZjxfWWpLJUSOtZRotpnhI/K6FE3aNDyElrkuhLnK//qTca+c1b4mNxEhypf5dy4q4MJQp
 Ekiw9qCeUPTzeZ9PvhLVcqz7Iz2nomCD/cw4OEdQ8qUmIH8RKvlcPmmk+vsDBJuk2BE9XkNXu
 PlyPYIDT5o1Wdjt17MHSZ85e6hNh54SwZ98y94WzD2cu/UCmV0XPB7EHxMrozc5A8/g3IVPLh
 MzsAvhfw922vu7O+NyWW8zg7JK94BX6O59QR6J5vO34WnkWp887TUxBXzS+jueKMyQhQzdAvk
 GKbrFxMgQvat8wZVHMV4wRnjZg+DOu+4/j1zVvocnU4TorZShqnTUUPeIOvDskslWL9EeTdJG
 1t56SEA6ftky8vMMXrBwMAWsY3EF2LzjIQiieoNbzG/ygHOZknu3ISqCnph8AljxCMCtFirCX
 82WXRS9VfWzI5MOWx2cOaP4tZOIFHUG5YNOVq6jPpWEKKzMPHzervBg/9oXuTYIHtDGTi+ySj
 PdIjSfoVOockgXrHDGZreSuPr5UNIjMPhCZ1fOpMGULveAPeycEJiwzinn0lrzW2B9K7jth0a
 mPZt0TahWt0hhRcZtfrhN4FukKhCM8bcNz+zJLha4hAzTFoBj5ud6/svr+Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aliases can only contain non-alias git commands and arguments,
but not other user-defined aliases. Resolving nested aliases
is prevented by breaking the loop after the first alias was
processed, git then fails with a command-not-found error.

Allow resolving nested aliases by not breaking the loop in
run_argv() after the first alias was processed. Instead, continue
incrementing done_alias until handle_alias() fails, which means
that there are no further aliases that can be processed.

---

I submitted this as RFC because I'm not sure whether disallowing
nested aliases was an intentional design choice. The done_alias
check implies that disallowing is intended, but the direct
recursion check for aliases that call themselves opposes that.

Furthermore, including this patch allows creating a looping state,
since the recursion check only checks if an alias is directly calling
itself.
One solution would be to break the loop as soon as done_alias reaches
a certain value, but that requires setting an arbitrary point of "too
many recursions".
A list of already resolved aliases and breaking the loop as soon as
an alias is resolved twice would probably do the trick, but
implementing that is well beyond the point of what I'm capable of
doing.

---
 git.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git.c b/git.c
index c27c38738..9d3cf5797 100644
--- a/git.c
+++ b/git.c
@@ -695,11 +695,9 @@ static int run_argv(int *argcp, const char ***argv)
 		 * of overriding "git log" with "git show" by having
 		 * alias.log = show
 		 */
-		if (done_alias)
-			break;
 		if (!handle_alias(argcp, argv))
 			break;
-		done_alias = 1;
+		done_alias++;
 	}
 
 	return done_alias;
-- 
2.19.0.rc1.2.g7460ee143

