Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D13C5207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754882AbdEFWMj (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:12:39 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37750 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754433AbdEFWLY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0A517280CD;
        Sat,  6 May 2017 22:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108675;
        bh=gAuqBFCaRKDczK4nKXJsphk4CAUYgR38Dfche2gqQKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJiRqxEyStmY4LWom/xg9iJu3y5ihAR32yWUjkMqlutN+Fvs6eYnRtaJFCtMGoy2g
         +fjRmWh+5rUVaCpzy7Nv3witoXo1tAg9Tm62xvI3VCGy/EYFDjJ4eB5PbAfc18N42T
         /iwx5G782vM5JQ8kG2XWeFuGhY0+vgVYIYORpUlHy/d2zRAkwlVvTCHB3ZMIQztnli
         ys+RadBERXrvDY6vXMnuneRscckc0+t0Ti+GjLOMDGMqVVab/euLX3cP945Bej5cbf
         r4B7HXwD4MEECXWNCRKNZZT++58SpPOMxML5xA0DaKdiuC+w7dROkzcFws2wHzblWu
         qRkXg93b7cHIjkiQZsrqnLpR/y91WQDyi4Io+F7D0yei+SG2I9g53svxWtWYMPu02b
         iTIVRd247ZNVFj8RwAVtIhdPeOUI9/8cD//Xfs9dQgj1Q47NCTCGiU7hihXSIr+SLB
         c3WO6/bLwtux6a0t/kN/OtZhp5WTQi5GedVaQ/U59ih+BeJ9rEr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 33/53] log-tree: convert to struct object_id
Date:   Sat,  6 May 2017 22:10:18 +0000
Message-Id: <20170506221038.296722-34-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
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
 
