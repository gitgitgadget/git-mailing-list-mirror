Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0E9C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhLIFGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLIFGH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:06:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1A4C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:02:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p18so3247712wmq.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tnVeP5VmZisuIg+QI+dt2f23zNhHXzXESoF2lJv2d/k=;
        b=XSXNn1jNWFJPKfoPkauakS/jCh4bNTE0Yi210zsFFEsc7knhl2ENUznt3AXeM0xXRJ
         okNhLhDK6A3EA2eTQOy7HK5QCfC4t4kBOM7xI1z2TblSpeNg4xpHGtqrRybZO79qng9B
         bia2prsA/zS34CTxU7qD9GVzWk/teA43oZurDkRgpB8Z7hsRMk87Hm2Oi0Ki12QzTOI/
         Q+WKS+ar1yruTAGId7y0fWs5MXui7jUz+jHTH0jFs8IeGgHVBANrMvwFH1U1fSz9USk7
         GA/+wDzsGOc2Vx43zmzvhukkZSv4MxpVqcg/BBUo3LKhclZIsMV9ErRqTvYubpGnIKW5
         U8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tnVeP5VmZisuIg+QI+dt2f23zNhHXzXESoF2lJv2d/k=;
        b=nodHD3KtmOdFms7Bp3qUjFNhc7EZrn1r4iDT6DRaG0sSPVxmkBM/nBBgYGXPhbkoxc
         HzQZ4aPjybUl1rxPwPJmcR3fPoaEe3bYmu5txWjfdWGa59NrQOYTgWi6zmLftDL/xjkt
         nRhkzTFVlv60AJkeQNsXoPD9VRoyfH24t5RAgjJhfrpbyBLjE1rkTzsxNiR1EE2dR/Zg
         46GjcjFS8a7EQDjZ6aKQNR8+Rnoi6tcK+3OKhGJ+fHjShlX2da3lMyAddh5qOg4kLfp0
         GL/U85OzM7GELJf3vkfXl8zCNR1jQTfRyUwqu8+eut1IX/l7lyUHPP0HL+Fhmj/uynlH
         e4JA==
X-Gm-Message-State: AOAM530DhxL8E31vt0XOzmZpC5DZ84kk2TWbw6yH5JTPg8q+KdcF5rjl
        bO2KY6oLx20wiaNXVq2k0efuc1mVCnfDtg==
X-Google-Smtp-Source: ABdhPJzIabcPKU0b5XrMfhflOld/KDHnr9CP01dXKbOn8zqPFIrEPETpn1CKuweajfGZsJeLrUa/3g==
X-Received: by 2002:a05:600c:4f44:: with SMTP id m4mr4253552wmq.95.1639026152894;
        Wed, 08 Dec 2021 21:02:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w22sm4270394wmi.27.2021.12.08.21.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:02:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
Date:   Thu,  9 Dec 2021 06:02:27 +0100
Message-Id: <patch-2.3-a4d1dadb9c9-20211209T045735Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g218b4aae189
In-Reply-To: <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com>
References: <xmqqo85q2a42.fsf@gitster.g> <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com>
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
index b4135a78c91..a649bd737ba 100644
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
2.34.1.930.g218b4aae189

