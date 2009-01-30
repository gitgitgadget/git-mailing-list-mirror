From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] verify_pack(): allow a quicker verification for a pack
 with version 2 idx
Date: Fri, 30 Jan 2009 03:05:14 -0800
Message-ID: <1233313517-24208-3-git-send-email-gitster@pobox.com>
References: <1233313517-24208-1-git-send-email-gitster@pobox.com>
 <1233313517-24208-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 12:07:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSrD3-0005hA-BV
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 12:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbZA3LFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 06:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbZA3LF3
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 06:05:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbZA3LF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 06:05:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B016494729
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 06:05:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A5A9394728 for
 <git@vger.kernel.org>; Fri, 30 Jan 2009 06:05:24 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.312.g5be3c
In-Reply-To: <1233313517-24208-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E577D2DA-EEBD-11DD-9B28-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107791>

This adds an extra flag parameter to verify_pack() so that the caller can
affect what kind of checks are performed.

For a packfile, we always validate its whole SHA-1 checksum and the pack
header.  By default, we make sure that we can unpack all the objects in
the packfile, and the unpacked data actually matches their object name.
In addition, for a pack with version 2 idx that has per-object CRC, we
verify their CRC checksum match what is recorded.

By specifying VERIFY_PACK_QUICK, you can omit the expensive per-object
unpacking and object name validation. Per-object CRC check that is done
for objects in a pack with version 2 idx file is still performed as it is
inexpensive.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-fsck.c        |    2 +-
 builtin-verify-pack.c |    2 +-
 http-push.c           |    2 +-
 http-walker.c         |    2 +-
 pack-check.c          |   17 +++++++++++++----
 pack.h                |    5 ++++-
 6 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 64dffa5..8dc7881 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -614,7 +614,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		prepare_packed_git();
 		for (p = packed_git; p; p = p->next)
 			/* verify gives error messages itself */
-			verify_pack(p);
+			verify_pack(p, 0);
 
 		for (p = packed_git; p; p = p->next) {
 			uint32_t j, num;
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 25a29f1..42ae406 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -93,7 +93,7 @@ static int verify_one_pack(const char *path, int verbose)
 		return error("packfile %s not found.", arg);
 
 	install_packed_git(pack);
-	err = verify_pack(pack);
+	err = verify_pack(pack, 0);
 
 	if (verbose) {
 		if (err)
diff --git a/http-push.c b/http-push.c
index 59037df..0cd2926 100644
--- a/http-push.c
+++ b/http-push.c
@@ -809,7 +809,7 @@ static void finish_request(struct transfer_request *request)
 					lst = &((*lst)->next);
 				*lst = (*lst)->next;
 
-				if (!verify_pack(target))
+				if (!verify_pack(target, 0))
 					install_packed_git(target);
 				else
 					remote->can_update_info_refs = 0;
diff --git a/http-walker.c b/http-walker.c
index 0dbad3c..7f314b0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -797,7 +797,7 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	if (verify_pack(target))
+	if (verify_pack(target, 0))
 		return -1;
 	install_packed_git(target);
 
diff --git a/pack-check.c b/pack-check.c
index 2c5f521..256370c 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -42,8 +42,8 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	return data_crc != ntohl(*index_crc);
 }
 
-static int verify_packfile(struct packed_git *p,
-			   struct pack_window **w_curs)
+static int verify_packfile(struct packed_git *p, struct pack_window **w_curs,
+			   unsigned flag)
 {
 	off_t index_size = p->index_size;
 	const unsigned char *index_base = p->index_data;
@@ -78,6 +78,12 @@ static int verify_packfile(struct packed_git *p,
 		err = error("%s SHA1 does not match its index", p->pack_name);
 	unuse_pack(w_curs);
 
+	if ((flag & VERIFY_PACK_QUICK) && p->index_version <= 1) {
+		warning("contents not checked for %s as its .idx does not have CRC",
+			p->pack_name);
+		return err;
+	}
+
 	/*
 	 * Make sure everything reachable from idx is valid.  Since we
 	 * have verified that nr_objects matches between idx and pack,
@@ -114,6 +120,9 @@ static int verify_packfile(struct packed_git *p,
 					    sha1_to_hex(entries[i].sha1),
 					    p->pack_name, (uintmax_t)offset);
 		}
+
+		if (flag & VERIFY_PACK_QUICK)
+			continue;
 		data = unpack_entry(p, entries[i].offset, &type, &size);
 		if (!data) {
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
@@ -134,7 +143,7 @@ static int verify_packfile(struct packed_git *p,
 	return err;
 }
 
-int verify_pack(struct packed_git *p)
+int verify_pack(struct packed_git *p, unsigned flag)
 {
 	off_t index_size;
 	const unsigned char *index_base;
@@ -157,7 +166,7 @@ int verify_pack(struct packed_git *p)
 			    p->pack_name);
 
 	/* Verify pack file */
-	err |= verify_packfile(p, &w_curs);
+	err |= verify_packfile(p, &w_curs, flag);
 	unuse_pack(&w_curs);
 
 	return err;
diff --git a/pack.h b/pack.h
index a883334..b9e381c 100644
--- a/pack.h
+++ b/pack.h
@@ -57,7 +57,10 @@ struct pack_idx_entry {
 
 extern char *write_idx_file(char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
-extern int verify_pack(struct packed_git *);
+
+#define VERIFY_PACK_QUICK 01
+extern int verify_pack(struct packed_git *, unsigned flag);
+
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 
-- 
1.6.1.2.312.g5be3c
