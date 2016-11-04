Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F562022D
	for <e@80x24.org>; Fri,  4 Nov 2016 19:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbcKDTiJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 15:38:09 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:33284 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbcKDTiI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 15:38:08 -0400
X-Greylist: delayed 1439 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Nov 2016 15:38:08 EDT
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c2jwG-0004WX-Jq; Fri, 04 Nov 2016 19:14:08 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: [PATCH 3/5] check-ref-format: Abolish leak of collapsed refname
Date:   Fri,  4 Nov 2016 19:13:56 +0000
Message-Id: <20161104191358.28812-4-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

collapse_slashes always returns a value from xmallocz.

Right now this leak is not very interesting, since we only call
check_one_ref_format once.

Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 builtin/check-ref-format.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index f12c19c..020ebe8 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -63,8 +63,10 @@ static int check_one_ref_format(const char *refname)
 		: check_refname_format(refname, flags);
 	if (got)
 		return 1;
-	if (normalize)
+	if (normalize) {
 		printf("%s\n", refname);
+		free((void*)refname);
+	}
 }
 
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
-- 
2.10.1

