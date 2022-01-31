Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A876C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 23:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiAaXX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiAaXXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 18:23:25 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB8C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 15:23:24 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h25so12056142qtm.1
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 15:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t8EX9/iwPlhRIEeRy+dRGbZLG1hXbMfIygOBNNVWi6w=;
        b=0WIbY3sZJfCZcxW0ebl4CAk3btFbm6CCA86KlMSG8XSoDI9WMXbSLHYnKgs8rD8511
         7ZeiNVk61HzMMImPlshSOqbxP5dPNo5RA3Ke2jRcm//AWi6RN/dr/N/tv25W9URf086E
         yqjgTERgBw8zeAXcJO/QrVz93qdCx5t9Y2yBc8QXnvX5gw67qBVYH0BSc3Ii4usrbybr
         ITekDa55k/wdn9aMs+8yucIWnLLNX4Gl0nK0JasW80qY0z9PNf41cDRdw9Lw4H3czh6A
         b5K0k84i/FabosiIk4k4tuJ81o3VqdgTbaLpxOO0Je6cNjM7QNiXIjEjBSu/1DJaRhF4
         2lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8EX9/iwPlhRIEeRy+dRGbZLG1hXbMfIygOBNNVWi6w=;
        b=lEgB3vbMMlkSpEBy0YdMxKDwhG2TE3JsECzXbjVSFDi3IOrn9xFPhnKEyEvVtHdWQb
         XuNxJ/TQGXlZOXpuoJ2A4jBqQvLvxSTJovi+dZKfI9tGfZLEX+6CyId2UklGnjzPokbR
         AGol0fw/npiosyGZwvXKZgIp2Q14w1riEaPXB8VpFTL0xs2hdlN/Nm8e3i1SO5dQ/ggN
         tEPVBawsr/iMxk/n/ewBcg2K6SgNcSpOKpOUYrqHhdfPW0Jyx6Gj3RZ0FloTFxP84yLV
         gLkdMO/7YlZKeFRAMheR0s2cJ7wdw+SMIIpQn+u3orSD50QkoTSmBDrxwcbDQcryEoNm
         x56w==
X-Gm-Message-State: AOAM531y7W+fQ1mKjXTB9TX1TDoK2Opmp+xVdJDwI6Vie272kRJnfRRJ
        G46VG01LAUqsqC4s3u9IuThIhbnhSAKZVA==
X-Google-Smtp-Source: ABdhPJyMV9jm27vwiR5UIxmIh5jEpw+p9bU0rHM8niOgDk7EujLhHBVXSWlNefSWCZKh41oTwAK3GQ==
X-Received: by 2002:ac8:424b:: with SMTP id r11mr16686114qtm.392.1643671403670;
        Mon, 31 Jan 2022 15:23:23 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id t18sm3428936qta.90.2022.01.31.15.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 15:23:23 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V3 2/2] patch-id: fix scan_hunk_header on diffs with 1 line of before/after
Date:   Mon, 31 Jan 2022 15:23:18 -0800
Message-Id: <20220131232318.8248-2-jerry@skydio.com>
X-Mailer: git-send-email 2.35.1.6.g61799e0acb
In-Reply-To: <20220131232318.8248-1-jerry@skydio.com>
References: <20220131232318.8248-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally diffs will contain a hunk header of the format
"@@ -2,2 +2,15 @@ code". However when there is only 1 line of
change, the unified diff format allows for the second comma
separated value to be omitted in either before or after
line counts.

This can produce hunk headers that look like
"@@ -2 +2,18 @@ code" or "@@ -2,2 +2 @@ code".
As a result, scan_hunk_header mistakenly returns the line
number as line count, which then results in unpredictable
parsing errors with the rest of the patch, including giving
multiple lines of output for a single commit.

Fix by explicitly setting line count to 1 when there is
no comma, and add a test.

apply.c contains this same logic except it is correct. A
worthwhile future project might be to unify these two diff
parsers so they both benefit from fixes.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
V2->V3:
- Made it clearer that the 1 line case is the only one where
unified diff would use this particular format.
- Cleaned up test and made separate patch to clean up old test.

 builtin/patch-id.c  |  9 +++++++--
 t/t4204-patch-id.sh | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 822ffff51f..881fcf3273 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -30,26 +30,31 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 
 	q = p + 4;
 	n = strspn(q, digits);
 	if (q[n] == ',') {
 		q += n + 1;
+		*p_before = atoi(q);
 		n = strspn(q, digits);
+	} else {
+		*p_before = 1;
 	}
+
 	if (n == 0 || q[n] != ' ' || q[n+1] != '+')
 		return 0;
 
 	r = q + n + 2;
 	n = strspn(r, digits);
 	if (r[n] == ',') {
 		r += n + 1;
+		*p_after = atoi(r);
 		n = strspn(r, digits);
+	} else {
+		*p_after = 1;
 	}
 	if (n == 0)
 		return 0;
 
-	*p_before = atoi(q);
-	*p_after = atoi(r);
 	return 1;
 }
 
 static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 			   struct strbuf *line_buf, int stable)
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index da60f5b472..686ecc3c18 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -36,11 +36,11 @@ test_expect_success 'patch-id output is well-formed' '
 calc_patch_id () {
 	patch_name="$1"
 	shift
 	git patch-id "$@" >patch-id.output &&
 	sed "s/ .*//" patch-id.output >patch-id_"$patch_name" &&
-	test_line_count -gt 0 patch-id_"$patch_name"
+	test_line_count -eq 1 patch-id_"$patch_name"
 }
 
 get_top_diff () {
 	git log -p -1 "$@" -O bar-then-foo --
 }
@@ -198,6 +198,35 @@ test_expect_success 'patch-id handles no-nl-at-eof markers' '
 	EOF
 	calc_patch_id nonl <nonl &&
 	calc_patch_id withnl <withnl &&
 	test_cmp patch-id_nonl patch-id_withnl
 '
+
+test_expect_success 'patch-id handles diffs with one line of before/after' '
+	cat >diffu1 <<-EOF &&
+	diff --git a/bar b/bar
+	index bdaf90f..31051f6 100644
+	--- a/bar
+	+++ b/bar
+	@@ -2 +2,2 @@
+	 b
+	+c
+	diff --git a/car b/car
+	index 00750ed..2ae5e34 100644
+	--- a/car
+	+++ b/car
+	@@ -1 +1,2 @@
+	 3
+	+d
+	diff --git a/foo b/foo
+	index e439850..7146eb8 100644
+	--- a/foo
+	+++ b/foo
+	@@ -2 +2,2 @@
+	 a
+	+e
+	EOF
+	calc_patch_id diffu1 <diffu1 &&
+	test_config patchid.stable true &&
+	calc_patch_id diffu1stable <diffu1
+'
 test_done
-- 
2.32.0.1314.g6ed4fcc4cc

