Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C1B20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 15:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbdASPbD (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 10:31:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753019AbdASPbC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 10:31:02 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B31B3A768B;
        Thu, 19 Jan 2017 15:03:55 +0000 (UTC)
Received: from localhost (ovpn-116-186.ams2.redhat.com [10.36.116.186])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0JF3sxa018472;
        Thu, 19 Jan 2017 10:03:54 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 1/2] grep: only add delimiter if there isn't one already
Date:   Thu, 19 Jan 2017 15:03:46 +0000
Message-Id: <20170119150347.3484-2-stefanha@redhat.com>
In-Reply-To: <20170119150347.3484-1-stefanha@redhat.com>
References: <20170119150347.3484-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 19 Jan 2017 15:03:55 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep(1) output does not follow git's own syntax:

  $ git grep malloc v2.9.3:
  v2.9.3::Makefile:       COMPAT_CFLAGS += -Icompat/nedmalloc
  $ git show v2.9.3::Makefile
  fatal: Path ':Makefile' does not exist in 'v2.9.3'

This patch avoids emitting the unnecessary ':' delimiter if the name
already ends with ':' or '/':

  $ git grep malloc v2.9.3:
  v2.9.3:Makefile:       COMPAT_CFLAGS += -Icompat/nedmalloc
  $ git show v2.9.3:Makefile
  (succeeds)

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 builtin/grep.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 462e607..3643d8a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -490,7 +490,11 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
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
-- 
2.9.3

