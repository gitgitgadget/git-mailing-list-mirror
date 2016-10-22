Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A44C20986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965106AbcJVXdj (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:39 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36261 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964952AbcJVXdc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:32 -0400
Received: by mail-it0-f43.google.com with SMTP id e187so74384119itc.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8WGWKx+EyeCHt6hcgFZBUT9CiUAZvQaFMkyJZcWSwLI=;
        b=ffmN83a4uJWoqNChNCTA1yP/k5dotTd5FNyOdQUJHZfgmQiD8FSC1s104FDX/kV+qa
         bxLbnHmvSCXKi/2dYF7sue6+tGpVmQ3bOxgK0MedrylIUBKoCF3MqZY9GvD1h4Ukk07O
         jDhZev8dEx6QRFO3cOPozdm95xWq5IpqsA0HoeczttHRrCnOLQtElxR2OQ+9pR/5kJca
         D09FbK5Pzy0EKyF+BR5h5Ya6uurknSuSkN2Ybush2OsmNSeFtPjDxHxvWk30XJgz5OK+
         /x+2DH6+lShPSCGhCY2r/yETCgBz0pJxHUNJt+jePSLthpHId0B0nKqmozS9NnJKU6lm
         7l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8WGWKx+EyeCHt6hcgFZBUT9CiUAZvQaFMkyJZcWSwLI=;
        b=LRaBA2VGZ1wSnALjvIKt/8iz9LrAfW/S9EtanfWkhBkdM99YXL2D6mBYr6NTuHUIwN
         BXbTHlM0XbRsrZ0/TrHumgq89B+V4j9NazwlWyt9AfaIShgPF5gHFcGCoAVOcsnZgLDR
         OqsfeKg9wvb01XFIT7Yk8nQmo4/EB9bHFLipqu2SKFD50Jk2kr+eutBu7549YjeAUXfN
         iLe97ldiVdv54N62+ApgyrZbcK7IP56a4bWSLIh9ZGUcxv/HM2SwIGkJL0NsIUCcUxcD
         5qicO9W3mWw/dUcwtV2bfDk1DeFRI8oTfmY0PVQMzMLmGzmJUTEraiCUusdzBrJxwmGT
         hTrg==
X-Gm-Message-State: ABUngvcElnoSq8eXjI00OdQeu2tOKvSDmKkFKwKQswjSb168tS356+0+SvpOEFi5UYRRICz3
X-Received: by 10.36.207.8 with SMTP id y8mr7235151itf.92.1477179211810;
        Sat, 22 Oct 2016 16:33:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id j76sm1974856itb.5.2016.10.22.16.33.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 31/36] pathspec: move prefix check out of the inner loop
Date:   Sat, 22 Oct 2016 16:32:20 -0700
Message-Id: <20161022233225.8883-32-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prefix check is not related the check of pathspec magic; also there
is no code that is relevant after we'd break the loop on a match for
"prefix:". So move the check before the loop and shortcircuit the outer
loop.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pathspec.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 67678fc..d44f8e7 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -107,21 +107,22 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
 			nextat = copyfrom + len;
 		if (!len)
 			continue;
+
+		if (starts_with(copyfrom, "prefix:")) {
+			char *endptr;
+			*pathspec_prefix = strtol(copyfrom + 7,
+						  &endptr, 10);
+			if (endptr - copyfrom != len)
+				die(_("invalid parameter for pathspec magic 'prefix'"));
+			continue;
+		}
+
 		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 			if (strlen(pathspec_magic[i].name) == len &&
 			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
 				*magic |= pathspec_magic[i].bit;
 				break;
 			}
-			if (starts_with(copyfrom, "prefix:")) {
-				char *endptr;
-				*pathspec_prefix = strtol(copyfrom + 7,
-							  &endptr, 10);
-				if (endptr - copyfrom != len)
-					die(_("invalid parameter for pathspec magic 'prefix'"));
-				/* "i" would be wrong, but it does not matter */
-				break;
-			}
 		}
 		if (ARRAY_SIZE(pathspec_magic) <= i)
 			die(_("Invalid pathspec magic '%.*s' in '%s'"),
-- 
2.10.1.508.g6572022

