Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C64C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 18:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348469AbiARSzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 13:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348467AbiARSzC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 13:55:02 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18375C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 10:55:02 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t27-20020a63461b000000b00342c204e4f3so15624pga.11
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 10:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rMcxUYa+pYWoaPyu7/jTRBRqiC6fopgEoB9QwP13mZM=;
        b=WIkyDmXc32CObUkOc5fLjWwgOho0z3VX3c3TortpCq9+GraPOSqZU//zeewm00OMZ9
         j2sSok5Q4VKHiQQwaik/qCvKJv0LrSmdMSf18Vx6Fp9Czy+E1fgxjZGBEj/0fKe2qlN+
         vRDd2xV63EZm2R2yTUP+5tgj0j3yr8Nj1pcjc4r8TGxu0pF8+kfVJ8Hbr7mlVIsEsTi5
         +Pm5IF/rbhZpQrd7MNQ53XoPwFF/4IjhfAqS7A2Y9bu460YzWCh8reNpTTqE2OyhCWcx
         3Jith/kciF/AtmWBIod1g7ywC72+qkpLlo7Gs/0f8MFrvyK/fPaKVjUGJTBtxW8ITcbA
         IMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rMcxUYa+pYWoaPyu7/jTRBRqiC6fopgEoB9QwP13mZM=;
        b=X6JFkPtm3T5gMvKJ/ZEDCjYKJE7fYNds3ylqKQhiFcO+iLJIgUI/sJrDMKF8Io+EuB
         YwmtnhAENraMlfGftPcD3tihj/7QTMd2ikGcGJnGhIq/6HeBZxdqCVXXnB9enIYX8hi1
         SR8gUdIZHIuVkNBrQozZX8TFDPxy9BnOz1R78t5OOc9quZxkoG+SQxI9E+tn+WGSoglE
         OYB+81gKsNFHWvGsUYs9abd0uDInbfvp+/BPviHtVA1XlGbpPDDOgMKSRmgHRO8t9CFS
         3DXl26WAAlxwo4jgWqoardTcgGSqEpHiyYgeayU//XAwkU9Fr6yOL37Ra9uX0OfnPs6t
         mIRg==
X-Gm-Message-State: AOAM530CtnojOY+3v81F2g6iEo1XDRSubV4KWVs1CNLoFGHFjRX6t8F4
        9+iK7PAMjAM8bSDGPkMQrogg+zx3h4C9s9+TGrwFw59nxQ34CGZjoIBwSvtlpHPzUmsL3JQF9AX
        nGC0d4+tswak44XgdaFGGHDZXy7W5vW0TRupYIW9OWeC/C9+Numb2PsS7OBAjyR4=
X-Google-Smtp-Source: ABdhPJyClfK3PNQkWuJAPlI0GzYi2h9Mkx2A+6fRtLb4zmFbDt2pSr//Re+jhGAZMVveYeezfJSrqF3SVGoOYw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:ae15:: with SMTP id
 t21mr32398659pjq.147.1642532101440; Tue, 18 Jan 2022 10:55:01 -0800 (PST)
Date:   Tue, 18 Jan 2022 10:54:51 -0800
In-Reply-To: <20220118185453.33710-1-chooglen@google.com>
Message-Id: <20220118185453.33710-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220113004501.78822-1-chooglen@google.com> <20220118185453.33710-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v5 1/3] fetch: use goto cleanup in cmd_fetch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace an early return with 'goto cleanup' in cmd_fetch() so that the
string_list is always cleared (the string_list_clear() call is purely
cleanup; the string_list is not reused). This makes cleanup consistent
so that a subsequent commit can use 'goto cleanup' to bail out early.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fetch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index eaab8056bf..0a625cb137 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2095,7 +2095,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
 			warning(_("protocol does not support --negotiate-only, exiting"));
-			return 1;
+			result = 1;
+			goto cleanup;
 		}
 		if (server_options.nr)
 			gtransport->server_options = &server_options;
@@ -2151,8 +2152,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		strvec_clear(&options);
 	}
 
-	string_list_clear(&list, 0);
-
 	prepare_repo_settings(the_repository);
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
@@ -2170,5 +2169,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (enable_auto_gc)
 		run_auto_maintenance(verbosity < 0);
 
+ cleanup:
+	string_list_clear(&list, 0);
 	return result;
 }
-- 
2.33.GIT

