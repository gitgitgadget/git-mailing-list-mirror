From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] Add git-unresolve <paths>...
Date: Wed, 19 Apr 2006 13:01:28 -0700
Message-ID: <7vu08p72sn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Apr 19 22:01:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWIrm-00071a-Tw
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 22:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWDSUBa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 16:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWDSUBa
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 16:01:30 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:11418 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751209AbWDSUB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 16:01:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419200129.SSJR8660.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 16:01:29 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18936>

This is an attempt to address the issue raised on #git channel
recently by Carl Worth.

After a conflicted automerge, "git diff" shows a combined diff
to give you how the tentative automerge result differs from
what came from each branch.  During a complex merge, it is
tempting to be able to resolve a few paths at a time, mark
them "I've dealt with them" with git-update-index to unclutter
the next "git diff" output, and keep going.  However, when the
final result does not compile or otherwise found to be a
mismerge, the workflow to fix the mismerged paths suddenly
changes to "git diff HEAD -- path" (to get a diff from our
HEAD before merging) and "git diff MERGE_HEAD -- path" (to get
a diff from theirs), and it cannot show the combined anymore.

With git-unresolve <paths>..., the versions from our branch and
their branch for specified blobs are placed in stage #2 and
stage #3, without touching the working tree files.  This gives
you the combined diff back for easier review, along with
"diff --ours" and "diff --theirs".

One thing it does not do is to place the base in stage #1; this
means "diff --base" would behave differently between the run
immediately after a conflicted three-way merge, and the run
after an update-index by mistake followed by a git-unresolve.

We could theoretically run merge-base between HEAD and
MERGE_HEAD to find which tree to place in stage #1, but
reviewing "diff --base" is not that useful so....

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * comes on top of the previous two "extended sha1" cleanups.

 .gitignore  |    1 
 Makefile    |    3 +
 cache.h     |    1 
 sha1_name.c |    6 +-
 unresolve.c |  145 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index b5959d6..1e4ba7b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -111,6 +111,7 @@ git-tag
 git-tar-tree
 git-unpack-file
 git-unpack-objects
+git-unresolve
 git-update-index
 git-update-ref
 git-update-server-info
diff --git a/Makefile b/Makefile
index 8aed3af..85938c0 100644
--- a/Makefile
+++ b/Makefile
@@ -165,7 +165,8 @@ PROGRAMS = \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
-	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
+	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X \
+	git-unresolve$X
 
 BUILT_INS = git-log$X
 
diff --git a/cache.h b/cache.h
index 69801b0..a5f1eb3 100644
--- a/cache.h
+++ b/cache.h
@@ -235,6 +235,7 @@ #define DEFAULT_ABBREV 7
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
+extern int get_tree_entry(const unsigned char *, const char *, unsigned char *, unsigned *);
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int);
 extern int create_symref(const char *git_HEAD, const char *refs_heads_master);
diff --git a/sha1_name.c b/sha1_name.c
index 7ad20b5..68b1275 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -450,8 +450,6 @@ static int get_sha1_1(const char *name, 
 	return get_short_sha1(name, len, sha1, 0);
 }
 
