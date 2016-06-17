Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFA61FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbcFQUcD (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:32:03 -0400
Received: from kitenet.net ([66.228.36.95]:59142 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142AbcFQUcB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:32:01 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=SQc+D406;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466195489; bh=YpH44+PHGRKQXiLvoiKcnt2MKQwqG+zgZkC5THHiW/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQc+D406N8NaAkH0Qks4knJNUPQPTI2EVwEA90Dzo0n++AprlRJkecZnojjt0h2vh
	 bXy4VAg5K4mTevZ96zJP5WAJgUV0yG/gBBhngqYCm52srFKGOdQxDaB/Cagvc7voXD
	 97aq8cLmO7J+U64pmAy6R5NUSFljJ3IN0qkmP8As=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v2 4/4] warn on unusable smudgeToFile/cleanFromFile config
Date:	Fri, 17 Jun 2016 16:31:21 -0400
Message-Id: <1466195481-23209-5-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1466195481-23209-1-git-send-email-joeyh@joeyh.name>
References: <1466195481-23209-1-git-send-email-joeyh@joeyh.name>
X-Spam-Status: No, score=-93.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_SOFTFAIL,URIBL_BLOCKED,USER_IN_WHITELIST
	autolearn=no autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Let the user know when they have a smudgeToFile/cleanFromFile config
that cannot be used because the corresponding smudge/clean config
is missing.

The warning is only displayed a maximum of once per git invocation,
and only when doing an operation that would use the filter.

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 convert.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/convert.c b/convert.c
index bf63ba0..84f6bc5 100644
--- a/convert.c
+++ b/convert.c
@@ -847,32 +847,50 @@ int would_convert_to_git_filter_fd(const char *path)
 	return apply_filter(path, NULL, NULL, 0, -1, NULL, ca.drv->clean);
 }
 
+static int can_filter_file(const char *filefilter, const char *filefiltername,
+			   const char *stdiofilter, const char *stdiofiltername,
+			   const struct conv_attrs *ca,
+			   int *warncount)
+{
+	if (! filefilter)
+		return 0;
+
+	if (stdiofilter)
+		return 1;
+
+	if (*warncount == 0)
+		warning("Not running your configured filter.%s.%s command, because filter.%s.%s is not configured",
+			ca->drv->name, filefiltername,
+			ca->drv->name, stdiofiltername);
+		*warncount=*warncount+1;
+	
+	return 0;
+}
+
 int can_clean_from_file(const char *path)
 {
 	struct conv_attrs ca;
+	static int warncount = 0;
 
 	convert_attrs(&ca, path);
 	if (!ca.drv)
 		return 0;
 
-	/* Only use the cleanFromFile filter when the clean filter is also
-	 * configured.
-	 */
-	return (ca.drv->clean_from_file && ca.drv->clean);
+	return can_filter_file(ca.drv->clean_from_file, "cleanFromFile",
+			       ca.drv->clean, "clean", &ca, &warncount);
 }
 
 int can_smudge_to_file(const char *path)
 {
 	struct conv_attrs ca;
+	static int warncount = 0;
 
 	convert_attrs(&ca, path);
 	if (!ca.drv)
 		return 0;
 
-	/* Only use the smudgeToFile filter when the smudge filter is also
-	 * configured.
-	 */
-	return (ca.drv->smudge_to_file && ca.drv->smudge);
+	return can_filter_file(ca.drv->smudge_to_file, "smudgeToFile",
+			       ca.drv->smudge, "smudge", &ca, &warncount);
 }
 
 const char *get_convert_attr_ascii(const char *path)
-- 
2.8.1

