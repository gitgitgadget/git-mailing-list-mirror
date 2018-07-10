Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7BDA1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 08:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeGJIxS (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 04:53:18 -0400
Received: from goliath.siemens.de ([192.35.17.28]:39377 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbeGJIxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 04:53:16 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w6A8qhIL017313
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 10:52:44 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6A8qgGS024364;
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
Subject: [PATCH v2 5/9] gpg-interface: introduce an abstraction for multiple gpg formats
Date:   Tue, 10 Jul 2018 10:52:27 +0200
Message-Id: <93d74df91b9f5c68dfd8a03f576d7428491976c0.1531208187.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a struct that holds the format details for the supported formats.
At the moment that is still just "openpgp". This commit prepares for the
introduction of more formats, that might use other programs and match
other signatures.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 gpg-interface.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index ed0e55917..0a8d1bff3 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,12 +7,46 @@
 #include "tempfile.h"
 
 static char *configured_signing_key;
-static const char *gpg_format = "openpgp";
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
+	{ .format = "openpgp", .program = "gpg",
+	  .extra_args_verify = { "--keyid-format=long" },
+	  .sigs = { PGP_SIGNATURE, PGP_MESSAGE }
+	},
+};
+static const char *gpg_format = "openpgp";
+
+static struct gpg_format_data *get_format_data(const char *str)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
+		if (!strcasecmp(gpg_formats[i].format, str))
+			return gpg_formats + i;
+	return NULL;
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
@@ -140,18 +173,14 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "gpg.format")) {
-		if (strcasecmp(value, "openpgp"))
+		if (!get_format_data(value))
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
 
@@ -165,12 +194,16 @@ const char *get_signing_key(void)
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
+	struct gpg_format_data *fmt;
 	int ret;
 	size_t i, j, bottom;
 	struct strbuf gpg_status = STRBUF_INIT;
 
+	fmt = get_format_data(gpg_format);
+	if (!fmt)
+		BUG("bad gpg_format '%s'", gpg_format);
 	argv_array_pushl(&gpg.args,
-			 gpg_program,
+			 fmt->program,
 			 "--status-fd=2",
 			 "-bsau", signing_key,
 			 NULL);
@@ -208,8 +241,9 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			 struct strbuf *gpg_output, struct strbuf *gpg_status)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
+	struct gpg_format_data *fmt;
 	struct tempfile *temp;
-	int ret;
+	int ret, i;
 	struct strbuf buf = STRBUF_INIT;
 
 	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
@@ -223,10 +257,18 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
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

