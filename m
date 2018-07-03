Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A551F660
	for <e@80x24.org>; Tue,  3 Jul 2018 12:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeGCM5e (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 08:57:34 -0400
Received: from goliath.siemens.de ([192.35.17.28]:43630 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeGCM5d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 08:57:33 -0400
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w63CcN1U017356
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 14:38:24 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id w63CcME7008580;
        Tue, 3 Jul 2018 14:38:23 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 4/8] gpg-interface: introduce an abstraction for multiple gpg formats
Date:   Tue,  3 Jul 2018 14:38:16 +0200
Message-Id: <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a struct that holds the format details for the supported formats.
At the moment that is still just "PGP". This commit prepares for the
introduction of more formats, that might use other programs and match
other signatures.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 gpg-interface.c | 80 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 1def1f131..cd3b1b568 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,12 +7,46 @@
 #include "tempfile.h"
 
 static char *configured_signing_key;
-static const char *gpg_format = "PGP";
-static const char *gpg_program = "gpg";
+struct gpg_format_data {
+	const char *format;
+	const char *program;
+	const char *extra_args_verify[1];
+	const char *sigs[2];
+};
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
 
+enum gpgformats { PGP_FMT };
+struct gpg_format_data gpg_formats[] = {
+	{ .format = "PGP", .program = "gpg",
+	  .extra_args_verify = { "--keyid-format=long", },
+	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE, },
+	},
+};
+static const char *gpg_format = "PGP";
+
+static struct gpg_format_data *get_format_data(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
+		if (!strcmp(gpg_formats[i].format, gpg_format))
+			return gpg_formats + i;
+	assert(0);
+}
+
+static struct gpg_format_data *get_format_data_by_sig(const char *sig)
+{
+	int i, j;
+	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
+		for (j = 0; j < ARRAY_SIZE(gpg_formats[i].sigs); j++)
+			if (gpg_formats[i].sigs[j] && 
+			    !strncmp(gpg_formats[i].sigs[j], sig,
+				     strlen(gpg_formats[i].sigs[j])))
+				return gpg_formats + i;
+	return NULL;
+}
+
 void signature_check_clear(struct signature_check *sigc)
 {
 	FREE_AND_NULL(sigc->payload);
@@ -104,8 +138,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 
 static int is_gpg_start(const char *line)
 {
-	return starts_with(line, PGP_SIGNATURE) ||
-		starts_with(line, PGP_MESSAGE);
+	return (get_format_data_by_sig(line) != NULL);
 }
 
 size_t parse_signature(const char *buf, size_t size)
@@ -132,6 +165,8 @@ void set_signing_key(const char *key)
 
 int git_gpg_config(const char *var, const char *value, void *cb)
 {
+	int i, j;
+
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -140,18 +175,20 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "gpg.format")) {
-		if (!strcmp(value, "PGP"))
+		j = 0;
+		for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
+			if (!strcmp(value, gpg_formats[i].format)) {
+				j++;
+				break;
+			}
+		if (!j)
 			return error("malformed value for %s: %s", var, value);
 		return git_config_string(&gpg_format, var, value);
 	}
 
-	if (!strcmp(var, "gpg.program")) {
-		if (!value)
-			return config_error_nonbool(var);
-		gpg_program = xstrdup(value);
-		return 0;
-	}
-
+	if (!strcmp(var, "gpg.program"))
+		return git_config_string(&gpg_formats[PGP_FMT].program, var,
+					 value);
 	return 0;
 }
 
@@ -165,12 +202,14 @@ const char *get_signing_key(void)
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
+	struct gpg_format_data *fmt;
 	int ret;
 	size_t i, j, bottom;
 	struct strbuf gpg_status = STRBUF_INIT;
 
+	fmt = get_format_data();
 	argv_array_pushl(&gpg.args,
-			 gpg_program,
+			 fmt->program,
 			 "--status-fd=2",
 			 "-bsau", signing_key,
 			 NULL);
@@ -208,8 +247,9 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			 struct strbuf *gpg_output, struct strbuf *gpg_status)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
+	struct gpg_format_data *fmt;
 	struct tempfile *temp;
-	int ret;
+	int ret, i;
 	struct strbuf buf = STRBUF_INIT;
 
 	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
@@ -223,10 +263,18 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		return -1;
 	}
 
+	fmt = get_format_data_by_sig(signature);
+	assert(fmt);
+
+	argv_array_pushl(&gpg.args,
+			 fmt->program, NULL);
+	for (i = 0; i < ARRAY_SIZE(fmt->extra_args_verify); i++)
+		if (fmt->extra_args_verify[i])
+			argv_array_pushl(&gpg.args,
+					 fmt->extra_args_verify[i], NULL);
+
 	argv_array_pushl(&gpg.args,
-			 gpg_program,
 			 "--status-fd=1",
-			 "--keyid-format=long",
 			 "--verify", temp->filename.buf, "-",
 			 NULL);
 
-- 
2.16.4

