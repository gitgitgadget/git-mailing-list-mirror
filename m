Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53254202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 13:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbdJRNYn (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 09:24:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44738 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdJRNYc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 09:24:32 -0400
Received: by mail-wr0-f196.google.com with SMTP id l24so5022069wre.1
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m9zzMPJ+/PCUghipj4xxknGB+j7aerTbe/sSjsQoO+8=;
        b=Z9hqexBl8/kFeQ6AXHjztfDBLjcJejLsVT93soOvuu1EnZxEi5VBk4AY809NTyQ9wi
         c4YHR2IED6BaeHUSrPQ2uGnZ0K7BMuKRoPB/y1H/+oqtEWfT+Rx0v2EodWfa8nc9X0Ux
         newl2RlhmB5DvPNsgTNvQwQ5tVOebzbH6qAftLlvZMcgJ2So/SQZStoV+E6CDxXVaGVy
         8rzKhByn0RZt03WncdvtpwHAFXIHYIgi9x4omILgirZ/+bturgAiOKXdejXzblthtUyc
         GO1Cts9bseStF0O2CRbKUG2naVT6vadb4vfQnbEw+XzxDa+JKnvrcTV6RRAgkZ4RCX/U
         S+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m9zzMPJ+/PCUghipj4xxknGB+j7aerTbe/sSjsQoO+8=;
        b=e5eEPt6UJlckPGRw7tcgnqxSB4gyFqLdwaQUOC7+9lhNXbXYsIvW0cJRJoZR4WwHDJ
         1rjuPbFjQ7ximizl8OMtRr3tql12MPIDjD/w8qR1cA2BVd6ZOgE5yNscGsY2202ZsXgv
         ljQmL6LjdXdfAvAywYSuRJCMRotZU6QFyIIkj3Rkporxcuod2MP5+qPktkc10p9wXfLf
         guNJAGVdl/Du0bLGnnsmwVkSu0lG4iDHkn4o5UfPXkOJuum952BGtSnliOMHBerTZ7RQ
         p7a8whdBETCH1W13++8h/HUHnZwXZ4kZp27WFjhDPkePgnYwra5PjsD9WgHipD9+yqB/
         pHkw==
X-Gm-Message-State: AMCzsaXalEFjfO0BUOt2PfJjfC38TrHs7RdiwIy8DBmhRQq7C/u6ATM/
        DrVSgUK5h9j5Eihkr8nPmRglJg==
X-Google-Smtp-Source: ABhQp+TSo7it4OAqjBwANR4r5lZqvxuOExLLMpj3D9g1z8mPzz3AZknelokrgTRm6j5abjyphMV7ww==
X-Received: by 10.223.185.105 with SMTP id b38mr6920698wrg.262.1508333070436;
        Wed, 18 Oct 2017 06:24:30 -0700 (PDT)
Received: from localhost.localdomain ([95.86.78.17])
        by smtp.gmail.com with ESMTPSA id j13sm6414329wrb.18.2017.10.18.06.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Oct 2017 06:24:29 -0700 (PDT)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] name-rev: Fix tag lookup on repository with mixed types of tags
Date:   Wed, 18 Oct 2017 16:24:20 +0300
Message-Id: <20171018132420.4577-1-orgads@gmail.com>
X-Mailer: git-send-email 2.15.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Commit 7550424804 (name-rev: include taggerdate in considering the best
name) introduced a bug in name-rev.

If a repository has both annotated and non-annotated tags, annotated
tag will always win, even if it was created decades after the commit.

Consider a repository that always used non-annotated tags, and at some
point started using annotated tags - name-rev --tags will return the
first annotated tags for all the old commits (in our repository it is
followed by ~5067 for one commit, or by ~120^2~21^2~88^2~87 for
another...). This is obviously not what the user expects.

There was an attempt to fix this in ef1e74065, but it is not enough.

The taggerdate should only be matched if *both tags* have it.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 builtin/name-rev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 9e088ebd11..dc9eaf21fa 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -35,7 +35,7 @@ static int is_better_name(struct rev_name *name,
 	 */
 	if (from_tag && name->from_tag)
 		return (name->taggerdate > taggerdate ||
-			(name->taggerdate == taggerdate &&
+			((taggerdate == TIME_MAX || name->taggerdate == taggerdate) &&
 			 name->distance > distance));
 
 	/*
@@ -53,7 +53,7 @@ static int is_better_name(struct rev_name *name,
 		return name->distance > distance;
 
 	/* ... or tiebreak to favor older date */
-	if (name->taggerdate != taggerdate)
+	if (taggerdate != TIME_MAX && name->taggerdate != taggerdate)
 		return name->taggerdate > taggerdate;
 
 	/* keep the current one if we cannot decide */
@@ -90,7 +90,8 @@ static void name_rev(struct commit *commit,
 				  generation, distance, from_tag)) {
 copy_data:
 		name->tip_name = tip_name;
-		name->taggerdate = taggerdate;
+		if (taggerdate != TIME_MAX)
+			name->taggerdate = taggerdate;
 		name->generation = generation;
 		name->distance = distance;
 		name->from_tag = from_tag;
-- 
2.14.2.windows.3

