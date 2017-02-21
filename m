Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364F3201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbdBUXsE (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:48:04 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39926 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753517AbdBUXsB (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Feb 2017 18:48:01 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E8802280BF;
        Tue, 21 Feb 2017 23:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487720866;
        bh=5jj4CKZto4kN7x4tIM92UdyOELib38nihb+opUMfge4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a03zjjDxeOaROU3TbMLylG8Rdb/OJ/2APl1i/aHOHmwKqZfotc4oEXumihxHTaXRR
         DDac+wlUDpW+9Ah0ThIbmca7PxysrA/+wb2VFjuSAc1w9ng3fevir5jSFmCx4yI7lS
         M9mkj0hchKhgxZmX8O2A7x1TG7dB6RNJ/MPR4eVvDXEWjIVeWWx9Wk4+6BHTqsQklf
         3/vUIvzcgAL0hf9h6EYCQGo9Ye0HyUvp8Z07N2k6y1MkfsuZHbq8v/4/0+wiNSctPB
         nBm9xdc511m3sk0FiBCzbzmrUuyA+iaxfz3TAyC+ysHC6as6f+FnOOVmzsxrbfUiJd
         2yHdg56QCDeDBw4n+cwklC84z+MmfEvoPh+7GwCIIhGblEGvffa4TgvzV7vhUp5Z1J
         wH6hIT+2Xl7EtzWopDTyTc3vvhzDuFXb145N91mE8xE+HKaEuXxOxd69wdLGQ8M2+a
         TsvLmv4K4/c3N0gyc/NVouoR3TOrBUSQsFMc+YGrsz3hmdycErY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 18/19] builtin/merge-base: convert to struct object_id
Date:   Tue, 21 Feb 2017 23:47:36 +0000
Message-Id: <20170221234737.894681-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170221234737.894681-1-sandals@crustytoothpaste.net>
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
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

