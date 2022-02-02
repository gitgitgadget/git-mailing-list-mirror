Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4DEC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 04:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbiBBETu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 23:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbiBBETt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 23:19:49 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED4BC061771
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 20:19:49 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id s6so17932096qvv.11
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 20:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zWPVWVanRlDqGTH554jQJ/QSUrrMWnnQ1ycUH33VMZ8=;
        b=ec47SZ7kdtMckJlnru32OGqNgK6+s909BTDJ+ijuLXacLwAQoaz43PhPe676E3g+cE
         1Z29qcd4Wx05+X5DhqUwtNzmepPxGXh0I04cvWeASu6YY255OIPnCyPUGwc95hAKGYjx
         82zClLYr97w1n7DgskEGht5qWE3oqKKsxDAxw1fn88pI/8x72IZj5p3G2o04E1nR2e/v
         qVKQoLrcwUadXEg7o9W0zm0HT89iob7LGlQlYaYQGL1DDiJd+dtG6G2XM8q3KVIbPExN
         dFHXDX26q/4SN8aGQJI8B4OljcrR9KdObK4VI6Kzd0QeAxamID+eo/YSoPieZpNHZe1c
         yUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWPVWVanRlDqGTH554jQJ/QSUrrMWnnQ1ycUH33VMZ8=;
        b=As//abhCUh9s+9z8LzvCqY6jMbs0mZR+xyIIVd9GnRHDgzpWF3pS8xpbRqRjXF6SWg
         S08mANYRzphkZ68SBdUn1T9aMUQojAQxEconl/Homx/unekKPlIyVntDOokFBUJN0L9g
         mSJVN+OH0qRYid7ng+KF0A+utpSKFwt5fLEculHJ4kc2VrYX0D2kdEXfs4MvXfKeeSeq
         m/4lhIuzzsnmE3GRNTOabGX/wY4eCXy0Cof4DMXQ/DUN2Az5PEa2jW+Noqj3wlHD9spG
         0NFFxHGPmQxKxOWm69YCkZ7+YXuSjJT8UJx5dKcQLoz6Ysv0QbDYmK5111e3GFAhhrcu
         rGmA==
X-Gm-Message-State: AOAM532vhs3eAWnWI7RS/fnT+rYTZOlEvegnv1frXzY2XIz9XuaL6YPi
        AruXmgS0TMWIGhuYmzwkXLf7AZkBJuRkwg==
X-Google-Smtp-Source: ABdhPJw077jpxrYWjG5xKudkN4RRfCjmFHQOthBCIQB7rX7oyy/onOjdklUg/ovrhG04zgCHo7ufng==
X-Received: by 2002:ad4:5be8:: with SMTP id k8mr25586345qvc.38.1643775588165;
        Tue, 01 Feb 2022 20:19:48 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id d22sm5284228qkn.112.2022.02.01.20.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 20:19:47 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V5 2/2] patch-id: fix scan_hunk_header on diffs with 1 line of before/after
Date:   Tue,  1 Feb 2022 20:19:45 -0800
Message-Id: <20220202041945.10077-1-jerry@skydio.com>
X-Mailer: git-send-email 2.35.1.7.ge3b4973ce7
In-Reply-To: <20220131235244.27429-1-jerry@skydio.com>
References: <20220131235244.27429-1-jerry@skydio.com>
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
V4->V5:
- Quote the EOF marker correctly

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
index 2bc940a07e..a730c0db98 100755
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
+	cat >diffu1 <<-\EOF &&
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

