Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F282620248
	for <e@80x24.org>; Tue,  9 Apr 2019 21:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfDIVo0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 17:44:26 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47259 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfDIVoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 17:44:24 -0400
Received: by mail-pf1-f201.google.com with SMTP id n63so10151pfb.14
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 14:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+VanXq4rtE0QuNErXPOSJouFJeXTJzNuBxJ6RaGbUhA=;
        b=VBFIrqntdbYQMW0cXSC3z+8Trzlmc+JUHOqxrc1LkoX/7lQKLNc5sW8BSx13dYk4At
         95yCKhUTGK6DSzaNOVmwtcsG3IpaO3/VWdv8ha4+nxTMoAnLHrnZXcetizbme8NX+czH
         E1d4RggjL2IO5QxdqqxPSdZZ+wAqXypIqtXnnoYcbokj4DdQ0djdBjZMDWmQ+oAwsBJn
         SGixxbvvCINGN14aNt59NsSAw/AD8k83bprNqPK7UlSCprHAxCzm+M+ve9XcrtP4hjFA
         gopy3hUakfRUNj4Jr4/RPvglEWF50y4tB0KAPcTZVCKc+l6jvmaLaOK8uVURVFBf/Ing
         w/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+VanXq4rtE0QuNErXPOSJouFJeXTJzNuBxJ6RaGbUhA=;
        b=BFBPj7h6aQ5jD6S0Zr14ST4RqNAKZuonj3utaUBpTj/0EeRR2EqDXwc0XNVTJk5lcX
         EWDEyUflnExqNIwUTsbF7Qt0jdfzJ+7HneQKd/8SgjV7Jj7ydGcSrTwupgcrm1b9H3zu
         76RtCxzRMwDBaxySY78n92NsWcv4r1N6QI1Jra6fa7Ak7fDEH6w7sEZ43cwEAEqJfz2I
         xCG2pdF/wto6nH0KV2jDC2PiT9ukluwiR5mXcAzAul7clp1p0YJdNIF3DDe+MFRWOKLg
         RhBURFL//p+RXkn17KsVGv/6+e6V0eeFosyVrHD1dThFryGItK440jFovWiMX5LBvGoA
         Feww==
X-Gm-Message-State: APjAAAVZ9S5RW7J4ksXs6bWUrdzgiiO8e3athD9HN8PmClzbAjC2ZSZ6
        +D/4OnDVXJpWOXcr74n9Ul4NOUv9JoVvu+OacLuWBEMgmtVETg0S9uawYOsrwHTjKmvcy7oZKLX
        8prel6QbxI+xoyVLWEappilSFwFoABSc9CF81GPaD+6+21zCly6euqO8gQvkJo75OAgaNYCRrkw
        Lt
X-Google-Smtp-Source: APXvYqw+NKz73DwIBmAbvRAggF8RbpEZOIX5gSzHBO+LpYAIVFd6tWk2ADDo/sPf4lzHfumLIuQVWtCjBVHqxNOmsdeV
X-Received: by 2002:a63:6d8a:: with SMTP id i132mr718406pgc.32.1554846263409;
 Tue, 09 Apr 2019 14:44:23 -0700 (PDT)
Date:   Tue,  9 Apr 2019 14:44:20 -0700
Message-Id: <20190409214420.90898-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC PATCH] pack-objects: write objects packed to trace2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is useful when investigating performance of pushes, and other times
when no progress information is written (because the pack is written to
stdout).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
We're trying to improve push performance, and it would be nice to be
able to observe the number of objects sent over each push, both to
correlate it with time taken (which is already traced) and to notice
situations when significantly more objects are being sent than needed.

Sending this as an RFC because this patch works but is somewhat ad-hoc -
perhaps someone else has a more comprehensive solution.
---
 builtin/pack-objects.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a154fc29f6..ac464d7d07 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -964,6 +964,7 @@ static void write_pack_file(void)
 	if (written != nr_result)
 		die(_("wrote %"PRIu32" objects while expecting %"PRIu32),
 		    written, nr_result);
+	trace2_printf("packed %d objects", nr_result);
 }
 
 static int no_try_delta(const char *path)
-- 
2.21.0.392.gf8f6787159e-goog

