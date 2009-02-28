From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] is_kept_pack(): final clean-up
Date: Sat, 28 Feb 2009 01:15:11 -0800
Message-ID: <69e020ae00ebd3f7ae3c2f35acb139361417ef64.1235812035.git.gitster@pobox.com>
References: <cover.1235812035.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 10:17:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdLK7-0001wI-M5
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 10:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbZB1JPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 04:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756117AbZB1JPj
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 04:15:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396AbZB1JPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 04:15:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2FC4E28CD
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 736B628CC for
 <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:32 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.99.g9f3bb
In-Reply-To: <cover.1235812035.git.gitster@pobox.com>
X-Pobox-Relay-ID: 5A001F92-0578-11DE-9242-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111756>

Now is_kept_pack() is just a member lookup into a structure, we can write
it as such.

Also rewrite the sole caller of has_sha1_kept_pack() to switch on the
criteria the callee uses (namely, revs->kept_pack_only) between calling
has_sha1_kept_pack() and has_sha1_pack(), so that these two callees do not
have to take a pointer to struct rev_info as an argument.

This removes the header file dependency issue temporarily introduced by
the earlier commit, so we revert changes associated to that as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-pack-objects.c |    4 ++--
 cache.h                |    1 +
 revision.c             |    4 +++-
 revision.h             |    3 ---
 sha1_file.c            |   22 +++++++---------------
 5 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 150258b..b2e4626 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1915,7 +1915,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 		const unsigned char *sha1;
 		struct object *o;
 
-		if (is_kept_pack(p))
+		if (p->pack_keep)
 			continue;
 		if (open_pack_index(p))
 			die("cannot open pack index");
@@ -1951,7 +1951,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 	const unsigned char *sha1;
 
 	for (p = packed_git; p; p = p->next) {
-		if (is_kept_pack(p))
+		if (p->pack_keep)
 			continue;
 
 		if (open_pack_index(p))
diff --git a/cache.h b/cache.h
index 23c16d0..0a3d523 100644
--- a/cache.h
+++ b/cache.h
@@ -566,6 +566,7 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
+extern int has_sha1_kept_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
diff --git a/revision.c b/revision.c
index 3cfd653..6d8ac46 100644
--- a/revision.c
+++ b/revision.c
@@ -1476,7 +1476,9 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
 	if (revs->unpacked &&
-	    has_sha1_kept_pack(commit->object.sha1, revs))
+	    (revs->kept_pack_only
+	     ? has_sha1_kept_pack(commit->object.sha1)
+	     : has_sha1_pack(commit->object.sha1)))
 		return commit_ignore;
 	if (revs->show_all)
 		return commit_show;
diff --git a/revision.h b/revision.h
index f63596f..b9fa9c2 100644
--- a/revision.h
+++ b/revision.h
@@ -156,7 +156,4 @@ enum commit_action {
 
 extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
 
-extern int has_sha1_kept_pack(const unsigned char *sha1, const struct rev_info *);
-extern int is_kept_pack(const struct packed_git *);
-
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index e8a9517..7ead56c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -16,8 +16,6 @@
 #include "refs.h"
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
-#include "diff.h"
-#include "revision.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -1858,13 +1856,8 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	return 0;
 }
 
-int is_kept_pack(const struct packed_git *p)
-{
-	return p->pack_keep;
-}
-
 static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
-			 const struct rev_info *revs)
+			 int kept_pack_only)
 {
 	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
@@ -1876,7 +1869,7 @@ static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
 	p = (last_found == (void *)1) ? packed_git : last_found;
 
 	do {
-		if (revs->kept_pack_only && !is_kept_pack(p))
+		if (kept_pack_only && !p->pack_keep)
 			goto next;
 		if (p->num_bad_objects) {
 			unsigned i;
@@ -1919,13 +1912,12 @@ static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
 
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
-	return find_pack_ent(sha1, e, NULL);
+	return find_pack_ent(sha1, e, 0);
 }
 
-static int find_kept_pack_entry(const unsigned char *sha1, struct pack_entry *e,
-				const struct rev_info *revs)
+static int find_kept_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
-	return find_pack_ent(sha1, e, revs);
+	return find_pack_ent(sha1, e, 1);
 }
 
 struct packed_git *find_sha1_pack(const unsigned char *sha1,
@@ -2395,10 +2387,10 @@ int has_sha1_pack(const unsigned char *sha1)
 	return find_pack_entry(sha1, &e);
 }
 
-int has_sha1_kept_pack(const unsigned char *sha1, const struct rev_info *revs)
+int has_sha1_kept_pack(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	return find_kept_pack_entry(sha1, &e, revs);
+	return find_kept_pack_entry(sha1, &e);
 }
 
 int has_sha1_file(const unsigned char *sha1)
-- 
1.6.2.rc2.99.g9f3bb
