Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 968111F859
	for <e@80x24.org>; Tue,  9 Aug 2016 14:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbcHIOSC (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 10:18:02 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:55661 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112AbcHIOSB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 10:18:01 -0400
Received: from [77.117.29.131] (smtpout1.drei.com [109.126.64.1])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s7xFg2fTSz5tlF;
	Tue,  9 Aug 2016 16:17:59 +0200 (CEST)
Subject: [PATCH 2/2] commit-slab.h: avoid duplicated global static variables
To:	Git Mailing List <git@vger.kernel.org>
References: <57A9E5C1.3030205@kdbg.org>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <57A9E614.6050601@kdbg.org>
Date:	Tue, 9 Aug 2016 16:17:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <57A9E5C1.3030205@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The gigantic define_commit_slab() macro repeats the definition of a
static variable that occurs earlier in the macro text. The purpose of
the repeated definition at the end of the macro is that it takes the
semicolon that occurs where the macro is used.

We cannot just remove the first definition of the variable because it
is referenced elsewhere in the macro text, and defining the macro later
would produce undefined identifier errors. We cannot have a "forward"
declaration, either. (This works only with "extern" global variables.)

The solution is to use a declaration of a struct that is already defined
earlier. This language construct can serve the same purpose as the
duplicated static variable definition, but without the confusion.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 commit-slab.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit-slab.h b/commit-slab.h
index f84b449..006a50b 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -126,16 +126,16 @@ static MAYBE_UNUSED elemtype *slabname## _peek(struct slabname *s,	\
 	return slabname##_at_peek(s, c, 0);				\
 }									\
 									\
-static int stat_ ##slabname## realloc
+struct slabname
 
 /*
- * Note that this seemingly redundant second declaration is required
+ * Note that this redundant forward declaration is required
  * to allow a terminating semicolon, which makes instantiations look
  * like function declarations.  I.e., the expansion of
  *
  *    define_commit_slab(indegree, int);
  *
- * ends in 'static int stat_indegreerealloc;'.  This would otherwise
+ * ends in 'struct indegree;'.  This would otherwise
  * be a syntax error according (at least) to ISO C.  It's hard to
  * catch because GCC silently parses it by default.
  */
-- 
2.9.2.935.gccae72a.dirty

