From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git-add --intent-to-add (-N)
Date: Thu, 21 Aug 2008 01:44:53 -0700
Message-ID: <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7viqtukbec.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:46:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW5oL-0001Z6-0e
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 10:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbYHUIpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 04:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbYHUIpG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 04:45:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbYHUIpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 04:45:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 36851594AE;
	Thu, 21 Aug 2008 04:45:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1D431594AD; Thu, 21 Aug 2008 04:44:56 -0400 (EDT)
In-Reply-To: <7viqtukbec.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Aug 2008 01:41:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 709016F6-6F5D-11DD-97EA-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93123>

This adds "--intent-to-add" option to "git add".  This is to let the
system know that you will tell it the final contents to be staged later,
iow, just be aware of the presense of the path with the type of the blob
for now.

With this sequence:

    $ git reset --hard
    $ edit newfile
    $ git add -N newfile
    $ edit newfile oldfile
    $ git diff

the diff will show all changes relative to the current commit.  Then you
can do:

    $ git commit -a ;# commit everything

or

    $ git commit oldfile ;# only oldfile, newfile not yet added

to pretend you are working with an index-free system like CVS.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c         |    4 +++-
 cache.h               |    2 ++
 read-cache.c          |   30 ++++++++++++++++++++----------
 t/t2203-add-intent.sh |   36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 11 deletions(-)
 create mode 100755 t/t2203-add-intent.sh

diff --git a/builtin-add.c b/builtin-add.c
index fc3f96e..a08d50d 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -191,7 +191,7 @@ static const char ignore_error[] =
 "The following paths are ignored by one of your .gitignore files:\n";
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
-static int ignore_add_errors, addremove;
+static int ignore_add_errors, addremove, intent_to_add;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only),
@@ -201,6 +201,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
 	OPT_BOOLEAN('f', "force", &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked files"),
+	OPT_BOOLEAN('N', "intent-to-add", &intent_to_add, "record only the fact that the path will be added later"),
 	OPT_BOOLEAN('A', "all", &addremove, "add all, noticing removal of tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip files which cannot be added because of errors"),
@@ -271,6 +272,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
 		 (show_only ? ADD_CACHE_PRETEND : 0) |
+		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0));
 
 	if (require_pathspec && argc == 0) {
diff --git a/cache.h b/cache.h
index 68ce6e6..5948bcc 100644
--- a/cache.h
+++ b/cache.h
@@ -369,6 +369,7 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
+#define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
@@ -377,6 +378,7 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
 #define ADD_CACHE_IGNORE_ERRORS	4
+#define ADD_CACHE_INTENT 8
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
diff --git a/read-cache.c b/read-cache.c
index 2c03ec3..1592045 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -154,13 +154,13 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
+static const unsigned char empty_blob_sha1[20] = {
+	0xe6,0x9d,0xe2,0x9b,0xb2,0xd1,0xd6,0x43,0x4b,0x8b,
+	0x29,0xae,0x77,0x5a,0xd8,0xc2,0xe4,0x8c,0x53,0x91
+};
+
 static int is_empty_blob_sha1(const unsigned char *sha1)
 {
-	static const unsigned char empty_blob_sha1[20] = {
-		0xe6,0x9d,0xe2,0x9b,0xb2,0xd1,0xd6,0x43,0x4b,0x8b,
-		0x29,0xae,0x77,0x5a,0xd8,0xc2,0xe4,0x8c,0x53,0x91
-	};
-
 	return !hashcmp(sha1, empty_blob_sha1);
 }
 
@@ -514,6 +514,9 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
 	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
 	int pretend = flags & ADD_CACHE_PRETEND;
+	int intent_only = flags & ADD_CACHE_INTENT;
+	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
+			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
 
 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
 		return error("%s: can only add regular files, symbolic links or git-directories", path);
@@ -527,7 +530,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_flags = namelen;
-	fill_stat_cache_info(ce, st);
+	if (!intent_only)
+		fill_stat_cache_info(ce, st);
 
 	if (trust_executable_bit && has_symlinks)
 		ce->ce_mode = create_ce_mode(st_mode);
@@ -550,8 +554,12 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		alias->ce_flags |= CE_ADDED;
 		return 0;
 	}
-	if (index_path(ce->sha1, path, st, 1))
-		return error("unable to index file %s", path);
+	if (!intent_only) {
+		if (index_path(ce->sha1, path, st, 1))
+			return error("unable to index file %s", path);
+	} else
+		hashcpy(ce->sha1, empty_blob_sha1);
+
 	if (ignore_case && alias && different_name(ce, alias))
 		ce = create_alias_ce(ce, alias);
 	ce->ce_flags |= CE_ADDED;
@@ -564,7 +572,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 
 	if (pretend)
 		;
-	else if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
+	else if (add_index_entry(istate, ce, add_option))
 		return error("unable to add %s to index",path);
 	if (verbose && !was_same)
 		printf("add '%s'\n", path);
@@ -843,13 +851,15 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
 	int ok_to_replace = option & ADD_CACHE_OK_TO_REPLACE;
 	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
+	int new_only = option & ADD_CACHE_NEW_ONLY;
 
 	cache_tree_invalidate_path(istate->cache_tree, ce->name);
 	pos = index_name_pos(istate, ce->name, ce->ce_flags);
 
 	/* existing match? Just replace it. */
 	if (pos >= 0) {
-		replace_index_entry(istate, pos, ce);
+		if (!new_only)
+			replace_index_entry(istate, pos, ce);
 		return 0;
 	}
 	pos = -pos-1;
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
new file mode 100755
index 0000000..d4de35e
--- /dev/null
+++ b/t/t2203-add-intent.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='Intent to add'
+
+. ./test-lib.sh
+
+test_expect_success 'intent to add' '
+	echo hello >file &&
+	echo hello >elif &&
+	git add -N file &&
+	git add elif
+'
+
+test_expect_success 'check result of "add -N"' '
+	git ls-files -s file >actual &&
+	empty=$(git hash-object --stdin </dev/null) &&
+	echo "100644 $empty 0	file" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'intent to add is just an ordinary empty blob' '
+	git add -u &&
+	git ls-files -s file >actual &&
+	git ls-files -s elif | sed -e "s/elif/file/" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'intent to add does not clobber existing paths' '
+	git add -N file elif &&
+	empty=$(git hash-object --stdin </dev/null) &&
+	git ls-files -s >actual &&
+	! grep "$empty" actual
+'
+
+test_done
+
-- 
1.6.0.51.g078ae
