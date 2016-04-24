From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 46/83] builtin/apply: move 'state' check into check_apply_state()
Date: Sun, 24 Apr 2016 15:33:46 +0200
Message-ID: <1461504863-15946-47-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCh-0008CN-32
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbcDXNfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:54 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38494 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbcDXNfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:52 -0400
Received: by mail-wm0-f47.google.com with SMTP id u206so89941802wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jVNRRVP2lTlvpAhcs+F1uMOd2siJsoCym37PDQEPIhY=;
        b=g+KpOzBFJBctBKWR2skHJSZ1zWlvcLXkPS+UqZjapBurb4JfVqZIhmwax/uBEIGycP
         fHZy1WGTSqbsAimDnzB3nfGVu1INV9xIA45A46sQRtrzxd9OmqxGU3LDLUOQox51MlrC
         Y3hW3DzQt7WdNFUFB4MeL5Ba+nK/ux4gVqVUYV2CAWAEC3XWEcUrQR9i7dGXnYUATVyM
         lZeAwiiuYByO2bf664+egCYWYsRD96m7wh0FobnYTjBv/BR6AvGfNUFCx82lBEKwgDUy
         osvfAonHaj7IFTZgfzXFXnCziB/RO6SSFjU2Wkent5H1bENecHR7gCXumtNeFcQLctnZ
         md7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jVNRRVP2lTlvpAhcs+F1uMOd2siJsoCym37PDQEPIhY=;
        b=YcacCHfMkIbG/n5vHBPwwLITnQqQ80k7PQRNGtvf+0tsCDZ684mjc+XC1ylcpnBNid
         55xZu08V/7QEAkZOyANMmijlqDzd0bzpFpZQvSQrj/gl5bwz6QZYhtqtA2D0ZxkbajqM
         W4AzBQnqgkdQrEFWApRwY2hZnLeYVrxT7kCrDylMinqrV8GQPWrJ8mz37XXHyso/I+rK
         GGj89s0fMOwmbZsnzYte8cNU8HrIHRWt9PqkVz2BKTrihD1ROwJEqubnb9/IPaXYq5TW
         ndoOtD5RWI9QD4mYVbq8EEntfmoTSVGaK0gBpLSL2GkzoLIoIITTx7O91uRMwzRKs5sd
         6SWA==
X-Gm-Message-State: AOPr4FWQtNY4IvLB45nR49iqz47W+opIHYLpcgtAqzRX0ltFG6D19yS5nXqqNHjgJI58KQ==
X-Received: by 10.194.107.6 with SMTP id gy6mr11958711wjb.20.1461504951245;
        Sun, 24 Apr 2016 06:35:51 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:50 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292345>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 52 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index f2dffa9..94bf120 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4692,11 +4692,38 @@ static void init_apply_state(struct apply_state *state, const char *prefix_)
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
@@ -4776,28 +4803,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.1.300.g5fed0c0
