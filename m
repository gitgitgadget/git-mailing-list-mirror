Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C4720281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbdI2UMb (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:31 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:51723 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbdI2UMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:25 -0400
Received: by mail-pf0-f179.google.com with SMTP id b70so331599pfl.8
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PbfaTcCqJ6VCyH+atE6bF7GzIfEALT5mBUaV3hW27mY=;
        b=quy0oMRvcGbeM7kSFPnZA5GguV6GF6493poqzr1meDS8DqqlSA+GS67ApBor7XetrK
         fKLdKoe10yE0UUCd7PktvNy9zhcMSWDwVfSgXyjZbiHyOK1FQYgTBa3TB8adVfd3emVo
         lV+Lc4CP/EvXs6JIuw2bKdaDLjEllZ2eskxIrraD5qjy7lfNG0DWZl4VAFYtDCDvhtYh
         7oDi9nxkefzB0LJayIEWrQEcebooBpCb5pflweSTEunSmfc+jHWHFsCMQhOf6dOsivZ+
         benpZsuxvsOxoQ1Pel0ds2JKbn5mR1/eezt8kYtgvkw9UZmT/uQ8w6Q6qIKEV9clyXKH
         R+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PbfaTcCqJ6VCyH+atE6bF7GzIfEALT5mBUaV3hW27mY=;
        b=m0q5D5xw1iym22wcrmtLkkVPuYZ3hhlIruDNCEf2u+KmbVSiyrEBhTsC1gor8PaHFp
         u0QQC2M2GlEyCz1r0ec9XUpte12jLOFlYSbk4tF0mhA4zpE29S5fr1k+XoTv6EkvZLGX
         4yraogDRTjtMnM1kj1b3hHTovh0xGVRDbU+y0MNoCEFZTca2UyaewcILeutEr+GRGlWa
         4WE7mgwNuPiqAbJ5s6tlXuptGBhkep+1X475ybVK10O1beVA8tuz15ZdcDIWset6DU9N
         EFg5fU5gZymkOkI8LM7r8btx073G2q+pbwSnrOynqeOzZHKRMZbhzEp5Gy2tL0Ej/Glu
         /Kxg==
X-Gm-Message-State: AHPjjUhYQVQjg32bsR452GCT0xR3nzuMIunO1ck+a2s4nWwVe1z2hBJs
        wSgDeM0u9ywD6mgBU/x7+DuF1izsUH0=
X-Google-Smtp-Source: AOwi7QCGXkzhUcB22zcfB96nPsOvm5V2yXKC/CeGxqDhtayyYcwsopL9FgnOH3hMIL14UoTwDU8z8g==
X-Received: by 10.98.95.1 with SMTP id t1mr8720152pfb.217.1506715944861;
        Fri, 29 Sep 2017 13:12:24 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:23 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 13/18] fetch: refactor calculation of remote list
Date:   Fri, 29 Sep 2017 13:11:49 -0700
Message-Id: <2234882d889d72f7f8ed86850d9aed3c471cd5b8.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Separate out the calculation of remotes to be fetched from and the
actual fetching. This will allow us to include an additional step before
the actual fetching in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 225c73492..1b1f03923 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1322,7 +1322,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct string_list list = STRING_LIST_INIT_DUP;
-	struct remote *remote;
+	struct remote *remote = NULL;
 	int result = 0;
 	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
 
@@ -1367,17 +1367,14 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		else if (argc > 1)
 			die(_("fetch --all does not make sense with refspecs"));
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
-		result = fetch_multiple(&list);
 	} else if (argc == 0) {
 		/* No arguments -- use default remote */
 		remote = remote_get(NULL);
-		result = fetch_one(remote, argc, argv);
 	} else if (multiple) {
 		/* All arguments are assumed to be remotes or groups */
 		for (i = 0; i < argc; i++)
 			if (!add_remote_or_group(argv[i], &list))
 				die(_("No such remote or remote group: %s"), argv[i]);
-		result = fetch_multiple(&list);
 	} else {
 		/* Single remote or group */
 		(void) add_remote_or_group(argv[0], &list);
@@ -1385,14 +1382,19 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			/* More than one remote */
 			if (argc > 1)
 				die(_("Fetching a group and specifying refspecs does not make sense"));
-			result = fetch_multiple(&list);
 		} else {
 			/* Zero or one remotes */
 			remote = remote_get(argv[0]);
-			result = fetch_one(remote, argc-1, argv+1);
+			argc--;
+			argv++;
 		}
 	}
 
+	if (remote)
+		result = fetch_one(remote, argc, argv);
+	else
+		result = fetch_multiple(&list);
+
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct argv_array options = ARGV_ARRAY_INIT;
 
-- 
2.14.2.822.g60be5d43e6-goog

