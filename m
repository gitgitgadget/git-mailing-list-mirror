From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2] notes: allow merging from arbitrary references
Date: Fri, 20 Nov 2015 10:51:09 -0800
Message-ID: <1448045469-12971-1-git-send-email-jacob.e.keller@intel.com>
Cc: Mike Hommey <mh@glandium.org>, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 19:51:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzqmp-0006h7-1G
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 19:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbbKTSvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 13:51:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:38380 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759545AbbKTSvc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 13:51:32 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 20 Nov 2015 10:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,323,1444719600"; 
   d="scan'208";a="843655818"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by fmsmga001.fm.intel.com with ESMTP; 20 Nov 2015 10:51:12 -0800
X-Mailer: git-send-email 2.6.3.505.g5cc1fd1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281527>

From: Jacob Keller <jacob.keller@gmail.com>

Create a new expansion function, expand_loose_notes_ref which will first
check whether the ref can be found using get_sha1. If it can't be found
then it will fallback to using expand_notes_ref. The content of the
strbuf will not be changed if the notes ref can be located using
get_sha1. Otherwise, it may be updated as done by expand_notes_ref.

Since we now support merging from non-notes refs, remove the test case
associated with that behavior. Add a test case for merging from a
non-notes ref.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

Since we already use get_sha1 inside the notes machinery, there is
little reason to expand get_sha1's object back into a strbuf so we can
just drop that code which will make expand_loose_notes_ref a little more
sane. This should be useful if we want to use expand_loose_notes_ref in
the future for non-write operations.

Notes:
    - v2
    * don't expand notes-ref to the sha1, in order to support get-ref better

 builtin/notes.c        |  4 ++--
 notes.c                | 10 ++++++++++
 notes.h                |  7 +++++++
 t/t3308-notes-merge.sh | 22 +++++++++++-----------
 4 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index e0f5d308d206..4a86cc90ee92 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -809,7 +809,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	o.local_ref = default_notes_ref();
 	strbuf_addstr(&remote_ref, argv[0]);
-	expand_notes_ref(&remote_ref);
+	expand_loose_notes_ref(&remote_ref);
 	o.remote_ref = remote_ref.buf;
 
 	t = init_notes_check("merge", NOTES_INIT_WRITABLE);
@@ -836,7 +836,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 	}
 
 	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
-		    remote_ref.buf, default_notes_ref());
+		    argv[0], default_notes_ref());
 	strbuf_add(&(o.commit_msg), msg.buf + 7, msg.len - 7); /* skip "notes: " */
 
 	result = notes_merge(&o, t, result_sha1);
diff --git a/notes.c b/notes.c
index 358e2fdb74eb..c1e503559076 100644
--- a/notes.c
+++ b/notes.c
@@ -1306,3 +1306,13 @@ void expand_notes_ref(struct strbuf *sb)
 	else
 		strbuf_insert(sb, 0, "refs/notes/", 11);
 }
+
+void expand_loose_notes_ref(struct strbuf *sb)
+{
+	unsigned char object[20];
+
+	if (get_sha1(sb->buf, object)) {
+		/* fallback to expand_notes_ref */
+		expand_notes_ref(sb);
+	}
+}
diff --git a/notes.h b/notes.h
index e5d67fd3754a..5345642cfd1c 100644
--- a/notes.h
+++ b/notes.h
@@ -302,4 +302,11 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 /* Expand inplace a note ref like "foo" or "notes/foo" into "refs/notes/foo" */
 void expand_notes_ref(struct strbuf *sb);
 
+/*
+ * Similar to expand_notes_ref, but will check whether the ref can be located
+ * via get_sha1 first, and only falls back to expand_notes_ref in the case
+ * where get_sha1 fails.
+ */
+void expand_loose_notes_ref(struct strbuf *sb);
+
 #endif
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 24d82b49bbea..19aed7ec953b 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -18,7 +18,9 @@ test_expect_success setup '
 	git notes add -m "Notes on 1st commit" 1st &&
 	git notes add -m "Notes on 2nd commit" 2nd &&
 	git notes add -m "Notes on 3rd commit" 3rd &&
-	git notes add -m "Notes on 4th commit" 4th
+	git notes add -m "Notes on 4th commit" 4th &&
+	# Copy notes to remote-notes
+	git fetch . refs/notes/*:refs/remote-notes/origin/*
 '
 
 commit_sha1=$(git rev-parse 1st^{commit})
@@ -66,7 +68,9 @@ test_expect_success 'verify initial notes (x)' '
 '
 
 cp expect_notes_x expect_notes_y
+cp expect_notes_x expect_notes_v
 cp expect_log_x expect_log_y
+cp expect_log_x expect_log_v
 
 test_expect_success 'fail to merge empty notes ref into empty notes ref (z => y)' '
 	test_must_fail git -c "core.notesRef=refs/notes/y" notes merge z
@@ -84,16 +88,12 @@ test_expect_success 'fail to merge into various non-notes refs' '
 	test_must_fail git -c "core.notesRef=refs/notes/foo^{bar" notes merge x
 '
 
-test_expect_success 'fail to merge various non-note-trees' '
-	git config core.notesRef refs/notes/y &&
-	test_must_fail git notes merge refs/notes &&
-	test_must_fail git notes merge refs/notes/ &&
-	test_must_fail git notes merge refs/notes/dir &&
-	test_must_fail git notes merge refs/notes/dir/ &&
-	test_must_fail git notes merge refs/heads/master &&
-	test_must_fail git notes merge x: &&
-	test_must_fail git notes merge x:foo &&
-	test_must_fail git notes merge foo^{bar
+test_expect_success 'merge non-notes ref into empty notes ref (remote-notes/origin/x => v)' '
+	git config core.notesRef refs/notes/v &&
+	git notes merge refs/remote-notes/origin/x &&
+	verify_notes v &&
+	# refs/remote-notes/origin/x and v should point to the same notes commit
+	test "$(git rev-parse refs/remote-notes/origin/x)" = "$(git rev-parse refs/notes/v)"
 '
 
 test_expect_success 'merge notes into empty notes ref (x => y)' '
-- 
2.6.3.505.g5cc1fd1
