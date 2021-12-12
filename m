Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F16C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 19:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhLLTy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 14:54:26 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:37846 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhLLTyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 14:54:25 -0500
Received: by mail-wm1-f47.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso12728279wms.2
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 11:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWVsb8YN4t8M8+ub39gZ647GbpiXC1+C3Rd247ysveU=;
        b=SMRIon8A7qvOApw1XqjFqY0K90UImx38NHI3fj0dudOS31Pe99TBXq9baIOBnJtdJb
         l4Rf50ObVXKuiCVvexU+uSf8oFdxRE4IFBsxsi5t+ZVmE9gq/Q08ZODzNn+SONI+eEKH
         yhVxULcmFhFeOothva6r5Jz0NXTKrBYFOlwhyQR+0PC2oo4f8CSj5zl6enHkImJisHnd
         haU/zrrTbvAdOldUK9yEyD6HJEVYxmWEJLPMQnzzxDZBlJBNi3FxCH724kw/5P95AHaa
         NNrhSe7pUnJStHLMIUJsWMWiq9NtF6GLt1Yoeg4obpEf8NPsBXXr47Gall6jyhIeKS85
         /Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWVsb8YN4t8M8+ub39gZ647GbpiXC1+C3Rd247ysveU=;
        b=G7Zug/Jkt8yGajFVXZnjUxNRte0aHCLO2asN54LMaOPvcpXlQWJBsR7xGZV+YWh1Jd
         b2lV01ioW9F231UbTk4H5B1JuEtVeFv5Ej6kjyKQw/oJnJ+bvWE776Fly45eL06FxBa3
         e//PfnPMAURIQO+BlZmd6kdbqfpktcOyFNciA3ATQ37MmepYGAJsinv/+LTIwZk8H0j0
         v1nvy45uH1RGA76/15krCLvf/BUK9moRJuxYTjwFPgTmw2rV70mxEWUB9UTjKUn1Mfke
         ICa2uiEdrVOsKvfbhySY0YSeLvnXD5o2LmgYQMu8GJwLVoiMSaaVri6zKAHUrHqHPOry
         rjKQ==
X-Gm-Message-State: AOAM530l406bY8oVAKhdBAAxfcV7silCq4MOfmRhVoNAjbQ+NdFN1oQj
        eZXCjlzrZBE6yLlX6xFH1nEJY79QvWSCmA==
X-Google-Smtp-Source: ABdhPJxdHApEHWbNk93QDcmIDzauo3rXi7ynktkFS2jM0uGv6irBCBVrbsDrl7owGtiEXE7UpTbmCg==
X-Received: by 2002:a05:600c:21cd:: with SMTP id x13mr32940760wmj.52.1639338803573;
        Sun, 12 Dec 2021 11:53:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g198sm5494323wme.23.2021.12.12.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 11:53:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
Date:   Sun, 12 Dec 2021 20:53:12 +0100
Message-Id: <patch-v2-2.3-12d453d3884-20211212T195108Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.929.ge922d848c7a
In-Reply-To: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that was faithfully migrated to the new "resolve_errno"
API in ed90f04155d (refs API: make resolve_ref_unsafe() not set errno,
2021-10-16) to stop caring about the errno at all.

When we fail to resolve "HEAD" after the sequencer runs it doesn't
really help to say what the "errno" value is, since the fake backend
errno may or may not reflect anything real about the state of the
".git/HEAD". With the upcoming reftable backend this fakery will
become even more pronounced.

So let's just die() instead of die_errno() here. This will also help
simplify the refs_resolve_ref_unsafe() API. This was the only user of
it that wasn't ignoring the "failure_errno" output parameter.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 795b370dd34..62bf6cac66b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1285,7 +1285,7 @@ void print_commit_summary(struct repository *r,
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
 	struct ref_store *refs;
-	int resolve_errno;
+	int ignore_errno;
 
 	commit = lookup_commit(r, oid);
 	if (!commit)
@@ -1337,11 +1337,9 @@ void print_commit_summary(struct repository *r,
 
 	refs = get_main_ref_store(the_repository);
 	head = refs_resolve_ref_unsafe(refs, "HEAD", 0, NULL, NULL,
-				       &resolve_errno);
-	if (!head) {
-		errno = resolve_errno;
-		die_errno(_("unable to resolve HEAD after creating commit"));
-	}
+				       &ignore_errno);
+	if (!head)
+		die(_("unable to resolve HEAD after creating commit"));
 	if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
-- 
2.34.1.929.ge922d848c7a

