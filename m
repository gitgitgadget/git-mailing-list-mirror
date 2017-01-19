Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D5420C2E
	for <e@80x24.org>; Thu, 19 Jan 2017 15:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbdASP2X (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 10:28:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753143AbdASP2V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 10:28:21 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5607E81247;
        Thu, 19 Jan 2017 15:03:57 +0000 (UTC)
Received: from localhost (ovpn-116-186.ams2.redhat.com [10.36.116.186])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0JF3u04021398;
        Thu, 19 Jan 2017 10:03:56 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 2/2] grep: use '/' delimiter for paths
Date:   Thu, 19 Jan 2017 15:03:47 +0000
Message-Id: <20170119150347.3484-3-stefanha@redhat.com>
In-Reply-To: <20170119150347.3484-1-stefanha@redhat.com>
References: <20170119150347.3484-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 19 Jan 2017 15:03:57 +0000 (UTC)
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

This patch does not cope with @{1979-02-26 18:30:00} syntax and treats
it as a path because it contains colons.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 builtin/grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3643d8a..06f8b47 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -493,7 +493,8 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 
 			/* Add a delimiter if there isn't one already */
 			if (name[len - 1] != '/' && name[len - 1] != ':') {
-				strbuf_addch(&base, ':');
+				/* rev: or rev:path/ */
+				strbuf_addch(&base, strchr(name, ':') ? '/' : ':');
 			}
 		}
 		init_tree_desc(&tree, data, size);
-- 
2.9.3

