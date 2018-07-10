Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208921F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 08:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeGJIxH (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 04:53:07 -0400
Received: from thoth.sbs.de ([192.35.17.2]:42004 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbeGJIxF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 04:53:05 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w6A8qh6Q026188
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 10:52:43 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6A8qgGQ024364;
        Tue, 10 Jul 2018 10:52:43 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 3/9] gpg-interface: add new config to select how to sign a commit
Date:   Tue, 10 Jul 2018 10:52:25 +0200
Message-Id: <911565bda250ebffc9a87203f2a5ae453f87e5da.1531208187.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add "gpg.format" where the user can specify which type of signature to
use for commits. At the moment only "openpgp" is supported and the value is
not even used. This commit prepares for a new types of signatures.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 Documentation/config.txt | 4 ++++
 gpg-interface.c          | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1cc18a828..ac373e3f4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1828,6 +1828,10 @@ gpg.program::
 	signed, and the program is expected to send the result to its
 	standard output.
 
+gpg.format::
+	Specifies which key format to use when signing with `--gpg-sign`.
+	Default is "openpgp", that is also the only supported value.
+
 gui.commitMsgWidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
diff --git a/gpg-interface.c b/gpg-interface.c
index 09ddfbc26..ed0e55917 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,6 +7,7 @@
 #include "tempfile.h"
 
 static char *configured_signing_key;
+static const char *gpg_format = "openpgp";
 static const char *gpg_program = "gpg";
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
@@ -138,6 +139,12 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "gpg.format")) {
+		if (strcasecmp(value, "openpgp"))
+			return error("malformed value for %s: %s", var, value);
+		return git_config_string(&gpg_format, var, value);
+	}
+
 	if (!strcmp(var, "gpg.program")) {
 		if (!value)
 			return config_error_nonbool(var);
-- 
2.16.4

