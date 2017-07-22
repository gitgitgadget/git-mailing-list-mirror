Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51005203F3
	for <e@80x24.org>; Sat, 22 Jul 2017 04:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbdGVEjY (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 00:39:24 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33005 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdGVEjY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 00:39:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id y43so13411818wrd.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 21:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h7ofG6OS3V9Cj9IOnO05bhbhjOAQvSnTYct7vINsugA=;
        b=ix1YPdIeGUpOYasGJIbRUsWiqIQFjUZyZHMwLkDMcyU1gGlE4VZbwSK8H4KrW0dNIv
         OSGiwskFvV+GyHkMu02AfN5aD6FDVd3FLcLceq5HHQnELiLRHrPHHxdfm1xw+8Tms8Tu
         QmzJIhALySLLkAy81DKycRUaGqKJKlbb0Rs/AviFq0BiYqk9UOEBShur0sgzIsIhTGdP
         3N52rdBBE9p1o+TmlJb8k/hjLRXec5MDzNNEDzZXGbRG5GwU8UH6r1UP8WQgLlx/TwCV
         46aK1G6ucR2vWSJCHy+Dl4XaHTKhnV8L094s66Rf4KQ2aXyn2blSJFWEGdFXrdBiNpph
         rbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h7ofG6OS3V9Cj9IOnO05bhbhjOAQvSnTYct7vINsugA=;
        b=mpfXnuFKYTmj6l+Y7EqoGDSyDdvJtoNQxF3O77JeW9QhAt8juLDi3OAWxAdjJxGm/e
         mST0pt09X1DISqAatVZVVMElEV6XwpZHARm+kGrPpNmQJLmXcnW/xyGggYj19S2mEtgN
         As7UCNVkn6wkc+Bh0EsilErUdhQ5GBLCPqypFPTmM+ScfA+UvSRsb9QbC1ro2+zDdxNg
         z/BdXeqxjNR6wLjTfbDFXKERGG4vkyod9Ja3styTDYsaSU5TD/DM3DYG2Qdbh+SIhbs9
         PKAURf63xLTnspaPzwPUXM/irFJop8XdUnM/fryNr14vzMJaQJjjTPpVvXtiUCwEaDn4
         PBTg==
X-Gm-Message-State: AIVw113J2KGEulERlZlS0Xey/z6Gxds1IybegLQnyVE92ViDdlxf1kUg
        mr0DSsNXXXLLiTUu
X-Received: by 10.223.134.26 with SMTP id 26mr8074284wrv.268.1500698362771;
        Fri, 21 Jul 2017 21:39:22 -0700 (PDT)
Received: from localhost.localdomain (72.198.126.78.rev.sfr.net. [78.126.198.72])
        by smtp.gmail.com with ESMTPSA id u49sm4688790wrc.14.2017.07.21.21.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jul 2017 21:39:21 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lukas Fleischer <lfleischer@lfos.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] refs: use skip_prefix() in ref_is_hidden()
Date:   Sat, 22 Jul 2017 06:39:12 +0200
Message-Id: <20170722043912.32118-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc0.26.g981adb928e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is shorter, makes the logic a bit easier to follow, and is
perhaps a bit faster too.

The logic is to make the final decision only when "subject" is there,
its early part matches "match", and the match is at the slash
boundary (or the whole thing).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

The change with the previous version was suggested by Junio in

https://public-inbox.org/git/xmqqk231hgpz.fsf@gitster.mtv.corp.google.com/

 refs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index ba22f4acef..ea2b9f84f8 100644
--- a/refs.c
+++ b/refs.c
@@ -1160,7 +1160,7 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 		const char *match = hide_refs->items[i].string;
 		const char *subject;
 		int neg = 0;
-		int len;
+		const char *p;
 
 		if (*match == '!') {
 			neg = 1;
@@ -1175,10 +1175,9 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 		}
 
 		/* refname can be NULL when namespaces are used. */
-		if (!subject || !starts_with(subject, match))
-			continue;
-		len = strlen(match);
-		if (!subject[len] || subject[len] == '/')
+		if (subject &&
+		    skip_prefix(subject, match, &p) &&
+		    (!*p || *p == '/'))
 			return !neg;
 	}
 	return 0;
-- 
2.14.0.rc0.26.g981adb928e.dirty

