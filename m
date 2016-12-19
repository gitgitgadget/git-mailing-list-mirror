Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3BA1FF6D
	for <e@80x24.org>; Mon, 19 Dec 2016 02:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbcLSCou (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 21:44:50 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:56992 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbcLSCot (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 21:44:49 -0500
X-Greylist: delayed 1950 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Dec 2016 21:44:48 EST
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <glandium@glandium.org>)
        id 1cInQy-0004AO-8k; Mon, 19 Dec 2016 11:12:12 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     johan@herland.net, gitster@pobox.com
Subject: [PATCH] fast-import: properly fanout notes when tree is imported
Date:   Mon, 19 Dec 2016 11:12:12 +0900
Message-Id: <20161219021212.15978-1-mh@glandium.org>
X-Mailer: git-send-email 2.11.0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In typical uses of fast-import, trees are inherited from a parent
commit. In that case, the tree_entry for the branch looks like:

  .versions[1].sha1 = $some_sha1
  .tree = <tree structure loaded from $some_sha1>

However, when trees are imported, rather than inherited, that is not the
case. One can import a tree with a filemodify command, replacing the
root tree object.

e.g.
  "M 040000 $some_sha1 \n"

In this case, the tree_entry for the branch looks like:

  .versions[1].sha1 = $some_sha1
  .tree = NULL

When adding new notes with the notemodify command, do_change_note_fanout
is called to get a notes count, and to do so, it loops over the
tree_entry->tree, but doesn't do anything when the tree is NULL.

In the latter case above, it means do_change_note_fanout thinks the tree
contains no note, and new notes are added with no fanout.

Interestingly, do_change_note_fanout does check whether subdirectories
have a NULL .tree, in which case it uses load_tree(). Which means the
right behaviour happens when using the filemodify command to import
subdirectories.

This change makes do_change_note_fanount call load_tree() whenever the
tree_entry it is given has no tree loaded, making all cases handled
equally.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

This is something I should have submitted a patch for a long time ago, back
when this was discussed in the thread starting from
https://www.spinics.net/lists/git/msg242426.html. The message most relevant to
this patch in the thread is https://www.spinics.net/lists/git/msg242448.html.

 fast-import.c                |  8 +++++---
 t/t9301-fast-import-notes.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index cb545d7df5..5e528b1999 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2220,13 +2220,17 @@ static uintmax_t do_change_note_fanout(
 		char *fullpath, unsigned int fullpath_len,
 		unsigned char fanout)
 {
-	struct tree_content *t = root->tree;
+	struct tree_content *t;
 	struct tree_entry *e, leaf;
 	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len;
 	uintmax_t num_notes = 0;
 	unsigned char sha1[20];
 	char realpath[60];
 
+	if (!root->tree)
+		load_tree(root);
+	t = root->tree;
+
 	for (i = 0; t && i < t->entry_count; i++) {
 		e = t->entries[i];
 		tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;
@@ -2278,8 +2282,6 @@ static uintmax_t do_change_note_fanout(
 				leaf.tree);
 		} else if (S_ISDIR(e->versions[1].mode)) {
 			/* This is a subdir that may contain note entries */
-			if (!e->tree)
-				load_tree(e);
 			num_notes += do_change_note_fanout(orig_root, e,
 				hex_sha1, tmp_hex_sha1_len,
 				fullpath, tmp_fullpath_len, fanout);
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 83acf68bc3..b408b2b32d 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -483,6 +483,47 @@ test_expect_success 'verify that lots of notes trigger a fanout scheme' '
 
 '
 
+# Create another notes tree from the one above
+cat >>input <<INPUT_END
+commit refs/heads/other_commits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+commit #$(($num_commit + 1))
+COMMIT
+
+from refs/heads/many_commits
+M 644 inline file
+data <<EOF
+file contents in commit #$(($num_commit + 1))
+EOF
+
+commit refs/notes/other_notes
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+committing one more note on a tree imported from a previous notes tree
+COMMIT
+
+M 040000 $(git log --no-walk --format=%T refs/notes/many_notes) 
+N inline :$(($num_commit + 1))
+data <<EOF
+note for commit #$(($num_commit + 1))
+EOF
+INPUT_END
+
+test_expect_success 'verify that importing a notes tree respects the fanout scheme' '
+	git fast-import <input &&
+
+	# None of the entries in the top-level notes tree should be a full SHA1
+	git ls-tree --name-only refs/notes/other_notes |
+	while read path
+	do
+		if test $(expr length "$path") -ge 40
+		then
+			return 1
+		fi
+	done
+'
+
 cat >>expect_non-note1 << EOF
 This is not a note, but rather a regular file residing in a notes tree
 EOF
-- 
2.11.0.dirty

