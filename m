Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8E41F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdGYVkl (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:40:41 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34969 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdGYVjv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:51 -0400
Received: by mail-pf0-f180.google.com with SMTP id h29so27974649pfd.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=03N/o6QfG3fYQr8E7atzqm6fPbzg4k7RrJ1z2GrdX2I=;
        b=pHViqLGoYk1ZDleJIXP94gc3mIIGqk5LHUJUoAjORh7iktAtQSZMAi8a+OO6OuC0eh
         fzUK52NThH2MmT5CcdEYAukOlDCfN/YVth29DY9VtsVW/t0jKXU0xjCOsu0h7dHLD5WD
         BOHItkgpqmSinyp3WMZzW4ur4F2FZqYHr793m4Xvf4Tp3VA5netCHmtAXTwvb2KzesvI
         i+yMoNxLK6J4U/apcAebzat44w5f0G/WjjfYFW5ONfW7dQdJkpv8dCZQUIJ+uaQdsAti
         aaXzQnZpaCtNmuPh5/TL1jL9nxZuZrgNa0flM5vKI7xeYI7j6iL18O+Jn14YjrIHsCEN
         FQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=03N/o6QfG3fYQr8E7atzqm6fPbzg4k7RrJ1z2GrdX2I=;
        b=dxe3HgT7YjSqXGMlNtTYNSoZaDbZXzp8dEPhmLrm9S7cJqxwxf9WC5mv7YZuWZVcJC
         AIP2VDmV+eGBEut6qxkbEG1+1qNjlTvXHw5lv91CKSZ+Z+HS1E+/eZYjahicw3nsi8AV
         R9ojeYtF/SJiPApS/ZAa7Vr1VWbWGvmI6qdmNqJdJD2sk2So9s1Cg+knJy9o/TnSq/If
         wkuljAsNqNGajv6yZrudZD+gP3bGb48W42Dk5P0JnLvxgtqipGcL3se2q8KnqOn8MkpT
         /wLAKKsUQ53esJSm4WyZtowR0n83V5AtnkMk8jARwvdsm9iYY9crfayttM5NEhjEyxr2
         3y9Q==
X-Gm-Message-State: AIVw112GKJHlZk8l1f0Y0HKGGu/oqKk6sPWc8pbJ4lDATR62d7MMvSip
        8qW3/5ovvnEC/yYjh1qI3w==
X-Received: by 10.98.70.86 with SMTP id t83mr20626388pfa.219.1501018790836;
        Tue, 25 Jul 2017 14:39:50 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:49 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 07/15] submodule: don't rely on overlayed config when setting diffopts
Date:   Tue, 25 Jul 2017 14:39:20 -0700
Message-Id: <20170725213928.125998-8-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't rely on overlaying the repository's config on top of the
submodule-config, instead query the repository's config directory for
the ignore field.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index c5058a4b8..f86b82fbb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -165,8 +165,16 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 {
 	const struct submodule *submodule = submodule_from_path(&null_oid, path);
 	if (submodule) {
-		if (submodule->ignore)
-			handle_ignore_submodules_arg(diffopt, submodule->ignore);
+		const char *ignore;
+		char *key;
+
+		key = xstrfmt("submodule.%s.ignore", submodule->name);
+		if (repo_config_get_string_const(the_repository, key, &ignore))
+			ignore = submodule->ignore;
+		free(key);
+
+		if (ignore)
+			handle_ignore_submodules_arg(diffopt, ignore);
 		else if (is_gitmodules_unmerged(&the_index))
 			DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
 	}
-- 
2.14.0.rc0.400.g1c36432dff-goog

