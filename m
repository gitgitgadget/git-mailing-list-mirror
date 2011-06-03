From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] verify-pack: use index-pack --verify
Date: Fri,  3 Jun 2011 15:32:17 -0700
Message-ID: <1307140337-27676-5-git-send-email-gitster@pobox.com>
References: <1307140337-27676-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 00:32:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QScvB-0005VB-98
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 00:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538Ab1FCWcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 18:32:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab1FCWca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 18:32:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9ED4956F2
	for <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gdbw
	84j+eDEeiW8bN4vg6fNN1aU=; b=qkPy6HoD+vDi5HRUl/Mye2gSArS8j2VBkryd
	93s2wfwsVIPDnWkBZ1cnoIa+XkasSYeG0j9ctmGIBfhpWGM13cpiDyWdda7o2DsP
	SUr9KwNuYJmcht91fOy7Y0IkECOf/KYsfT9PQcKhz54s18fmv6EQMO6jsQwYIus7
	DFPcviU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LR/HFY
	1RKYBi2CCKBS5q7VNVgzH7E4qeSqARqLQwkl8CSQrsh4EkPN203cebPb5SS8/yfG
	hjTgyjwjSFgNqijb+Ult5//LrYljqVPoWBsKms5wZOGo5yH9d5DkOKhuI9phZoBB
	oH57WsONv2bn/CSAtHgZE5Br54jb5Pt+bsn7g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C1AB56F1
	for <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A928256F0 for
 <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc0.106.g68174
In-Reply-To: <1307140337-27676-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AB0D669E-8E31-11E0-BD2E-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175036>

This finally gets rid of the inefficient verify-pack implementation that
walks objects in the packfile in their object name order and replaces it
with a call to index-pack --verify. As a side effect, it also removes
packed_object_info_detail() API which is rather expensive.

As this changes the way errors are reported (verify-pack used to rely on
the usual runtime error detection routine unpack_entry() to diagnose the
CRC errors in an entry in the *.idx file; index-pack --verify checks the
whole *.idx file in one go), update a test that expected the string "CRC"
to appear in the error message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/verify-pack.c |  132 +++++++++---------------------------------------
 cache.h               |    1 -
 sha1_file.c           |   55 --------------------
 t/t5302-pack-index.sh |    5 +-
 4 files changed, 27 insertions(+), 166 deletions(-)

diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index b6079ae..e841b4a 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -1,134 +1,53 @@
 #include "builtin.h"
 #include "cache.h"
-#include "pack.h"
-#include "pack-revindex.h"
+#include "run-command.h"
 #include "parse-options.h"
 
-#define MAX_CHAIN 50
-
 #define VERIFY_PACK_VERBOSE 01
 #define VERIFY_PACK_STAT_ONLY 02
 
-static void show_pack_info(struct packed_git *p, unsigned int flags)
-{
-	uint32_t nr_objects, i;
-	int cnt;
-	int stat_only = flags & VERIFY_PACK_STAT_ONLY;
-	unsigned long chain_histogram[MAX_CHAIN+1], baseobjects;
-
-	nr_objects = p->num_objects;
-	memset(chain_histogram, 0, sizeof(chain_histogram));
-	baseobjects = 0;
-
-	for (i = 0; i < nr_objects; i++) {
-		const unsigned char *sha1;
-		unsigned char base_sha1[20];
-		const char *type;
-		unsigned long size;
-		unsigned long store_size;
-		off_t offset;
-		unsigned int delta_chain_length;
-
-		sha1 = nth_packed_object_sha1(p, i);
-		if (!sha1)
-			die("internal error pack-check nth-packed-object");
-		offset = nth_packed_object_offset(p, i);
-		type = packed_object_info_detail(p, offset, &size, &store_size,
-						 &delta_chain_length,
-						 base_sha1);
-		if (!stat_only)
-			printf("%s ", sha1_to_hex(sha1));
-		if (!delta_chain_length) {
-			if (!stat_only)
-				printf("%-6s %lu %lu %"PRIuMAX"\n",
-				       type, size, store_size, (uintmax_t)offset);
-			baseobjects++;
-		}
-		else {
-			if (!stat_only)
-				printf("%-6s %lu %lu %"PRIuMAX" %u %s\n",
-				       type, size, store_size, (uintmax_t)offset,
-				       delta_chain_length, sha1_to_hex(base_sha1));
-			if (delta_chain_length <= MAX_CHAIN)
-				chain_histogram[delta_chain_length]++;
-			else
-				chain_histogram[0]++;
-		}
-	}
-
-	if (baseobjects)
-		printf("non delta: %lu object%s\n",
-		       baseobjects, baseobjects > 1 ? "s" : "");
-
-	for (cnt = 1; cnt <= MAX_CHAIN; cnt++) {
-		if (!chain_histogram[cnt])
-			continue;
-		printf("chain length = %d: %lu object%s\n", cnt,
-		       chain_histogram[cnt],
-		       chain_histogram[cnt] > 1 ? "s" : "");
-	}
-	if (chain_histogram[0])
-		printf("chain length > %d: %lu object%s\n", MAX_CHAIN,
-		       chain_histogram[0],
-		       chain_histogram[0] > 1 ? "s" : "");
-}
-
 static int verify_one_pack(const char *path, unsigned int flags)
 {
-	char arg[PATH_MAX];
-	int len;
+	struct child_process index_pack;
+	const char *argv[] = {"index-pack", NULL, NULL, NULL };
+	struct strbuf arg = STRBUF_INIT;
 	int verbose = flags & VERIFY_PACK_VERBOSE;
 	int stat_only = flags & VERIFY_PACK_STAT_ONLY;
-	struct packed_git *pack;
 	int err;
 
-	len = strlcpy(arg, path, PATH_MAX);
-	if (len >= PATH_MAX)
-		return error("name too long: %s", path);
-
-	/*
-	 * In addition to "foo.idx" we accept "foo.pack" and "foo";
-	 * normalize these forms to "foo.idx" for add_packed_git().
-	 */
-	if (has_extension(arg, ".pack")) {
-		strcpy(arg + len - 5, ".idx");
-		len--;
-	} else if (!has_extension(arg, ".idx")) {
-		if (len + 4 >= PATH_MAX)
-			return error("name too long: %s.idx", arg);
-		strcpy(arg + len, ".idx");
-		len += 4;
-	}
+	if (stat_only)
+		argv[1] = "--verify-stat-only";
+	else if (verbose)
+		argv[1] = "--verify-stat";
+	else
+		argv[1] = "--verify";
 
 	/*
-	 * add_packed_git() uses our buffer (containing "foo.idx") to
-	 * build the pack filename ("foo.pack").  Make sure it fits.
+	 * In addition to "foo.pack" we accept "foo.idx" and "foo";
+	 * normalize these forms to "foo.pack" for "index-pack --verify".
 	 */
-	if (len + 1 >= PATH_MAX) {
-		arg[len - 4] = '\0';
-		return error("name too long: %s.pack", arg);
-	}
-
-	pack = add_packed_git(arg, len, 1);
-	if (!pack)
-		return error("packfile %s not found.", arg);
+	strbuf_addstr(&arg, path);
+	if (has_extension(arg.buf, ".idx"))
+		strbuf_splice(&arg, arg.len - 3, 3, "pack", 4);
+	else if (!has_extension(arg.buf, ".pack"))
+		strbuf_add(&arg, ".pack", 5);
+	argv[2] = arg.buf;
 
-	install_packed_git(pack);
+	memset(&index_pack, 0, sizeof(index_pack));
+	index_pack.argv = argv;
+	index_pack.git_cmd = 1;
 
-	if (!stat_only)
-		err = verify_pack(pack);
-	else
-		err = open_pack_index(pack);
+	err = run_command(&index_pack);
 
 	if (verbose || stat_only) {
 		if (err)
-			printf("%s: bad\n", pack->pack_name);
+			printf("%s: bad\n", arg.buf);
 		else {
-			show_pack_info(pack, flags);
 			if (!stat_only)
-				printf("%s: ok\n", pack->pack_name);
+				printf("%s: ok\n", arg.buf);
 		}
 	}
+	strbuf_release(&arg);
 
 	return err;
 }
