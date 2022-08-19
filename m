Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6C8C00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 03:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbiHSDW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241940AbiHSDWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 23:22:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B27DA3E8
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:22:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g18so3491171pju.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Akql0iNkYSozHtEjoAQSaojCWdGc3+btUviECy1lkiU=;
        b=RlJuUaZa4y9hO9ChxuVS12SazMIJhf/FYl4Cg7QesWfEuppP/xuSoU9bfrI7qW3xjR
         ZCBpODjRsW1J6mlkpnqQjsigJV5b9NYscVj4CRL2najS0u7drobfm7/ugWlX6gY+5NXn
         3K8+UoEPtv8r6yy3s5Y4w679AaDcdSbO+b9Nm8V+HZpF4NFGVC7Odm39hutwB+UhfIof
         OD+9jSaVV+WD5tGDg70KEWoXsNVeOaMzwe0WaCHOTvRc2MSHWvQ7obCfxhfxG64JZhJ6
         Q1o2SDxObwb8EDubIerQ8Zm3ZQKgl7uoGA4HAjrg4XAXCKVXk8Si0a+67nwfjD752Wz3
         kKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Akql0iNkYSozHtEjoAQSaojCWdGc3+btUviECy1lkiU=;
        b=xnuz7gC3x+a+4wDN8+aOOEBEIbcls2E5K1VJiwZvF5UW3P/OY7oouZCxQj1DqdHP0q
         9/sqPP5+6B5sgyn5ibug41lxkrUwImDNm8G12owRTWZueogfKAM2bL+hzLx2aF6Rkft+
         HRTPwEgI1g6SK2niInJOFIkse62nAai2mSoYFlRH4/8O8By4+QrsGsyJKY+KXJoJYU0y
         5TqGGhfnJuvfBkBcu9idZqjx+2d8N0opvTGiCbyrxl58OOYL/FDwCCHPitE2f/u4+6rc
         zA/OVYV0IrEvkiFK5YSzuRQRdQDAo/gJtFMm89WkwFeF1vu7xhz+71AGsFNYRwtVEEAE
         RU9A==
X-Gm-Message-State: ACgBeo1S6CXzy3wgVVPXY8oMlMmfM5MtS93Pw0iPE4ImtUobbIXCZpp8
        mDhIfnxZnbzl78CPrCzK0F4=
X-Google-Smtp-Source: AA6agR6//OC10UGWZ06OWGhhVvYy9D6fE+ROmSCQPbnj0xYHNs9+5W3weqPQiicBvp/7Aos6YRJ3mA==
X-Received: by 2002:a17:902:d2d1:b0:172:aaf5:861a with SMTP id n17-20020a170902d2d100b00172aaf5861amr5354090plc.114.1660879319829;
        Thu, 18 Aug 2022 20:21:59 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0016f1319d2a7sm2036995plt.297.2022.08.18.20.21.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:21:59 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Michael Heemskerk <mheemskerk@atlassian.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 8/9] refs: reimplement files_copy_or_rename_ref() to run refs-txn hook
Date:   Fri, 19 Aug 2022 11:21:46 +0800
Message-Id: <20220819032147.28841-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
References: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When copying or renaming a branch, the "reference-transaction" hook is
not executed. This is because we called two low-level functions
"lock_ref_oid_basic()" and "write_ref_to_lockfile()", and reinvented
the wheel in "commit_ref_update()" to update the reference instead of
implementing "files_copy_or_rename_ref()" by calling "refs_update_ref()"
to update a reference in a transaction. The reason for this is that we
want to create a proper reflog for the newly copied reference.

Refactor "files_copy_or_rename_ref()" by calling the extended version
of "refs_update_ref", i.e. "refs_update_ref_extended()", so we can
create the target branch for copying or renaming a branch and generate
a correct reflog file at the same time.

The behavior of the following git commands and two testcases have been
fixed in t1416:

 * git branch -c <src> <dest>	# copy branch
 * git branch -m <old> <new>	# rename branch

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs/files-backend.c             | 97 +++-----------------------------
 t/t1416-ref-transaction-hooks.sh | 28 +--------
 2 files changed, 9 insertions(+), 116 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 336384daa0..e029f5a885 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1376,10 +1376,6 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const struct object_id *oid,
 				 int skip_oid_verification, struct strbuf *err);
