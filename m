Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25899C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiG2KND (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbiG2KM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:12:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1776C747AB
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o3so4192105ple.5
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yysz+isgtB/SioY8uNqLW2uBB4o9yHVCf0k08Wg+lk=;
        b=AKe41LdAiRzQKgn5cf27SHZTwzpM1HjgToJN0Fa3q/sjQcNaavnzFPXxPuTpaS6+4n
         dC4aUC/YIDNSjXvUICXRW8Lzia97H9A1GGxonfp5Cd7277DQOfWZwhYokHc7S+qyWFTG
         vdiBlMj34vzAq+3/OQ6XLSjZ4DsPXcLJqkUF0nOp2CK/SnMAkArb/XeFfMiSfChHZWBS
         lN/zMTV2STJ/y1+KgDGSW4DRSUAjJWYP6MjUGk0Qjms96vi0v7NWoH7F32BOeIvxjXaU
         iz766PtoY2Th978wfdtFEJ3EB5HULKUjh8DJwqv5XsqyHUx6uQPtEBTDbkSM+MdO0681
         vTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0yysz+isgtB/SioY8uNqLW2uBB4o9yHVCf0k08Wg+lk=;
        b=CMrpEbPsa4rSGOwrhojVq6CqbjKRAzg58cPthCCZTZspOXmDC6JuLFji7Qq3LaHPDn
         s3VBI4JOm/R5Ki6EEZdkxl8N430KXXeZzvjt/AwM1mPEPkaYlGZ+yqHGramiwHFPqbxC
         R+Ej5ZDPMCFuDax2EXB7yKOJHK+R1fvOaB9wD0yNcAapt8F6XhZmtj0YOIzCZA/QGGLo
         X7XubrsMNt9xVoQm1RGeiMSJQWvfVS3EYyUPzihLkOobkYqCjtTD7EIHSe8y2/rbeLJV
         j0JdwWmfnfKdJ5rwaySAFIxJg/B/f6e+e5WUUbNbe5b2FwDoyRZaQsqeXtXlimkAjtFU
         +tzw==
X-Gm-Message-State: ACgBeo3Ns6bc33m+WmeAPmsj9zy5+z9TuqbolpIHsFHfw+t2gsBaERKp
        fDocgZXTAauBB72ziJ2f560=
X-Google-Smtp-Source: AA6agR7FAe1yvgWnp3auWWJvMhFNEL5keC45gfIzeS8OGxMAi17cuXarhGTfqI6pr4vvFrrKumdvGQ==
X-Received: by 2002:a17:90b:350b:b0:1f0:23d9:57eb with SMTP id ls11-20020a17090b350b00b001f023d957ebmr3860497pjb.17.1659089576639;
        Fri, 29 Jul 2022 03:12:56 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0016c4fb6e0b2sm3207797plg.55.2022.07.29.03.12.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:12:56 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 3/9] refs: add new field in transaction for running transaction hook
Date:   Fri, 29 Jul 2022 18:12:39 +0800
Message-Id: <20220729101245.6469-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220729101245.6469-1-worldhello.net@gmail.com>
References: <20220729101245.6469-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add a new field "hook_flags" in transaction, and only run the
"reference-transaction" hook if the specific flag is turned on.

The "reference-transaction" hook has three states: prepared, committed,
and aborted. To update a reference, git may create two seperate
transactions, one for loose reference and one for packed ref-store. This
may cause duplicate running of the hook for same references. The new
field "hook_flags" in the transaction can turn off running of a specific
transaction. In some scenarios, we may only want to turn off certain
states of a transaction, such as "committed" and "aborted", but want to
turn on the "prepared" state of the hook to do some pre-checks, so the
"hook_flags" field has three bits to control running of the three states
of the hook.

By calling the "ref_store_transaction_begin()" function, all the flags
of the "hook_flags" field for the new initialized transaction will be
turned on. The new function "ref_store_transaction_begin_extended()"
will be used in later commits to custom the "hook_flags" field for a
new initialized transaction.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c               | 25 +++++++++++++++++++++++--
 refs.h               |  3 +++
 refs/refs-internal.h |  8 ++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 90bcb27168..48b69460e2 100644
--- a/refs.c
+++ b/refs.c
@@ -998,17 +998,27 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 	return 1;
 }
 
-struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
-						    struct strbuf *err)
+struct ref_transaction *ref_store_transaction_begin_extended(struct ref_store *refs,
+							     unsigned int hook_flags,
+							     struct strbuf *err)
 {
 	struct ref_transaction *tr;
 	assert(err);
 
 	CALLOC_ARRAY(tr, 1);
 	tr->ref_store = refs;
+	tr->hook_flags = hook_flags;
 	return tr;
 }
 
+struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    struct strbuf *err)
+{
+	return ref_store_transaction_begin_extended(refs,
+						    REF_TRANSACTION_RUN_ALL_HOOKS,
+						    err);
+}
+
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return ref_store_transaction_begin(get_main_ref_store(the_repository), err);
@@ -2074,6 +2084,17 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	const char *hook;
 	int ret = 0, i;
 
+	if (!strcmp(state, "prepared")) {
+		if (!(transaction->hook_flags & REF_TRANSACTION_RUN_PREPARED_HOOK))
+			return 0;
+	} else if (!strcmp(state, "committed")) {
+		if (!(transaction->hook_flags & REF_TRANSACTION_RUN_COMMITTED_HOOK))
+			return 0;
+	} else if (!strcmp(state, "aborted")) {
+		if (!(transaction->hook_flags & REF_TRANSACTION_RUN_ABORTED_HOOK))
+			return 0;
+	}
+
 	hook = find_hook("reference-transaction");
 	if (!hook)
 		return ret;
diff --git a/refs.h b/refs.h
index 47cb9edbaa..715127ab58 100644
--- a/refs.h
+++ b/refs.h
@@ -570,6 +570,9 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
+struct ref_transaction *ref_store_transaction_begin_extended(struct ref_store *refs,
+							     unsigned int hook_flags,
+							     struct strbuf *err);
 struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 						    struct strbuf *err);
 struct ref_transaction *ref_transaction_begin(struct strbuf *err);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 69f93b0e2a..5220d1980d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -201,6 +201,13 @@ enum ref_transaction_state {
 	REF_TRANSACTION_CLOSED   = 2
 };
 
+#define REF_TRANSACTION_RUN_PREPARED_HOOK (1 << 0)
+#define REF_TRANSACTION_RUN_COMMITTED_HOOK (1 << 1)
+#define REF_TRANSACTION_RUN_ABORTED_HOOK (1 << 2)
+#define REF_TRANSACTION_RUN_ALL_HOOKS         \
+	(REF_TRANSACTION_RUN_PREPARED_HOOK  | \
+	 REF_TRANSACTION_RUN_COMMITTED_HOOK | \
+	 REF_TRANSACTION_RUN_ABORTED_HOOK)
 /*
  * Data structure for holding a reference transaction, which can
  * consist of checks and updates to multiple references, carried out
@@ -212,6 +219,7 @@ struct ref_transaction {
 	size_t alloc;
 	size_t nr;
 	enum ref_transaction_state state;
+	unsigned int hook_flags;
 	void *backend_data;
 };
 
-- 
2.36.1.25.gc87d5ad63a.dirty

