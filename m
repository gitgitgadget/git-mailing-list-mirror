From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 5/5] Remove --kept-pack-only option and associated infrastructure
Date: Thu, 19 Mar 2009 22:47:54 -0500
Message-ID: <t_s5aa51o2kq_ePRWgLTEuhVqJ8uEP2M4mNXlcR5bTOSGntvtmK1-2zwj9VIPyIUzDg3JDg57Nk@cipher.nrlssc.navy.mil>
References: <EblkEXbcYUWby1OEDup9n0l6lbwNL-4-jyt02Cjab2pqLqekAUji0w@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEkVg4HqH1dQa6_mVq4djPPG4Vxylm2hNqmx7fPC2W5AsfcXg83DYbGc@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEpak5ue1ZM7YICzIF-RsnmN68psiOC0Tnz9bsH5tTxgVEU0bxG-OtJ8@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEg6KbvKii55gDA1y-1oKgx9KP4EKyrqg8sDFaph97G5MPoLgUx_vx48@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEvwR8O51ATzGH2_NEfAeCgOx3i1IYGfgLg3-dTPOh68RhaeQgBB9s2g@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEtCnzveAKdblNoXw2p9yc1N22fpuARDjOh9wRXpwEKvultyJoNzUWBY@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, drafnel@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 20 04:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkVk9-000158-Pl
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 04:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbZCTDs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 23:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbZCTDsT
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 23:48:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60271 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbZCTDsM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 23:48:12 -0400
Received: by mail.nrlssc.navy.mil id n2K3m8vE019899; Thu, 19 Mar 2009 22:48:08 -0500
In-Reply-To: <t_s5aa51o2kq_ePRWgLTEtCnzveAKdblNoXw2p9yc1N22fpuARDjOh9wRXpwEKvultyJoNzUWBY@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Mar 2009 03:48:06.0980 (UTC) FILETIME=[ADF32840:01C9A90E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113890>

This option to pack-objects/rev-list was created to improve the -A and -a
options of repack.  It was found to be lacking in that it did not provide
the ability to differentiate between local and non-local kept packs, and
found to be unnecessary since objects residing in local kept packs can be
filtered out by the --honor-pack-keep option.
---
 builtin-pack-objects.c |    1 -
 cache.h                |    1 -
 revision.c             |    9 +--------
 revision.h             |    1 -
 sha1_file.c            |   21 +--------------------
 5 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 22d69ef..24f96f0 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2200,7 +2200,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp("--unpacked", arg) ||
-		    !strcmp("--kept-pack-only", arg) ||
 		    !strcmp("--reflog", arg) ||
 		    !strcmp("--all", arg)) {
 			use_internal_rev_list = 1;
diff --git a/cache.h b/cache.h
index 39789ee..a94cf67 100644
--- a/cache.h
+++ b/cache.h
@@ -646,7 +646,6 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
-extern int has_sha1_kept_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
diff --git a/revision.c b/revision.c
index f5771c7..b6215cc 100644
--- a/revision.c
+++ b/revision.c
@@ -1106,10 +1106,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->edge_hint = 1;
 	} else if (!strcmp(arg, "--unpacked")) {
 		revs->unpacked = 1;
-		revs->kept_pack_only = 0;
-	} else if (!strcmp(arg, "--kept-pack-only")) {
-		revs->unpacked = 1;
-		revs->kept_pack_only = 1;
 	} else if (!prefixcmp(arg, "--unpacked=")) {
 		die("--unpacked=<packfile> no longer supported.");
 	} else if (!strcmp(arg, "-r")) {
@@ -1679,10 +1675,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
-	if (revs->unpacked &&
-	    (revs->kept_pack_only
-	     ? has_sha1_kept_pack(commit->object.sha1)
-	     : has_sha1_pack(commit->object.sha1)))
+	if (revs->unpacked && has_sha1_pack(commit->object.sha1))
 		return commit_ignore;
 	if (revs->show_all)
 		return commit_show;
diff --git a/revision.h b/revision.h
index ad123d7..6e98b71 100644
--- a/revision.h
+++ b/revision.h
@@ -50,7 +50,6 @@ struct rev_info {
 			edge_hint:1,
 			limited:1,
 			unpacked:1,
-			kept_pack_only:1,
 			boundary:2,
 			left_right:1,
 			rewrite_parents:1,
diff --git a/sha1_file.c b/sha1_file.c
index 4563173..a354f06 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1919,8 +1919,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	return 0;
 }
 
-static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
-			 int kept_pack_only)
+static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
 	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
@@ -1932,8 +1931,6 @@ static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
 	p = (last_found == (void *)1) ? packed_git : last_found;
 
 	do {
-		if (kept_pack_only && !p->pack_keep)
-			goto next;
 		if (p->num_bad_objects) {
 			unsigned i;
 			for (i = 0; i < p->num_bad_objects; i++)
@@ -1973,16 +1970,6 @@ static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
 	return 0;
 }
 
-static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
-{
-	return find_pack_ent(sha1, e, 0);
-}
-
-static int find_kept_pack_entry(const unsigned char *sha1, struct pack_entry *e)
-{
-	return find_pack_ent(sha1, e, 1);
-}
-
 struct packed_git *find_sha1_pack(const unsigned char *sha1,
 				  struct packed_git *packs)
 {
@@ -2456,12 +2443,6 @@ int has_sha1_pack(const unsigned char *sha1)
 	return find_pack_entry(sha1, &e);
 }
 
-int has_sha1_kept_pack(const unsigned char *sha1)
-{
-	struct pack_entry e;
-	return find_kept_pack_entry(sha1, &e);
-}
-
 int has_sha1_file(const unsigned char *sha1)
 {
 	struct pack_entry e;
-- 
1.6.2.16.geb16e
