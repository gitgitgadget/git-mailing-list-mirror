From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 19/23] git notes merge: Add another auto-resolving strategy:
 "cat_sort_uniq"
Date: Mon, 25 Oct 2010 02:08:49 +0200
Message-ID: <1287965333-5099-20-git-send-email-johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:10:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAdp-0000ju-LA
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab0JYAJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 20:09:45 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59910 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab0JYAJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:29 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT0051UKFMGG50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:23 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D604C179913D_CC4CAB2B	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:22 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 7ADB717966BC_CC4CAB2F	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:21 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:17 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287965333-5099-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159914>

This new strategy is similar to "concatenate", but in addition to
concatenating the two note candidates, this strategy sorts the resulting
lines, and removes duplicate lines from the result. This is equivalent to
applying the "cat | sort | uniq" shell pipeline to the two note candidates.

This strategy is useful if the notes follow a line-based format where one
wants to avoid duplicate lines in the merge result.

Note that if either of the note candidates contain duplicate lines _prior_
to the merge, these will also be removed by this merge strategy.

The patch also contains tests and documentation for the new strategy.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt         |   12 +++-
 builtin/notes.c                     |    8 ++-
 notes-merge.c                       |    6 ++
 notes-merge.h                       |    3 +-
 notes.c                             |   76 ++++++++++++++++++
 notes.h                             |    1 +
 t/t3309-notes-merge-auto-resolve.sh |  145 +++++++++++++++++++++++++++++++++++
 7 files changed, 247 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index a822551..1de1417 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -155,7 +155,7 @@ OPTIONS
 --strategy=<strategy>::
 	When merging notes, resolve notes conflicts using the given
 	strategy. The following strategies are recognized: "manual"
-	(default), "ours", "theirs" and "union".
+	(default), "ours", "theirs", "union" and "cat_sort_uniq".
 	See the "NOTES MERGE STRATEGIES" section below for more
 	information on each notes merge strategy.
 
@@ -230,6 +230,16 @@ ref).
 "union" automatically resolves notes conflicts by concatenating the
 local and remote versions.
 
+"cat_sort_uniq" is similar to "union", but in addition to concatenating
+the local and remote versions, this strategy also sorts the resulting
+lines, and removes duplicate lines from the result. This is equivalent
+to applying the "cat | sort | uniq" shell pipeline to the local and
+remote versions. This strategy is useful if the notes follow a line-based
+format where one wants to avoid duplicated lines in the merge result.
+Note that if either the local or remote version contain duplicate lines
+prior to the merge, these will also be removed by this notes merge
+strategy.
+
 
 EXAMPLES
 --------
diff --git a/builtin/notes.c b/builtin/notes.c
index ca09d45..79783a5 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -324,6 +324,8 @@ combine_notes_fn parse_combine_notes_fn(const char *v)
 		return combine_notes_ignore;
 	else if (!strcasecmp(v, "concatenate"))
 		return combine_notes_concatenate;
+	else if (!strcasecmp(v, "cat_sort_uniq"))
+		return combine_notes_cat_sort_uniq;
 	else
 		return NULL;
 }
@@ -846,8 +848,8 @@ static int merge(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSITY(&verbosity),
 		OPT_GROUP("Merge options"),
 		OPT_STRING('s', "strategy", &strategy, "strategy",
-			   "resolve notes conflicts using the given "
-			   "strategy (manual/ours/theirs/union)"),
+			   "resolve notes conflicts using the given strategy "
+			   "(manual/ours/theirs/union/cat_sort_uniq)"),
 		OPT_GROUP("Committing unmerged notes"),
 		{ OPTION_BOOLEAN, 0, "commit", &do_commit, NULL,
 			"finalize notes merge by committing unmerged notes",
@@ -899,6 +901,8 @@ static int merge(int argc, const char **argv, const char *prefix)
 			o.strategy = NOTES_MERGE_RESOLVE_THEIRS;
 		else if (!strcmp(strategy, "union"))
 			o.strategy = NOTES_MERGE_RESOLVE_UNION;
+		else if (!strcmp(strategy, "cat_sort_uniq"))
+			o.strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
 		else {
 			error("Unknown -s/--strategy: %s", strategy);
 			usage_with_options(git_notes_merge_usage, options);
diff --git a/notes-merge.c b/notes-merge.c
index db4fe08..d112a91 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -452,6 +452,12 @@ static int merge_one_change(struct notes_merge_options *o,
 		if (add_note(t, p->obj, p->remote, combine_notes_concatenate))
 			die("confused: combine_notes_concatenate failed");
 		return 0;
+	case NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ:
+		OUTPUT(o, 2, "Concatenating unique lines in local and remote "
+		       "notes for %s", sha1_to_hex(p->obj));
+		if (add_note(t, p->obj, p->remote, combine_notes_cat_sort_uniq))
+			die("confused: combine_notes_cat_sort_uniq failed");
+		return 0;
 	}
 	die("Unknown strategy (%i).", o->strategy);
 }
diff --git a/notes-merge.h b/notes-merge.h
index 195222f..168a672 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -17,7 +17,8 @@ struct notes_merge_options {
 		NOTES_MERGE_RESOLVE_MANUAL = 0,
 		NOTES_MERGE_RESOLVE_OURS,
 		NOTES_MERGE_RESOLVE_THEIRS,
-		NOTES_MERGE_RESOLVE_UNION
+		NOTES_MERGE_RESOLVE_UNION,
+		NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ
 	} strategy;
 	unsigned has_worktree:1;
 };
