Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60176201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 00:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbdBRAHQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 19:07:16 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:60056 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751411AbdBRAHF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 19:07:05 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 29191280BD;
        Sat, 18 Feb 2017 00:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487376423;
        bh=5jj4CKZto4kN7x4tIM92UdyOELib38nihb+opUMfge4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwqsFK6QIRnhXpgidzUv33xiNP4CU+LCmIWdPRSdrr+J+j/1SRBNRju5qnGyPk7zm
         v5DtlN65WLL6JVTGb+nlXaXRRwKlm5NPLiwgfb7h2cY0Ng/P0TgK12qV9SzWftiHL7
         1J1qzGJfvfd1kl0RZV5ahQ6ZE3V1zvoHiJvm+TbeMAB4yRLPUexdQtyMiAn6Uw4KRY
         3q9x231hVbjxSHTiRD2Q2YfPMt/OElOhIYag1o2FrAewQb3XEXu9fXLv3G6Pz73xsQ
         zp4oUZre+/duh+UH5jECFAZXxkni3DdK8ZLOu5Xk+FVCxmKGDI1DPADK8ErU2eCU0v
         ULRH99wauxJkBtOSQ/rtGabv2BnYJol1l+EtZ4G1vKbrP5oDDKpuLAObSXMW/bhZbf
         MUibmzIlCmb8UanIGH0jxAZuB7aPOWAwbnFGmDgGHWjxVTTXs6Q+B9LVC0R3OqHxFE
         P0jFlWJc6QoRXryBNdreQDLCP4pga++p5otD969yl+LWJzhPSkq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 18/19] builtin/merge-base: convert to struct object_id
Date:   Sat, 18 Feb 2017 00:06:51 +0000
Message-Id: <20170218000652.375129-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170218000652.375129-1-sandals@crustytoothpaste.net>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining uses of unsigned char [20] to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge-base.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index db95bc29cf..cfe2a796f8 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -36,12 +36,12 @@ static const char * const merge_base_usage[] = {
 
 static struct commit *get_commit_reference(const char *arg)
 {
-	unsigned char revkey[20];
+	struct object_id revkey;
 	struct commit *r;
 
-	if (get_sha1(arg, revkey))
+	if (get_oid(arg, &revkey))
 		die("Not a valid object name %s", arg);
-	r = lookup_commit_reference(revkey);
+	r = lookup_commit_reference(revkey.hash);
 	if (!r)
 		die("Not a valid commit name %s", arg);
 
@@ -113,14 +113,14 @@ struct rev_collect {
 	unsigned int initial : 1;
 };
 
-static void add_one_commit(unsigned char *sha1, struct rev_collect *revs)
+static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 {
 	struct commit *commit;
 
-	if (is_null_sha1(sha1))
+	if (is_null_oid(oid))
 		return;
 
-	commit = lookup_commit(sha1);
+	commit = lookup_commit(oid->hash);
 	if (!commit ||
 	    (commit->object.flags & TMP_MARK) ||
 	    parse_commit(commit))
@@ -139,15 +139,15 @@ static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid
 
 	if (revs->initial) {
 		revs->initial = 0;
-		add_one_commit(ooid->hash, revs);
+		add_one_commit(ooid, revs);
 	}
-	add_one_commit(noid->hash, revs);
+	add_one_commit(noid, revs);
 	return 0;
 }
 
 static int handle_fork_point(int argc, const char **argv)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *refname;
 	const char *commitname;
 	struct rev_collect revs;
@@ -155,7 +155,7 @@ static int handle_fork_point(int argc, const char **argv)
 	struct commit_list *bases;
 	int i, ret = 0;
 
-	switch (dwim_ref(argv[0], strlen(argv[0]), sha1, &refname)) {
+	switch (dwim_ref(argv[0], strlen(argv[0]), oid.hash, &refname)) {
 	case 0:
 		die("No such ref: '%s'", argv[0]);
 	case 1:
@@ -165,16 +165,16 @@ static int handle_fork_point(int argc, const char **argv)
 	}
 
 	commitname = (argc == 2) ? argv[1] : "HEAD";
-	if (get_sha1(commitname, sha1))
+	if (get_oid(commitname, &oid))
 		die("Not a valid object name: '%s'", commitname);
 
-	derived = lookup_commit_reference(sha1);
+	derived = lookup_commit_reference(oid.hash);
 	memset(&revs, 0, sizeof(revs));
 	revs.initial = 1;
 	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
 
-	if (!revs.nr && !get_sha1(refname, sha1))
-		add_one_commit(sha1, &revs);
+	if (!revs.nr && !get_oid(refname, &oid))
+		add_one_commit(&oid, &revs);
 
 	for (i = 0; i < revs.nr; i++)
 		revs.commit[i]->object.flags &= ~TMP_MARK;
-- 
2.11.0

