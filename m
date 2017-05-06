Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5A6207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbdEFWLW (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:11:22 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37612 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754128AbdEFWLH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B4C78280B4;
        Sat,  6 May 2017 22:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108666;
        bh=hutjRo5HsKDbF/+SRuxzdwpgjZ2+YgA4SPBCk5IDydU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5ZHjxHcTx4L0RVI3fsNa4F3c3U1Wb29jTNL71D2SBljoaTpQYRPwdve2uUe9EIzt
         DL+HV5Lvr5+UMgKLXNmgoxptkGMi6bz11n+mvRta0mnrykuYYqc+cSAdilpusYcMFG
         lB36J4t2jbifxhc9rhcwYN96V7gRDyXpTEOdpy9UHqbrVXUWTalfNaKr+TvF3xPd2q
         cN/TjQ4ESiwcTxFKRr5aOZzLe06mi+rjva18bTUdnq5yhTyJUh3X2789OW7YNXxFKh
         Mlf1B2bKbiptZnEWyu2LY8DuR3rtEHGrcQTXAZXmYwoMWbuMVKXmsmeKwLQvBGyNKR
         25SfuHR2zUOWNXWCgUVT2LOSP2ygOyQwAcxlPTwmtk+73FTHrgLakEE6AjNEokZvum
         4+t37364uhsQxnAgYDfr8aDTqCfeIyyflL6FvRTCe7NUkVPVKfulBU/gV24wjgG97s
         r533nGbRBoNYecV06bGJ+bEONf65wMqcH22P4rXkV2AW3kebEiN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 07/53] branch: convert to struct object_id
Date:   Sat,  6 May 2017 22:09:52 +0000
Message-Id: <20170506221038.296722-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change is required to convert lookup_commit_reference later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 branch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index ad5a2299b..1758c9708 100644
--- a/branch.c
+++ b/branch.c
@@ -191,9 +191,9 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 
 	if (!attr_only) {
 		const char *head;
-		unsigned char sha1[20];
+		struct object_id oid;
 
-		head = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
+		head = resolve_ref_unsafe("HEAD", 0, oid.hash, NULL);
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
 			die(_("Cannot force update the current branch."));
 	}
@@ -233,7 +233,7 @@ void create_branch(const char *name, const char *start_name,
 		   int quiet, enum branch_track track)
 {
 	struct commit *commit;
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *real_ref;
 	struct strbuf ref = STRBUF_INIT;
 	int forcing = 0;
@@ -253,7 +253,7 @@ void create_branch(const char *name, const char *start_name,
 	}
 
 	real_ref = NULL;
-	if (get_sha1(start_name, sha1)) {
+	if (get_oid(start_name, &oid)) {
 		if (explicit_tracking) {
 			if (advice_set_upstream_failure) {
 				error(_(upstream_missing), start_name);
@@ -265,7 +265,7 @@ void create_branch(const char *name, const char *start_name,
 		die(_("Not a valid object name: '%s'."), start_name);
 	}
 
-	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
+	switch (dwim_ref(start_name, strlen(start_name), oid.hash, &real_ref)) {
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
@@ -286,9 +286,9 @@ void create_branch(const char *name, const char *start_name,
 		break;
 	}
 
-	if ((commit = lookup_commit_reference(sha1)) == NULL)
+	if ((commit = lookup_commit_reference(oid.hash)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
-	hashcpy(sha1, commit->object.oid.hash);
+	oidcpy(&oid, &commit->object.oid);
 
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
@@ -306,7 +306,7 @@ void create_branch(const char *name, const char *start_name,
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, ref.buf,
-					   sha1, forcing ? NULL : null_sha1,
+					   oid.hash, forcing ? NULL : null_sha1,
 					   0, msg, &err) ||
 		    ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
