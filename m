Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6A11F660
	for <e@80x24.org>; Tue,  3 Jul 2018 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeGCMxm (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 08:53:42 -0400
Received: from david.siemens.de ([192.35.17.14]:49802 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752878AbeGCMxk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 08:53:40 -0400
X-Greylist: delayed 891 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2018 08:53:34 EDT
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w63CcOtC016807
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 14:38:24 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id w63CcMEA008580;
        Tue, 3 Jul 2018 14:38:24 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 7/8] gpg-interface: introduce new signature format "X509" using gpgsm
Date:   Tue,  3 Jul 2018 14:38:19 +0200
Message-Id: <1f99ef66bc5e115ec06a3c456658ad54ce405ce3.1530616446.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit allows git to create and check X509 type signatures using
gpgsm.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 Documentation/config.txt |  5 ++++-
 gpg-interface.c          | 10 +++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c88903399..337df6e48 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1828,9 +1828,12 @@ gpg.program::
 	signed, and the program is expected to send the result to its
 	standard output.
 
+gpg.programX509::
+	Just like gpg.program, here the default you override is "`gpgsm`".
+
 gpg.format::
 	Specifies which key format to use when signing with `--gpg-sign`.
-	Default is "PGP", that is also the only supported value.
+	Default is "PGP" and another possible value is "X509".
 
 gui.commitMsgWidth::
 	Defines how wide the commit message window is in the
diff --git a/gpg-interface.c b/gpg-interface.c
index aa747278e..85d721007 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -16,13 +16,18 @@ struct gpg_format_data {
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
+#define X509_SIGNATURE "-----BEGIN SIGNED MESSAGE-----"
 
-enum gpgformats { PGP_FMT };
+enum gpgformats { PGP_FMT, X509_FMT };
 struct gpg_format_data gpg_formats[] = {
 	{ .format = "PGP", .program = "gpg",
 	  .extra_args_verify = { "--keyid-format=long", },
 	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE, },
 	},
+	{ .format = "X509", .program = "gpgsm",
+	  .extra_args_verify = { NULL },
+	  .sigs = {X509_SIGNATURE, NULL, }
+	},
 };
 static const char *gpg_format = "PGP";
 
@@ -190,6 +195,9 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "gpg.program"))
 		return git_config_string(&gpg_formats[PGP_FMT].program, var,
 					 value);
+	if (!strcmp(var, "gpg.programX509"))
+		return git_config_string(&gpg_formats[X509_FMT].program, var,
+					 value);
 	return 0;
 }
 
-- 
2.16.4

