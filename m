Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7629BC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 14:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbiAZOhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242210AbiAZOhH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 09:37:07 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAEAC06173B
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 06:37:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so1280945wmd.5
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 06:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6g0wjx5Ea9Q2YLh2kpjuhQ4eDx0XpDJiZXNvFHaxiA=;
        b=apR1jsP590TVT7mkBcmBWqi58EwFmgHlYz1w3K80Q15RgRMENWCtg5wxlCO24qMgXY
         8m6vI9YN5TH+5plcCu91ow0F2mudZ3cV424ZBJvR3zvCtSIDs5NexFPhn5g5PQKdxAc3
         tKvEYGkiR0YWCKcx8/GlwCdBAbpt6oaRdwSpZIT/atBh5cdjBxq/d37SyOowjP20obL5
         FC9EJBhIxDtXxjhSQMbfHEurRNRnmRlhpXYpS0kacB2wM2UEPmzHf1tpQRWAfxmSdEzN
         1GZIn0DhCigIH4BSozQfEgw0VOsP1UCqJjMtXS9b7Oiu1FuEnF5DQlANlKR5lczfz1xQ
         reng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6g0wjx5Ea9Q2YLh2kpjuhQ4eDx0XpDJiZXNvFHaxiA=;
        b=OhFQB6VUYmiFbZojujBGLOolIXGN/nkHwTZOINv5aG05IcFGUSYTaVBbTP2HRYVXA8
         g+afuP220/CQ958Ph6KDZ5ghW/YC478x/CBKLzeo5GneIFyAZ/xAF0dQpbNLsCEuolHp
         TWjHDzr+526LM+5gLIE/4puPkyiXld/7zQ0HkocvFdD0O22L7aHd2lV6yfHhN3AxmCkx
         mMZ0cskKWPGEW58acTGaqkHwiUHc96V7+isZ60ANNQKzFZOgWMfjR7SZ8wozyQ2/1eKO
         F5ODe3WsbhCd5IXPK07M011EJBSf0NPjWWqR13XdS1H7yUCizmx0ICs6ke6+zQQvnxFj
         BP2g==
X-Gm-Message-State: AOAM532I9ORVLVwVmCgqIazwxvGLtwIQqCRnG9D2ugSy1WnPYEmuJG+L
        9eJRxQUn5q8A+qhlLoFVth9IQ9awP3ksZQ==
X-Google-Smtp-Source: ABdhPJxwnFX3AFBwNlTQclCx34MltG5H45Zt4hIDNr5RGQ3wq02qd91DIm1/8GecinGiYwpIbRlsBA==
X-Received: by 2002:a7b:cf23:: with SMTP id m3mr7613446wmg.146.1643207825773;
        Wed, 26 Jan 2022 06:37:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x4sm21015294wrp.13.2022.01.26.06.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:37:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/2] sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
Date:   Wed, 26 Jan 2022 15:37:00 +0100
Message-Id: <patch-v4-1.2-7f31277fd57-20220126T143427Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.g96f29f9df61
In-Reply-To: <cover-v4-0.2-00000000000-20220126T143427Z-avarab@gmail.com>
References: <xmqqo84gu4sb.fsf@gitster.g> <cover-v4-0.2-00000000000-20220126T143427Z-avarab@gmail.com>
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
2.35.0.890.g96f29f9df61

