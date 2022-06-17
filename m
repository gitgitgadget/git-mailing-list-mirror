Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389D1C433EF
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 21:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiFQVrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiFQVro (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 17:47:44 -0400
X-Greylist: delayed 1143 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jun 2022 14:47:43 PDT
Received: from localhost (ec2-44-200-137-115.compute-1.amazonaws.com [44.200.137.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E9725CF
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 14:47:42 -0700 (PDT)
From:   Tom Levy <tomlevy93@gmail.com>
To:     git@vger.kernel.org
Cc:     Tom Levy <tomlevy93@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 08/11] read_index_from(): avoid memory leak
Date:   Fri, 17 Jun 2022 21:27:36 +0000
Message-Id: <20220617212736.1951-1-tomlevy93@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <a3f79b3e034a3a982b3be7835062493bfdf29ee5.1655336146.git.gitgitgadget@gmail.com>
References: <a3f79b3e034a3a982b3be7835062493bfdf29ee5.1655336146.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I think there is another problem with this code: later on it refers to
the 'base_path' variable, but I think it should refer to 'base_path2'
if the first path did not exist.

How about the following patch instead (or in addition)?

Regards,
Tom Levy


-- >8 --

Subject: [PATCH] read_index_from(): use second path consistently, avoid memory
 leak

In 998330ac2e7c (read-cache: look for shared index files next to the
index, too, 2021-08-26), we added code that allocates memory to store
the path of a second shared base index, but we never released that
memory. Also, later code (e.g. the call to freshen_shared_index())
continued to use the first path even when the second path was
selected.

Modify the code to store the second path in the original variable
(after freeing the first path), so that the later code will use the
second path (and also free it).

The memory leak was reported by Coverity.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Tom Levy <tomlevy93@gmail.com>
---
 read-cache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4df97e185e..48f2b9aa9d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2459,15 +2459,15 @@ int read_index_from(struct index_state *istate, const char *path,
                                   the_repository, "%s", base_path);
        if (!ret) {
                char *path_copy = xstrdup(path);
-               const char *base_path2 = xstrfmt("%s/sharedindex.%s",
-                                                dirname(path_copy),
-                                                base_oid_hex);
+               free(base_path);
+               base_path = xstrfmt("%s/sharedindex.%s", dirname(path_copy),
+                                   base_oid_hex);
                free(path_copy);
                trace2_region_enter_printf("index", "shared/do_read_index",
-                                          the_repository, "%s", base_path2);
-               ret = do_read_index(split_index->base, base_path2, 1);
+                                          the_repository, "%s", base_path);
+               ret = do_read_index(split_index->base, base_path, 1);
                trace2_region_leave_printf("index", "shared/do_read_index",
-                                          the_repository, "%s", base_path2);
+                                          the_repository, "%s", base_path);
        }
        if (!oideq(&split_index->base_oid, &split_index->base->oid))
                die(_("broken index, expect %s in %s, got %s"),
--
2.30.2

