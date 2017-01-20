Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FA920756
	for <e@80x24.org>; Fri, 20 Jan 2017 17:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbdATRLn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 12:11:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbdATRLl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 12:11:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE74C7FE84;
        Fri, 20 Jan 2017 17:11:31 +0000 (UTC)
Received: from localhost (ovpn-117-185.ams2.redhat.com [10.36.117.185])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0KHBUO8009178;
        Fri, 20 Jan 2017 12:11:31 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 1/2] grep: only add delimiter if there isn't one already
Date:   Fri, 20 Jan 2017 17:11:25 +0000
Message-Id: <20170120171126.16269-2-stefanha@redhat.com>
In-Reply-To: <20170120171126.16269-1-stefanha@redhat.com>
References: <20170120171126.16269-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 20 Jan 2017 17:11:31 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep(1) output does not follow git's own syntax:

  $ git grep malloc v2.9.3:t/
  v2.9.3:t/:test-lib.sh:  setup_malloc_check () {
  $ git show v2.9.3:t/:test-lib.sh
  fatal: Path 't/:test-lib.sh' does not exist in 'v2.9.3'

This patch avoids emitting the unnecessary ':' delimiter if the name
already ends with ':' or '/':

  $ git grep malloc v2.9.3:
  v2.9.3:t/test-lib.sh:   setup_malloc_check () {
  $ git show v2.9.3:t/test-lib.sh
  (succeeds)

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 builtin/grep.c  |  6 +++++-
 t/t7810-grep.sh | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8887b6a..90a4f3d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -491,7 +491,11 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		strbuf_init(&base, PATH_MAX + len + 1);
 		if (len) {
 			strbuf_add(&base, name, len);
-			strbuf_addch(&base, ':');
+
+			/* Add a delimiter if there isn't one already */
+			if (name[len - 1] != '/' && name[len - 1] != ':') {
+				strbuf_addch(&base, ':');
+			}
 		}
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index de2405c..e804a3f 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1435,4 +1435,25 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+HEAD:t/a/v:vvv
+HEAD:t/v:vvv
+EOF
+
+test_expect_success 'grep outputs valid <rev>:<path> for HEAD:t/' '
+	git grep vvv HEAD:t/ >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+HEAD:t/a/v:vvv
+HEAD:t/v:vvv
+HEAD:v:vvv
+EOF
+
+test_expect_success 'grep outputs valid <rev>:<path> for HEAD:' '
+	git grep vvv HEAD: >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.9.3

