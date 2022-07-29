Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC358C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiG2KNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbiG2KNC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:13:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614CA82121
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:13:01 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q22so467843pfn.9
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyiQb1ntOiMmibsJjS5cwpB5bR8EcIKe9wDtwxsBiaE=;
        b=gMcOwFINZjLiu9eYlSjiomcVOF0CYOnNs6BJ8+ZxA4k+KmqYOzcd8hArbO/1C5xDVi
         on4KLftNewOMz5ANk0buV6Z1znNizctNHZQyGPaNLrnpkM2HvT6C4ZcKWnWJX/l9Ddbv
         9EqY/ZfX1+zXfJlEW+TR6f8wO6qQtw7USeiofbKwNKS3PJI1X+47i+qSt5xojRMhSEsE
         xgoCFpWv4nybxYiW4RL7Ix+/tnsYGhpSHo+uqVplmwA9X1jpLOcccpQ+ykgZRT5ntWhE
         mTzKGyWwc9qqFAtjq/YB4yKsE7PqTQec4Yw2JkPQi9TwKER1DV3ddJwmEPDQnZIvDkhk
         6L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyiQb1ntOiMmibsJjS5cwpB5bR8EcIKe9wDtwxsBiaE=;
        b=CZlipcn04OLLzBfB/hOcUJZIL8i4/2IvxRenaLYMvDOVfnlAeJZ7yLPoqCfwIMY7GL
         d7J6QYxJdjkw7iatxJC1mccPmiWmI+HKvhR+F7JkK0+qYnbNdy5GTSmB16I8Ku+Unj+x
         0dKzWLf9VApxnCBiDt7jUEcDmIQZOPvunJITholP3yu8yobyQT1und2c57U5WNyipx76
         LXBmUPvyeKrMMXxoT3ojEIXou0/kGBEZuTjiqMkAV2qP/lcGSc+DyjE+qo/+IGWBl98m
         NAN2bgACeQhjbU7rQKLs8TANmNDgVYT5UDKZnGuuDy0pRdILUJz7D7sEGRuwXHKh8Ajv
         g7rQ==
X-Gm-Message-State: AJIora/KtrT3/fc2rPbn7nNkUHv7qWl0D/eJGPUfthELyoOgIJX0cAQj
        qlOPmaat/5DVOWQ07nxK9aK8XVEcYPSk9A==
X-Google-Smtp-Source: AGRyM1utY7eGi2uNzhshRcr3iC0psLJIJeuKsiwJXlQUSCt+dUraPcyQObRGClVVGAc8cO5SgSV2rQ==
X-Received: by 2002:a05:6a00:1590:b0:52a:eb00:71dc with SMTP id u16-20020a056a00159000b0052aeb0071dcmr2793176pfk.64.1659089580931;
        Fri, 29 Jul 2022 03:13:00 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0016c4fb6e0b2sm3207797plg.55.2022.07.29.03.13.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:13:00 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 8/9] refs: reimplement files_copy_or_rename_ref() to run hook
Date:   Fri, 29 Jul 2022 18:12:44 +0800
Message-Id: <20220729101245.6469-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220729101245.6469-1-worldhello.net@gmail.com>
References: <20220729101245.6469-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When copying or renaming a branch, the "reference-transaction" hook is
not executed. This is because we used to reinvent the wheel in function
"files_copy_or_rename_ref()". By calling "refs_update_ref_extended()" to
reimplement "files_copy_or_rename_ref()", the "reference-transaction"
hook will run correctly.

The behavior of the following git commands and two testcases have been
fixed in t1416:

 * git branch -c <src> <dest>	# copy branch
 * git branch -m <old> <new>	# rename branch

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs/files-backend.c             | 97 +++-----------------------------
 t/t1416-ref-transaction-hooks.sh |  4 +-
 2 files changed, 9 insertions(+), 92 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e2eabe9d8e..8baea66e58 100644
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
index 21d5326575..df75e5727c 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -670,7 +670,7 @@ test_expect_success "branch: update refs to create loose refs" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "branch: copy branches" '
+test_expect_success "branch: copy branches" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
@@ -703,7 +703,7 @@ test_expect_failure "branch: copy branches" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-test_expect_failure "branch: rename branches" '
+test_expect_success "branch: rename branches" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-EOF &&
-- 
2.36.1.25.gc87d5ad63a.dirty

