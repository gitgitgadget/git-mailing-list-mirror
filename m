Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 064F01F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeDWXk1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60562 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932687AbeDWXkU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A8F3B60B37;
        Mon, 23 Apr 2018 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526819;
        bh=Y++OP3F89orICCnvyd/xA+jqiN9XF8qghD5VCcDKj1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xTJ/PPtW29FJe2ezSHhvCEtEXca+hv7YheOeHXI/vncelbYXxRBXrIAvtCaVpmizs
         xhbzGhki5MkC49d4oOOZY3TEB0YiD/Q5tjMJeWaNbrvRRRpWj6r0KtHiMg4ULFeeJE
         qTjYEVE6s7SbsSlz4JlfMoVMdvW++vzSKIhkJLqlP4DUusdVnlQm+PAydcH2IhTOn/
         oaYqmb8e+7oKSCg851vpaKZAwU1yq2c8NsH5PggOjKfED41pXEogIURmLiqWBnW390
         SPD9DIOdz7LhLJ6V7wLKPAfAkoxERgPmXAMTt6o1I6EincoHYjBAXggkV2xex26z0c
         +CLHzl56astkRi6J8qFX1OA54Vjm84ZNc1Fv0PRthBzOYh8ZIzchcks10/9hDZq+yC
         h1+Ib4C9I0slVrvG+MDVOWqIgexDjUXXB9zeKjPL/hpHms27PmvDUgs3Qore8PdeGL
         5tcbOQQhSfoC0U11c18EXD08pyq/bazS60N61jh65If5MvXldFR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 13/41] fsck: convert static functions to struct object_id
Date:   Mon, 23 Apr 2018 23:39:23 +0000
Message-Id: <20180423233951.276447-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert two static functions to use struct object_id and parse_oid_hex,
instead of relying on harcoded 20 and 40-based constants.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fsck.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fsck.c b/fsck.c
index 9218c2a643..768011f812 100644
--- a/fsck.c
+++ b/fsck.c
@@ -711,30 +711,31 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	unsigned long size, struct fsck_options *options)
 {
-	unsigned char tree_sha1[20], sha1[20];
+	struct object_id tree_oid, oid;
 	struct commit_graft *graft;
 	unsigned parent_count, parent_line_count = 0, author_count;
 	int err;
 	const char *buffer_begin = buffer;
+	const char *p;
 
 	if (verify_headers(buffer, size, &commit->object, options))
 		return -1;
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
 		return report(options, &commit->object, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n') {
+	if (parse_oid_hex(buffer, &tree_oid, &p) || *p != '\n') {
 		err = report(options, &commit->object, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
 		if (err)
 			return err;
 	}
-	buffer += 41;
+	buffer = p + 1;
 	while (skip_prefix(buffer, "parent ", &buffer)) {
-		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n') {
+		if (parse_oid_hex(buffer, &oid, &p) || *p != '\n') {
 			err = report(options, &commit->object, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 			if (err)
 				return err;
 		}
-		buffer += 41;
+		buffer = p + 1;
 		parent_line_count++;
 	}
 	graft = lookup_commit_graft(&commit->object.oid);
@@ -773,7 +774,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	if (err)
 		return err;
 	if (!commit->tree) {
-		err = report(options, &commit->object, FSCK_MSG_BAD_TREE, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
+		err = report(options, &commit->object, FSCK_MSG_BAD_TREE, "could not load commit's tree %s", oid_to_hex(&tree_oid));
 		if (err)
 			return err;
 	}
@@ -799,11 +800,12 @@ static int fsck_commit(struct commit *commit, const char *data,
 static int fsck_tag_buffer(struct tag *tag, const char *data,
 	unsigned long size, struct fsck_options *options)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	int ret = 0;
 	const char *buffer;
 	char *to_free = NULL, *eol;
 	struct strbuf sb = STRBUF_INIT;
+	const char *p;
 
 	if (data)
 		buffer = data;
@@ -834,12 +836,12 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		ret = report(options, &tag->object, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
 		goto done;
 	}
-	if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n') {
+	if (parse_oid_hex(buffer, &oid, &p) || *p != '\n') {
 		ret = report(options, &tag->object, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
 		if (ret)
 			goto done;
 	}
-	buffer += 41;
+	buffer = p + 1;
 
 	if (!skip_prefix(buffer, "type ", &buffer)) {
 		ret = report(options, &tag->object, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
