From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] has_sha1_kept_pack(): take "struct rev_info"
Date: Sat, 28 Feb 2009 01:15:08 -0800
Message-ID: <b8431b033f9e60f87a75b864612873307a3e5966.1235812035.git.gitster@pobox.com>
References: <cover.1235812035.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 10:17:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdLK6-0001wI-RK
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 10:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbZB1JPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 04:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbZB1JPb
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 04:15:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443AbZB1JP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 04:15:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7DCDA28CB
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CCF1F28CA for
 <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:24 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.99.g9f3bb
In-Reply-To: <cover.1235812035.git.gitster@pobox.com>
X-Pobox-Relay-ID: 556C3916-0578-11DE-B0AB-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111761>

Its "ignore_packed" parameter always comes from struct rev_info.  This
patch makes the function take a pointer to the surrounding structure, so
that the refactoring in the next patch becomes easier to review.

There is an unfortunate header file dependency and the easiest workaround
is to temporarily move the function declaration from cache.h to
revision.h; this will be moved back to cache.h once the function loses
this "ignore_packed" parameter altogether in the later part of the
series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    1 -
 revision.c  |    2 +-
 revision.h  |    2 ++
 sha1_file.c |   16 +++++++++-------
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index c1539bf..8e43f38 100644
--- a/cache.h
+++ b/cache.h
@@ -566,7 +566,6 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
-extern int has_sha1_kept_pack(const unsigned char *sha1, const char **ignore);
 extern int has_sha1_file(const unsigned char *sha1);
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
diff --git a/revision.c b/revision.c
index 746eeed..795e0c0 100644
--- a/revision.c
+++ b/revision.c
@@ -1486,7 +1486,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
 	if (revs->unpacked &&
-	    has_sha1_kept_pack(commit->object.sha1, revs->ignore_packed))
+	    has_sha1_kept_pack(commit->object.sha1, revs))
 		return commit_ignore;
 	if (revs->show_all)
 		return commit_show;
diff --git a/revision.h b/revision.h
index 91f1944..9304296 100644
--- a/revision.h
+++ b/revision.h
@@ -158,4 +158,6 @@ enum commit_action {
 
 extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
 
+extern int has_sha1_kept_pack(const unsigned char *sha1, const struct rev_info *);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index ac4375d..f963c3c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -16,6 +16,8 @@
 #include "refs.h"
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
+#include "diff.h"
+#include "revision.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -1875,7 +1877,7 @@ int matches_pack_name(struct packed_git *p, const char *name)
 }
 
 static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
-			 const char **ignore_packed)
+			 const struct rev_info *revs)
 {
 	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
@@ -1887,9 +1889,9 @@ static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
 	p = (last_found == (void *)1) ? packed_git : last_found;
 
 	do {
-		if (ignore_packed) {
+		if (revs->ignore_packed) {
 			const char **ig;
-			for (ig = ignore_packed; *ig; ig++)
+			for (ig = revs->ignore_packed; *ig; ig++)
 				if (matches_pack_name(p, *ig))
 					break;
 			if (*ig)
@@ -1941,9 +1943,9 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 }
 
 static int find_kept_pack_entry(const unsigned char *sha1, struct pack_entry *e,
-				const char **ignore_packed)
+				const struct rev_info *revs)
 {
-	return find_pack_ent(sha1, e, ignore_packed);
+	return find_pack_ent(sha1, e, revs);
 }
 
 struct packed_git *find_sha1_pack(const unsigned char *sha1,
@@ -2413,10 +2415,10 @@ int has_sha1_pack(const unsigned char *sha1)
 	return find_pack_entry(sha1, &e);
 }
 
-int has_sha1_kept_pack(const unsigned char *sha1, const char **ignore_packed)
+int has_sha1_kept_pack(const unsigned char *sha1, const struct rev_info *revs)
 {
 	struct pack_entry e;
-	return find_kept_pack_entry(sha1, &e, ignore_packed);
+	return find_kept_pack_entry(sha1, &e, revs);
 }
 
 int has_sha1_file(const unsigned char *sha1)
-- 
1.6.2.rc2.99.g9f3bb
