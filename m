Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C08C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 12:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbhLJMeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 07:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbhLJMeX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 07:34:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F62C0617A1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q3so14661394wru.5
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bh1yZPKc8giaFpr7KotTIXBqHc8mb8W2os1ZwCsBMTU=;
        b=BWGdhZkWaHc6zaeq3bh9KWDYw/fdDNS0zyOH8tay1U2ZNq95zn/6hA8IdazCNrTXGN
         h64KTcsAuauopAx8yA5jVgjLea09T6iyBRH07Mdef57K8RkjqPadB61ahi4kzymIIaff
         3XMCaGP9qKwzUmkQybKh/bNrFhGL3SkRWKAdXdmvjq77VYZzLp9Sf57pMwX671v8gdxF
         NQdyelfLBy35zZTihLIp7hjVV6BQl7hJoY3H2pIJw3RdiEEVCSGAdZJTWHaOlYo8IRLs
         C+jJ07deLxr7XXBHDqE9f89sIVETGMCVofCltHE+jPZ53sJDZKpUQtWel9Dij4ZdklPY
         kE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bh1yZPKc8giaFpr7KotTIXBqHc8mb8W2os1ZwCsBMTU=;
        b=0ESfwQPrDKCVQt8ZTAkHp4khow50sGcJDNmJOMeDChGg1LQ3rb6T1geo56kOnY8QH5
         NMnMJNzkSAsBrJ3el2U204LzmoqpD0g+UXRy9EPhWmSNibrbLIUbZUMnpKc91dnlqbXP
         0Ee8mFAIO0w2rkhVSgTzHeyGQAxlXopDBGKt9aadIM/pzkMVAjWRin/eyIDFSR9yqRCV
         xXQXhUw3TxdWlmRqh9fDs6tJVd8P7wgp/7BI8OeUkrF5ERls/263Gmo1TClh+jRlNKHD
         Aw3cWGi2msZJlDQU4ZJfStQrgkXeRUqKgFKJszziX1clDIroMA84gGF6pMlEEAXX/Gee
         ImXQ==
X-Gm-Message-State: AOAM531r9tjAAznJ5SWpeWizSbvN4sSzA8sgvgwwcleyUv2tGOmECC87
        /773YQF88ZJkKPPYNwFzNZafSdkMh429kA==
X-Google-Smtp-Source: ABdhPJwWDdFZ+nsl7hjkMmjP3UNvml1EXqomVjVswDnJCQQ2ECXJKjirSk1u1qZdjrbSPMX6HjYCLw==
X-Received: by 2002:adf:e3ca:: with SMTP id k10mr13874299wrm.592.1639139447082;
        Fri, 10 Dec 2021 04:30:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm11898982wmq.38.2021.12.10.04.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:30:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 1/5] range-diff: zero out elements in "cost" first
Date:   Fri, 10 Dec 2021 13:30:38 +0100
Message-Id: <RFC-patch-v2-1.5-068c203adc6-20211210T122901Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.932.g36842105b61
In-Reply-To: <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com> <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the get_correspondences() function use CALLOC_ARRAY instead of
looping over the newly allocated "cost" to zero out some of its
elements.

The for-loop that zero'd out elements in "cost" wasn't the first loop
in that function, nor did it cover all of its elements, but regardless
of that this change doesn't affect its end-state. None of the
for-loops touched the same items in the array, so we could have (and
an earlier WIP version of this change did) moved the for-loop we're
deleting to come first in get_correspondences().

This can be seen from a careful reading of this code added in in
d9c66f0b5bf (range-diff: first rudimentary implementation,
2018-08-13) (as well as adding some printf-debugging) we'll set all
elements in the in the "n * n" allocated array. That's "n = A+B" where
"A" and "B" are the number of commits in our respective ranges.

So let's just allocate this with CALLOC_ARRAY(), and skip these two
for-loops. Furthermore let's remove the early exit condition from
compute_assignment() in favor of an assert that it must be called with
"column_count > 1", then "get_correspondences()" can skip calling it
when no further filling of the "a2b" and "b2a" arrays is needed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 linear-assignment.c |  7 +------
 range-diff.c        | 13 +++++--------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/linear-assignment.c b/linear-assignment.c
index ecffc09be6e..0c0786a63b6 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -19,12 +19,7 @@ void compute_assignment(int column_count, int row_count, int *cost,
 	int *free_row, free_count = 0, saved_free_count, *pred, *col;
 	int i, j, phase;
 
-	if (column_count < 2) {
-		memset(column2row, 0, sizeof(int) * column_count);
-		memset(row2column, 0, sizeof(int) * row_count);
-		return;
-	}
-
+	assert(column_count > 1);
 	memset(column2row, -1, sizeof(int) * column_count);
 	memset(row2column, -1, sizeof(int) * row_count);
 	ALLOC_ARRAY(v, column_count);
diff --git a/range-diff.c b/range-diff.c
index cac89a2f4f2..b2fcc6f66e0 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -312,9 +312,9 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	int *cost, c, *a2b, *b2a;
 	int i, j;
 
-	ALLOC_ARRAY(cost, st_mult(n, n));
-	ALLOC_ARRAY(a2b, n);
-	ALLOC_ARRAY(b2a, n);
+	CALLOC_ARRAY(cost, st_mult(n, n));
+	CALLOC_ARRAY(a2b, n);
+	CALLOC_ARRAY(b2a, n);
 
 	for (i = 0; i < a->nr; i++) {
 		struct patch_util *a_util = a->items[i].util;
@@ -346,11 +346,8 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 			cost[i + n * j] = c;
 	}
 
-	for (i = a->nr; i < n; i++)
-		for (j = b->nr; j < n; j++)
-			cost[i + n * j] = 0;
-
-	compute_assignment(n, n, cost, a2b, b2a);
+	if (n > 1)
+		compute_assignment(n, n, cost, a2b, b2a);
 
 	for (i = 0; i < a->nr; i++)
 		if (a2b[i] >= 0 && a2b[i] < b->nr) {
-- 
2.34.1.932.g36842105b61

