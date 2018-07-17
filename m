Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6461F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbeGQNXF (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 09:23:05 -0400
Received: from thoth.sbs.de ([192.35.17.2]:58856 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731477AbeGQNXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 09:23:05 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w6HCoEWn004793
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:50:15 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6HCoEZX005172;
        Tue, 17 Jul 2018 14:50:14 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 3/7] gpg-interface: introduce an abstraction for multiple gpg formats
Date:   Tue, 17 Jul 2018 14:50:09 +0200
Message-Id: <afe7d2ef577d265ace458ef73f7a18b9ded91cd8.1531831244.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531831244.git.henning.schild@siemens.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531831244.git.henning.schild@siemens.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
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
 gpg-interface.c | 88 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 21 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index b39a27980..a02db7658 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,11 +7,52 @@
 #include "tempfile.h"
 
 static char *configured_signing_key;
-static const char *gpg_format = "openpgp";
-static const char *gpg_program = "gpg";
+struct gpg_format {
+	const char *name;
+	const char *program;
+	const char **verify_args;
+	const char **sigs;
+};
+
+static const char *openpgp_verify_args[] = {
+	"--keyid-format=long",
+	NULL
+};
+static const char *openpgp_sigs[] = {
+	"-----BEGIN PGP SIGNATURE-----",
+	"-----BEGIN PGP MESSAGE-----",
+	NULL
+};
+
+static struct gpg_format gpg_format[] = {
+	{ .name = "openpgp", .program = "gpg",
+	  .verify_args = openpgp_verify_args,
+	  .sigs = openpgp_sigs
+	},
+};
+
+static struct gpg_format *use_format = &gpg_format[0];
 
-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
-#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
+static struct gpg_format *get_format_by_name(const char *str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gpg_format); i++)
+		if (!strcmp(gpg_format[i].name, str))
+			return gpg_format + i;
+	return NULL;
+}
+
+static struct gpg_format *get_format_by_sig(const char *sig)
+{
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(gpg_format); i++)
+		for (j = 0; gpg_format[i].sigs[j]; j++)
+			if (starts_with(sig, gpg_format[i].sigs[j]))
+				return gpg_format + i;
+	return NULL;
+}
 
 void signature_check_clear(struct signature_check *sigc)
 {
@@ -102,12 +143,6 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }
 
-static int is_gpg_start(const char *line)
-{
-	return starts_with(line, PGP_SIGNATURE) ||
-		starts_with(line, PGP_MESSAGE);
-}
-
 size_t parse_signature(const char *buf, size_t size)
 {
 	size_t len = 0;
@@ -115,7 +150,7 @@ size_t parse_signature(const char *buf, size_t size)
 	while (len < size) {
 		const char *eol;
 
-		if (is_gpg_start(buf + len))
+		if (get_format_by_sig(buf + len))
 			match = len;
 
 		eol = memchr(buf + len, '\n', size - len);
@@ -132,6 +167,9 @@ void set_signing_key(const char *key)
 
 int git_gpg_config(const char *var, const char *value, void *cb)
 {
+	struct gpg_format *fmt = NULL;
+	char *fmtname = NULL;
+
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -142,17 +180,20 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "gpg.format")) {
 		if (!value)
 			return config_error_nonbool(var);
-		if (strcmp(value, "openpgp"))
+		fmt = get_format_by_name(value);
+		if (!fmt)
 			return error("unsupported value for %s: %s",
 				     var, value);
-		return git_config_string(&gpg_format, var, value);
+		use_format = fmt;
+		return 0;
 	}
 
-	if (!strcmp(var, "gpg.program")) {
-		if (!value)
-			return config_error_nonbool(var);
-		gpg_program = xstrdup(value);
-		return 0;
+	if (!strcmp(var, "gpg.program"))
+		fmtname = "openpgp";
+
+	if (fmtname) {
+		fmt = get_format_by_name(fmtname);
+		return git_config_string(&fmt->program, var, value);
 	}
 
 	return 0;
@@ -173,7 +214,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	struct strbuf gpg_status = STRBUF_INIT;
 
 	argv_array_pushl(&gpg.args,
-			 gpg_program,
+			 use_format->program,
 			 "--status-fd=2",
 			 "-bsau", signing_key,
 			 NULL);
@@ -211,6 +252,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			 struct strbuf *gpg_output, struct strbuf *gpg_status)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
+	struct gpg_format *fmt;
 	struct tempfile *temp;
 	int ret;
 	struct strbuf buf = STRBUF_INIT;
@@ -226,10 +268,14 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		return -1;
 	}
 
+	fmt = get_format_by_sig(signature);
+	if (!fmt)
+		BUG("bad signature '%s'", signature);
+
+	argv_array_push(&gpg.args, fmt->program);
+	argv_array_pushv(&gpg.args, fmt->verify_args);
 	argv_array_pushl(&gpg.args,
-			 gpg_program,
 			 "--status-fd=1",
-			 "--keyid-format=long",
 			 "--verify", temp->filename.buf, "-",
 			 NULL);
 
-- 
2.16.4