@@ -159,7 +78,6 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < argc; i++) {
 		if (verify_one_pack(argv[i], flags))
 			err = 1;
-		discard_revindex();
 	}
 
 	return err;
diff --git a/cache.h b/cache.h
index 08a9022..edea69e 100644
--- a/cache.h
+++ b/cache.h
@@ -991,7 +991,6 @@ extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/sha1_file.c b/sha1_file.c
index d949b35..ca87e3d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1496,61 +1496,6 @@ static int unpack_object_header(struct packed_git *p,
 	return type;
 }
 
-const char *packed_object_info_detail(struct packed_git *p,
-				      off_t obj_offset,
-				      unsigned long *size,
-				      unsigned long *store_size,
-				      unsigned int *delta_chain_length,
-				      unsigned char *base_sha1)
-{
-	struct pack_window *w_curs = NULL;
-	off_t curpos;
-	unsigned long dummy;
-	unsigned char *next_sha1;
-	enum object_type type;
-	struct revindex_entry *revidx;
-
-	*delta_chain_length = 0;
-	curpos = obj_offset;
-	type = unpack_object_header(p, &w_curs, &curpos, size);
-
-	revidx = find_pack_revindex(p, obj_offset);
-	*store_size = revidx[1].offset - obj_offset;
-
-	for (;;) {
-		switch (type) {
-		default:
-			die("pack %s contains unknown object type %d",
-			    p->pack_name, type);
-		case OBJ_COMMIT:
-		case OBJ_TREE:
-		case OBJ_BLOB:
-		case OBJ_TAG:
-			unuse_pack(&w_curs);
-			return typename(type);
-		case OBJ_OFS_DELTA:
-			obj_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
-			if (!obj_offset)
-				die("pack %s contains bad delta base reference of type %s",
-				    p->pack_name, typename(type));
-			if (*delta_chain_length == 0) {
-				revidx = find_pack_revindex(p, obj_offset);
-				hashcpy(base_sha1, nth_packed_object_sha1(p, revidx->nr));
-			}
-			break;
-		case OBJ_REF_DELTA:
-			next_sha1 = use_pack(p, &w_curs, curpos, NULL);
-			if (*delta_chain_length == 0)
-				hashcpy(base_sha1, next_sha1);
-			obj_offset = find_pack_entry_one(next_sha1, p);
-			break;
-		}
-		(*delta_chain_length)++;
-		curpos = obj_offset;
-		type = unpack_object_header(p, &w_curs, &curpos, &dummy);
-	}
-}
-
 static int packed_object_info(struct packed_git *p, off_t obj_offset,
 			      unsigned long *sizep)
 {
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 76bcaca..f8fa924 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -226,9 +226,8 @@ test_expect_success \
      ( while read obj
        do git cat-file -p $obj >/dev/null || exit 1
        done <obj-list ) &&
-     err=$(test_must_fail git verify-pack \
-       ".git/objects/pack/pack-${pack1}.pack" 2>&1) &&
-     echo "$err" | grep "CRC mismatch"'
+     test_must_fail git verify-pack ".git/objects/pack/pack-${pack1}.pack"
+'
 
 test_expect_success 'running index-pack in the object store' '
     rm -f .git/objects/pack/* &&
-- 
1.7.6.rc0.106.g68174
