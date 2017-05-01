Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D781F829
	for <e@80x24.org>; Mon,  1 May 2017 02:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642349AbdEACcM (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:12 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36066 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999460AbdEACa4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 83B77280D1;
        Mon,  1 May 2017 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605812;
        bh=gAuqBFCaRKDczK4nKXJsphk4CAUYgR38Dfche2gqQKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqzbRonk62K/wieupIQRuu5P6zdIwjKwjKeiXvusKfB95YhhmkcDNFmEbg1BKPLf+
         +4tb/srkCyvtGYmZS/cXtIBvdP0ZDPSwzvq6LlmdAZ2Wny2sgq6YI+4F+GRHQvllu4
         yeW0veel1Z+f+jwn7R1vCUgDwO+MbdWi7T9YzhT9j7jJ1Orep4rlsTn8KUkl2Gfz/E
         PwJyZi+v7LiTLgngOjgahbctPsiPvTjiMAQHKZC25qsCYaMiPzxYE8XLKYjD3JlSyv
         L30h9Ld7HKkNdyLYM1J2DsQOzMTWtZGyN7keXaALhbh3yccutlSClOg5QQ6H6diVnw
         qEtAnrHeR/Iki7Ft8N+dL8ljHGtD3Anh6ZO2lptpjYA/9PAI6zLzeAxz1FrgQKiRuO
         XEnmHV4dlWvTdIW9KrvqJR7sRtsJsqnrudT4MDZQHPfevjpr/pS4aspNO8tDXDWzXB
         AZ3qpy06lPryrMH2A/Yu0urTNY33yuP1xoyoinvZxzM9Z78wFXt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 33/53] log-tree: convert to struct object_id
Date:   Mon,  1 May 2017 02:29:26 +0000
Message-Id: <20170501022946.258735-34-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining functions to take pointers to struct object_id
instead of pointers to unsigned char, and update the internals of these
functions as well.  Among these functions is a caller of lookup_tag,
which we will convert shortly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 log-tree.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7fb1a85d2..169fd039f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -184,7 +184,7 @@ static const struct name_decoration *current_pointed_by_HEAD(const struct name_d
 {
 	const struct name_decoration *list, *head = NULL;
 	const char *branch_name = NULL;
-	unsigned char unused[20];
+	struct object_id unused;
 	int rru_flags;
 
 	/* First find HEAD */
@@ -197,7 +197,7 @@ static const struct name_decoration *current_pointed_by_HEAD(const struct name_d
 		return NULL;
 
 	/* Now resolve and find the matching current branch */
-	branch_name = resolve_ref_unsafe("HEAD", 0, unused, &rru_flags);
+	branch_name = resolve_ref_unsafe("HEAD", 0, unused.hash, &rru_flags);
 	if (!(rru_flags & REF_ISSYMREF))
 		return NULL;
 
@@ -456,13 +456,13 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	strbuf_release(&signature);
 }
 
-static int which_parent(const unsigned char *sha1, const struct commit *commit)
+static int which_parent(const struct object_id *oid, const struct commit *commit)
 {
 	int nth;
 	const struct commit_list *parent;
 
 	for (nth = 0, parent = commit->parents; parent; parent = parent->next) {
-		if (!hashcmp(parent->item->object.oid.hash, sha1))
+		if (!oidcmp(&parent->item->object.oid, oid))
 			return nth;
 		nth++;
 	}
@@ -481,14 +481,14 @@ static void show_one_mergetag(struct commit *commit,
 			      void *data)
 {
 	struct rev_info *opt = (struct rev_info *)data;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct tag *tag;
 	struct strbuf verify_message;
 	int status, nth;
 	size_t payload_size, gpg_message_offset;
 
-	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), sha1);
-	tag = lookup_tag(sha1);
+	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), oid.hash);
+	tag = lookup_tag(oid.hash);
 	if (!tag)
 		return; /* error message already given */
 
@@ -500,7 +500,7 @@ static void show_one_mergetag(struct commit *commit,
 			  &commit->parents->next->item->object.oid))
 		strbuf_addf(&verify_message,
 			    "merged tag '%s'\n", tag->tag);
-	else if ((nth = which_parent(tag->tagged->oid.hash, commit)) < 0)
+	else if ((nth = which_parent(&tag->tagged->oid, commit)) < 0)
 		strbuf_addf(&verify_message, "tag %s names a non-parent %s\n",
 				    tag->tag, tag->tagged->oid.hash);
 	else
@@ -536,7 +536,7 @@ void show_log(struct rev_info *opt)
 	struct strbuf msgbuf = STRBUF_INIT;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
-	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
+	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : GIT_SHA1_HEXSZ;
 	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
 
