From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 47/48] builtin/apply: move 'state' check into check_apply_state()
Date: Wed,  9 Mar 2016 18:49:15 +0100
Message-ID: <1457545756-20616-48-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJh-0000gp-Sb
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933790AbcCIRy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:54:26 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33252 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933761AbcCIRyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:54:08 -0500
Received: by mail-wm0-f51.google.com with SMTP id l68so203719380wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YGpUATs+3BEheK38tjn1jR+NT6le5cjIsTNikx8vD+0=;
        b=EqfabunOpZDiFjnMG9fluaCNfAF1z281PqTCscfbDnH84dKdc4uDzpH6RQi56y8g/s
         Pcnkmz5pWKA9xx4j2taHCCs5y4ZMrNFTVBQetU80LQnbczWpGrPX5jyC0Bj+0XJW86Wv
         4bC1sd2o3L0gzNkyhal39CZsczXhYPjRl+EjHbabjnqbNAZMc3A6JgZc1vidSr+9rAUU
         +J/HxRCzN60QuSZMGvP9AgdJl/CV0U5xcBdvjhvEY5n/k1CKfETc6Ht0Codz2EIdQ/B6
         cekxInW8VvX7KjPo+nLNH4AQ+I0k5pqhD+aNkSLZdRwtbAry3udbEQJE+/U4zDneo4jP
         J7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YGpUATs+3BEheK38tjn1jR+NT6le5cjIsTNikx8vD+0=;
        b=HZIItVXfUNK4ifwR/x87emd72SYDWc2pHLky6PAJeQ+bsoqOv0HgGeWjiL+XTGsgLA
         /Zmg1H5aNSnqmDFpAG0dxzcL4WNAH68MIbVGNBsE8YM5dLktSfk120LsYzqWRqdM7eH1
         A+Q7twHnVk4EjIndIYpeAqcBdSRndszUKepNT59nzYd6YzHrFnSctrNZik5K7agN36A7
         luvAO0eJhVgr1oP8QyYbqdD+cRyitUJzteInQ1zLWA5SUEab5xx8nXm5WhRiSAfR3evK
         HM89MqKDD/oFCws3Nm4nvw+r6HbGngV7xYTiTWKjwLvh27dw3t5UZwRS5N4w7154bBYN
         s6bg==
X-Gm-Message-State: AD7BkJJYQh6GG7NE402aVzav4TjRpUcmJR/xu6jin8BPT79pp+bqlXA3VWDtCxoVP70+NA==
X-Received: by 10.28.216.141 with SMTP id p135mr27935408wmg.22.1457546047658;
        Wed, 09 Mar 2016 09:54:07 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:54:06 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288536>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 52 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1676ce1..3f76469 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4690,11 +4690,38 @@ static void init_apply_state(struct apply_state *state, const char *prefix_)
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
@@ -4774,28 +4801,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.0.rc1.49.gca61272
