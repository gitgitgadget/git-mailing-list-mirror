Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35D55203BD
	for <e@80x24.org>; Thu, 27 Oct 2016 22:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943037AbcJ0WjK (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:39:10 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35827 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943033AbcJ0WjI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:39:08 -0400
Received: by mail-pf0-f170.google.com with SMTP id s8so25079602pfj.2
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xZC8fd6JRFbVhcWfssZeGfmmBTlFjOPbYPEBPFv1wXA=;
        b=JWQbDyVVyxFXEOcIESGrxbyi62wABDt1JMOA56xshue7v+8/PAbdGXivys8ECmNzUe
         i8mSLo18eNmy/XMyho1C4YUt+LGL43AvOzDuK2jjWYR2PDbkaa4RrQS+EYbGL/9jo4a/
         f4wZhK3ZZpElKkrHGE08Sx55P/shq8p33jAKkGZEFL/VfehQEBGqJXVw3s46ldiXw283
         D7SZ8DlDOO3UcuEMF3XEM3cXy50BE26Ko5ChThEj7/O0FDcItWGcHKo0CPr0aZphBbF1
         1/GwExNWvEZkO+vHUBN9A+WJMBcOYiFU2mTjEbDC9O+Ga3vI/XNMbcByqETfQUSbqJLG
         VEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xZC8fd6JRFbVhcWfssZeGfmmBTlFjOPbYPEBPFv1wXA=;
        b=UXzfJm1wX9oMX/R4G8UmCjsPEpIy1anTSxWWrCpiviBB+pf8l8Iy2xpQpaE2ne5BTr
         Xu2hzic+o6nHK0vAvDJ3k1mfRjbfX3ytOvcEU4kjvRwoAGL47d0LmajT5Az8plzMlL9F
         FGukvtiDm0O5jj6nsokB+WGn1IoNw0eyhJGbkij3N5KnAF0tacmtSiRz9ZPJ736y+Rgw
         E9Ew/UYAdBKKRVAl4YiEYBfS5PZyMAhUDS+XM5gkRAhInvrjA8MuB+NsooRKir0+ZdXy
         P4aBVjYGt0ArYEftbwpcbUMu9bA7cfSw+d/Agi085Tbr9nWe2cvg5I4feeXDjpIcfLSQ
         y5VQ==
X-Gm-Message-State: ABUngvf9Wt7CE13j8Atu1GyR21tIp0ihJxR+66/pMGxXbH9fNp+aQs6jYOYh4oz//R1/yjiJ
X-Received: by 10.99.65.133 with SMTP id o127mr15356140pga.73.1477607947158;
        Thu, 27 Oct 2016 15:39:07 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.37.191])
        by smtp.gmail.com with ESMTPSA id d2sm8129400pfd.38.2016.10.27.15.39.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 27 Oct 2016 15:39:06 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/5] grep: add submodules as a grep source type
Date:   Thu, 27 Oct 2016 15:38:32 -0700
Message-Id: <20161027223834.35312-4-bmwill@google.com>
X-Mailer: git-send-email 2.10.1.613.g6021889
In-Reply-To: <20161027223834.35312-1-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
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
index 1194d35b5..0dbdc1d00 100644
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
index 5856a23e4..267534ca2 100644
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
2.10.1.613.g6021889

