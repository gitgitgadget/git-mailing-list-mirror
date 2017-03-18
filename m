Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650862095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdCRTvk (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:51:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdCRTvj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:51:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D12C4AE8E;
        Sat, 18 Mar 2017 19:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 3D12C4AE8E
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=agruenba@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 3D12C4AE8E
Received: from nux.redhat.com (ovpn-116-31.ams2.redhat.com [10.36.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47FCC176BD;
        Sat, 18 Mar 2017 19:51:38 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     git@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: [PATCH] Inconsistency between git log and git rev-parse for ^HEAD^@
Date:   Sat, 18 Mar 2017 20:51:36 +0100
Message-Id: <1489866696-17487-1-git-send-email-agruenba@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 18 Mar 2017 19:51:39 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

the log and rev-parse commands both support the rev^@ syntax which stands for
all parents of rev.  The log command also supports ^rev^@ to exclude all of the
parents of rev, but rev-parse does not.  Should this be fixed?

If so, the following patch would be a start.

Thanks,
Andreas

--

rev-parse: Add support for ^rev^@

Add support for the ^rev^@ syntax to exclude all of the parents of rev.  This
syntax is already supported by git log.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 builtin/rev-parse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2549643..ab84c49 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -293,7 +293,7 @@ static int try_difference(const char *arg)
 	return 0;
 }
 
-static int try_parent_shorthands(const char *arg)
+static int try_parent_shorthands(int type, const char *arg)
 {
 	char *dotdot;
 	unsigned char sha1[20];
@@ -339,7 +339,7 @@ static int try_parent_shorthands(const char *arg)
 	}
 
 	if (include_rev)
-		show_rev(NORMAL, sha1, arg);
+		show_rev(type, sha1, arg);
 	for (parents = commit->parents, parent_number = 1;
 	     parents;
 	     parents = parents->next, parent_number++) {
@@ -350,7 +350,7 @@ static int try_parent_shorthands(const char *arg)
 
 		if (symbolic)
 			name = xstrfmt("%s^%d", arg, parent_number);
-		show_rev(include_parents ? NORMAL : REVERSED,
+		show_rev(include_parents ? type : !type,
 			 parents->item->object.oid.hash, name);
 		free(name);
 	}
@@ -896,14 +896,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		/* Not a flag argument */
 		if (try_difference(arg))
 			continue;
-		if (try_parent_shorthands(arg))
-			continue;
 		name = arg;
 		type = NORMAL;
 		if (*arg == '^') {
 			name++;
 			type = REVERSED;
 		}
+		if (try_parent_shorthands(type, name))
+			continue;
 		if (!get_sha1_with_context(name, flags, sha1, &unused)) {
 			if (verify)
 				revs_count++;
-- 
2.7.4

