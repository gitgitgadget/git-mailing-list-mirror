Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8741F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBLBXa (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:30 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34244 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726986AbfBLBXZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:25 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9035260898;
        Tue, 12 Feb 2019 01:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934603;
        bh=HYNOlAF8X1nzhpR01uWWaxlZjtcyodmx+NvLuLfpqpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=a1qe3TH3DS01tKQM9kksZFKWnBgBIRx4zZa2UUjfWAoC9dAA1js1JOLfYPW4L9nbP
         OTwSFiJyTHXJD+7oSVc74HnE+qViwFP+G0sIxhJyB5G20Jrz7Zr317qZbw92PrYQRg
         NTrYV4p2AwQH/pqh2XfdyFkoQ4exROADKYvTjtV4sC3z/B7br+kaOHwow05dJHcEgv
         T87XsnVzCMxxk4xFHKzmUOY5GSD2lGTqgYzZtYqC09Ff4cYYfJY3oD2Uw227KGevJJ
         RuQICdOfPQaMnC/IZGaT46CnKaYZf9aTXNlT++V2W47GdavEjQRwtCDk3VZJGMO29D
         /FBNGuLla+5jqA+n/Nwcu3CrIXdyL4rYAjSuhDM8LabLujTmLT4CkaGfhCyYI9cMzW
         1AIW4Ovo4JQCb/5wAZY9wS44so9yGunAiE8kPs5hj1Sb6vAwtz91t9ibFDjjlVaY09
         RDmoNxbllhUs18OMwQMUSmSAHXH3Lis92c0E6qKc0bk/UnfydeY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 10/31] object-store: rename and expand packed_git's sha1 member
Date:   Tue, 12 Feb 2019 01:22:35 +0000
Message-Id: <20190212012256.1005924-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This member is used to represent the pack checksum of the pack in
question.  Expand this member to be GIT_MAX_RAWSZ bytes in length so it
works with longer hashes and rename it to be "hash" instead of "sha1".
This transformation was made with a change to the definition and the
following semantic patch:

@@
struct packed_git *E1;
@@
- E1->sha1
+ E1->hash

@@
struct packed_git E1;
@@
- E1.sha1
+ E1.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-redundant.c |  2 +-
 fast-import.c            | 17 +++++++++--------
 http-push.c              |  3 ++-
 http-walker.c            |  2 +-
 http.c                   | 13 +++++++------
 object-store.h           |  2 +-
 packfile.c               |  6 +++---
 7 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 11bc514566..d9af7f5414 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -689,7 +689,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 	pl = red = pack_list_difference(local_packs, min);
 	while (pl) {
 		printf("%s\n%s\n",
-		       sha1_pack_index_name(pl->pack->sha1),
+		       sha1_pack_index_name(pl->pack->hash),
 		       pl->pack->pack_name);
 		pl = pl->next;
 	}
diff --git a/fast-import.c b/fast-import.c
index b7ba755c2b..7c9a10a77b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -742,7 +742,8 @@ static const char *create_index(void)
 	if (c != last)
 		die("internal consistency error creating the index");
 
-	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts, pack_data->sha1);
+	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts,
+				 pack_data->hash);
 	free(idx);
 	return tmpfile;
 }
@@ -753,7 +754,7 @@ static char *keep_pack(const char *curr_index_name)
 	struct strbuf name = STRBUF_INIT;
 	int keep_fd;
 
