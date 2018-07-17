Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33EA1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbeGQNXZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 09:23:25 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:55513 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbeGQNXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 09:23:25 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w6HCoFel029149
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:50:15 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6HCoEZa005172;
        Tue, 17 Jul 2018 14:50:15 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 6/7] gpg-interface: introduce new signature format "x509" using gpgsm
Date:   Tue, 17 Jul 2018 14:50:12 +0200
Message-Id: <85a3ce25afbeb3eeec6b2e35adaec39f6632668e.1531831244.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531831244.git.henning.schild@siemens.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531831244.git.henning.schild@siemens.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit allows git to create and check x509 type signatures using
gpgsm.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 Documentation/config.txt |  5 +++--
 gpg-interface.c          | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e871346a..ff1d4a76c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1830,12 +1830,13 @@ gpg.program::
 
 gpg.format::
 	Specifies which key format to use when signing with `--gpg-sign`.
-	Default is "openpgp", that is also the only supported value.
+	Default is "openpgp" and another possible value is "x509".
 
 gpg.<format>.program::
 	Use this to customize the program used for the signing format you
 	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
-	be used as a legacy synonym for	`gpg.openpgp.program`.
+	be used as a legacy synonym for	`gpg.openpgp.program`. The default
+	value for `gpg.x509.program` is "gpgsm".
 
 gui.commitMsgWidth::
 	Defines how wide the commit message window is in the
diff --git a/gpg-interface.c b/gpg-interface.c
index a158f08c1..bb8ea668b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -24,11 +24,23 @@ static const char *openpgp_sigs[] = {
 	NULL
 };
 
+static const char *x509_verify_args[] = {
+	NULL
+};
+static const char *x509_sigs[] = {
+	"-----BEGIN SIGNED MESSAGE-----",
+	NULL
+};
+
 static struct gpg_format gpg_format[] = {
 	{ .name = "openpgp", .program = "gpg",
 	  .verify_args = openpgp_verify_args,
 	  .sigs = openpgp_sigs
 	},
+	{ .name = "x509", .program = "gpgsm",
+	  .verify_args = x509_verify_args,
+	  .sigs = x509_sigs
+	},
 };
 
 static struct gpg_format *use_format = &gpg_format[0];
@@ -192,6 +204,9 @@ int git_gpg_config(const char *var, const char *value, void *cb)
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

