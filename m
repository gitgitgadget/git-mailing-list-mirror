Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543221F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 19:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbdKHTz1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 14:55:27 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:50854 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752281AbdKHTzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 14:55:25 -0500
Received: by mail-io0-f194.google.com with SMTP id 97so7234688iok.7
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 11:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4mPTerQqu9FZa4rBvR/kOrBh047pLs1/CiXGGQbi+yw=;
        b=iAoJuk9EbLpLrYCvcHW46RFWFxuZxLSNM0/U2ppvnwMe565lGmNjfHxmdqJ2OO6HcQ
         +IDKfEe7AUmN1BzEE8CWxM1sFINBEoL8OCaZJnP+4blv0TqxlAetcbKjp1kKhLxa+Wc7
         HhY+R3PneA2Cux/Cmm9lRJerJOag+7o4ONCuqelvuyRAsEPPgJ6Q2fh4DphUjPmv9Yiu
         H9nmvu+Sd9EsD7TZPlQZlKRKJ62LWT2qxrGRu0Fu6q6c+Oz0b7Zy2B+AQA1Lb4ayxHW8
         xKb8iiZjtAIpQRwkuPEczxQVTqEJiXg7fBRYWUzDFnjB09YCJqfyCpnBko/ufxittFZa
         Q0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4mPTerQqu9FZa4rBvR/kOrBh047pLs1/CiXGGQbi+yw=;
        b=t+SCuFZqsLAXUFXSdWixbcxSyErr/78ytuFkT9ymzmTjbRGMGiZPTY8At8h9ZdnBEW
         wRwv75ElO/VmZkwCowO8K180wdyoiayYbGcpICgKkuwGIQsi/7Galh5JDEAoRgo2B68r
         Q63MEOfyjmbxeBPz0xfye+C2bzqMX+DuQTXzUE218IP/8X27Hhmjvp8rII0vOnQ+Xr7x
         z5xqALDg6Ja07TpbB5i0XApmevyJP8QfoLzR1KatqCTegvDnkjhpYvrZ0M6LFjaSa5Fo
         ihmWblxqkNscb/p0aaC1QLgGCgRAO3L/X04+Qmg2WnN15rFCciPJN9FxZBP/fUI7s1jQ
         HtqA==
X-Gm-Message-State: AJaThX62fGCodoliPyftYBg3TB9d95Jilolcy8Cxwm4YqbpkwDWs+VRL
        ZI+RA9UbquAX/oH9ihBg0WNOY/wN3yw=
X-Google-Smtp-Source: ABhQp+TW8wEqGFOAk6SVvz3SOBCAexd5BoR6jUamFBMu3hUGMhQlWC6zASZ+An8rBPGInBQntXpcNQ==
X-Received: by 10.107.192.4 with SMTP id q4mr2223572iof.59.1510170924853;
        Wed, 08 Nov 2017 11:55:24 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c178:b390:b6a8:a0e2])
        by smtp.gmail.com with ESMTPSA id 68sm2183944iov.2.2017.11.08.11.55.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Nov 2017 11:55:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] remote, revision: factor out exclusive counting between two commits
Date:   Wed,  8 Nov 2017 11:55:06 -0800
Message-Id: <20171108195509.7839-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171108195509.7839-1-sbeller@google.com>
References: <20171108195509.7839-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 remote.c   | 40 +---------------------------------------
 revision.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 revision.h |  7 +++++++
 3 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/remote.c b/remote.c
index 685e776a65..60c689383a 100644
--- a/remote.c
+++ b/remote.c
@@ -1990,9 +1990,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 {
 	struct object_id oid;
 	struct commit *ours, *theirs;
-	struct rev_info revs;
 	const char *base;
-	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	/* Cannot stat unless we are marked to build on top of somebody else. */
 	base = branch_get_upstream(branch, NULL);
@@ -2014,43 +2012,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	if (!ours)
 		return -1;
 
-	/* are we the same? */
-	if (theirs == ours) {
-		*num_theirs = *num_ours = 0;
-		return 0;
-	}
-
-	/* Run "rev-list --left-right ours...theirs" internally... */
-	argv_array_push(&argv, ""); /* ignored */
-	argv_array_push(&argv, "--left-right");
-	argv_array_pushf(&argv, "%s...%s",
-			 oid_to_hex(&ours->object.oid),
-			 oid_to_hex(&theirs->object.oid));
-	argv_array_push(&argv, "--");
-
-	init_revisions(&revs, NULL);
-	setup_revisions(argv.argc, argv.argv, &revs, NULL);
-	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
-
-	/* ... and count the commits on each side. */
-	*num_ours = 0;
-	*num_theirs = 0;
-	while (1) {
-		struct commit *c = get_revision(&revs);
-		if (!c)
-			break;
-		if (c->object.flags & SYMMETRIC_LEFT)
-			(*num_ours)++;
-		else
-			(*num_theirs)++;
-	}
-
-	/* clear object flags smudged by the above traversal */
-	clear_commit_marks(ours, ALL_REV_FLAGS);
-	clear_commit_marks(theirs, ALL_REV_FLAGS);
-
-	argv_array_clear(&argv);
+	compare_commits(ours, theirs, num_ours, num_theirs);
 	return 0;
 }
 
diff --git a/revision.c b/revision.c
index 99c95c19b0..fe1faf2628 100644
--- a/revision.c
+++ b/revision.c
@@ -1159,6 +1159,51 @@ int ref_excluded(struct string_list *ref_excludes, const char *path)
 	return 0;
 }
 
+void compare_commits(struct commit *ours, struct commit *theirs,
+		    int *num_ours, int *num_theirs)
+{
+	struct rev_info revs;
+	struct argv_array argv = ARGV_ARRAY_INIT;
+
+	/* are we the same? */
+	if (theirs == ours) {
+		*num_theirs = *num_ours = 0;
+		return;
+	}
+
+	/* Run "rev-list --left-right ours...theirs" internally... */
+	argv_array_push(&argv, ""); /* ignored */
+	argv_array_push(&argv, "--left-right");
+	argv_array_pushf(&argv, "%s...%s",
+			 oid_to_hex(&ours->object.oid),
+			 oid_to_hex(&theirs->object.oid));
+	argv_array_push(&argv, "--");
+
+	init_revisions(&revs, NULL);
+	setup_revisions(argv.argc, argv.argv, &revs, NULL);
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+
+	/* ... and count the commits on each side. */
+	*num_ours = 0;
+	*num_theirs = 0;
+	while (1) {
+		struct commit *c = get_revision(&revs);
+		if (!c)
+			break;
+		if (c->object.flags & SYMMETRIC_LEFT)
+			(*num_ours)++;
+		else
+			(*num_theirs)++;
+	}
+
+	/* clear object flags smudged by the above traversal */
+	clear_commit_marks(ours, ALL_REV_FLAGS);
+	clear_commit_marks(theirs, ALL_REV_FLAGS);
+
+	argv_array_clear(&argv);
+}
+
 static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
diff --git a/revision.h b/revision.h
index 54761200ad..3ff6a5190b 100644
--- a/revision.h
+++ b/revision.h
@@ -324,4 +324,11 @@ extern int rewrite_parents(struct rev_info *revs, struct commit *commit,
  */
 extern struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
 
+/*
+ * Compute the number of commits between 'one' and 'two' storing the number
+ * of commits in their parent DAG  ncluded in each but not the other.
+ */
+extern void compare_commits(struct commit *one, struct commit *two,
+			    int *num_one, int *num_two);
+
 #endif
-- 
2.15.0.128.g40905b34bf.dirty