-static int get_tree_entry(const unsigned char *, const char *, unsigned char *, unsigned *);
-
 static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result, unsigned *mode)
 {
 	int namelen = strlen(name);
@@ -487,13 +485,13 @@ static int find_tree_entry(struct tree_d
 	return -1;
 }
 
-static int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned char *sha1, unsigned *mode)
+int get_tree_entry(const unsigned char *ent_sha1, const char *name, unsigned char *sha1, unsigned *mode)
 {
 	int retval;
 	void *tree;
 	struct tree_desc t;
 
-	tree = read_object_with_reference(tree_sha1, tree_type, &t.size, NULL);
+	tree = read_object_with_reference(ent_sha1, tree_type, &t.size, NULL);
 	if (!tree)
 		return -1;
 	t.buf = tree;
diff --git a/unresolve.c b/unresolve.c
new file mode 100644
index 0000000..14655f7
--- /dev/null
+++ b/unresolve.c
@@ -0,0 +1,145 @@
+#include "cache.h"
+
+static const char unresolve_usage[] =
+"git-unresolve <paths>...";
+
+static struct cache_file cache_file;
+static unsigned char head_sha1[20];
+static unsigned char merge_head_sha1[20];
+
+static struct cache_entry *read_one_ent(const char *which,
+					unsigned char *ent, const char *path,
+					int namelen, int stage)
+{
+	unsigned mode;
+	unsigned char sha1[20];
+	int size;
+	struct cache_entry *ce;
+
+	if (get_tree_entry(ent, path, sha1, &mode)) {
+		error("%s: not in %s branch.", path, which);
+		return NULL;
+	}
+	if (mode == S_IFDIR) {
+		error("%s: not a blob in %s branch.", path, which);
+		return NULL;
+	}
+	size = cache_entry_size(namelen);
+	ce = xcalloc(1, size);
+
+	memcpy(ce->sha1, sha1, 20);
+	memcpy(ce->name, path, namelen);
+	ce->ce_flags = create_ce_flags(namelen, stage);
+	ce->ce_mode = create_ce_mode(mode);
+	return ce;
+}
+
+static int unresolve_one(const char *path)
+{
+	int namelen = strlen(path);
+	int pos;
+	int ret = 0;
+	struct cache_entry *ce_2 = NULL, *ce_3 = NULL;
+
+	/* See if there is such entry in the index. */
+	pos = cache_name_pos(path, namelen);
+	if (pos < 0) {
+		/* If there isn't, either it is unmerged, or
+		 * resolved as "removed" by mistake.  We do not
+		 * want to do anything in the former case.
+		 */
+		pos = -pos-1;
+		if (pos < active_nr) {
+			struct cache_entry *ce = active_cache[pos];
+			if (ce_namelen(ce) == namelen &&
+			    !memcmp(ce->name, path, namelen)) {
+				fprintf(stderr,
+					"%s: skipping still unmerged path.\n",
+					path);
+				goto free_return;
+			}
+		}
+	}
+
+	/* Grab blobs from given path from HEAD and MERGE_HEAD,
+	 * stuff HEAD version in stage #2,
+	 * stuff MERGE_HEAD version in stage #3.
+	 */
+	ce_2 = read_one_ent("our", head_sha1, path, namelen, 2);
+	ce_3 = read_one_ent("their", merge_head_sha1, path, namelen, 3);
+
+	if (!ce_2 || !ce_3) {
+		ret = -1;
+		goto free_return;
+	}
+	if (!memcmp(ce_2->sha1, ce_3->sha1, 20) &&
+	    ce_2->ce_mode == ce_3->ce_mode) {
+		fprintf(stderr, "%s: identical in both, skipping.\n",
+			path);
+		goto free_return;
+	}
+
+	remove_file_from_cache(path);
+	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
+		error("%s: cannot add our version to the index.", path);
+		ret = -1;
+		goto free_return;
+	}
+	if (!add_cache_entry(ce_3, ADD_CACHE_OK_TO_ADD))
+		return 0;
+	error("%s: cannot add their version to the index.", path);
+	ret = -1;
+ free_return:
+	free(ce_2);
+	free(ce_3);
+	return ret;
+}
+
+static void read_head_pointers(void)
+{
+	if (read_ref(git_path("HEAD"), head_sha1))
+		die("Cannot read HEAD -- no initial commit yet?");
+	if (read_ref(git_path("MERGE_HEAD"), merge_head_sha1)) {
+		fprintf(stderr, "Not in the middle of a merge.\n");
+		exit(0);
+	}
+}
+
+int main(int ac, char **av)
+{
+	int i;
+	int err = 0;
+	int newfd;
+
+	if (ac < 2)
+		usage(unresolve_usage);
+
+	git_config(git_default_config);
+
+	/* Read HEAD and MERGE_HEAD; if MERGE_HEAD does not exist, we
+	 * are not doing a merge, so exit with success status.
+	 */
+	read_head_pointers();
+
+	/* Otherwise we would need to update the cache. */
+	newfd= hold_index_file_for_update(&cache_file, get_index_file());
+	if (newfd < 0)
+		die("unable to create new cachefile");
+
+	if (read_cache() < 0)
+		die("cache corrupted");
+
+	for (i = 1; i < ac; i++) {
+		char *arg = av[i];
+		err |= unresolve_one(arg);
+	}
+	if (err)
+		die("Error encountered; index not updated.");
+
+	if (active_cache_changed) {
+		if (write_cache(newfd, active_cache, active_nr) ||
+		    commit_index_file(&cache_file))
+			die("Unable to write new cachefile");
+	}
+	return 0;
+}
-- 
1.3.0.g2c4a
