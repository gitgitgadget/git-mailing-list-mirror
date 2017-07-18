Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745F620387
	for <e@80x24.org>; Tue, 18 Jul 2017 19:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbdGRTFo (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:05:44 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32775 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdGRTFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:05:41 -0400
Received: by mail-pg0-f54.google.com with SMTP id k14so17611698pgr.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D7wZv/yY9ELwCwOfCc2fFhvERtIqxqRmmx2FTex2SZY=;
        b=fWLsu+obblkNudFeqwchgt1LuMWKsqbiZ6+xj17G2lJbkRNTB+3oxGkQxlvpuxVs30
         WEFnp3wB33CYJi0t4vHVYK5w2nwS4mMfiaE4cSxBbK94cVtO9LLnJjpoFu10WGvn0Eyr
         GZ23BVe7FmYG7tc8DzFSG6BZ33CCK4r/9JVVTmJSb71vTHCwA6yGV5XEpNQn6y60E4Tp
         XcBfadU7oxddcFgEV+GAVcXuJIgxYyRLOFdWsA0BDisFAKaViukdAsYd/dZSrUJL6Xop
         HWeUs2l7p754LIMDujJ/9pKYKn07flWprDXn3gLdgggtlF6m50igK5+GmfKrCQRu7X2l
         dQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D7wZv/yY9ELwCwOfCc2fFhvERtIqxqRmmx2FTex2SZY=;
        b=mReJEABKTXVXpXwtHm1fUdp+zeNzREqu6Vycru3TPcu521Z706XsqERWTo7P3v7cyx
         PTKlw2J6eKbWql8PlXadYLSsFVaCgXmqupOJytQ39DS5FGWYZFBEIHCmDd9Nkac9OHQR
         grMiMIHbHTyir0vYRnkwJ4H7hq0o/ZMj+WNVbuttCsqld4acdOOJ5yXedLOZI45h6XwV
         WjI8hVjmzrVliMoIUjBo027aF6uRiUxgukenrOE7ARLb4YRpcL0/SzrDgfLFtm8H2/VB
         2H5/lcwFX55MZzLdoZMlB9vT5LKp1ylQx1e4BGMFKMHH+yZHakdxkVQHzcbO+5Er8jVQ
         SLhQ==
X-Gm-Message-State: AIVw111LXPmIFloQ9mLqmtssvAwlkxOOfe/PhdNLQD5FXUsbxbXhgZGB
        bHRx2VCGQQ+82zc+7IAZtQ==
X-Received: by 10.84.198.1 with SMTP id o1mr3423542pld.33.1500404740678;
        Tue, 18 Jul 2017 12:05:40 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t11sm6894649pfi.66.2017.07.18.12.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 12:05:39 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 02/10] repository: have the_repository use the_index
Date:   Tue, 18 Jul 2017 12:05:19 -0700
Message-Id: <20170718190527.78049-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170718190527.78049-1-bmwill@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the index state which is stored in 'the_repository' be a pointer to
the in-core index 'the_index'.  This makes it easier to begin
transitioning more parts of the code base to operate on a 'struct
repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repository.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index 8e60af1d5..c0e0e0e7e 100644
--- a/repository.c
+++ b/repository.c
@@ -4,7 +4,9 @@
 #include "submodule-config.h"
 
 /* The main repository */
-static struct repository the_repo;
+static struct repository the_repo = {
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, 0, 0
+};
 struct repository *the_repository = &the_repo;
 
 static char *git_path_from_env(const char *envvar, const char *git_dir,
-- 
2.13.2.932.g7449e964c-goog

