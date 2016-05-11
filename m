From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 46/94] builtin/apply: move 'state' check into check_apply_state()
Date: Wed, 11 May 2016 15:16:57 +0200
Message-ID: <20160511131745.2914-47-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3e-0003Hd-RD
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbcEKNUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33295 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbcEKNUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so9411955wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q3gojvukNWTdTnoQPc/QldGmQVysosznlJyVuVlDS6k=;
        b=NH+ribZmtEDaD2aYF6d3ij7r65OAw9ZJCON1QRQsA//IYCQ9X9CvcDkUmSS8sC9WgM
         R6fZCah9hEnKkRft3QlFNDfXt66xXU+8g1M7JnBqbc5DBmqULFFwasMNWO/j1JFtdQJp
         MPnWJzZzsIL8H2IQBFcMnsFpWqCwmUTvT6VYTrQk1Mvb5qIzzpmeMxtXe+cwc1stbUf/
         fVdfgOqOcCwIAz0gAIkcFoiRdba/f9joiYGGSyPcZ30ABCepPWKNBlm1ZCqqApei8PN5
         5saTnr39NfiFKOnzIrDYCOcZ4oVevfnpLUp1IpBYeSbp+47M4tJ8oMh9nwYx3R8G06Qi
         8v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q3gojvukNWTdTnoQPc/QldGmQVysosznlJyVuVlDS6k=;
        b=N9JV8gT6W2K9BY6A3HfUgiMWAA2hx0wghdG3tWQ9pLk08/RXVWQKpOhL7UvlKbKo+X
         1NyZ7Etz0JIq3wywX7SoOz6ULs1cqhWZFd7swDWk3SzEgRRv0RDOPD3ruFtwBbAaWj01
         6CFQFxqZg7KsNZrIyLbrGbigxpLAhDe8dESfG+eczRgiBOnW/O21NfyrzLoWGKVdPhJS
         RJ4Yv5vgx55g+YrBuZBp1EzBp/yrDuvVcgBWPZrXou1r0377X7oFa29DtjjW4DdqQQUm
         YabwxTv4I8Gv6qt5eXrrdOpg1ShA5FqSgIkZE5n2Jj8DEz5d0uHSRi26veG+yXIw7n08
         0QjQ==
X-Gm-Message-State: AOPr4FVxmacMQqlQ9XX+hIfuH478ap4lcYEyRy4nJ2hnX4iVyhVRqiu3Lk8+Sh1STS2cCQ==
X-Received: by 10.28.175.83 with SMTP id y80mr4253586wme.8.1462972801899;
        Wed, 11 May 2016 06:20:01 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:00 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294275>

To libify the apply functionality we should provide a function
to check that the values in a 'struct apply_state' instance are
coherent. Let's move the code to do that into a new
check_apply_state() function.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 52 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 14286d2..e5f76d8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4681,11 +4681,38 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
 }
 
+static void check_apply_state(struct apply_state *state, int force_apply)
+{
+	int is_not_gitdir = !startup_info->have_repository;
+
+	if (state->apply_with_reject && state->threeway)
+		die("--reject and --3way cannot be used together.");
+	if (state->cached && state->threeway)
+		die("--cached and --3way cannot be used together.");
+	if (state->threeway) {
+		if (is_not_gitdir)
+			die(_("--3way outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->apply_with_reject)
+		state->apply = state->apply_verbosely = 1;
+	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
+		state->apply = 0;
+	if (state->check_index && is_not_gitdir)
+		die(_("--index outside a repository"));
+	if (state->cached) {
+		if (is_not_gitdir)
+			die(_("--cached outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->check_index)
+		state->unsafe_paths = 0;
+}
+
 int cmd_apply(int argc, const char **argv, const char *prefix_)
 {
 	int i;
 	int errs = 0;
-	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
 	int options = 0;
 	int read_stdin = 1;
@@ -4765,28 +4792,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	if (state.apply_with_reject && state.threeway)
-		die("--reject and --3way cannot be used together.");
-	if (state.cached && state.threeway)
-		die("--cached and --3way cannot be used together.");
-	if (state.threeway) {
-		if (is_not_gitdir)
-			die(_("--3way outside a repository"));
-		state.check_index = 1;
-	}
-	if (state.apply_with_reject)
-		state.apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || state.fake_ancestor))
-		state.apply = 0;
-	if (state.check_index && is_not_gitdir)
-		die(_("--index outside a repository"));
-	if (state.cached) {
-		if (is_not_gitdir)
-			die(_("--cached outside a repository"));
-		state.check_index = 1;
-	}
-	if (state.check_index)
-		state.unsafe_paths = 0;
+	check_apply_state(&state, force_apply);
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-- 
2.8.2.490.g3dabe57
