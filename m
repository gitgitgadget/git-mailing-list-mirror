From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] Simplify is_kept_pack()
Date: Sat, 28 Feb 2009 01:15:10 -0800
Message-ID: <03a9683d22eca52bc2b2b9b09258a143e76416f6.1235812035.git.gitster@pobox.com>
References: <cover.1235812035.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 10:17:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdLK8-0001wI-D9
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 10:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbZB1JPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 04:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755447AbZB1JPl
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 04:15:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbZB1JPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 04:15:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E01939D46D
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1034E9D46C for
 <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:29 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.99.g9f3bb
In-Reply-To: <cover.1235812035.git.gitster@pobox.com>
X-Pobox-Relay-ID: 58A27FB4-0578-11DE-96F0-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111757>

This removes --unpacked=<packfile> parameter from the revision parser, and
rewrites its use in git-repack to pass a single --kept-pack-only option
instead.

The new --kept-pack-only option means just that.  When this option is
given, is_kept_pack() that used to say "not on the --unpacked=<packfile>
list" now says "the packfile has corresponding .keep file".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-pack-objects.c |    6 +++---
 git-repack.sh          |    5 ++++-
 revision.c             |   20 +++++---------------
 revision.h             |    8 +++-----
 sha1_file.c            |   30 +++---------------------------
 5 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 7e7719b..150258b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1915,7 +1915,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 		const unsigned char *sha1;
 		struct object *o;
 
-		if (is_kept_pack(p, revs))
+		if (is_kept_pack(p))
 			continue;
 		if (open_pack_index(p))
 			die("cannot open pack index");
@@ -1951,7 +1951,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 	const unsigned char *sha1;
 
 	for (p = packed_git; p; p = p->next) {
-		if (is_kept_pack(p, revs))
+		if (is_kept_pack(p))
 			continue;
 
 		if (open_pack_index(p))
@@ -2149,7 +2149,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp("--unpacked", arg) ||
-		    !prefixcmp(arg, "--unpacked=") ||
+		    !strcmp("--kept-pack-only", arg) ||
 		    !strcmp("--reflog", arg) ||
 		    !strcmp("--all", arg)) {
 			use_internal_rev_list = 1;
diff --git a/git-repack.sh b/git-repack.sh
index 8600015..a736009 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -68,10 +68,13 @@ case ",$all_into_one," in
 			if [ -e "$PACKDIR/$e.keep" ]; then
 				: keep
 			else
-				args="$args --unpacked=$e.pack"
 				existing="$existing $e"
 			fi
 		done
+		if test -n "$existing"
+		then
+			args="--kept-pack-only"
+		fi
 		if test -n "$args" -a -n "$unpack_unreachable" -a \
 			-n "$remove_redundant"
 		then
diff --git a/revision.c b/revision.c
index 795e0c0..3cfd653 100644
--- a/revision.c
+++ b/revision.c
@@ -963,16 +963,6 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
-static void add_ignore_packed(struct rev_info *revs, const char *name)
-{
-	int num = ++revs->num_ignore_packed;
-
-	revs->ignore_packed = xrealloc(revs->ignore_packed,
-				       sizeof(const char *) * (num + 1));
-	revs->ignore_packed[num-1] = name;
-	revs->ignore_packed[num] = NULL;
-}
-
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv)
 {
@@ -1072,12 +1062,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->edge_hint = 1;
 	} else if (!strcmp(arg, "--unpacked")) {
 		revs->unpacked = 1;
-		free(revs->ignore_packed);
-		revs->ignore_packed = NULL;
-		revs->num_ignore_packed = 0;
-	} else if (!prefixcmp(arg, "--unpacked=")) {
+		revs->kept_pack_only = 0;
+	} else if (!strcmp(arg, "--kept-pack-only")) {
 		revs->unpacked = 1;
-		add_ignore_packed(revs, arg+11);
+		revs->kept_pack_only = 1;
+	} else if (!prefixcmp(arg, "--unpacked=")) {
+		die("--unpacked=<packfile> no longer supported.");
 	} else if (!strcmp(arg, "-r")) {
 		revs->diff = 1;
 		DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
diff --git a/revision.h b/revision.h
index af414e5..f63596f 100644
--- a/revision.h
+++ b/revision.h
@@ -47,7 +47,8 @@ struct rev_info {
 			blob_objects:1,
 			edge_hint:1,
 			limited:1,
-			unpacked:1, /* see also ignore_packed below */
+			unpacked:1,
+			kept_pack_only:1,
 			boundary:2,
 			left_right:1,
 			rewrite_parents:1,
@@ -75,9 +76,6 @@ struct rev_info {
 			missing_newline:1;
 	enum date_mode date_mode;
 
-	const char **ignore_packed; /* pretend objects in these are unpacked */
-	int num_ignore_packed;
-
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
 	struct log_info *loginfo;
@@ -159,6 +157,6 @@ enum commit_action {
 extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
 
 extern int has_sha1_kept_pack(const unsigned char *sha1, const struct rev_info *);
-extern int is_kept_pack(const struct packed_git *, const struct rev_info *);
+extern int is_kept_pack(const struct packed_git *);
 
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 6e0a462..e8a9517 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1858,33 +1858,9 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	return 0;
 }
 
-static int matches_pack_name(const struct packed_git *p, const char *name)
+int is_kept_pack(const struct packed_git *p)
 {
-	const char *last_c, *c;
-
-	if (!strcmp(p->pack_name, name))
-		return 1;
-
-	for (c = p->pack_name, last_c = c; *c;)
-		if (*c == '/')
-			last_c = ++c;
-		else
-			++c;
-	if (!strcmp(last_c, name))
-		return 1;
-
-	return 0;
-}
-
-int is_kept_pack(const struct packed_git *p, const struct rev_info *revs)
-{
-	int i;
-
-	for (i = 0; i < revs->num_ignore_packed; i++) {
-		if (matches_pack_name(p, revs->ignore_packed[i]))
-			return 0;
-	}
-	return 1;
+	return p->pack_keep;
 }
 
 static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
@@ -1900,7 +1876,7 @@ static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
 	p = (last_found == (void *)1) ? packed_git : last_found;
 
 	do {
-		if (revs->ignore_packed && !is_kept_pack(p, revs))
+		if (revs->kept_pack_only && !is_kept_pack(p))
 			goto next;
 		if (p->num_bad_objects) {
 			unsigned i;
-- 
1.6.2.rc2.99.g9f3bb
