Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E016EC433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiAYWQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiAYWQH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:16:07 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67800C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:16:07 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id o9so22793557qvy.13
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GPP1sif2guRpAWvtoa7+gdEOWA/ZDlt1+HEX5e138s=;
        b=qZOX6EQtThHYGzvXvfrag4PX+MJhb4C51kjVD/iLZPX/6Zj9s7TwlHlzulHhWgcjs+
         8AHUxnH2UuVOjq/9gM/DzeoMTXX9C1CpPPtNSldYczxZh2MRFcS5GdLABrcWp6uYAofX
         f93uOJqTmXQI+/GLqB4UcgkhhJfKeQKMoKoaM8JDhgKK1eZBAR7VFx1petHBdvJSWOUl
         rQmSIOUyPCW0wwJybVwWJNpNvS7j554pDXJG51+aOu4BNZAYCMKGzq6hw0FSTJCFrXxi
         ZrRCiVS4Yhs4WYlsVMIdWAKhLhjwyDDpMnrKTHp0m6nv1ROFfJ05bTmYriRYD4CccNXx
         pGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GPP1sif2guRpAWvtoa7+gdEOWA/ZDlt1+HEX5e138s=;
        b=zPCxfHPWNVvaEzw5ozMZsxho0TS7p+4qoQTaaqIFq8MJ1aj77WQ7Mn1rjGQNuXcuG1
         MA9OkP/edbF+ZGNyDWEzbaaDI4JPZD6ySBmdKbmpmZNMlRXiTGRBBPpGOsb955tBlcxR
         xowcObC5aFz3wsosh6yKrxNuYYKghZt1qYUPhoNzMRl3nK6MG/2zjc3Fy4lR1XFzl4nA
         6Jo6iYW8rSNnIwxpq8pQbLitEVlcghorPO6H/zZzafBIuoLypHabTO72+8DFkhCX3aHd
         MOls/lALf8R3vNyEq1tdJ0j8XOrr+UwhunbaZyL6/S2vkQ5kB93xxWXZ5NjRLYet3WFj
         C8pA==
X-Gm-Message-State: AOAM530oe4C9u0PKH1+zxkTLmycMN6e+YmJ75fgbe/WxSOW2jt0iI+4a
        Jv4NRqeTBjbErDUUfiiGw+W9IIt7vUNGzQ==
X-Google-Smtp-Source: ABdhPJw7uAJzuKmLhmPYukGzXmxYtCM3jU18lu1mPn1e3Ggkc0NMzPyY3tKaqocM0+SujYuV1T8YBw==
X-Received: by 2002:a05:6214:194b:: with SMTP id q11mr17076175qvk.66.1643148966231;
        Tue, 25 Jan 2022 14:16:06 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id d6sm1019725qtb.55.2022.01.25.14.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:16:05 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] patch-id: fix scan_hunk_header on diffs with -U1
Date:   Tue, 25 Jan 2022 14:16:02 -0800
Message-Id: <20220125221602.26557-1-jerry@skydio.com>
X-Mailer: git-send-email 2.35.0.2.gf0c132520d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally diffs will contain a hunk header of the format
"@@ -2,2 +2,15 @@ code". However when git diff is given "-U1"
indicating that diffs are surrounded by only one line of
context, it can omit the second comma separated value in
either before or after line counts in the case where there
is only one line.

This can produce hunk headers that look like
"@@ -2 +2,18 @@ code" or "@@ -2,2 +2 @@ code".
As a result, scan_hunk_header mistakenly returns the line
number as line count, which then results in unpredictable
parsing errors with the rest of the patch, including giving
multiple lines of output for a single commit.

Fix by explicitly setting line count to 1 when there is
no comma, and add a test.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 builtin/patch-id.c  |  9 +++++++--
 t/t4204-patch-id.sh | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 3 deletions(-)

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
index 80f4a65b28..08d10dfc3e 100755
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
@@ -200,6 +200,36 @@ EOF
 test_expect_success 'patch-id handles no-nl-at-eof markers' '
 	cat nonl | calc_patch_id nonl &&
 	cat withnl | calc_patch_id withnl &&
 	test_cmp patch-id_nonl patch-id_withnl
 '
+
+cat >diffu1 <<\EOF
+diff --git a/bar b/bar
+index bdaf90f..31051f6 100644
+--- a/bar
++++ b/bar
+@@ -2 +2,2 @@
+ b
++c
+diff --git a/car b/car
+index 00750ed..2ae5e34 100644
+--- a/car
++++ b/car
+@@ -1 +1,2 @@
+ 3
++d
+diff --git a/foo b/foo
+index e439850..7146eb8 100644
+--- a/foo
++++ b/foo
+@@ -2 +2,2 @@
+ a
++e
+EOF
+
+test_expect_success 'patch-id handles diffs with -U1' '
+	cat diffu1 | calc_patch_id diffu1 &&
+	test_config patchid.stable true &&
+	cat diffu1 | calc_patch_id diffu1stable
+'
 test_done
-- 
2.32.0.1314.g6ed4fcc4cc