diff --git a/notes.c b/notes.c
index 09a93ab..96cde42 100644
--- a/notes.c
+++ b/notes.c
@@ -845,6 +845,82 @@ int combine_notes_ignore(unsigned char *cur_sha1,
 	return 0;
 }
 
+static int string_list_add_note_lines(struct string_list *sort_uniq_list,
+				      const unsigned char *sha1)
+{
+	char *data;
+	unsigned long len;
+	enum object_type t;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf **lines = NULL;
+	int i, list_index;
+
+	if (is_null_sha1(sha1))
+		return 0;
+
+	/* read_sha1_file NUL-terminates */
+	data = read_sha1_file(sha1, &t, &len);
+	if (t != OBJ_BLOB || !data || !len) {
+		free(data);
+		return t != OBJ_BLOB || !data;
+	}
+
+	strbuf_attach(&buf, data, len, len + 1);
+	lines = strbuf_split(&buf, '\n');
+
+	for (i = 0; lines[i]; i++) {
+		if (lines[i]->buf[lines[i]->len - 1] == '\n')
+			strbuf_setlen(lines[i], lines[i]->len - 1);
+		if (!lines[i]->len)
+			continue; /* skip empty lines */
+		list_index = string_list_find_insert_index(sort_uniq_list,
+							   lines[i]->buf, 0);
+		if (list_index < 0)
+			continue; /* skip duplicate lines */
+		string_list_insert_at_index(sort_uniq_list, list_index,
+					    lines[i]->buf);
+	}
+
+	strbuf_list_free(lines);
+	strbuf_release(&buf);
+	return 0;
+}
+
+static int string_list_join_lines_helper(struct string_list_item *item,
+					 void *cb_data)
+{
+	struct strbuf *buf = cb_data;
+	strbuf_addstr(buf, item->string);
+	strbuf_addch(buf, '\n');
+	return 0;
+}
+
+int combine_notes_cat_sort_uniq(unsigned char *cur_sha1,
+		const unsigned char *new_sha1)
+{
+	struct string_list sort_uniq_list = { NULL, 0, 0, 1 };
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 1;
+
+	/* read both note blob objects into unique_lines */
+	if (string_list_add_note_lines(&sort_uniq_list, cur_sha1))
+		goto out;
+	if (string_list_add_note_lines(&sort_uniq_list, new_sha1))
+		goto out;
+
+	/* create a new blob object from sort_uniq_list */
+	if (for_each_string_list(&sort_uniq_list,
+				 string_list_join_lines_helper, &buf))
+		goto out;
+
+	ret = write_sha1_file(buf.buf, buf.len, blob_type, cur_sha1);
+
+out:
+	strbuf_release(&buf);
+	string_list_clear(&sort_uniq_list, 0);
+	return ret;
+}
+
 static int string_list_add_one_ref(const char *path, const unsigned char *sha1,
 				   int flag, void *cb)
 {
diff --git a/notes.h b/notes.h
index b372575..93a7365 100644
--- a/notes.h
+++ b/notes.h
@@ -27,6 +27,7 @@ typedef int (*combine_notes_fn)(unsigned char *cur_sha1, const unsigned char *ne
 int combine_notes_concatenate(unsigned char *cur_sha1, const unsigned char *new_sha1);
 int combine_notes_overwrite(unsigned char *cur_sha1, const unsigned char *new_sha1);
 int combine_notes_ignore(unsigned char *cur_sha1, const unsigned char *new_sha1);
+int combine_notes_cat_sort_uniq(unsigned char *cur_sha1, const unsigned char *new_sha1);
 
 /*
  * Notes tree object
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index 1a1fc7e..461fd84 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -499,4 +499,149 @@ test_expect_success 'merge z into y with "union" strategy => Non-conflicting 3-w
 	verify_notes y union
 '
 
+test_expect_success 'reset to pre-merge state (y)' '
+	git update-ref refs/notes/y refs/notes/y^1 &&
+	# Verify pre-merge state
+	verify_notes y y
+'
+
+cat <<EOF | sort >expect_notes_union2
+d682107b8bf7a7aea1e537a8d5cb6a12b60135f1 $commit_sha15
+5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
+3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc $commit_sha13
+a66055fa82f7a03fe0c02a6aba3287a85abf7c62 $commit_sha12
+7e3c53503a3db8dd996cb62e37c66e070b44b54d $commit_sha11
+b8d03e173f67f6505a76f6e00cf93440200dd9be $commit_sha10
+851e1638784a884c7dd26c5d41f3340f6387413a $commit_sha8
+357b6ca14c7afd59b7f8b8aaaa6b8b723771135b $commit_sha5
+e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
+5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
+283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+EOF
+
+cat >expect_log_union2 <<EOF
+$commit_sha15 15th
+z notes on 15th commit
+
+y notes on 15th commit
+
+$commit_sha14 14th
+y notes on 14th commit
+
+$commit_sha13 13th
+y notes on 13th commit
+
+$commit_sha12 12th
+y notes on 12th commit
+
+$commit_sha11 11th
+z notes on 11th commit
+
+$commit_sha10 10th
+x notes on 10th commit
+
+$commit_sha9 9th
+
+$commit_sha8 8th
+z notes on 8th commit
+
+$commit_sha7 7th
+
+$commit_sha6 6th
+
+$commit_sha5 5th
+z notes on 5th commit
+
+y notes on 5th commit
+
+$commit_sha4 4th
+y notes on 4th commit
+
+$commit_sha3 3rd
+y notes on 3rd commit
+
+$commit_sha2 2nd
+z notes on 2nd commit
+
+$commit_sha1 1st
+
+EOF
+
+test_expect_success 'merge y into z with "union" strategy => Non-conflicting 3-way merge' '
+	git config core.notesRef refs/notes/z &&
+	git notes merge --strategy=union y &&
+	verify_notes z union2
+'
+
+test_expect_success 'reset to pre-merge state (z)' '
+	git update-ref refs/notes/z refs/notes/z^1 &&
+	# Verify pre-merge state
+	verify_notes z z
+'
+
+cat <<EOF | sort >expect_notes_cat_sort_uniq
+6be90240b5f54594203e25d9f2f64b7567175aee $commit_sha15
+5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
+3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc $commit_sha13
+a66055fa82f7a03fe0c02a6aba3287a85abf7c62 $commit_sha12
+7e3c53503a3db8dd996cb62e37c66e070b44b54d $commit_sha11
+b8d03e173f67f6505a76f6e00cf93440200dd9be $commit_sha10
+851e1638784a884c7dd26c5d41f3340f6387413a $commit_sha8
+660311d7f78dc53db12ac373a43fca7465381a7e $commit_sha5
+e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
+5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
+283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+EOF
+
+cat >expect_log_cat_sort_uniq <<EOF
+$commit_sha15 15th
+y notes on 15th commit
+z notes on 15th commit
+
+$commit_sha14 14th
+y notes on 14th commit
+
+$commit_sha13 13th
+y notes on 13th commit
+
+$commit_sha12 12th
+y notes on 12th commit
+
+$commit_sha11 11th
+z notes on 11th commit
+
+$commit_sha10 10th
+x notes on 10th commit
+
+$commit_sha9 9th
+
+$commit_sha8 8th
+z notes on 8th commit
+
+$commit_sha7 7th
+
+$commit_sha6 6th
+
+$commit_sha5 5th
+y notes on 5th commit
+z notes on 5th commit
+
+$commit_sha4 4th
+y notes on 4th commit
+
+$commit_sha3 3rd
+y notes on 3rd commit
+
+$commit_sha2 2nd
+z notes on 2nd commit
+
+$commit_sha1 1st
+
+EOF
+
+test_expect_success 'merge y into z with "cat_sort_uniq" strategy => Non-conflicting 3-way merge' '
+	git notes merge --strategy=cat_sort_uniq y &&
+	verify_notes z cat_sort_uniq
+'
+
 test_done
-- 
1.7.3.98.g5ad7d9
