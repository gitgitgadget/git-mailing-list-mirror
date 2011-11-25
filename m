From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 3/3] fast-import: Fix incorrect fanout level when modifying
 existing notes refs
Date: Fri, 25 Nov 2011 01:09:47 +0100
Message-ID: <1322179787-4422-4-git-send-email-johan@herland.net>
References: <Pine.GSO.4.63.1111231137350.5099@shipon.roxen.com>
 <1322179787-4422-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, jrnieder@gmail.com, johan@herland.net
To: grubba@grubba.org
X-From: git-owner@vger.kernel.org Fri Nov 25 02:10:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTkJ1-0006dq-2Z
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 02:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259Ab1KYBKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 20:10:09 -0500
Received: from smtp.getmail.no ([84.208.15.66]:55121 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995Ab1KYBKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 20:10:07 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Nov 2011 20:10:04 EST
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LV600HDHWGPGC60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 25 Nov 2011 01:10:01 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id AAC691799141_ECEDCD9B	for <git@vger.kernel.org>; Fri,
 25 Nov 2011 00:10:01 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 24F411796390_ECEDCD9F	for <git@vger.kernel.org>; Fri,
 25 Nov 2011 00:10:01 +0000 (GMT)
Received: from alpha.herland ([84.208.177.71]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LV600D70WGNSC30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 25 Nov 2011 01:10:00 +0100 (MET)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1322179787-4422-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185920>

This fixes the bug uncovered by the tests added in the previous two patches.

When an existing notes ref was loaded into the fast-import machinery, the
num_notes counter associated with that ref remained == 0, even though the
true number of notes in the loaded ref was higher. This caused a fanout
level of 0 to be used, although the actual fanout of the tree could be > 0.
Manipulating the notes tree at an incorrect fanout level causes removals to
silently fail, and modifications of existing notes to instead produce an
additional note (leaving the old object in place at a different fanout level).

This patch fixes the bug by explicitly counting the number of notes in the
notes tree whenever it looks like the num_notes counter could be wrong (when
num_notes == 0). There may be false positives (i.e. triggering the counting
when the notes tree is truly empty), but in those cases, the counting should
not take long.

Signed-off-by: Johan Herland <johan@herland.net>
---
 fast-import.c                |   28 +++++++++++++++++++++++++---
 t/t9301-fast-import-notes.sh |    8 ++++----
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 8d8ea3c..f4bfe0f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2173,6 +2173,11 @@ static uintmax_t do_change_note_fanout(
 
 		if (tmp_hex_sha1_len == 40 && !get_sha1_hex(hex_sha1, sha1)) {
 			/* This is a note entry */
+			if (fanout == 0xff) {
+				/* Counting mode, no rename */
+				num_notes++;
+				continue;
+			}
 			construct_path_with_fanout(hex_sha1, fanout, realpath);
 			if (!strcmp(fullpath, realpath)) {
 				/* Note entry is in correct location */
@@ -2379,7 +2384,7 @@ static void file_change_cr(struct branch *b, int rename)
 		leaf.tree);
 }
 
-static void note_change_n(struct branch *b, unsigned char old_fanout)
+static void note_change_n(struct branch *b, unsigned char *old_fanout)
 {
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
@@ -2390,6 +2395,23 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 	uint16_t inline_data = 0;
 	unsigned char new_fanout;
 
+	/*
+	 * When loading a branch, we don't traverse its tree to count the real
+	 * number of notes (too expensive to do this for all non-note refs).
+	 * This means that recently loaded notes refs might incorrectly have
+	 * b->num_notes == 0, and consequently, old_fanout might be wrong.
+	 *
+	 * Fix this by traversing the tree and counting the number of notes
+	 * when b->num_notes == 0. If the notes tree is truly empty, the
+	 * calculation should not take long.
+	 */
+	if (b->num_notes == 0 && *old_fanout == 0) {
+		/* Invoke change_note_fanout() in "counting mode". */
+		b->num_notes = change_note_fanout(&b->branch_tree, 0xff);
+		*old_fanout = convert_num_notes_to_fanout(b->num_notes);
+	}
+
+	/* Now parse the notemodify command. */
 	/* <dataref> or 'inline' */
 	if (*p == ':') {
 		char *x;
@@ -2450,7 +2472,7 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 			    typename(type), command_buf.buf);
 	}
 
-	construct_path_with_fanout(sha1_to_hex(commit_sha1), old_fanout, path);
+	construct_path_with_fanout(sha1_to_hex(commit_sha1), *old_fanout, path);
 	if (tree_content_remove(&b->branch_tree, path, NULL))
 		b->num_notes--;
 
@@ -2637,7 +2659,7 @@ static void parse_new_commit(void)
 		else if (!prefixcmp(command_buf.buf, "C "))
 			file_change_cr(b, 0);
 		else if (!prefixcmp(command_buf.buf, "N "))
-			note_change_n(b, prev_fanout);
+			note_change_n(b, &prev_fanout);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
 		else if (!prefixcmp(command_buf.buf, "ls "))
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 57d85a6..83acf68 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -536,7 +536,7 @@ EXPECT_END
 	j=$(($j + 1))
 done
 
-test_expect_failure 'change a few existing notes' '
+test_expect_success 'change a few existing notes' '
 
 	git fast-import <input &&
 	GIT_NOTES_REF=refs/notes/many_notes git log -n3 refs/heads/many_commits |
@@ -545,7 +545,7 @@ test_expect_failure 'change a few existing notes' '
 
 '
 
-test_expect_failure 'verify that changing notes respect existing fanout' '
+test_expect_success 'verify that changing notes respect existing fanout' '
 
 	# None of the entries in the top-level notes tree should be a full SHA1
 	git ls-tree --name-only refs/notes/many_notes |
@@ -594,7 +594,7 @@ EXPECT_END
 	i=$(($i - 1))
 done
 
-test_expect_failure 'remove lots of notes' '
+test_expect_success 'remove lots of notes' '
 
 	git fast-import <input &&
 	GIT_NOTES_REF=refs/notes/many_notes git log refs/heads/many_commits |
@@ -603,7 +603,7 @@ test_expect_failure 'remove lots of notes' '
 
 '
 
-test_expect_failure 'verify that removing notes trigger fanout consolidation' '
+test_expect_success 'verify that removing notes trigger fanout consolidation' '
 
 	# All entries in the top-level notes tree should be a full SHA1
 	git ls-tree --name-only -r refs/notes/many_notes |
-- 
1.7.5.rc1.3.g4d7b
