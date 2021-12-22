Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B77C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 02:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbhLVC7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 21:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbhLVC7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 21:59:07 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337DAC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 18:59:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v7so1765757wrv.12
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 18:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdyqqH01hTjXcKQTZW6SEM/Rs93OoJrEu9Zvy8CRHiE=;
        b=PKC+cqaytaRx0qpvWC0pEp/j1sRr8qr6OA9jVp+d+s8HyTx0uUwz2ys3dYJqaOZp5Q
         f8oZlObFF0Bm/fNjgOmJbS+dK7psNjJZt5Ei7ggI9tRmkrwPYz7gK/mqUrbjdTcRaoh1
         sjckuMJj0u/8gmIq43mBMwOyrw6f4PXEP8SxtzD7O+z9N9kOy0QUWXfGVew8D2t+F6VW
         yU0tSbivvoJ5/CjJpAWgWXDXK0bemzwwQ6VqZ4vwV6KLwUkEHEoFBrA2mS4HbR0K682e
         32vT4lASO0bsQipeuYP37qInXn6wQgdEWXGEF1AnWKE/nHyjMTuH9GU1arfaIzkxtWDo
         PkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdyqqH01hTjXcKQTZW6SEM/Rs93OoJrEu9Zvy8CRHiE=;
        b=Wy5KQaN9d5FJH9Qjd8DWLI4KZgJOc9QtOx+TeRO9aAH7n9AKqdDDQE6wDpQ0MK5v8U
         h4oPtHJLn2n3AzcjISP/VUvap7P9Iy7drCI0xAwuM3dDNyb/VEC4rAbY+8ElraO6VdHe
         Jg0qSAqRZ44niRkBO8MRNXC2vYZ/q9kO2e0oaND799U9hbSGodbcsdLHpXd/Nr6X395C
         d3TNDjAu4XP11ghXI7xVQ2d4YL3O9/Aug/ET+Jc4ZFh7sq9h291Jemu3dlOkMkzy9v1y
         sL9dMoPEBV/wMFcbUcLL7U5xhiHO9M8n5C8xHs9lhR/1BEkgnQIc1kVqg1oBAf/KZLnX
         VHnA==
X-Gm-Message-State: AOAM530hzUa85e67drmOvqiD7nF+QtmVtbwrKIFOPk/7KWMNy2u7vfpB
        M2dttvqMTjJvOXILLrJxmiLx9e8ycblE2Q==
X-Google-Smtp-Source: ABdhPJyILKDRv5+UFiA/TdcGYiq36BMMS3fqYdjZJiXp3RECaTy/g09J5D584KhC5zYlZ5pnp0jzvA==
X-Received: by 2002:adf:b1d5:: with SMTP id r21mr629463wra.520.1640141945568;
        Tue, 21 Dec 2021 18:59:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm611577wru.66.2021.12.21.18.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 18:59:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/7] grep.c: don't pass along NULL callback value
Date:   Wed, 22 Dec 2021 03:58:55 +0100
Message-Id: <patch-v5-5.7-a33b00a247e-20211222T025214Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com> <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change grep_cmd_config() to stop passing around the always-NULL "cb"
value. When this code was added in 7e8f59d577e (grep: color patterns
in output, 2009-03-07) it was non-NULL, but when that changed in
15fabd1bbd4 (builtin/grep.c: make configuration callback more
reusable, 2012-10-09) this code was left behind.

In a subsequent change I'll start using the "cb" value, this will make
it clear which functions we call need it, and which don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d85cbabea67..5ec4cecae45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,8 +285,8 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	int st = grep_config(var, value, NULL);
+	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-- 
2.34.1.1146.gb52885e7c44

