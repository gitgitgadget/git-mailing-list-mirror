Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103F5207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046140AbdDWVfw (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:35:52 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37320 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046091AbdDWVfb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A058E280B4;
        Sun, 23 Apr 2017 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983329;
        bh=hutjRo5HsKDbF/+SRuxzdwpgjZ2+YgA4SPBCk5IDydU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pIMhNVCuGxAzTZ3mcNgacJbbVLoQr14OGuGdJ51Zhdh2U96E0TBuwo73m3+80eKSk
         e+heWurp1J/lbp1P6QF5DHz9LI7NJrm0Yauy99FeVxH1ND199mzMHJjLte4+hh/JdG
         /OKglQ8MROYjjFY48fVQMW5YDXVE1UYXMWboD4Q+g7r0ilkkeAR90Fy5I9UFH0s6pM
         NKlQ9ylnq5P6aFGnZcgjTdyfebiBfGKCYGI4kfIpY1ESI3yis5N8gl7hJ5JTKmWPGp
         dKbSjuXOCyQnl4DtK1Z16F+fJ2K1vVNOX9aiSVJQHTr/IpTuLMeTLdijYAD1eXx1C4
         JdyPgCks895PeXgVrdyuSWU2LAZ7MckiioWG3imDAV+nTZ59OoHzp1zheQUo5FcLXq
         0t8sdCtGtMlh7Iw4oooIgxywYmv4XKMcPsYJ2CzHtMWeFAXUPVv/fVl4JrfVGfIhzb
         H9FhrmxxyyN1e5ZSiThJxaIozVRfGFXs4M2h0YCJxmp5bnHn9es
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/53] branch: convert to struct object_id
Date:   Sun, 23 Apr 2017 21:34:07 +0000
Message-Id: <20170423213453.253425-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
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
