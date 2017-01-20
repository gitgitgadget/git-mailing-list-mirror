Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A6620756
	for <e@80x24.org>; Fri, 20 Jan 2017 17:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbdATRLm (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 12:11:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbdATRLl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 12:11:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21D177E9C4;
        Fri, 20 Jan 2017 17:11:34 +0000 (UTC)
Received: from localhost (ovpn-117-185.ams2.redhat.com [10.36.117.185])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0KHBWJr009189;
        Fri, 20 Jan 2017 12:11:33 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 2/2] grep: use '/' delimiter for paths
Date:   Fri, 20 Jan 2017 17:11:26 +0000
Message-Id: <20170120171126.16269-3-stefanha@redhat.com>
In-Reply-To: <20170120171126.16269-1-stefanha@redhat.com>
References: <20170120171126.16269-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 20 Jan 2017 17:11:34 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the tree contains a sub-directory then git-grep(1) output contains a
colon character instead of a path separator:

  $ git grep malloc v2.9.3:t
  v2.9.3:t:test-lib.sh:	setup_malloc_check () {
  $ git show v2.9.3:t:test-lib.sh
  fatal: Path 't:test-lib.sh' does not exist in 'v2.9.3'

This patch attempts to use the correct delimiter:

  $ git grep malloc v2.9.3:t
  v2.9.3:t/test-lib.sh:	setup_malloc_check () {
  $ git show v2.9.3:t/test-lib.sh
  (success)

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 builtin/grep.c  | 4 +++-
 t/t7810-grep.sh | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 90a4f3d..7a7aab9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -494,7 +494,9 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 
 			/* Add a delimiter if there isn't one already */
 			if (name[len - 1] != '/' && name[len - 1] != ':') {
-				strbuf_addch(&base, ':');
+				/* rev: or rev:path/ */
+				char delim = obj->type == OBJ_COMMIT ? ':' : '/';
+				strbuf_addch(&base, delim);
 			}
 		}
 		init_tree_desc(&tree, data, size);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index e804a3f..8a58d5e 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1445,6 +1445,11 @@ test_expect_success 'grep outputs valid <rev>:<path> for HEAD:t/' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep outputs valid <rev>:<path> for HEAD:t' '
+	git grep vvv HEAD:t >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 HEAD:t/a/v:vvv
 HEAD:t/v:vvv
-- 
2.9.3

