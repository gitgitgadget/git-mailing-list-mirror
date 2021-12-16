Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F2CC433FE
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhLPNpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhLPNpX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:23 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2745EC06173F
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y83-20020a1c7d56000000b003456dfe7c5cso844379wmc.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgKmLSP0oz8duIvUjOaU38Wa0wQBTnsEsafr59P1tMU=;
        b=Q1hHYDq5VEvWQEmfUgxhYmrWWDo2HACMs/xobLsP6PHBPjyj4UKu2rsswByybyII8s
         yeWpHnYd3CBls/9yWDS6rAC4+14pEI/+Z1706bYoj2PDk6vFfY5/TeQMpqDt5MN9azsJ
         WMBIsrZwuQFM9oU6eFCxDMAO4LnqhwF7y2B0NxJ8WQ2akwBEOcxyOBKL/g4nb6aeiZJe
         482brAOArNIiAg0OL55J1FBxfeg8Vm+OihHiXG96GSPFNUX/A+lLLZ4VNAsTsbztUwNb
         lOpKoZTziBz5PucRK/f9R+ErLoE8pgmc9C3r/GnltivYbKBnyGGRjoHtEe5vgE+x33AX
         q6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgKmLSP0oz8duIvUjOaU38Wa0wQBTnsEsafr59P1tMU=;
        b=6vNLkvq3xnTeS1Kz+bNDULVLmAj6En7CT3lhu6t06QXmYQPNdI/ugyipQJnzthNpzQ
         769Y/UUypiY3hG+DSMABSt1qASEcDqp3DGuXFueKbR2v35JdNgcPrQqZU5ySRvbYyEHA
         3ka6EZ0C7h02DnFWNdy4ETAFHUQvHKVf1+Y7LzNkT0/gGrEmsnUURDNBHuh0X9RqgrVp
         MGkzoAsDfiwKK129+4toVEKM0yn86JervLb5NJQe8ZP0CvA3YU7FyxUicud+3CavEKKI
         ROCRhaP9vLEw36+1FQ2+itu7zXkO462dqKEv4ow0AGZJBAOzHuZke+oHZE5Zfxto+Pq3
         jVXA==
X-Gm-Message-State: AOAM531CB+XFrvCabJHo6y+o7UP9Z5Y9oiyumrwQs69JfIxzaPz3uHCI
        3VHJ3q9DRpV66QJrTXjIZLhDR6WiJrHy/A==
X-Google-Smtp-Source: ABdhPJxWJZFNilBV6hSkrD1JUKUd/uqJldLWxKwGUcmU+fiA0chnDmOJFNA5N5Ps9r7JKa7RG32Cfw==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr4960218wmf.143.1639662321484;
        Thu, 16 Dec 2021 05:45:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm4866821wrn.73.2021.12.16.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:45:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] reflog delete: narrow scope of "cmd" passed to count_reflog_ent()
Date:   Thu, 16 Dec 2021 14:45:10 +0100
Message-Id: <patch-v2-1.9-22c8119640c-20211216T134028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "cb_data" we pass to the count_reflog_ent() to be the
&cb.cmd itself, instead of passing &cb and having the callback lookup
cb->cmd.

This makes it clear that the "cb" itself is the same memzero'd
structure on each iteration of the for-loop that uses &cb, except for
the "cmd" member.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 175c83e7cc2..4c15d71f3e9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -662,20 +662,18 @@ static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
 		const char *email, timestamp_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
-	struct expire_reflog_policy_cb *cb = cb_data;
-	if (!cb->cmd.expire_total || timestamp < cb->cmd.expire_total)
-		cb->cmd.recno++;
+	struct cmd_reflog_expire_cb *cb = cb_data;
+	if (!cb->expire_total || timestamp < cb->expire_total)
+		cb->recno++;
 	return 0;
 }
 
 static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
-	struct expire_reflog_policy_cb cb;
+	struct cmd_reflog_expire_cb cmd = { 0 };
 	int i, status = 0;
 	unsigned int flags = 0;
 
-	memset(&cb, 0, sizeof(cb));
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
@@ -703,6 +701,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		const char *spec = strstr(argv[i], "@{");
 		char *ep, *ref;
 		int recno;
+		struct expire_reflog_policy_cb cb = { 0 };
 
 		if (!spec) {
 			status |= error(_("not a reflog: %s"), argv[i]);
@@ -716,14 +715,15 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
 		recno = strtoul(spec + 2, &ep, 10);
 		if (*ep == '}') {
-			cb.cmd.recno = -recno;
-			for_each_reflog_ent(ref, count_reflog_ent, &cb);
+			cmd.recno = -recno;
+			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
 		} else {
-			cb.cmd.expire_total = approxidate(spec + 2);
-			for_each_reflog_ent(ref, count_reflog_ent, &cb);
-			cb.cmd.expire_total = 0;
+			cmd.expire_total = approxidate(spec + 2);
+			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
+			cmd.expire_total = 0;
 		}
 
+		cb.cmd = cmd;
 		status |= reflog_expire(ref, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
-- 
2.34.1.1020.gc80c40b6642

