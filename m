Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D393A1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbfBSAGS (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:18 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34808 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732266AbfBSAGL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:11 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7A2BA6109E;
        Tue, 19 Feb 2019 00:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534768;
        bh=/DZi0o48QYNqk5weSOiSaregngZ4lls1QVGD4dHkRHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=u+y8D1q9Z3qtgy7852QE64RVBJlEslf8OhgYMQ6FuRGB8dW4jEQJalkgplTTJN7i7
         FSCaHM3mFw0lOWcMnyA2QHeRGiztFFjiii0964aEk9gU/zLkOcOekLQdhTYCLHyqWD
         EtZIXuEOPhPS5/gwku5/hRr3XnxXXoc58BXYrklnhpa63veqb3bGKReDBEAicRuh76
         gWubEmSGwtqwqyuYTtSmeCN98ttRAoAtEDGa3lrNbxP/GQaMP5UBL3mRpzAZj6wZOi
         hTneg9MEa6JfmtVa0HvjuehNVkMGdNZj+nYNkMX30F6l2bRNm7mOAkMv34U0KtZ2Y5
         nvpnRJk4dRrBtiSLniFLTHpPS4ak0gnr+BfmPzkW6McWxn/14oWFBSgv1b5OMua6hC
         DG/Hw7K7WvhojlTcbsoJRgI17g7aZ/+zDQJ1xQ9unaktuj8uFApCqydK+AdAsCX4KW
         R40lsWCZPEUu81mclHR87LYxOhQ7BSuzBC6mz/Dfg9y4+vM+dkm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 27/35] get-tar-commit-id: parse comment record
Date:   Tue, 19 Feb 2019 00:05:18 +0000
Message-Id: <20190219000526.476553-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rene Scharfe <l.s.r@web.de>

Parse pax comment records properly and get rid of magic numbers for
acceptable comment length.  This simplifies a later change to handle
longer hashes.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/get-tar-commit-id.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 2706fcfaf2..312e44ed05 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -21,6 +21,8 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	char *content = buffer + RECORDSIZE;
 	const char *comment;
 	ssize_t n;
+	long len;
+	char *end;
 
 	if (argc != 1)
 		usage(builtin_get_tar_commit_id_usage);
@@ -32,10 +34,17 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 		die_errno("git get-tar-commit-id: EOF before reading tar header");
 	if (header->typeflag[0] != 'g')
 		return 1;
-	if (!skip_prefix(content, "52 comment=", &comment))
+
+	len = strtol(content, &end, 10);
+	if (errno == ERANGE || end == content || len < 0)
+		return 1;
+	if (!skip_prefix(end, " comment=", &comment))
+		return 1;
+	len -= comment - content;
+	if (len != GIT_SHA1_HEXSZ + 1)
 		return 1;
 
-	if (write_in_full(1, comment, 41) < 0)
+	if (write_in_full(1, comment, len) < 0)
 		die_errno("git get-tar-commit-id: write error");
 
 	return 0;
