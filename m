Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB895C43219
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbhLPNph (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbhLPNpa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65539C061746
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e5so10879592wrc.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hIOh6wjcZZyoc6fc0b5RftKi+WUZDsiKwbUYYaWlyzk=;
        b=cjeMVE+TzaiJzq8z4bzhFxNVhHYYDl+texXfSW2YmYTQBB5NhwXG8OGrM2Mw0jlo+e
         bTVpzE4mce3wDJ7PGwA2AhgCqAPszueeJVHkrocHBxnL973ME16+P/fh8g00PN5gOEPw
         jrUx3B29xshcD9aeb9tcQJGNTSoyZecgjlsKQCGiNe4hTtFF3oa5fXbYO+MM674MpUuo
         fi2IsL45Js8Ftartbv2ohHkl5yL1E5TqcRaMd1Ub4Q/tbZ+dGvG5pQEvhEDRmaGwDtHH
         WbJWsQ51LP4mXgUVDbb8Lr/Tp+3VCTO0NXzdzi91YUdbkHq/uvv7Br5WV8hY/AVyQGHM
         D2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIOh6wjcZZyoc6fc0b5RftKi+WUZDsiKwbUYYaWlyzk=;
        b=1gLm9Q3mvHZeTpchuNEmkTHqsfEtMRzvSrlIPJsy7j6W/J2EA/MdQlTNqxzBynsmWV
         rUK9RgcOX5d1vjC+ujirnyA+NUUQApgz8u3Tc99fDgeqtmRXi/wTBBob94Io6GWHLcdJ
         NNKGPNScxprGK4wnNNOrn80cMG9KYYnyRJlcighpCDkXp5LeBH8DfSjIouL9ZV2aAslu
         J0pJNWZDugJteCNYXip6HM94XHPEsGmCAAgk4NU9Mv26Q4U7EHcGFSdjmihKUr77KOJa
         lGnlQwN9G1BxrWGdXQvJ490CPb0IBzc/a+pnvf2hZ9EvK7HUm96+8EqHifvWBZEDE7f+
         +5oQ==
X-Gm-Message-State: AOAM531xCiLRPEhFNeW2YoPBN9URa4IzaK1wQUJO9vSUx7LOWgoRe+Ep
        l+7jiCBTAmpdSQJce70PW3wVJdEMj3y+Kg==
X-Google-Smtp-Source: ABdhPJwIEdhbVLU3WrmXbYqWABMWSgU9OFfaTIlEogrF7SGC5AC+H2Ypqb6h00zTSFF5oXVuCILEgQ==
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr465173wrw.182.1639662327709;
        Thu, 16 Dec 2021 05:45:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm4866821wrn.73.2021.12.16.05.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:45:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/9] reflog: reduce scope of "struct rev_info"
Date:   Thu, 16 Dec 2021 14:45:16 +0100
Message-Id: <patch-v2-7.9-2fb33ef2546-20211216T134028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "cmd.stalefix" handling added in 1389d9ddaa6 (reflog expire
--fix-stale, 2007-01-06) to use a locally scoped "struct
rev_info". This code relies on mark_reachable_objects() twiddling
flags in the walked objects.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 29dcd91abca..48e4f5887b0 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -28,7 +28,6 @@ static timestamp_t default_reflog_expire;
 static timestamp_t default_reflog_expire_unreachable;
 
 struct cmd_reflog_expire_cb {
-	struct rev_info revs;
 	int stalefix;
 	timestamp_t expire_total;
 	timestamp_t expire_unreachable;
@@ -594,13 +593,15 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 * from reflog if the repository was pruned with older git.
 	 */
 	if (cmd.stalefix) {
-		repo_init_revisions(the_repository, &cmd.revs, prefix);
-		cmd.revs.do_not_die_on_missing_tree = 1;
-		cmd.revs.ignore_missing = 1;
-		cmd.revs.ignore_missing_links = 1;
+		struct rev_info revs;
+
+		repo_init_revisions(the_repository, &revs, prefix);
+		revs.do_not_die_on_missing_tree = 1;
+		revs.ignore_missing = 1;
+		revs.ignore_missing_links = 1;
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf(_("Marking reachable objects..."));
-		mark_reachable_objects(&cmd.revs, 0, 0, NULL);
+		mark_reachable_objects(&revs, 0, 0, NULL);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			putchar('\n');
 	}
-- 
2.34.1.1020.gc80c40b6642

