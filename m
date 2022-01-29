Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A411AC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 02:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352211AbiA2CsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 21:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiA2CsB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 21:48:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A59C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 18:48:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so12636490pjt.5
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 18:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FL2wl+7Wf2BBuCLAeb2nHgSOBGSKgfa2YVm1gBrAPsk=;
        b=O5Kukql3UPfL5efg/JM475nn8Vt+iiiG4ktew0zAtjQisj+oeHoUvw9eaadSMRknn6
         JyjIMxWH/I1bHD81cYAfcVhrQm1tqfZClEIeFNJlgNAkmD3S4fWQTpVkHLS7ZSUmBT/i
         gQYcZecFYhBQhZnADtklDpPf7lTZEmVcvwEQV8JmZl39KBI8BeurziJ9H7XYauXvJbXe
         FxaCrtaob8XGUFkjArbi7TxvRhd01lmjiKgk7HNIJrSkw8py50TK4PezTKNtew4EGA0X
         F+hhmSe1IyyMC1usY+Pu0FmF7ltXD/lxvl6cnhCHFyn1IOyyYzAgWfDL1EVk1ynrDldQ
         H0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FL2wl+7Wf2BBuCLAeb2nHgSOBGSKgfa2YVm1gBrAPsk=;
        b=c+6tGmRPK/jZXraLBmEAL+6xrdfL/9Knfz1ItGOqWlwUJQIGOCOgWQd/d9BjixqTM7
         qZA1p6aSz7SL6KG5q5hXCSY1tVnSjIKthh51sKLVfWPhL0lQMpTqqmhqZO+PT9zveWik
         MCuO3aL8XOLABEt93bUlJ7iVNWYqy3Ufx+7zS0vjNOPPrd/k0Gs5kLf7s+GLTn3TYolw
         tPxAXa6Np4I0RNgRBXGfNAZcDEHwMFz/BgbGI0G8gcHaNRynvmWZJD7XvaXBsPZUCs8e
         /PPHJ5QY4F2O/ag5p/j5Qqdv94vcDFqfI8AHiAbjW05Oc/1D2wYer7kTcP/K1wZeGHyI
         Bqpw==
X-Gm-Message-State: AOAM5303lul5IGJ6Y14aAg8rEge6/w938YypkxzC/QbXteMQymi5jA9B
        svDxo7SrP0j1+guva0sIXIYJ0v4AQtfWYA==
X-Google-Smtp-Source: ABdhPJzcxdMlrP0ltQEBDT2CkBkb+7zGgQaMPm9PMWLC/m1xB06+xEU+YpdC9vJg7RiRwTih8pyftg==
X-Received: by 2002:a17:902:710c:: with SMTP id a12mr11341797pll.13.1643424480498;
        Fri, 28 Jan 2022 18:48:00 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id y20sm11273776pfi.78.2022.01.28.18.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 18:47:59 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V2] patch-id: fix scan_hunk_header on diffs with 1 line of before/after
Date:   Fri, 28 Jan 2022 18:47:57 -0800
Message-Id: <20220129024757.24763-1-jerry@skydio.com>
X-Mailer: git-send-email 2.35.1.6.g61799e0acb
In-Reply-To: <20220125221602.26557-1-jerry@skydio.com>
References: <20220125221602.26557-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally diffs will contain a hunk header of the format
"@@ -2,2 +2,15 @@ code". However in certain situations git can
omit the second comma separated value in either before or after
line counts in the case where there is only one line.

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
V1->V2:
- Removed references to -U1 since this isn't limited to that
- Added notes for future tasks

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
index 80f4a65b28..34a386aee2 100755
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
+test_expect_success 'patch-id handles diffs with one line of before/after'
+	cat diffu1 | calc_patch_id diffu1 &&
+	test_config patchid.stable true &&
+	cat diffu1 | calc_patch_id diffu1stable
+'
 test_done
-- 
2.32.0.1314.g6ed4fcc4cc

