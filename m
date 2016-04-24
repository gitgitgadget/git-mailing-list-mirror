From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 61/83] builtin/apply: libify check_apply_state()
Date: Sun, 24 Apr 2016 15:34:01 +0200
Message-ID: <1461504863-15946-62-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKD6-0008S1-OT
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbcDXNgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:22 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36889 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbcDXNgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:12 -0400
Received: by mail-wm0-f51.google.com with SMTP id n3so90223885wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rypnFRqrO0/Gc6X28jPCg72lZSCqgap8K3DjSzBL58k=;
        b=cDOwnp6WsRlsEkeHEMent8ublTvfmJ1O2I33ieVFN3/RADzYxtC1zEeC9fFYJmC84M
         D6u1/SOgbpG2CUpBG6b1JrToq9cUefRUquU/ODy/agTk6tsCQxo2q6bX5eg6YPMkqr2j
         5BhIt2+CwZPiDW24F4Q+ulo0Y5gzlGmDs3+TvD7lbplowdKyW8h2+3UUtrJR+S6eiHIk
         GYTbeeKIu/Ut4Gx9xJ6IlIe23sbYtcKl9JyeE1AsG0e2iMUbUcqCqD4OG9PhCpRurQyd
         mOymimxxI1WYhy0RIa94KRR0UAgtfyIcjwBi/vFzvAnh9Op9qbl13iNBFTwOfCZ5nwSa
         thyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rypnFRqrO0/Gc6X28jPCg72lZSCqgap8K3DjSzBL58k=;
        b=RCZmAjyeHMEH1d0CU3nKx+JiobmUMHYiXXLcMPlwvgBNPQNV9i1Qpzo4gavg6J4iCe
         xsDiR/WyILDgRXhSroJscznwsRGTphSxSAJqjqGa3UOr2a424EceSVTzcG0Ml3t3158t
         fNQuv976F3l2ShfzZJ+RfLkW2g9Md23KlKVfMOjXCxm2Sc2ByBZJlMXpSAvPMoTphEij
         SZWl+H0et0dJn8YhHwlSx8JTw0xonrDLdipaplBkhUqcO9+xIl0mInK7XBjrjjLrbasC
         VCbJydbKV1n+p2T50Y6PsMqlxF09fT6lHx45YV/RzuM7IQhF9e1WWQMwOkYbCYvhboiw
         Uj5A==
X-Gm-Message-State: AOPr4FVWXbviwgn3uODtGnIkSBZYPrqPfaarR6kF7VDvqUIZqM2VdPZAPGSMgEV4qFkoZQ==
X-Received: by 10.28.73.66 with SMTP id w63mr7197729wma.53.1461504971364;
        Sun, 24 Apr 2016 06:36:11 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:10 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292354>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e3ee199..7576ec5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4534,17 +4534,17 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void check_apply_state(struct apply_state *state, int force_apply)
+static int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		die("--reject and --3way cannot be used together.");
+		return error("--reject and --3way cannot be used together.");
 	if (state->cached && state->threeway)
-		die("--cached and --3way cannot be used together.");
+		return error("--cached and --3way cannot be used together.");
 	if (state->threeway) {
 		if (is_not_gitdir)
-			die(_("--3way outside a repository"));
+			return error(_("--3way outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->apply_with_reject)
@@ -4552,14 +4552,15 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
-		die(_("--index outside a repository"));
+		return error(_("--index outside a repository"));
 	if (state->cached) {
 		if (is_not_gitdir)
-			die(_("--cached outside a repository"));
+			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
+	return 0;
 }
 
 static int apply_all_patches(struct apply_state *state,
@@ -4723,7 +4724,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	check_apply_state(&state, force_apply);
+	if (check_apply_state(&state, force_apply))
+		exit(1);
 
 	return apply_all_patches(&state, argc, argv, options);
 }
-- 
2.8.1.300.g5fed0c0
