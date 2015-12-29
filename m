From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2] notes: allow merging from arbitrary references
Date: Tue, 29 Dec 2015 14:40:28 -0800
Message-ID: <1451428828-23714-1-git-send-email-jacob.e.keller@intel.com>
Cc: Mike Hommey <mh@glandium.org>, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 23:40:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE2wX-0002kE-1J
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 23:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbbL2Wkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 17:40:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:13941 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbbL2Wkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 17:40:31 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 29 Dec 2015 14:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,497,1444719600"; 
   d="scan'208";a="871456740"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2015 14:40:32 -0800
X-Mailer: git-send-email 2.6.3.505.g5cc1fd1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283156>

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

Notes:
    - v2
    * don't expand notes-ref to the sha1, in order to support get-ref better
    * fix failed tests due to mis-use of argv[0] instead of remote_ref.buf

 builtin/notes.c        |  2 +-
 notes.c                | 10 ++++++++++
 notes.h                |  7 +++++++
 t/t3308-notes-merge.sh | 22 +++++++++++-----------
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 515cebbeb8a3..c090e33dcadb 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -806,7 +806,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	o.local_ref = default_notes_ref();
 	strbuf_addstr(&remote_ref, argv[0]);
-	expand_notes_ref(&remote_ref);
+	expand_loose_notes_ref(&remote_ref);
 	o.remote_ref = remote_ref.buf;
 
 	t = init_notes_check("merge");
diff --git a/notes.c b/notes.c
index db77922130b4..086cc483e518 100644
--- a/notes.c
+++ b/notes.c
@@ -1303,3 +1303,13 @@ void expand_notes_ref(struct strbuf *sb)
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
index 2a3f92338076..431f14378817 100644
--- a/notes.h
+++ b/notes.h
@@ -294,4 +294,11 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
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
