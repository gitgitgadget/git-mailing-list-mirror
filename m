From: Johan Herland <johan@herland.net>
Subject: [PATCH 15/18] git notes merge: List conflicting notes in notes merge
 commit message
Date: Wed, 29 Sep 2010 02:23:28 +0200
Message-ID: <1285719811-10871-16-git-send-email-johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 02:24:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0kTT-0001F0-0G
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 02:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab0I2AYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 20:24:06 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44298 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491Ab0I2AX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 20:23:56 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H0030JFRPTS80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:49 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 9BEF21EEF879_CA28715B	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:49 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 324231EEF859_CA28715F	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:48 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H00IQEFRHZC10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:43 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1285719811-10871-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157508>

This brings notes merge in line with regular merge's behaviour.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c                       |    2 +-
 notes-merge.c                         |   11 ++++++++++-
 notes-merge.h                         |    2 +-
 t/t3310-notes-merge-manual-resolve.sh |   12 ++++++++++++
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 8be7d9e..961dcbf 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -902,7 +902,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
 		    remote_ref.buf, default_notes_ref());
-	o.commit_msg = msg.buf + 7; // skip "notes: " prefix
+	strbuf_add(&(o.commit_msg), msg.buf + 7, msg.len - 7); // skip "notes: "
 
 	result = notes_merge(&o, t, result_sha1);
 
diff --git a/notes-merge.c b/notes-merge.c
index cf1f8da..8b34a32 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -7,6 +7,7 @@
 #include "dir.h"
 #include "notes.h"
 #include "notes-merge.h"
+#include "strbuf.h"
 
 struct notes_merge_pair {
 	unsigned char obj[20], base[20], local[20], remote[20];
@@ -15,6 +16,7 @@ struct notes_merge_pair {
 void init_notes_merge_options(struct notes_merge_options *o)
 {
 	memset(o, 0, sizeof(struct notes_merge_options));
+	strbuf_init(&(o->commit_msg), 0);
 	o->verbosity = 2;
 }
 
@@ -383,6 +385,12 @@ static int merge_one_change_manual(struct notes_merge_options *o,
 	       sha1_to_hex(p->obj), sha1_to_hex(p->base),
 	       sha1_to_hex(p->local), sha1_to_hex(p->remote));
 
+	/* add "Conflicts:" section to commit message first time through */
+	if (!o->has_worktree)
+		strbuf_addstr(&(o->commit_msg), "\n\nConflicts:\n");
+
+	strbuf_addf(&(o->commit_msg), "\t%s\n", sha1_to_hex(p->obj));
+
 	OUTPUT(o, 2, "Auto-merging notes for %s", sha1_to_hex(p->obj));
 	check_notes_merge_worktree(o);
 	if (is_null_sha1(p->local)) {
@@ -622,12 +630,13 @@ int notes_merge(struct notes_merge_options *o,
 		struct commit_list *parents = NULL;
 		commit_list_insert(remote, &parents); /* LIFO order */
 		commit_list_insert(local, &parents);
-		create_notes_commit(local_tree, parents, o->commit_msg,
+		create_notes_commit(local_tree, parents, o->commit_msg.buf,
 				    result_sha1);
 	}
 
 found_result:
 	free_commit_list(bases);
+	strbuf_release(&(o->commit_msg));
 	OUTPUT(o, 5, "notes_merge(): result = %i, result_sha1 = %.7s",
 	       result, sha1_to_hex(result_sha1));
 	return result;
diff --git a/notes-merge.h b/notes-merge.h
index e2f3459..a6ccb6a 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -6,7 +6,7 @@
 struct notes_merge_options {
 	const char *local_ref;
 	const char *remote_ref;
-	const char *commit_msg;
+	struct strbuf commit_msg;
 	int verbosity;
 	enum {
 		NOTES_MERGE_RESOLVE_MANUAL = 0,
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 1db0649..8568307 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -333,6 +333,12 @@ EOF
 	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
 	grep -q refs/notes/m merge_commit_msg &&
 	grep -q refs/notes/z merge_commit_msg &&
+	# Merge commit mentions conflicting notes
+	grep -q "Conflicts" merge_commit_msg &&
+	( for sha1 in $(cat expect_conflicts); do
+		grep -q "$sha1" merge_commit_msg ||
+		exit 1
+	done ) &&
 	# Verify contents of merge result
 	verify_notes m &&
 	# Verify that other notes refs has not changed (w, x, y and z)
@@ -456,6 +462,12 @@ EOF
 	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
 	grep -q refs/notes/m merge_commit_msg &&
 	grep -q refs/notes/z merge_commit_msg &&
+	# Merge commit mentions conflicting notes
+	grep -q "Conflicts" merge_commit_msg &&
+	( for sha1 in $(cat expect_conflicts); do
+		grep -q "$sha1" merge_commit_msg ||
+		exit 1
+	done ) &&
 	# Verify contents of merge result
 	verify_notes m &&
 	# Verify that other notes refs has not changed (w, x, y and z)
-- 
1.7.3.98.g5ad7d9
