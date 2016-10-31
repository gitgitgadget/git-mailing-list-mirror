Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29E72021E
	for <e@80x24.org>; Mon, 31 Oct 2016 22:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965024AbcJaWi6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 18:38:58 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33506 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945612AbcJaWiz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 18:38:55 -0400
Received: by mail-pf0-f180.google.com with SMTP id d2so8587980pfd.0
        for <git@vger.kernel.org>; Mon, 31 Oct 2016 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NF4Q+uyuh/uNgdb7QcoI3bpLcjotXT8LLSCPVIPQ1S8=;
        b=fpo8DrEusg9PwMAgmHqPN3dai8uNJaIDjqwgH14b4+5xREfGeVmFXaoQgL93rehjEe
         QeI3tjlVfV9zR4N15gU3zOupMg4GGWNY7PRY9p+qffWx8gQk2xFz79okIjIkP06ZQE5Q
         gb/Sml7zWDoX7DMwzts4sXtklIa2WVK6nGQ/4rcxZ3MsFFBkIyUFXd3qAe2aNDSPsTUP
         AcX+ajR+89azDXa0lSYI4+hF/mQgAIchyM2Bx088BS+F2SLfBeoqZyQS0gDvPJluD5xK
         e2pDVuate4QnVmNPX9ymQTW+gd7zGsKVfRw95brr4+y74Nbim0ngufgPpSYQ6J06tPsD
         U7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NF4Q+uyuh/uNgdb7QcoI3bpLcjotXT8LLSCPVIPQ1S8=;
        b=QFIg65WtBhhVnq3VAoF9h0YC2Qbozmwk9APvCpsX20WZd40bZfo6vX+h1REodNePvV
         LO/0d0XorZxN2rdSkNB2+l+OTIcidv9gVdijHRHX6X3Wu4aypD7ERZRwGxaLiIcbnmW2
         ZCz3E/5tq57JEh77Fok4DxHLsc6vkES+lC5AyfKQeiH9BJndreJM1UsMryWvQ/vxbg2i
         g9xGI6fszkMAaD2IHHWn6Pz3uQWsfg3Of2Cg0rDCho4Z9M+arSIRekOZWudK4qdpubi1
         7PGvaMnqPbgeTPznorpll80QqxH5OgkZkYe8k6q7KB7uO6nL05v7RznAuiqsBtWq3iMa
         T0zA==
X-Gm-Message-State: ABUngvdMMB/V/RHhNIOJ5aDrjm9ghQrJYj6oJJRWh9cb/FsoQNESl68I/YbjhCJtMe04Di+j
X-Received: by 10.99.54.74 with SMTP id d71mr44756983pga.34.1477953534672;
        Mon, 31 Oct 2016 15:38:54 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id uh10sm37847280pab.5.2016.10.31.15.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 15:38:53 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, sbeller@google.com
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 3/6] grep: add submodules as a grep source type
Date:   Mon, 31 Oct 2016 15:38:13 -0700
Message-Id: <1477953496-103596-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1477953496-103596-1-git-send-email-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
 <1477953496-103596-1-git-send-email-bmwill@google.com>
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

