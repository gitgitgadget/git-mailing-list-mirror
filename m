Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC00E1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 19:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbcKRT7M (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 14:59:12 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36265 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbcKRT7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 14:59:08 -0500
Received: by mail-pg0-f50.google.com with SMTP id f188so105781846pgc.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NF4Q+uyuh/uNgdb7QcoI3bpLcjotXT8LLSCPVIPQ1S8=;
        b=aip25k5ak09Oszp5+nG/nnnj5aNWQi8nuZ8HQrfv07zt/O1PZaBQM+/gK+OEwhjqfV
         b530ESnrgadItJnlPEDrIvf2iJBjJCiHChA8umhtXiyOv3MxXt8lI+6ExP364mFe3byS
         e17RZmKt+g5aLukL/ZrGkSju/pm9ijc09Yi1LtbiFxW4mv/388nidJOkts8gftOKQL+z
         miTIeN+l1rj4zTI4+/19woIga6HZr/GX6vvIsD/of0pqRrMY09dZONjwZTfDPJMUNYor
         9uizJZX6vGzCPVSeRNJYoUT+i1FBIDcKCPl5RYKMDNPjArEskuZ5XT39bYnaiY1cejfv
         Tw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NF4Q+uyuh/uNgdb7QcoI3bpLcjotXT8LLSCPVIPQ1S8=;
        b=DTBRbxHLlD3ScYOgvX2DDc0EkMf91tag1bLlozjZ6JT5DJFDaFEAO+YuFZRIpfnOJg
         CEabZ04GF+3HXUvstuQE9D1NTFviNd+IFWoMvuXSoh4mj7M+okHZFwmoa4WVbH5Zh/MW
         Etbu89s2vtvSoyyj2r94IXm6PYH/dxYdo0lWJPINPjnJr4Kgsvo/FydknSCAb3KOCsiv
         CTK32pgq1/yaPn5tkor+Js+ha94aiUj23D0PznOUgt6gSolaCuy3rXKRCOhPuLiSDgb5
         aQ3yytIUfva1jm2oUAj2yksomrHVNum6aQESfPHYSYNQ4tvqr+tfASeLshPe1ZEMuly0
         2Qfw==
X-Gm-Message-State: AKaTC02F9k9oxL1Dagfq58fAAhGwbMO4dcE7PYHiZpXakhvb+yWAggbywrpjmjYS7nInpbKP
X-Received: by 10.98.14.82 with SMTP id w79mr1796978pfi.153.1479499148039;
        Fri, 18 Nov 2016 11:59:08 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm19850441pfb.42.2016.11.18.11.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Nov 2016 11:59:07 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v4 3/6] grep: add submodules as a grep source type
Date:   Fri, 18 Nov 2016 11:58:52 -0800
Message-Id: <1479499135-64269-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479499135-64269-1-git-send-email-bmwill@google.com>
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1479499135-64269-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add `GREP_SOURCE_SUBMODULE` as a grep_source type and cases for this new
type in the various switch statements in grep.c.

When initializing a grep_source with type `GREP_SOURCE_SUBMODULE` the
identifier can either be NULL (to indicate that the working tree will be
used) or a SHA1 (the REV of the submodule to be grep'd).  If the
identifier is a SHA1 then we want to fall through to the
`GREP_SOURCE_SHA1` case to handle the copying of the SHA1.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 grep.c | 16 +++++++++++++++-
 grep.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 1194d35..0dbdc1d 100644
--- a/grep.c
+++ b/grep.c
@@ -1735,12 +1735,23 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 	case GREP_SOURCE_FILE:
 		gs->identifier = xstrdup(identifier);
 		break;
+	case GREP_SOURCE_SUBMODULE:
+		if (!identifier) {
+			gs->identifier = NULL;
+			break;
+		}
+		/*
+		 * FALL THROUGH
+		 * If the identifier is non-NULL (in the submodule case) it
+		 * will be a SHA1 that needs to be copied.
+		 */
 	case GREP_SOURCE_SHA1:
 		gs->identifier = xmalloc(20);
 		hashcpy(gs->identifier, identifier);
 		break;
 	case GREP_SOURCE_BUF:
 		gs->identifier = NULL;
+		break;
 	}
 }
 
@@ -1760,6 +1771,7 @@ void grep_source_clear_data(struct grep_source *gs)
 	switch (gs->type) {
 	case GREP_SOURCE_FILE:
 	case GREP_SOURCE_SHA1:
+	case GREP_SOURCE_SUBMODULE:
 		free(gs->buf);
 		gs->buf = NULL;
 		gs->size = 0;
@@ -1831,8 +1843,10 @@ static int grep_source_load(struct grep_source *gs)
 		return grep_source_load_sha1(gs);
 	case GREP_SOURCE_BUF:
 		return gs->buf ? 0 : -1;
+	case GREP_SOURCE_SUBMODULE:
+		break;
 	}
-	die("BUG: invalid grep_source type");
+	die("BUG: invalid grep_source type to load");
 }
 
 void grep_source_load_driver(struct grep_source *gs)
diff --git a/grep.h b/grep.h
index 5856a23..267534c 100644
--- a/grep.h
+++ b/grep.h
@@ -161,6 +161,7 @@ struct grep_source {
 		GREP_SOURCE_SHA1,
 		GREP_SOURCE_FILE,
 		GREP_SOURCE_BUF,
+		GREP_SOURCE_SUBMODULE,
 	} type;
 	void *identifier;
 
-- 
2.8.0.rc3.226.g39d4020

