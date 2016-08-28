Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F611F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbcH1X2K (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:10 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40984 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756139AbcH1X2C (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DA820280A9;
        Sun, 28 Aug 2016 23:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426881;
        bh=r9rsPUkphy/Y0NDGgQzWUVzpkNl75Av5kuU7uW+RsoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXo2LY3KKuRPIsJHUEEtDx5BqqokDYKKxF+PrO6cEJBX2hZsoTKuazZKnSzILEh4h
         I3qhR+bC5/LgQjPP94UY2akFl8sjriq3f1zd9rhkaloyI8bn7N1V/fXYmOHxVaTb1X
         O4iuKt5z48/u42V/i+aYXfU84jYP57lQNq+F/Omt4CCIcaE8xd0ISeApx2jhohy02y
         Jp9M715WpuT107f3tWdFcVZloC7FO5Rx/Vjis2rkNY/H30rgliBQxOPP3NulCvcwcT
         KWS1dtlBBIg+8+L94HkflptJKw8ugLNtI6rZEQhPKQuDhpqa9y/uAouKH1zCkd9TG/
         duaHm44cLEiNPqNnx5/Bd9UC4/1gYquseJPYmoPMxdWlnIooBCQs0U2M621ALnwdl+
         nGx4Q9L8vvrF2BZ4eD1rHnPCtQjw1+YUXR670xI2qW0aGZulQyP2gjt00lBnaidsLl
         tTv2ZsMG3wvwSqBygB2coIy1vRqUnAWRfQ4ykCqeryO83d9GbA6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 03/20] builtin/blame: convert struct origin to use struct object_id
Date:   Sun, 28 Aug 2016 23:27:40 +0000
Message-Id: <20160828232757.373278-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct origin to use struct object_id by applying the
following semantic patch and the object_id transforms from contrib:

@@
struct origin E1;
@@
- E1.blob_sha1
+ E1.blob_oid.hash

@@
struct origin *E1;
@@
- E1->blob_sha1
+ E1->blob_oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 06b2c743..3852d189 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -120,7 +120,7 @@ struct origin {
 	 */
 	struct blame_entry *suspects;
 	mmfile_t file;
-	unsigned char blob_sha1[20];
+	struct object_id blob_oid;
 	unsigned mode;
 	/* guilty gets set when shipping any suspects to the final
 	 * blame list instead of other commits
@@ -188,15 +188,16 @@ static void fill_origin_blob(struct diff_options *opt,
 
 		num_read_blob++;
 		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-		    textconv_object(o->path, o->mode, o->blob_sha1, 1, &file->ptr, &file_size))
+		    textconv_object(o->path, o->mode, o->blob_oid.hash, 1, &file->ptr, &file_size))
 			;
 		else
-			file->ptr = read_sha1_file(o->blob_sha1, &type, &file_size);
+			file->ptr = read_sha1_file(o->blob_oid.hash, &type,
+						   &file_size);
 		file->size = file_size;
 
 		if (!file->ptr)
 			die("Cannot read blob %s for path %s",
-			    sha1_to_hex(o->blob_sha1),
+			    oid_to_hex(&o->blob_oid),
 			    o->path);
 		o->file = *file;
 	}
@@ -508,17 +509,17 @@ static struct origin *get_origin(struct scoreboard *sb,
  */
 static int fill_blob_sha1_and_mode(struct origin *origin)
 {
-	if (!is_null_sha1(origin->blob_sha1))
+	if (!is_null_oid(&origin->blob_oid))
 		return 0;
 	if (get_tree_entry(origin->commit->object.oid.hash,
 			   origin->path,
-			   origin->blob_sha1, &origin->mode))
+			   origin->blob_oid.hash, &origin->mode))
 		goto error_out;
-	if (sha1_object_info(origin->blob_sha1, NULL) != OBJ_BLOB)
+	if (sha1_object_info(origin->blob_oid.hash, NULL) != OBJ_BLOB)
 		goto error_out;
 	return 0;
  error_out:
-	hashclr(origin->blob_sha1);
+	oidclr(&origin->blob_oid);
 	origin->mode = S_IFINVALID;
 	return -1;
 }
@@ -572,7 +573,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 	if (!diff_queued_diff.nr) {
 		/* The path is the same as parent */
 		porigin = get_origin(sb, parent, origin->path);
-		hashcpy(porigin->blob_sha1, origin->blob_sha1);
+		oidcpy(&porigin->blob_oid, &origin->blob_oid);
 		porigin->mode = origin->mode;
 	} else {
 		/*
@@ -598,7 +599,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 			    p->status);
 		case 'M':
 			porigin = get_origin(sb, parent, origin->path);
-			hashcpy(porigin->blob_sha1, p->one->oid.hash);
+			oidcpy(&porigin->blob_oid, &p->one->oid);
 			porigin->mode = p->one->mode;
 			break;
 		case 'A':
@@ -644,7 +645,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 		if ((p->status == 'R' || p->status == 'C') &&
 		    !strcmp(p->two->path, origin->path)) {
 			porigin = get_origin(sb, parent, p->one->path);
-			hashcpy(porigin->blob_sha1, p->one->oid.hash);
+			oidcpy(&porigin->blob_oid, &p->one->oid);
 			porigin->mode = p->one->mode;
 			break;
 		}
@@ -1308,7 +1309,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 				continue;
 
 			norigin = get_origin(sb, parent, p->one->path);
-			hashcpy(norigin->blob_sha1, p->one->oid.hash);
+			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
 			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p);
 			if (!file_p.ptr)
@@ -1458,15 +1459,14 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 			porigin = find(sb, p, origin);
 			if (!porigin)
 				continue;
-			if (!hashcmp(porigin->blob_sha1, origin->blob_sha1)) {
+			if (!oidcmp(&porigin->blob_oid, &origin->blob_oid)) {
 				pass_whole_blame(sb, origin, porigin);
 				origin_decref(porigin);
 				goto finish;
 			}
 			for (j = same = 0; j < i; j++)
 				if (sg_origin[j] &&
-				    !hashcmp(sg_origin[j]->blob_sha1,
-					     porigin->blob_sha1)) {
+				    !oidcmp(&sg_origin[j]->blob_oid, &porigin->blob_oid)) {
 					same = 1;
 					break;
 				}
@@ -2387,7 +2387,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	convert_to_git(path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
-	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
+	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
 
 	/*
 	 * Read the current index, replace the path entry with
@@ -2409,7 +2409,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	}
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
-	hashcpy(ce->oid.hash, origin->blob_sha1);
+	oidcpy(&ce->oid, &origin->blob_oid);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = len;
@@ -2792,16 +2792,16 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			die("no such path %s in %s", path, final_commit_name);
 
 		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
-		    textconv_object(path, o->mode, o->blob_sha1, 1, (char **) &sb.final_buf,
+		    textconv_object(path, o->mode, o->blob_oid.hash, 1, (char **) &sb.final_buf,
 				    &sb.final_buf_size))
 			;
 		else
-			sb.final_buf = read_sha1_file(o->blob_sha1, &type,
+			sb.final_buf = read_sha1_file(o->blob_oid.hash, &type,
 						      &sb.final_buf_size);
 
 		if (!sb.final_buf)
 			die("Cannot read blob %s for path %s",
-			    sha1_to_hex(o->blob_sha1),
+			    oid_to_hex(&o->blob_oid),
 			    path);
 	}
 	num_read_blob++;
