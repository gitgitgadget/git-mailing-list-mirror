Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA48C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 11:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiEIL0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 07:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiEIL0O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 07:26:14 -0400
Received: from mailproxy07.manitu.net (mailproxy07.manitu.net [217.11.48.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBBA1CA372
        for <git@vger.kernel.org>; Mon,  9 May 2022 04:22:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a49:4f00:9c7:48c8:ed2a:27e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy07.manitu.net (Postfix) with ESMTPSA id 0EBF1C88AF;
        Mon,  9 May 2022 13:22:05 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH] detect-compiler: make detection independent of locale
Date:   Mon,  9 May 2022 13:22:02 +0200
Message-Id: <f306f43f375bc9b9c98e85260587442e5d9ef0ba.1652094958.git.git@grubix.eu>
X-Mailer: git-send-email 2.36.1.512.g0d1bd43151
In-Reply-To: <cover.1651859773.git.git@grubix.eu>
References: <cover.1651859773.git.git@grubix.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`detect-compiler` has accumulated a few compiler dependent workarounds
lately for the more and more ubiquitious gcc12. This is intended to make
CI set-ups work across tool-chain updates, but also help those
developers who build with `DEVELOPER=1`.

Alas, `detect-compiler` uses the locale dependent output of `$(CC) -v`
to parse for the version string, which fails unless it literally
contains ` version`.

Use `LANG=C $(CC) -v` instead to grep for stable output.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
Sorry for not checking the ML before sending the previous patches. I
know now that the dir.c warning is a false psoitive and http.c's use of
stack variables and globals is a mess ;)

To my excuse: Over here, the problem with the warnings was made worse
because `DEVELOPER=1` turned them into errors for reasons fixed by this
patch ...

 detect-compiler | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/detect-compiler b/detect-compiler
index 11d60da5b7..473f3bd4fe 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -9,7 +9,7 @@ CC="$*"
 #
 # FreeBSD clang version 3.4.1 (tags/RELEASE...)
 get_version_line() {
-	$CC -v 2>&1 | grep ' version '
+	LANG=C $CC -v 2>&1 | grep ' version '
 }
 
 get_family() {
-- 
2.36.1.512.g0d1bd43151

