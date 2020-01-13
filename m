Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC87C33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4794207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KGrUjzOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAMMsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:13 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37794 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728918AbgAMMsH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:48:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 448AD607FE
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919685;
        bh=W0hC+8lkUKKicHJ2a2IySVoikYCqELub9d4mc8qVku4=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=KGrUjzOb07MnXwvdsFApYaQpo4P9C/Q3ddMQextWIMuqUyFR41C//jYUPUYmQ0Jit
         6Bm5f6PiGifq6p33DJWwRqL+kzr+PM7ZMC6/PrtpxFNp4S8+roDjZZ80YSKgD7pp1m
         5Y+z8u+LUuTiO7RapOi44Xw8Jb7I+jSbvWQrtUzSKn5foJVXR01eqKMPXZUprC9KP6
         MTT26MB9j1Dx8Ehh2efEi0nGKdPi9KzP/plQLAM/jHSdYGQypv4dcPcERCYeYduvcE
         iSI6YAjj0erz0g98RWHXmkAHz73HMrh1L1YXj87LBdH03mYPdR6I5ceV94IUOGQWpf
         TEun2vxjX1ET2AEtZs2PlJSD0/NCY9tAIECwOatxOi9sSfYFbYPRVoli45K8+CoCUX
         8uAz8dVaklqUrK7tV3635fYH3RI0ahH4TBMjsYzoSeV1LkjX0Yf7nzQK8fZquhTvg/
         vtakoxrK+Iq7+clpVskXZJUcURpXdaHfmIVbs+2Whlz/FpZhBTR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 20/22] fast-import: make find_marks work on any mark set
Date:   Mon, 13 Jan 2020 12:47:27 +0000
Message-Id: <20200113124729.3684846-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we'll use multiple different mark sets with this
function, so make it take an argument that points to the mark set to
operate on.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3ce4a04473..8aaa7f6289 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -517,10 +517,9 @@ static void insert_mark(struct mark_set *s, uintmax_t idnum, struct object_entry
 	s->data.marked[idnum] = oe;
 }
 
-static struct object_entry *find_mark(uintmax_t idnum)
+static void *find_mark(struct mark_set *s, uintmax_t idnum)
 {
 	uintmax_t orig_idnum = idnum;
-	struct mark_set *s = marks;
 	struct object_entry *oe = NULL;
 	if ((idnum >> s->shift) < 1024) {
 		while (s && s->shift) {
@@ -2225,7 +2224,7 @@ static void file_change_m(const char *p, struct branch *b)
 	}
 
 	if (*p == ':') {
-		oe = find_mark(parse_mark_ref_space(&p));
+		oe = find_mark(marks, parse_mark_ref_space(&p));
 		oidcpy(&oid, &oe->idx.oid);
 	} else if (skip_prefix(p, "inline ", &p)) {
 		inline_data = 1;
@@ -2399,7 +2398,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	/* Now parse the notemodify command. */
 	/* <dataref> or 'inline' */
 	if (*p == ':') {
-		oe = find_mark(parse_mark_ref_space(&p));
+		oe = find_mark(marks, parse_mark_ref_space(&p));
 		oidcpy(&oid, &oe->idx.oid);
 	} else if (skip_prefix(p, "inline ", &p)) {
 		inline_data = 1;
@@ -2420,7 +2419,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		oidcpy(&commit_oid, &s->oid);
 	} else if (*p == ':') {
 		uintmax_t commit_mark = parse_mark_ref_eol(p);
-		struct object_entry *commit_oe = find_mark(commit_mark);
+		struct object_entry *commit_oe = find_mark(marks, commit_mark);
 		if (commit_oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
@@ -2524,7 +2523,7 @@ static int parse_objectish(struct branch *b, const char *objectish)
 		oidcpy(&b->branch_tree.versions[1].oid, t);
 	} else if (*objectish == ':') {
 		uintmax_t idnum = parse_mark_ref_eol(objectish);
-		struct object_entry *oe = find_mark(idnum);
+		struct object_entry *oe = find_mark(marks, idnum);
 		if (oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", idnum);
 		if (!oideq(&b->oid, &oe->idx.oid)) {
@@ -2588,7 +2587,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 			oidcpy(&n->oid, &s->oid);
 		else if (*from == ':') {
 			uintmax_t idnum = parse_mark_ref_eol(from);
-			struct object_entry *oe = find_mark(idnum);
+			struct object_entry *oe = find_mark(marks, idnum);
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			oidcpy(&n->oid, &oe->idx.oid);
@@ -2762,7 +2761,7 @@ static void parse_new_tag(const char *arg)
 	} else if (*from == ':') {
 		struct object_entry *oe;
 		from_mark = parse_mark_ref_eol(from);
-		oe = find_mark(from_mark);
+		oe = find_mark(marks, from_mark);
 		type = oe->type;
 		oidcpy(&oid, &oe->idx.oid);
 	} else if (!get_oid(from, &oid)) {
@@ -2920,7 +2919,7 @@ static void parse_get_mark(const char *p)
 	if (*p != ':')
 		die("Not a mark: %s", p);
 
-	oe = find_mark(parse_mark_ref_eol(p));
+	oe = find_mark(marks, parse_mark_ref_eol(p));
 	if (!oe)
 		die("Unknown mark: %s", command_buf.buf);
 
@@ -2935,7 +2934,7 @@ static void parse_cat_blob(const char *p)
 
 	/* cat-blob SP <object> LF */
 	if (*p == ':') {
-		oe = find_mark(parse_mark_ref_eol(p));
+		oe = find_mark(marks, parse_mark_ref_eol(p));
 		if (!oe)
 			die("Unknown mark: %s", command_buf.buf);
 		oidcpy(&oid, &oe->idx.oid);
@@ -3010,7 +3009,7 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 	struct object_entry *e;
 
 	if (**p == ':') {	/* <mark> */
-		e = find_mark(parse_mark_ref_space(p));
+		e = find_mark(marks, parse_mark_ref_space(p));
 		if (!e)
 			die("Unknown mark: %s", command_buf.buf);
 		oidcpy(&oid, &e->idx.oid);
