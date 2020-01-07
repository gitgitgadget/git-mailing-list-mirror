Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96D3C3F68F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A622073D
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rngiClKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgAGBg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:36:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60672 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbgAGBgz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Jan 2020 20:36:55 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9EFC660787;
        Tue,  7 Jan 2020 01:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578361015;
        bh=oyb23SC/BMNDhDj3uAZnTAmobFiVaBfDs/FQ/J2bwZc=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rngiClKka/mp5VOlFRPSULAnRcReScAyoOKGUFPgFV1JmtFyegINDPLnIf0eJTqDU
         ZxbP085ZtIEhrAR3FeISYmMy78z1Q1DM7Rq6x3sf41SjFaZiU6CSmKKrCqUuW3equm
         EXha3+LaUfa2upp2q9AQOL9Dt45gASvcWzHC8a6ev+bABWkI6mXaPoOnFebH1tEgPV
         cKOEAkA/W9MGgicrKV+/aUYFxrykOOD/XexrpHPQMoEGDtjzKD38hHb9k4eNN4kZag
         j65jPhFem6zhuuaX1t8kjDM9x9rMzU4WzutgUeIFwzJc5FWTOChGkakFJfb5l6N8Xz
         rYwltNLs7l0tgMRbgW6VZL44P77hbQ9Wx+vGGp3MjkNvNO25rbWKSJMc/Mf7xGt9tz
         LfR5DWG3prGJbgXAu0eC+nHTWZPRzmSmR2BdHKoSY9SiyDnPc30sNlvYo5wXk8D0Ow
         F1u9aBFMt0I7R34mIK24OUi7kCtdXFLts/NGY3a9pCDxBecF+fQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Miriam R." <mirucam@gmail.com>
Subject: [PATCH] run-command: avoid undefined behavior in exists_in_PATH
Date:   Tue,  7 Jan 2020 01:36:40 +0000
Message-Id: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this function, we free the pointer we get from locate_in_PATH and
then check whether it's NULL.  However, this is undefined behavior if
the pointer is non-NULL, since the C standard no longer permits us to
use a valid pointer after freeing it.

The only case in which the C standard would permit this to be defined
behavior is if r were NULL, since it states that in such a case "no
action occurs" as a result of calling free.

It's easy to suggest that this is not likely to be a problem, but we
know that GCC does aggressively exploit the fact that undefined
behavior can never occur to optimize and rewrite code, even when that's
contrary to the expectations of the programmer.  It is, in fact, very
common for it to omit NULL pointer checks, just as we have here.

Since it's easy to fix, let's do so, and avoid a potential headache in
the future.

Noticed-by: Miriam R. <mirucam@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 run-command.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 9942f120a9..f5e1149f9b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -213,8 +213,9 @@ static char *locate_in_PATH(const char *file)
 static int exists_in_PATH(const char *file)
 {
 	char *r = locate_in_PATH(file);
+	int found = r != NULL;
 	free(r);
-	return r != NULL;
+	return found;
 }
 
 int sane_execvp(const char *file, char * const argv[])
