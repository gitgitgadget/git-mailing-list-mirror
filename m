Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B32C1FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999539AbdEACbX (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:23 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35662 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642367AbdEACah (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2A1A0280C1;
        Mon,  1 May 2017 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605807;
        bh=qETeohCd45sT5pTpefYGNi6MafKhVx8ZCbTbEQEvCvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0EbkNFoMgItYK9uPxv6qQHQ6KrxynBZ9rQ8n5jvfPdHXVGqwZ8h05bHBjt4tBMrQb
         2dqTfG/YyQo5t4W23fN3jKqJmN0KslbqrICwf+ffURSRIygNi6dV5ZD2BVEfgEFwgy
         IECOoV0GTTsYNpoFYnLDf+cWtT8hQmQcv8v3WW/x4dnBe9DeRWJwJ+5NOefdY6HXN4
         NnKzkNf0I83HmJV8b2KuM/kG2nqJODm/yjTLjteLTlc8rGu8azAisJ8lrrVmusOWx6
         boKux6vfD9vRvu/VjmK9sKsmcNSyqQF1lVInycRqKyj9SFjC4EgLBbBc7SriWFNcV0
         QC/EnnHMbSbx7Znj53u2VQG/QWzhNq2KIxf5YFOXx4v77wx5VnyJYZSzzG2vmoa8Xw
         9mzQicTnM0nErO4BVoKahrMi+rDqVRmkTMt8hKRfZelk40KKuMYnub39ejvFa2dY5I
         DQr3CKETXKfDnekEvh3dNxC0DaO433PvTqqCVddUJWFqiBTLYxZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 18/53] http-push: convert some static functions to struct object_id
Date:   Mon,  1 May 2017 02:29:11 +0000
Message-Id: <20170501022946.258735-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Among the functions converted is a caller of lookup_commit_or_die, which
we will convert later on.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-push.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/http-push.c b/http-push.c
index f0e3108f7..f3dd0a560 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1536,7 +1536,7 @@ static int remote_exists(const char *path)
 	return ret;
 }
 
-static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
+static void fetch_symref(const char *path, char **symref, struct object_id *oid)
 {
 	char *url = xstrfmt("%s%s", repo->url, path);
 	struct strbuf buffer = STRBUF_INIT;
@@ -1549,7 +1549,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 
 	free(*symref);
 	*symref = NULL;
-	hashclr(sha1);
+	oidclr(oid);
 
 	if (buffer.len == 0)
 		return;
@@ -1561,15 +1561,15 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 	if (skip_prefix(buffer.buf, "ref: ", &name)) {
 		*symref = xmemdupz(name, buffer.len - (name - buffer.buf));
 	} else {
-		get_sha1_hex(buffer.buf, sha1);
+		get_oid_hex(buffer.buf, oid);
 	}
 
 	strbuf_release(&buffer);
 }
 
-static int verify_merge_base(unsigned char *head_sha1, struct ref *remote)
+static int verify_merge_base(struct object_id *head_oid, struct ref *remote)
 {
-	struct commit *head = lookup_commit_or_die(head_sha1, "HEAD");
+	struct commit *head = lookup_commit_or_die(head_oid->hash, "HEAD");
 	struct commit *branch = lookup_commit_or_die(remote->old_oid.hash, remote->name);
 
 	return in_merge_bases(branch, head);
@@ -1579,7 +1579,7 @@ static int delete_remote_branch(const char *pattern, int force)
 {
 	struct ref *refs = remote_refs;
 	struct ref *remote_ref = NULL;
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 	char *symref = NULL;
 	int match;
 	int patlen = strlen(pattern);
@@ -1610,7 +1610,7 @@ static int delete_remote_branch(const char *pattern, int force)
 	 * Remote HEAD must be a symref (not exactly foolproof; a remote
 	 * symlink to a symref will look like a symref)
 	 */
-	fetch_symref("HEAD", &symref, head_sha1);
+	fetch_symref("HEAD", &symref, &head_oid);
 	if (!symref)
 		return error("Remote HEAD is not a symref");
 
@@ -1619,7 +1619,7 @@ static int delete_remote_branch(const char *pattern, int force)
 		if (!strcmp(remote_ref->name, symref))
 			return error("Remote branch %s is the current HEAD",
 				     remote_ref->name);
-		fetch_symref(symref, &symref, head_sha1);
+		fetch_symref(symref, &symref, &head_oid);
 	}
 
 	/* Run extra sanity checks if delete is not forced */
@@ -1627,10 +1627,10 @@ static int delete_remote_branch(const char *pattern, int force)
 		/* Remote HEAD must resolve to a known object */
 		if (symref)
 			return error("Remote HEAD symrefs too deep");
-		if (is_null_sha1(head_sha1))
+		if (is_null_oid(&head_oid))
 			return error("Unable to resolve remote HEAD");
-		if (!has_sha1_file(head_sha1))
-			return error("Remote HEAD resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", sha1_to_hex(head_sha1));
+		if (!has_object_file(&head_oid))
+			return error("Remote HEAD resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", oid_to_hex(&head_oid));
 
 		/* Remote branch must resolve to a known object */
 		if (is_null_oid(&remote_ref->old_oid))
@@ -1640,7 +1640,7 @@ static int delete_remote_branch(const char *pattern, int force)
 			return error("Remote branch %s resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", remote_ref->name, oid_to_hex(&remote_ref->old_oid));
 
 		/* Remote branch must be an ancestor of remote HEAD */
-		if (!verify_merge_base(head_sha1, remote_ref)) {
+		if (!verify_merge_base(&head_oid, remote_ref)) {
 			return error("The branch '%s' is not an ancestor "
 				     "of your current HEAD.\n"
 				     "If you are sure you want to delete it,"
