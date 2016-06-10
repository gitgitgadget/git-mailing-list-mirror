From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 12/44] builtin/apply: move check_apply_state() to apply.c
Date: Fri, 10 Jun 2016 22:10:46 +0200
Message-ID: <20160610201118.13813-13-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSoG-0004Rt-U6
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbcFJUNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:13:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34918 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbcFJUMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id k184so1047805wme.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9lAJHNfTVGDNnZIK4Df7h6Fhircs9qx8qtLb07JJaMA=;
        b=ZIwn4IlcZkgEGXrlmmVPV44NVDKwkKeGXkNw7gGHnggpJfPFcoY2ENSwYYIm6k5K1h
         UwDEkCp1Rea/NgeLoD20mKq/V4t0DEejofGl2OXTkhsHoVJOJQQeC5FWAECVm+NSCbcC
         xZCoB9n+KcGJHM+OCQop3N+xjbD7ROykLI4t2YB/3OIglqpE9qQ+fnepL4L6G+Car16G
         A+fYTIGvawp2A9mGYJV1jNYu/UvsrxHXYreSj0VbQkKTc0T/mYQfwOLP9xjhqx8/fdT0
         qr8oXQ5wll//kcUBHH7PQJ375+t+nAucH7Z3EkPIq4GE8MRR+MUNcVGojgsauXA2OkHt
         Ryzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9lAJHNfTVGDNnZIK4Df7h6Fhircs9qx8qtLb07JJaMA=;
        b=WaRu94s7/6qsySxfrXlPDD2MC3xJFqRnm6tJ+z/kV5xyeMhXOdlBlNEXhhop0vSlAu
         yAwFlnK+ozjpnQflB9F14O1cMvR6rxS7nVZeq3fBwrpJfeuUnGkTgcAhyylTbdUCD8ac
         GIgUQynmzZ1wdU0rzpaNi4enD07+8BCFAFfZPnahmsRjQBoNVt5F091fT+aO5GReITtI
         JkOM1v2ik6H56m/IR0uQgUAN+ZdljIWdfgPcFSrsEG1HsjNfqGck8RgOfeAaZwmzUvDQ
         nuj5xTpduvfwz7P5xZY0miqymmElfvUn2Nx/YSWhN+IXE7sU1sLJz8fJgK1vkaO5zo2c
         oRFw==
X-Gm-Message-State: ALyK8tJD0AX4M8T8dRanLkTVVdao0m6ZjjhmDuM1tvLK9U+quAmW4A2gU0ThrrDcJHA+WA==
X-Received: by 10.28.234.16 with SMTP id i16mr702204wmh.36.1465589516432;
        Fri, 10 Jun 2016 13:11:56 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:55 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297060>

To libify `git apply` functionality we must make check_apply_state()
usable outside "builtin/apply.c".

Let's do that by moving it into "apply.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 32 ++++++++++++++++++++++++++++++++
 apply.h         |  1 +
 builtin/apply.c | 32 --------------------------------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/apply.c b/apply.c
index c5a9ee2..84dae3d 100644
--- a/apply.c
+++ b/apply.c
@@ -90,3 +90,35 @@ void clear_apply_state(struct apply_state *state)
 
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
+
+int check_apply_state(struct apply_state *state, int force_apply)
+{
+	int is_not_gitdir = !startup_info->have_repository;
+
+	if (state->apply_with_reject && state->threeway)
+		return error("--reject and --3way cannot be used together.");
+	if (state->cached && state->threeway)
+		return error("--cached and --3way cannot be used together.");
+	if (state->threeway) {
+		if (is_not_gitdir)
+			return error(_("--3way outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->apply_with_reject)
+		state->apply = state->apply_verbosely = 1;
+	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
+		state->apply = 0;
+	if (state->check_index && is_not_gitdir)
+		return error(_("--index outside a repository"));
+	if (state->cached) {
+		if (is_not_gitdir)
+			return error(_("--cached outside a repository"));
+		state->check_index = 1;
+	}
+	if (state->check_index)
+		state->unsafe_paths = 0;
+	if (!state->lock_file)
+		return error("BUG: state->lock_file should not be NULL");
+
+	return 0;
+}
diff --git a/apply.h b/apply.h
index 7d3a03b..1f2277e 100644
--- a/apply.h
+++ b/apply.h
@@ -106,5 +106,6 @@ extern int init_apply_state(struct apply_state *state,
 			    const char *prefix,
 			    struct lock_file *lock_file);
 extern void clear_apply_state(struct apply_state *state);
+extern int check_apply_state(struct apply_state *state, int force_apply);
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index d60ffce..a27fdd3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4541,38 +4541,6 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static int check_apply_state(struct apply_state *state, int force_apply)
-{
-	int is_not_gitdir = !startup_info->have_repository;
-
-	if (state->apply_with_reject && state->threeway)
-		return error("--reject and --3way cannot be used together.");
-	if (state->cached && state->threeway)
-		return error("--cached and --3way cannot be used together.");
-	if (state->threeway) {
-		if (is_not_gitdir)
-			return error(_("--3way outside a repository"));
-		state->check_index = 1;
-	}
-	if (state->apply_with_reject)
-		state->apply = state->apply_verbosely = 1;
-	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
-		state->apply = 0;
-	if (state->check_index && is_not_gitdir)
-		return error(_("--index outside a repository"));
-	if (state->cached) {
-		if (is_not_gitdir)
-			return error(_("--cached outside a repository"));
-		state->check_index = 1;
-	}
-	if (state->check_index)
-		state->unsafe_paths = 0;
-	if (!state->lock_file)
-		return error("BUG: state->lock_file should not be NULL");
-
-	return 0;
-}
-
 static int apply_all_patches(struct apply_state *state,
 			     int argc,
 			     const char **argv,
-- 
2.9.0.rc2.362.g3cd93d0