-	odb_pack_name(&name, pack_data->sha1, "keep");
+	odb_pack_name(&name, pack_data->hash, "keep");
 	keep_fd = odb_pack_keep(name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
@@ -761,11 +762,11 @@ static char *keep_pack(const char *curr_index_name)
 	if (close(keep_fd))
 		die_errno("failed to write keep file");
 
-	odb_pack_name(&name, pack_data->sha1, "pack");
+	odb_pack_name(&name, pack_data->hash, "pack");
 	if (finalize_object_file(pack_data->pack_name, name.buf))
 		die("cannot store pack file");
 
-	odb_pack_name(&name, pack_data->sha1, "idx");
+	odb_pack_name(&name, pack_data->hash, "idx");
 	if (finalize_object_file(curr_index_name, name.buf))
 		die("cannot store index file");
 	free((void *)curr_index_name);
@@ -779,7 +780,7 @@ static void unkeep_all_packs(void)
 
 	for (k = 0; k < pack_id; k++) {
 		struct packed_git *p = all_packs[k];
-		odb_pack_name(&name, p->sha1, "keep");
+		odb_pack_name(&name, p->hash, "keep");
 		unlink_or_warn(name.buf);
 	}
 	strbuf_release(&name);
@@ -821,9 +822,9 @@ static void end_packfile(void)
 
 		close_pack_windows(pack_data);
 		finalize_hashfile(pack_file, cur_pack_oid.hash, 0);
-		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
-				    pack_data->pack_name, object_count,
-				    cur_pack_oid.hash, pack_size);
+		fixup_pack_header_footer(pack_data->pack_fd, pack_data->hash,
+					 pack_data->pack_name, object_count,
+					 cur_pack_oid.hash, pack_size);
 
 		if (object_count <= unpack_limit) {
 			if (!loosen_small_pack(pack_data)) {
diff --git a/http-push.c b/http-push.c
index b22c7caea0..b313ada515 100644
--- a/http-push.c
+++ b/http-push.c
@@ -315,7 +315,8 @@ static void start_fetch_packed(struct transfer_request *request)
 		return;
 	}
 
-	fprintf(stderr,	"Fetching pack %s\n", sha1_to_hex(target->sha1));
+	fprintf(stderr,	"Fetching pack %s\n",
+		sha1_to_hex(target->hash));
 	fprintf(stderr, " which contains %s\n", oid_to_hex(&request->obj->oid));
 
 	preq = new_http_pack_request(target, repo->url);
diff --git a/http-walker.c b/http-walker.c
index 8ae5d76c6a..8063896cf6 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -434,7 +434,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 
 	if (walker->get_verbosely) {
 		fprintf(stderr, "Getting pack %s\n",
-			sha1_to_hex(target->sha1));
+			sha1_to_hex(target->hash));
 		fprintf(stderr, " which contains %s\n",
 			sha1_to_hex(sha1));
 	}
diff --git a/http.c b/http.c
index a32ad36ddf..a09adc518f 100644
--- a/http.c
+++ b/http.c
@@ -2236,10 +2236,10 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		return -1;
 	}
 
-	unlink(sha1_pack_index_name(p->sha1));
+	unlink(sha1_pack_index_name(p->hash));
 
-	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->sha1))
-	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
+	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->hash))
+	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->hash))) {
 		free(tmp_idx);
 		return -1;
 	}
@@ -2262,10 +2262,10 @@ struct http_pack_request *new_http_pack_request(
 
 	end_url_with_slash(&buf, base_url);
 	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
-		sha1_to_hex(target->sha1));
+		sha1_to_hex(target->hash));
 	preq->url = strbuf_detach(&buf, NULL);
 
-	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(target->sha1));
+	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(target->hash));
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
 		error("Unable to open local file %s for pack",
@@ -2289,7 +2289,8 @@ struct http_pack_request *new_http_pack_request(
 		if (http_is_verbose)
 			fprintf(stderr,
 				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
-				sha1_to_hex(target->sha1), (uintmax_t)prev_posn);
+				sha1_to_hex(target->hash),
+				(uintmax_t)prev_posn);
 		http_opt_request_remainder(preq->slot->curl, prev_posn);
 	}
 
diff --git a/object-store.h b/object-store.h
index 14fc935bd1..56f8aea1cc 100644
--- a/object-store.h
+++ b/object-store.h
@@ -77,7 +77,7 @@ struct packed_git {
 		 freshened:1,
 		 do_not_close:1,
 		 pack_promisor:1;
-	unsigned char sha1[20];
+	unsigned char hash[GIT_MAX_RAWSZ];
 	struct revindex_entry *revindex;
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
diff --git a/packfile.c b/packfile.c
index 16bcb75262..e6e8861650 100644
--- a/packfile.c
+++ b/packfile.c
@@ -235,7 +235,7 @@ struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 	struct packed_git *p = alloc_packed_git(alloc);
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
-	hashcpy(p->sha1, sha1);
+	hashcpy(p->hash, sha1);
 	if (check_packed_git_idx(idx_path, p)) {
 		free(p);
 		return NULL;
@@ -722,8 +722,8 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
 	if (path_len < the_hash_algo->hexsz ||
-	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->sha1))
-		hashclr(p->sha1);
+	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
+		hashclr(p->hash);
 	return p;
 }
 
