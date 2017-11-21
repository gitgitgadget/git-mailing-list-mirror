Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5532036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdKUXoM (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:44:12 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44175 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdKUXoL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:44:11 -0500
Received: by mail-pf0-f194.google.com with SMTP id r14so4505892pfl.11
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Muzl4lAiFeDVOYJka10p7MXqA3oTrnplUu7xBNkWAfw=;
        b=LN5d3j8pg9Kz84zd50xBHp/9v5aO79htY1SuSZvZZ6zTn/Pd+CBSpgEbop18HjUm5A
         C3iq2E/y32kf2f0STXO67qUowI3bAoazzXE86STDkIApZo6Lpm0CQwyTNXY3zuTvnEnt
         puLiem48FnHNb7vqSuR7PhHrrIu0BnKgv36u7KKMUw7b1pGaGnGiWTNnaU3BbaiSlQH1
         UQFpmb0K3Agh2JQIRbTwChgoxoRYhtk91IgAymXSqp/dogT7iMkqoQht4nRFtuL9loH1
         fRBRghtQLXpFrTW2964YkhnV7iAFnQu1rSamnMSDZ6tUmsjDdhM0e8LAHEERHubC1jl6
         MN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Muzl4lAiFeDVOYJka10p7MXqA3oTrnplUu7xBNkWAfw=;
        b=S/dDSpUjwUevN6j5sRDPLUix274hG97qEs+enaYwTgHyIIXgGlxaz5lIhgDINL+PL8
         WTVAkG8JJaTij8G3M1OndA2Nm+09viAQbv+dBiBJ+s18ZEHDobY80F+UfDMpDGxb2wtz
         8Wl5Yzg5VcXOSBJ4p3CvakRcTkWjuknBgQZG2sAW/wX0wrdjI0/P9gigQAzKE7sKNeg2
         2TDncUZeE2tKE4CDnQM/wUIdRDczVNrpf9D6sjrD2n812bx04zTgouJOTwPaKCeJXMhi
         y5bxjYldVPF/xvswdSBMeVJ1Iz+JZJzOxfsm7sla/KDpOIMvZCXUnyOZr93pAQAkAJyr
         8J2w==
X-Gm-Message-State: AJaThX7SEdRIZSIsFag2pTMzFVgnfO/FxpzC4sdjfwV1eiA5S1big1iC
        7B0/8pWKspvXy+kRjaARtkuPaSo3
X-Google-Smtp-Source: AGs4zMbWx/T7FP1zf9inerUL00YYhu7CvJteGWcvYbBZ8e+19UZmTxaO8M0Msz9806uX8PW+u/r0iw==
X-Received: by 10.98.80.208 with SMTP id g77mr17024382pfj.201.1511307849927;
        Tue, 21 Nov 2017 15:44:09 -0800 (PST)
Received: from phord-x1.purestorage.com ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id t4sm23328754pfd.110.2017.11.21.15.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 15:44:08 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Phil Hord <phil.hord@gmail.com>
Subject: [PATCH] defer expensive load_ref_decorations until needed
Date:   Tue, 21 Nov 2017 15:43:36 -0800
Message-Id: <20171121234336.10209-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.15.0.471.g17a719cfe.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With many thousands of references, a simple `git rev-parse HEAD` may take
more than a second to return because it first loads all the refs into
memory even though it will never use them.

Defer loading any references until we actually need them.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 log-tree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 3b904f037..c1509f8b9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -84,8 +84,10 @@ void add_name_decoration(enum decoration_type type, const char *name, struct obj
 	res->next = add_decoration(&name_decoration, obj, res);
 }
 
+static void maybe_load_ref_decorations();
 const struct name_decoration *get_name_decoration(const struct object *obj)
 {
+	maybe_load_ref_decorations();
 	return lookup_decoration(&name_decoration, obj);
 }
 
@@ -150,10 +152,13 @@ static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 
 void load_ref_decorations(int flags)
 {
-	if (!decoration_loaded) {
+	decoration_flags = flags;
+}
 
+static void maybe_load_ref_decorations()
+{
+	if (!decoration_loaded) {
 		decoration_loaded = 1;
-		decoration_flags = flags;
 		for_each_ref(add_ref_decoration, NULL);
 		head_ref(add_ref_decoration, NULL);
 		for_each_commit_graft(add_graft_decoration, NULL);
-- 
2.15.0.471.g17a719cfe.dirty

