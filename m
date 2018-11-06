Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FBF71F453
	for <e@80x24.org>; Tue,  6 Nov 2018 07:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbeKFROP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 12:14:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:41824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729160AbeKFROP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 12:14:15 -0500
Received: (qmail 17702 invoked by uid 109); 6 Nov 2018 07:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 07:50:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29085 invoked by uid 111); 6 Nov 2018 07:49:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 02:49:37 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 02:50:17 -0500
Date:   Tue, 6 Nov 2018 02:50:17 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Felix Eckhofer <felix@eckhofer.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] merge: extract verify_merge_signature() helper
Message-ID: <20181106075017.GA22021@sigill.intra.peff.net>
References: <20181106074910.GA31978@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106074910.GA31978@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The logic to implement "merge --verify-signatures" is inline in
cmd_merge(), but this site misses some cases. Let's extract the logic
into a function so we can call it from more places.

We'll move it to commit.[ch], since one of the callers (git-pull) is
outside our source file. This function isn't all that general (after
all, its main function is to exit the program) but it's not worth trying
to fix that. The heavy lifting is done by check_commit_signature(), and
our purpose here is just sharing the die() logic. We'll mark it with a
comment to make that clear.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c | 26 +-------------------------
 commit.c        | 26 ++++++++++++++++++++++++++
 commit.h        |  7 +++++++
 3 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4aa6071598..c677f9375e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1357,31 +1357,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (verify_signatures) {
 		for (p = remoteheads; p; p = p->next) {
-			struct commit *commit = p->item;
-			char hex[GIT_MAX_HEXSZ + 1];
-			struct signature_check signature_check;
-			memset(&signature_check, 0, sizeof(signature_check));
-
-			check_commit_signature(commit, &signature_check);
-
-			find_unique_abbrev_r(hex, &commit->object.oid, DEFAULT_ABBREV);
-			switch (signature_check.result) {
-			case 'G':
-				break;
-			case 'U':
-				die(_("Commit %s has an untrusted GPG signature, "
-				      "allegedly by %s."), hex, signature_check.signer);
-			case 'B':
-				die(_("Commit %s has a bad GPG signature "
-				      "allegedly by %s."), hex, signature_check.signer);
-			default: /* 'N' */
-				die(_("Commit %s does not have a GPG signature."), hex);
-			}
-			if (verbosity >= 0 && signature_check.result == 'G')
-				printf(_("Commit %s has a good GPG signature by %s\n"),
-				       hex, signature_check.signer);
-
-			signature_check_clear(&signature_check);
+			verify_merge_signature(p->item, verbosity);
 		}
 	}
 
diff --git a/commit.c b/commit.c
index d566d7e45c..e1428aed6d 100644
--- a/commit.c
+++ b/commit.c
@@ -1100,7 +1100,33 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 	return ret;
 }
 
+void verify_merge_signature(struct commit *commit, int verbosity)
+{
+	char hex[GIT_MAX_HEXSZ + 1];
+	struct signature_check signature_check;
+	memset(&signature_check, 0, sizeof(signature_check));
+
+	check_commit_signature(commit, &signature_check);
+
+	find_unique_abbrev_r(hex, &commit->object.oid, DEFAULT_ABBREV);
+	switch (signature_check.result) {
+	case 'G':
+		break;
+	case 'U':
+		die(_("Commit %s has an untrusted GPG signature, "
+		      "allegedly by %s."), hex, signature_check.signer);
+	case 'B':
+		die(_("Commit %s has a bad GPG signature "
+		      "allegedly by %s."), hex, signature_check.signer);
+	default: /* 'N' */
+		die(_("Commit %s does not have a GPG signature."), hex);
+	}
+	if (verbosity >= 0 && signature_check.result == 'G')
+		printf(_("Commit %s has a good GPG signature by %s\n"),
+		       hex, signature_check.signer);
 
+	signature_check_clear(&signature_check);
+}
 
 void append_merge_tag_headers(struct commit_list *parents,
 			      struct commit_extra_header ***tail)
diff --git a/commit.h b/commit.h
index 6c4428c593..a98cca635a 100644
--- a/commit.h
+++ b/commit.h
@@ -331,6 +331,13 @@ extern int remove_signature(struct strbuf *buf);
  */
 extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
+/*
+ * Verify a single commit with check_commit_signature() and die() if it is not
+ * a good signature. This isn't really suitable for general use, but is a
+ * helper to implement consistent logic for pull/merge --verify-signatures.
+ */
+void verify_merge_signature(struct commit *commit, int verbose);
+
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
-- 
2.19.1.1533.g982fead9fb

