Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698C51F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeJXDmo (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 23:42:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeJXDmo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 23:42:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB2C04E91D;
        Tue, 23 Oct 2018 19:18:01 +0000 (UTC)
Received: from max.home.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD61A608F0;
        Tue, 23 Oct 2018 19:18:00 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] Clear --exclude list after 'git rev-parse --all'
Date:   Tue, 23 Oct 2018 21:17:58 +0200
Message-Id: <20181023191758.15138-1-agruenba@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 23 Oct 2018 19:18:01 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit [1] added the --exclude option to revision.c.  The --all,
--branches, --tags, --remotes, and --glob options clear the exclude
list.  Shortly therafter, commit [2] added the same to 'git rev-parse',
but without clearing the exclude list for the --all option.  Fix that.

[1] e7b432c52 ("revision: introduce --exclude=<glob> to tame wildcards", 2013-08-30)
[2] 9dc01bf06 ("rev-parse: introduce --exclude=<glob> to tame wildcards", 2013-11-01)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 builtin/rev-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 0f09bbbf6..c71e3b104 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -764,6 +764,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--all")) {
 				for_each_ref(show_reference, NULL);
+				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (skip_prefix(arg, "--disambiguate=", &arg)) {
-- 
2.17.2

