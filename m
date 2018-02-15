Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904A71F404
	for <e@80x24.org>; Thu, 15 Feb 2018 21:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756082AbeBOV4d (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 16:56:33 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52444 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbeBOV41 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 16:56:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id t3so1366389wmc.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 13:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zYkIs2H+2G3xfpY8HOSGvam8k1eZHFcwcBv/cUphnY8=;
        b=f8y7OEiMq60LlQco2Cegqhi4OJS8Xc5k4ZnGXhY6fUFGVmVLY+S2hL/viL81FqutXM
         56zcX7b+VfnAwXE6AsJEOs3MumyalKHny3tbmDDk/G/84SYAVdYlPvbKXXMhhxnY+lL1
         5s9dC6WMC8xNQ655phFVRH4wXoSR/tS11obRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zYkIs2H+2G3xfpY8HOSGvam8k1eZHFcwcBv/cUphnY8=;
        b=H4MvQkCkpT+auEH4PeiSzs2puYHVjFCgTgSeXgzyIg8ogFHr0QK5t9X9Bprshmsift
         TpZUURKksCS10yzLtLc5wJCRc80yPZWMJRh09BH7dOz/dkY/YrYjiiDjNqCagTiT+yKX
         WjOuZ4rN0onyxhpOJ6KCAOLXyFgNyKhtD7NHdCU3XtB7hEiR3L3P1w97ONpY0v+WEDDh
         pla6Lu2fv6n0W8RC8gpWlsO2yXT3mLdQ02jLmMHQErhz2zS//bvEy5ZbIkv7xqR0Ljn8
         vsJ9ChujitOn+FbZWPuEZYooUfXlVOobSfDhB5H90keiysw+qMXDrVT3XF126K5uvQYu
         qnrA==
X-Gm-Message-State: APf1xPArhkXv7xNodm21tPobz7HJYhbpHBxO0ZjWDwtGb1LcgSbSEAlx
        dAL/yzABOKm5tvzqsYFaNu6FIBg8W3k=
X-Google-Smtp-Source: AH8x227ua9s57sPdH8PDb8ADzwt23awo+EDtdxnIX7QyF8K+L5GiKsuNjObgib5PuNtFqfk6c5GhYg==
X-Received: by 10.80.246.155 with SMTP id d27mr5165790edn.93.1518731785796;
        Thu, 15 Feb 2018 13:56:25 -0800 (PST)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-126-104.cgn.ip.fibianet.dk. [5.186.126.104])
        by smtp.gmail.com with ESMTPSA id d60sm11476124edc.40.2018.02.15.13.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Feb 2018 13:56:25 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 3/3] grep: avoid one strdup() per file
Date:   Thu, 15 Feb 2018 22:56:15 +0100
Message-Id: <20180215215615.21208-4-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is only one instance of grep_source_init(GREP_SOURCE_FILE), and in
that case the path and identifier arguments are equal - not just as
strings, but the same pointer is passed. So we can save some time and
memory by reusing the gs->path = xstrdup_or_null(path) we have already
done as gs->identifier, and changing grep_source_clear accordingly
to avoid a double free.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 grep.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 3d7cd0e96..b1532b1b6 100644
--- a/grep.c
+++ b/grep.c
@@ -1972,7 +1972,8 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 
 	switch (type) {
 	case GREP_SOURCE_FILE:
-		gs->identifier = xstrdup(identifier);
+		gs->identifier = identifier == path ?
+			gs->path : xstrdup(identifier);
 		break;
 	case GREP_SOURCE_OID:
 		gs->identifier = oiddup(identifier);
@@ -1986,7 +1987,10 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 void grep_source_clear(struct grep_source *gs)
 {
 	FREE_AND_NULL(gs->name);
-	FREE_AND_NULL(gs->path);
+	if (gs->path == gs->identifier)
+		gs->path = NULL;
+	else
+		FREE_AND_NULL(gs->path);
 	FREE_AND_NULL(gs->identifier);
 	grep_source_clear_data(gs);
 }
-- 
2.15.1

