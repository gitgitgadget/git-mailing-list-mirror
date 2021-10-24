Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C18EC433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 19:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22184604D2
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 19:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhJXTkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 15:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJXTkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 15:40:09 -0400
X-Greylist: delayed 75 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Oct 2021 12:37:47 PDT
Received: from mackerel.carobme.de (unknown [IPv6:2a01:4f8:1c1c:4990::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6712C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 12:37:47 -0700 (PDT)
Received: from mail.carobme.de (p57a9a54f.dip0.t-ipconnect.de [87.169.165.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: mrelay)
        by mackerel.carobme.de (Postfix) with ESMTPSA id 4HcpHL1bj6zFMNK;
        Sun, 24 Oct 2021 21:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaddrinuse.net;
        s=thorn; t=1635104190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pyL+lDtRieadPSVntvDX//TowlYrARa42kljI6yf8eg=;
        b=miT1H+MHgi67Q4bK1PeeN6/w45UYZ2JPPfm84JT0S+IIprTgrWUcKc787vuiMi/fsRIzO/
        +Ur4yoNC13QhNCzEAq6vy39NWN1k6tisvvIg9jEaa9aXkoINF/Wqe2F4Eb+mPjvSqeoDcN
        QpEWTTB8768V3nO2QGZd7dc9HZ6ksMNduR+Ux/alEgf/POEdsRSS2UlnDXvrGxrDf8+Vvm
        3AUgBBl/w1ShMQO6JbKUV+qTl1pdMLcTnCAFc0UFWxgtiiwaZKAV/7F1mNcnHubBb8TnRY
        +7yTFNMeYINXk+TE+6XUB3NWgAO5QSivM+SeuSxBmZuXEkIUYGf3mcnNdmLX4Q==
Received: from octopus.int.carobme.de (octopus.int.carobme.de [192.168.78.3])
        by mail.carobme.de (Postfix) with ESMTP id 4HcpHK74RSzXRVd;
        Sun, 24 Oct 2021 21:36:29 +0200 (CEST)
From:   Marco Beck <mbeck@eaddrinuse.net>
To:     git@vger.kernel.org
Cc:     Marco Beck <mbeck@eaddrinuse.net>
Subject: [PATCH] gpg-interface: allow selecting key id with env variable
Date:   Sun, 24 Oct 2021 21:36:25 +0200
Message-Id: <20211024193625.148-1-mbeck@eaddrinuse.net>
X-Mailer: git-send-email 2.33.1.712.g5fc7320430
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows selecting the gpg(1) key id to use for signing by setting the
environment variable GIT_GPG_SIGNINGKEY.

Signed-off-by: Marco Beck <mbeck@eaddrinuse.net>
---
 Documentation/git.txt | 6 ++++++
 gpg-interface.c       | 5 +++++
 2 files changed, 11 insertions(+)

diff --git Documentation/git.txt Documentation/git.txt
index d63c65e67d..ab032f2760 100644
--- Documentation/git.txt
+++ Documentation/git.txt
@@ -941,6 +941,12 @@ corresponding standard handle, and if `GIT_REDIRECT_STDERR` is
 `2>&1`, standard error will be redirected to the same handle as
 standard output.
 
+`GIT_GPG_SIGNINGKEY`::
+	If this environment variable is set, then Git commands which use
+	`gpg(1)` for signing (e.g. linkgit:git-commit[1], linkgit:git-tag[1])
+	will use the specified key. See also the `user.signingkey` option in
+	linkgit:git-config[1].
+
 `GIT_PRINT_SHA1_ELLIPSIS` (deprecated)::
 	If set to `yes`, print an ellipsis following an
 	(abbreviated) SHA-1 value.  This affects indications of
diff --git gpg-interface.c gpg-interface.c
index 127aecfc2b..10e923140c 100644
--- gpg-interface.c
+++ gpg-interface.c
@@ -435,6 +435,11 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 
 const char *get_signing_key(void)
 {
+	const char *signing_key;
+
+	if ((signing_key = getenv("GIT_GPG_SIGNINGKEY")))
+		return signing_key;
+
 	if (configured_signing_key)
 		return configured_signing_key;
 	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
-- 
2.32.0

