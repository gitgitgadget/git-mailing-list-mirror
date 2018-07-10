Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA51B1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 08:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbeGJIxH (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 04:53:07 -0400
Received: from david.siemens.de ([192.35.17.14]:57640 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeGJIxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 04:53:06 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w6A8qi2n011126
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 10:52:44 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6A8qgGV024364;
        Tue, 10 Jul 2018 10:52:44 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 8/9] gpg-interface: introduce new signature format "x509" using gpgsm
Date:   Tue, 10 Jul 2018 10:52:30 +0200
Message-Id: <4a2cf83a63d25776cb1996490240ce3e5df8ada4.1531208187.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit allows git to create and check x509 type signatures using
gpgsm.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 Documentation/config.txt |  2 +-
 gpg-interface.c          | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c0bd80954..b6f9b47d5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1830,7 +1830,7 @@ gpg.program::
 
 gpg.format::
 	Specifies which key format to use when signing with `--gpg-sign`.
-	Default is "openpgp", that is also the only supported value.
+	Default is "opengpg" and another possible value is "x509".
 
 gpg.<format>.program::
 	Use this to customize the program used for the signing format you
diff --git a/gpg-interface.c b/gpg-interface.c
index 65098430f..bf8d567a4 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -16,13 +16,18 @@ struct gpg_format_data {
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
+#define X509_SIGNATURE "-----BEGIN SIGNED MESSAGE-----"
 
-enum gpgformats { PGP_FMT };
+enum gpgformats { PGP_FMT, X509_FMT };
 struct gpg_format_data gpg_formats[] = {
 	{ .format = "openpgp", .program = "gpg",
 	  .extra_args_verify = { "--keyid-format=long" },
 	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE }
 	},
+	{ .format = "x509", .program = "gpgsm",
+	  .extra_args_verify = { NULL },
+	  .sigs = { X509_SIGNATURE, NULL }
+	},
 };
 static const char *gpg_format = "openpgp";
 
@@ -182,6 +187,9 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
 		return git_config_string(&gpg_formats[PGP_FMT].program, var,
 					 value);
+	if (!strcmp(var, "gpg.x509.program"))
+		return git_config_string(&gpg_formats[X509_FMT].program, var,
+					 value);
 	return 0;
 }
 
-- 
2.16.4

