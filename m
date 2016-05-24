From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 46/49] builtin/apply: move 'state' check into check_apply_state()
Date: Tue, 24 May 2016 10:11:23 +0200
Message-ID: <20160524081126.16973-47-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:13:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57TK-0001LX-Nn
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbcEXIMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35034 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbcEXIMv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id f75so3659177wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oT+6VIQ9zHN3VJgtfuOgcwoSMIiYh2Bm7eHan8S76Sc=;
        b=DtroAP2GvKNwZZc1Mo9/YxUiatYAdHJoQV/JIbSaTkffYvFn10EsOUQUu75cG4kl7z
         DtjtJCzGboUO7Ae2Kvr3oFRBvf1Xg/R7o8Jin31+oAOfRq/saVsfcsWlQKazL0Ws0Mwi
         cDCuONfBLxa87NAGMhPaGWSLS091D/pcQ6nNNhETeSlA92aSXh+otD4Th+Hny0fhzTCc
         p5pZLx0Qf59ODRdWHvMnG/8JcyU04GwQuQGYS/sQi9Sgo1OKwHFipVCWf/n4ld9QHn3q
         xDb6Z/S8OUQepo4/nlQ3i8qE0I92uBPwYlCpIbgdmIj/K1pMdKPfROaAx6rFtRQT3Twb
         vy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oT+6VIQ9zHN3VJgtfuOgcwoSMIiYh2Bm7eHan8S76Sc=;
        b=LEf1tsc5QsAKaHRNUOlRsKtUI8m+5i2aGNM5H6/j+1vCeC0fXsfzkJjTltaL6YIu6I
         XJsZNw8SPXYWhgA6WinmqJLekfNgieem4FcXcT1mPLWopD2whbQgLnQtU8boiEoHb19p
         oxphLgD5OdI2eVGKriWdgpot3l2zH/Iq0WhzMkHGt+2kF37p+/0XnDTPjTLoB2RIooQz
         O6K7IndVIg+LRhAOm7G742/X1ZE/lWwUZHW5cAqM65bMnhu1hzkOaCIku/SS9KG8oZVa
         1m6znDmsO3go9qceE5aph2q7inAWWqSbu4MJ7aGN///jgufim3EhiLH59MKeJx+rTyZd
         5adw==
X-Gm-Message-State: ALyK8tJbwObbB88IKoS/dFP+38e23YcnLEH4HBLYKVGRMPIgD/8UWEq7mlCSQX/4CVjLdQ==
X-Received: by 10.194.169.37 with SMTP id ab5mr2800704wjc.141.1464077569563;
        Tue, 24 May 2016 01:12:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:48 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295450>

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
index 980bb34..8095026 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4679,11 +4679,38 @@ static void clear_apply_state(struct apply_state *state)
 	/* &state->fn_table is cleared at the end of apply_patch() */
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
 int cmd_apply(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int errs = 0;
-	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
 	int options = 0;
 	int read_stdin = 1;
@@ -4763,28 +4790,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
2.8.3.443.gaeee61e