-static int commit_ref_update(struct files_ref_store *refs,
-			     struct ref_lock *lock,
-			     const struct object_id *oid, const char *logmsg,
-			     struct strbuf *err);
 
 /*
  * Emit a better error message than lockfile.c's
@@ -1418,13 +1414,13 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
 	struct object_id orig_oid;
 	int flag = 0, logmoved = 0;
-	struct ref_lock *lock;
 	struct stat loginfo;
 	struct strbuf sb_oldref = STRBUF_INIT;
 	struct strbuf sb_newref = STRBUF_INIT;
 	struct strbuf tmp_renamed_log = STRBUF_INIT;
 	int log, ret;
 	struct strbuf err = STRBUF_INIT;
+	struct reflog_info reflog_info;
 
 	files_reflog_path(refs, &sb_oldref, oldrefname);
 	files_reflog_path(refs, &sb_newref, newrefname);
@@ -1510,8 +1506,10 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
-	lock = lock_ref_oid_basic(refs, newrefname, &err);
-	if (!lock) {
+	reflog_info.msg = (char *)logmsg;
+	reflog_info.old_oid = &orig_oid;
+	if (refs_update_ref_extended(ref_store, newrefname, &orig_oid, NULL,
+				     REF_NO_DEREF, &reflog_info, &err)) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		else
@@ -1519,36 +1517,20 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		strbuf_release(&err);
 		goto rollback;
 	}
-	oidcpy(&lock->old_oid, &orig_oid);
-
-	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
-	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
-		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
-		strbuf_release(&err);
-		goto rollback;
-	}
 
 	ret = 0;
 	goto out;
 
  rollback:
-	lock = lock_ref_oid_basic(refs, oldrefname, &err);
-	if (!lock) {
-		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
-		strbuf_release(&err);
-		goto rollbacklog;
-	}
-
 	flag = log_all_ref_updates;
 	log_all_ref_updates = LOG_REFS_NONE;
-	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
-	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
+	if (refs_update_ref_extended(ref_store, oldrefname, &orig_oid, NULL,
+				     REF_NO_DEREF, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
 	log_all_ref_updates = flag;
 
- rollbacklog:
 	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from %s: %s",
 			oldrefname, newrefname, strerror(errno));
@@ -1815,71 +1797,6 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	return 0;
 }
 
-/*
- * Commit a change to a loose reference that has already been written
- * to the loose reference lockfile. Also update the reflogs if
- * necessary, using the specified lockmsg (which can be NULL).
- */
-static int commit_ref_update(struct files_ref_store *refs,
-			     struct ref_lock *lock,
-			     const struct object_id *oid, const char *logmsg,
-			     struct strbuf *err)
-{
-	files_assert_main_repository(refs, "commit_ref_update");
-
-	clear_loose_ref_cache(refs);
-	if (files_log_ref_write(refs, lock->ref_name,
-				&lock->old_oid, oid,
-				logmsg, 0, err)) {
-		char *old_msg = strbuf_detach(err, NULL);
-		strbuf_addf(err, "cannot update the ref '%s': %s",
-			    lock->ref_name, old_msg);
-		free(old_msg);
-		unlock_ref(lock);
-		return -1;
-	}
-
-	if (strcmp(lock->ref_name, "HEAD") != 0) {
-		/*
-		 * Special hack: If a branch is updated directly and HEAD
-		 * points to it (may happen on the remote side of a push
-		 * for example) then logically the HEAD reflog should be
-		 * updated too.
-		 * A generic solution implies reverse symref information,
-		 * but finding all symrefs pointing to the given branch
-		 * would be rather costly for this rare event (the direct
-		 * update of a branch) to be worth it.  So let's cheat and
-		 * check with HEAD only which should cover 99% of all usage
-		 * scenarios (even 100% of the default ones).
-		 */
-		int head_flag;
-		const char *head_ref;
-
-		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
-						   RESOLVE_REF_READING,
-						   NULL, &head_flag);
-		if (head_ref && (head_flag & REF_ISSYMREF) &&
-		    !strcmp(head_ref, lock->ref_name)) {
-			struct strbuf log_err = STRBUF_INIT;
-			if (files_log_ref_write(refs, "HEAD",
-						&lock->old_oid, oid,
-						logmsg, 0, &log_err)) {
-				error("%s", log_err.buf);
-				strbuf_release(&log_err);
-			}
-		}
-	}
-
-	if (commit_ref(lock)) {
-		strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
-		unlock_ref(lock);
-		return -1;
-	}
-
-	unlock_ref(lock);
-	return 0;
-}
-
 static int create_ref_symlink(struct ref_lock *lock, const char *target)
 {
 	int ret = -1;
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 6ba7ba746c..77996017d7 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -715,9 +715,7 @@ test_expect_success "branch: update branch without old-oid" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Failed because the reference-transaction hook was not executed at all
-# when copying a branch using "git branch -c".
-test_expect_failure "branch: copy branches" '
+test_expect_success "branch: copy branches" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -750,29 +748,7 @@ test_expect_failure "branch: copy branches" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Mismatched hook output for "git branch -m":
-#
-#  * The "reference-transaction committed" command was not executed
-#    for the target branch.
-#
-# The differences are as follows:
-#
-#     @@ -3,14 +3,6 @@
-#      ## Call hook: reference-transaction committed ##
-#      <COMMIT-B> <ZERO-OID> refs/heads/topic4
-#      ## Call hook: reference-transaction  prepared ##
-#     -<ZERO-OID> <COMMIT-B> refs/heads/topic6
-#     -## Call hook: reference-transaction committed ##
-#     -<ZERO-OID> <COMMIT-B> refs/heads/topic6
-#     -## Call hook: reference-transaction  prepared ##
-#      <COMMIT-C> <ZERO-OID> refs/heads/topic5
-#      ## Call hook: reference-transaction committed ##
-#      <COMMIT-C> <ZERO-OID> refs/heads/topic5
-#     -## Call hook: reference-transaction  prepared ##
-#     -<ZERO-OID> <COMMIT-C> refs/heads/topic7
-#     -## Call hook: reference-transaction committed ##
-#     -<ZERO-OID> <COMMIT-C> refs/heads/topic7
-test_expect_failure "branch: rename branches" '
+test_expect_success "branch: rename branches" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
-- 
2.36.1.25.gc87d5ad63a.dirty

