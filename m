Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E26921F744
	for <e@80x24.org>; Mon, 11 Jul 2016 22:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbcGKWrI (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 18:47:08 -0400
Received: from kitenet.net ([66.228.36.95]:60984 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbcGKWrI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 18:47:08 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=Yy9dgbAc;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1468277198; bh=ZPsSRNaHriT6igc+PUYizSKSXZl5YDOyDcX0bJMWFqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yy9dgbAcC69LAmxyt4U9d2lqehM4dKl+NuDIHbQ//uTjX1mmOMkj/Pe4n7vrShEUP
	 D4h/CYU5C4oRTJMhV1MF501fgcvPvOujxUMOviTB+g1EH5YfP989HvZT+7xafE3M4m
	 8+IYWJC1JpDN45UcBwYBROl/ch/87+shPUlms+ds=
From:	Joey Hess <joeyh@joeyh.name>
To:	git@vger.kernel.org
Cc:	Joey Hess <joeyh@joeyh.name>
Subject: [PATCH v5 5/8] warn on unusable smudgeToFile/cleanFromFile config
Date:	Mon, 11 Jul 2016 18:45:09 -0400
Message-Id: <1468277112-9909-6-git-send-email-joeyh@joeyh.name>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
References: <1468277112-9909-1-git-send-email-joeyh@joeyh.name>
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
 convert.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index eb7774f..e1b0b44 100644
--- a/convert.c
+++ b/convert.c
@@ -845,34 +845,50 @@ int would_convert_to_git_filter_fd(const char *path)
 	return apply_filter(path, NULL, NULL, 0, -1, NULL, ca.drv->clean);
 }
 
+static int can_filter_file(const char *filefilter, const char *filefiltername,
+			   const char *stdiofilter, const char *stdiofiltername,
+			   const struct conv_attrs *ca,
+			   int *warncount)
+{
+	if (!filefilter)
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
 
-	/*
-	 * Only use the cleanFromFile filter when the clean filter is also
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
 
-	/*
-	 * Only use the smudgeToFile filter when the smudge filter is also
-	 * configured.
-	 */
-	return (ca.drv->smudge_to_file && ca.drv->smudge);
+	return can_filter_file(ca.drv->smudge_to_file, "smudgeToFile",
+			       ca.drv->smudge, "smudge", &ca, &warncount);
 }
 
 const char *get_convert_attr_ascii(const char *path)
-- 
2.8.1

