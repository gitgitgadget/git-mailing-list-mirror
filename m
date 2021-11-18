Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4321DC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1E461B2B
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhKRQxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57644 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhKRQwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 80DD01FD40
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNck9KdNOF5Q1sHo+uYStEzLaVAX6KCJVKKc5Ex23hk=;
        b=AXwrQldK5RvA4Am0kC9xmkDKb/Df6VPJfIubkJeYX+vw/taZfjYD5LxHqnXyzt+YIKc6w+
        DZLd3g/nY8qRWYibgQRkHqeRUqedDALKVWAkDmipHeXZ6RwUAK+ojEg8USr9xYcGDyU/7S
        5x/Ycui8rkewbrXoTx2nCWVjopDtLcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNck9KdNOF5Q1sHo+uYStEzLaVAX6KCJVKKc5Ex23hk=;
        b=/tnENvhfbO4uNdFokMtEhJyotWXwXqjy2R42p/VI3odSGPy7Lz9MwC3YcD5bWyk8sg5ArW
        7wBRwk1Uw4J4KOAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 72B01A3B96;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9CF931F2CAC; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 13/27] bisect: Allow specifying desired result confidence
Date:   Thu, 18 Nov 2021 17:49:26 +0100
Message-Id: <20211118164940.8818-14-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow specifying desired result confidence for stochastic bisection
when starting bisection. Store it and load it when doing bisection
steps.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c                 | 15 ++++++++++++++-
 builtin/bisect--helper.c | 22 +++++++++++++++++++++-
 fixedpoint.h             |  1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 0773a872c82b..f87753d0c67c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -22,6 +22,8 @@ static struct oid_array good_revs;
 static struct oid_array ptest_revs;
 static struct oid_array skipped_revs;
 
+static fpnum_t result_confidence;
+
 static struct object_id *current_bad_oid;
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
@@ -482,15 +484,25 @@ static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_confidences, "BISECT_CONFIDENCES")
+static GIT_PATH_FUNC(git_path_bisect_result_confidence, "BISECT_RESULT_CONFIDENCE")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
 static void read_bisect_confidences(void)
 {
 	struct strbuf str = STRBUF_INIT;
-	const char *filename = git_path_bisect_confidences();
+	const char *filename = git_path_bisect_result_confidence();
 	FILE *fp = fopen(filename, "r");
 
 	/* Just a regular bisection? */
+	if (!fp)
+		return;
+	if (fscanf(fp, "%"FPNUM_FMT, &result_confidence) != 1)
+		die(_("Cannot parse result confidence in file '%s'"), filename);
+	fclose(fp);
+
+	/* No uncertain bisection steps yet? */
+	filename = git_path_bisect_confidences();
+	fp = fopen(filename, "r");
 	if (!fp)
 		return;
 
@@ -1223,6 +1235,7 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
 	unlink_or_warn(git_path_bisect_confidences());
+	unlink_or_warn(git_path_bisect_result_confidence());
 	/* Cleanup head-name if it got left by an old version of git-bisect */
 	unlink_or_warn(git_path_head_name());
 	/*
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index f88feb8da949..5b46a8ca3fd9 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,12 +21,14 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 static GIT_PATH_FUNC(git_path_bisect_confidences, "BISECT_CONFIDENCES")
+static GIT_PATH_FUNC(git_path_bisect_result_confidence, "BISECT_RESULT_CONFIDENCE")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
-					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
+					    " [--no-checkout] [--first-parent] [--confidence <conf>]"
+					    " [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-state (bad|new) [--confidence <conf>] [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [--confidence <conf>] [<rev>...]"),
@@ -668,6 +670,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 	struct object_id head_oid;
 	struct object_id oid;
 	const char *head;
+	fpnum_t confidence = FP_ONE;
 
 	if (is_bare_repository())
 		no_checkout = 1;
@@ -690,6 +693,16 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--first-parent")) {
 			first_parent_only = 1;
+		} else if (!strcmp(arg, "--confidence")) {
+			i++;
+			if (argc <= i)
+				return error(_("missing confidence argument"));
+			if (parse_confidence(argv[i], &confidence))
+				return -1;
+			if (confidence == FP_ONE)
+				return error(_("Absolute confidence not possible with stochastic bisection"));
+			if (confidence < FP_HALF)
+				return error(_("Target confidence of at least 0.5 needed for stochastic bisection"));
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
 			i++;
@@ -809,6 +822,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 	if (first_parent_only)
 		write_file(git_path_bisect_first_parent(), "\n");
 
+	if (confidence != FP_ONE)
+		write_file(git_path_bisect_result_confidence(),
+			   "%" FPNUM_FMT "\n", confidence);
+
 	if (no_checkout) {
 		if (get_oid(start_head.buf, &oid) < 0) {
 			res = error(_("invalid ref: '%s'"), start_head.buf);
@@ -917,6 +934,9 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 			return error(_("missing confidence argument"));
 		if (parse_confidence(argv[1], &confidence))
 			return -1;
+		if (is_empty_or_missing_file(git_path_bisect_result_confidence()))
+			return error(_("Stochastic bisection not started. Pass "
+				"desired target confidence to git bisect start."));
 		argv += 2;
 		argc -= 2;
 	}
diff --git a/fixedpoint.h b/fixedpoint.h
index addef223be2b..3f6234c6530a 100644
--- a/fixedpoint.h
+++ b/fixedpoint.h
@@ -25,5 +25,6 @@ static inline const double fp_to_double(fpnum_t n)
 }
 
 #define FP_ONE frac_to_fp(1, 1)
+#define FP_HALF frac_to_fp(1, 2)
 
 #endif
-- 
2.26.2

