From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] Consolidate ignore_packed logic more
Date: Sat, 28 Feb 2009 01:15:09 -0800
Message-ID: <386cb77210cdb09cd808698d21d0e796cd77f26f.1235812035.git.gitster@pobox.com>
References: <cover.1235812035.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 10:17:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdLK9-0001wI-4B
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 10:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbZB1JPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 04:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755858AbZB1JPp
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 04:15:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbZB1JP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 04:15:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D8E129D46B
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2364E9D469 for
 <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:26 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.99.g9f3bb
In-Reply-To: <cover.1235812035.git.gitster@pobox.com>
X-Pobox-Relay-ID: 56D42AFC-0578-11DE-89E4-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111762>

This refactors three loops that check if a given packfile is on the
ignore_packed list into a function is_kept_pack().  The function returns
false for a pack on the list, and true for a pack not on the list, because
this list is solely used by "git repack" to pass list of packfiles that do
not have corresponding .keep files, i.e. a packfile not on the list is
"kept".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-pack-objects.c |   12 ++----------
 cache.h                |    1 -
 revision.h             |    1 +
 sha1_file.c            |   24 ++++++++++++++----------
 4 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index fb5e14d..7e7719b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1915,11 +1915,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 		const unsigned char *sha1;
 		struct object *o;
 
-		for (i = 0; i < revs->num_ignore_packed; i++) {
-			if (matches_pack_name(p, revs->ignore_packed[i]))
-				break;
-		}
-		if (revs->num_ignore_packed <= i)
+		if (is_kept_pack(p, revs))
 			continue;
 		if (open_pack_index(p))
 			die("cannot open pack index");
@@ -1955,11 +1951,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 	const unsigned char *sha1;
 
 	for (p = packed_git; p; p = p->next) {
-		for (i = 0; i < revs->num_ignore_packed; i++) {
-			if (matches_pack_name(p, revs->ignore_packed[i]))
-				break;
-		}
-		if (revs->num_ignore_packed <= i)
+		if (is_kept_pack(p, revs))
 			continue;
 
 		if (open_pack_index(p))
diff --git a/cache.h b/cache.h
index 8e43f38..23c16d0 100644
--- a/cache.h
+++ b/cache.h
@@ -747,7 +747,6 @@ extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsign
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
-extern int matches_pack_name(struct packed_git *p, const char *name);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/revision.h b/revision.h
index 9304296..af414e5 100644
--- a/revision.h
+++ b/revision.h
@@ -159,5 +159,6 @@ enum commit_action {
 extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
 
 extern int has_sha1_kept_pack(const unsigned char *sha1, const struct rev_info *);
+extern int is_kept_pack(const struct packed_git *, const struct rev_info *);
 
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index f963c3c..6e0a462 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1858,7 +1858,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	return 0;
 }
 
-int matches_pack_name(struct packed_git *p, const char *name)
+static int matches_pack_name(const struct packed_git *p, const char *name)
 {
 	const char *last_c, *c;
 
@@ -1876,6 +1876,17 @@ int matches_pack_name(struct packed_git *p, const char *name)
 	return 0;
 }
 
+int is_kept_pack(const struct packed_git *p, const struct rev_info *revs)
+{
+	int i;
+
+	for (i = 0; i < revs->num_ignore_packed; i++) {
+		if (matches_pack_name(p, revs->ignore_packed[i]))
+			return 0;
+	}
+	return 1;
+}
+
 static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
 			 const struct rev_info *revs)
 {
@@ -1889,15 +1900,8 @@ static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
 	p = (last_found == (void *)1) ? packed_git : last_found;
 
 	do {
-		if (revs->ignore_packed) {
-			const char **ig;
-			for (ig = revs->ignore_packed; *ig; ig++)
-				if (matches_pack_name(p, *ig))
-					break;
-			if (*ig)
-				goto next;
-		}
-
+		if (revs->ignore_packed && !is_kept_pack(p, revs))
+			goto next;
 		if (p->num_bad_objects) {
 			unsigned i;
 			for (i = 0; i < p->num_bad_objects; i++)
-- 
1.6.2.rc2.99.g9f3bb
