Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795491F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 08:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeGMIze (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 04:55:34 -0400
Received: from goliath.siemens.de ([192.35.17.28]:34051 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbeGMIzb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 04:55:31 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w6D8fVaq007860
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 10:41:31 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6D8fU0E023492;
        Fri, 13 Jul 2018 10:41:31 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 6/7] gpg-interface: introduce new signature format "x509" using gpgsm
Date:   Fri, 13 Jul 2018 10:41:28 +0200
Message-Id: <003d08b067b239a060641eadcba913e2aedb5cba.1531470729.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531470729.git.henning.schild@siemens.com>
References: <cover.1531470729.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531470729.git.henning.schild@siemens.com>
References: <cover.1531470729.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit allows git to create and check x509 type signatures using
gpgsm.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 Documentation/config.txt | 5 +++--
 gpg-interface.c          | 9 +++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c0bd80954..7cfce4dc8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1830,12 +1830,13 @@ gpg.program::
 
 gpg.format::
 	Specifies which key format to use when signing with `--gpg-sign`.
-	Default is "openpgp", that is also the only supported value.
+	Default is "openpgp" and another possible value is "x509".
 
 gpg.<format>.program::
 	Use this to customize the program used for the signing format you
 	chose. (see gpg.program) gpg.openpgp.program is a synonym for the
-	legacy gpg.program.
+	legacy gpg.program, while the default gpg.x509.program is "gpgsm".
+
 
 gui.commitMsgWidth::
 	Defines how wide the commit message window is in the
diff --git a/gpg-interface.c b/gpg-interface.c
index f3c22b551..62a9acf68 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -18,12 +18,18 @@ static const char *openpgp_verify_args[] = { "--keyid-format=long", NULL };
 static const char *openpgp_sigs[] = {
 	"-----BEGIN PGP SIGNATURE-----",
 	"-----BEGIN PGP MESSAGE-----", NULL };
+static const char *x509_verify_args[] = { NULL };
+static const char *x509_sigs[] = { "-----BEGIN SIGNED MESSAGE-----", NULL };
 
 static struct gpg_format gpg_formats[] = {
 	{ .name = "openpgp", .program = "gpg",
 	  .extra_args_verify = openpgp_verify_args,
 	  .sigs = openpgp_sigs
 	},
+	{ .name = "x509", .program = "gpgsm",
+	  .extra_args_verify = x509_verify_args,
+	  .sigs = x509_sigs
+	},
 };
 static struct gpg_format *current_format = &gpg_formats[0];
 
@@ -185,6 +191,9 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "gpg.program") || !strcmp(var, "gpg.openpgp.program"))
 		fmtname = "openpgp";
 
+	if (!strcmp(var, "gpg.x509.program"))
+		fmtname = "x509";
+
 	if (fmtname) {
 		fmt = get_format_by_name(fmtname);
 		return git_config_string(&fmt->program, var, value);
-- 
2.16.4

