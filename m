Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE172C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353205AbiALMhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353197AbiALMhO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:37:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4BC061751
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:37:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id w26so1525275wmi.0
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2K/NCKgwEFtIz4ZRvsWtogsI2CoCq+ySEUsCHgkK+g=;
        b=BfsVFwpYIiK0avkZqAoM8mEBHjx5Vel+cejigVsQNAQdlaAX2XJ8dNrawYHBhne2I0
         DtThtBE55yHAwd6Wq4HYv0HuW9O4McmE65k7PbeGBDXiteB8yvbpTifaNnJXi5XnZZRZ
         ojElTl1Nr8BDW+fzTr7XhlxuDV8YFOyTQRb1zSdQ6noSxJThyCajEwKi6qPt9YaKc3Gw
         VCJmcluCCS0m+FwJgBMAnZBEiJ2LhKoW/Bvki2GBdzUIv4JcUZzTeVKoxscrSSagpbxa
         0xPhMTbMumrBKz7B1V+WZFwaeCl2+wuAv1Ypm/3YxN+3GZR4tDWtgFj4elaWfd/M5+pC
         lUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2K/NCKgwEFtIz4ZRvsWtogsI2CoCq+ySEUsCHgkK+g=;
        b=OP7aOq/xtrlWMcZsZxD5AJkc5EzhUIV/H49R5fpOzcoxXo08waY/mZqHt2xT8W7Mzw
         cmjMZjxg4A1qlxYuZYbYH5IEb8tR5oZ5xUQtY+kf9gCzNkm/w4IZ+u934erzBlbR8IlB
         lCWFX+1efrmuQx73RAjff930XssJ26YozCPuZ9poaLi+AnHCc0PCexOCHee5nkpnnLap
         2zenz12R7bgKRir23h4aMNEgxLLF4A0PeUbA+lyv16Z7kxybpvBi6X9Phr8YLwnBeNzc
         xC2z1ApftlveJviGvBumxsBPqRUzqQD1gHBfEoKl1j9cjqYKdO1a4Y1PgbjqGo/xLu9P
         FssA==
X-Gm-Message-State: AOAM530YhDNGSJsOhNdZxSYgokcoCcZeL7+tzRBiwKdDfN7+x46YJdW9
        bPeio5cJTN55Jpw1Z+tAZ1ejeORGFknu/Q==
X-Google-Smtp-Source: ABdhPJws4XOl4y8kSLnw2h0ZjR2X31Jvbg247EqPNX2JlD5i3fuQJ4UEDHcn0aHRlU4m9lgWfDG5zg==
X-Received: by 2002:a7b:c457:: with SMTP id l23mr6614812wmi.57.1641991032786;
        Wed, 12 Jan 2022 04:37:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3sm2919137wma.12.2022.01.12.04.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:37:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
Date:   Wed, 12 Jan 2022 13:36:47 +0100
Message-Id: <patch-v3-2.3-8d8691a5e93-20220112T123117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.848.gb9d3879eb1d
In-Reply-To: <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
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
index 6abd72160cc..03cdf548d72 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1281,7 +1281,7 @@ void print_commit_summary(struct repository *r,
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
 	struct ref_store *refs;
-	int resolve_errno;
+	int ignore_errno;
 
 	commit = lookup_commit(r, oid);
 	if (!commit)
@@ -1333,11 +1333,9 @@ void print_commit_summary(struct repository *r,
 
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
2.35.0.rc0.848.gb9d3879eb1d

