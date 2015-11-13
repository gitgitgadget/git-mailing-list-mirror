From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] notes: allow merging from arbitrary references
Date: Fri, 13 Nov 2015 08:34:22 -0800
Message-ID: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
Cc: Mike Hommey <mh@glandium.org>, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 17:34:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxHJ2-0002rp-NM
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 17:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001AbbKMQe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 11:34:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:23457 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932616AbbKMQe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 11:34:27 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 13 Nov 2015 08:34:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,288,1444719600"; 
   d="scan'208";a="849909124"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2015 08:34:26 -0800
X-Mailer: git-send-email 2.6.1.264.gbab76a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281254>

From: Jacob Keller <jacob.keller@gmail.com>

Create a new expansion function, expand_loose_notes_ref which will
expand any ref using get_sha1, but falls back to expand_notes_ref if
this fails. The contents of the strbuf will be either the hex string of
the sha1, or the expanded notes ref. It is expected to be re-expanded
using get_sha1 inside the notes merge machinery, and there is no real
error checking provided at this layer.

Since we now support merging from non-notes refs, remove the test case
associated with that behavior. Add a test case for merging from a
non-notes ref.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
I do not remember what version this was since it has been an age ago
that I sent the previous code. This is mostly just a rebase onto current
next. I believe I have covered everything previous reviewers noted.

I'm interested in whether this is the right direction, as my longterm
goal is to be able to push/pull notes to a specific namespace (probably
refs/remote-notes/*, since actually modifying to use
refs/remotes/notes/* is difficult to send to users, and remote-notes
makes the most useful sense). The first part of this is allowing merge
to come from an arbitrary reference, as currently it is not really
possible to merge from refs/remote-notes as we'd need it to be.

 builtin/notes.c        |  4 ++--
 notes.c                | 14 ++++++++++++++
 notes.h                |  8 ++++++++
 t/t3308-notes-merge.sh | 22 +++++++++++-----------
 4 files changed, 35 insertions(+), 13 deletions(-)

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
index 358e2fdb74eb..c92c22aa217a 100644
--- a/notes.c
+++ b/notes.c
@@ -1306,3 +1306,17 @@ void expand_notes_ref(struct strbuf *sb)
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
+	} else {
+		/* we got an object, so replace the strbuf with the hex string */
+		strbuf_reset(sb);
+		strbuf_addstr(sb, sha1_to_hex(object));
+	}
+}
diff --git a/notes.h b/notes.h
index e5d67fd3754a..658caf7d6e99 100644
--- a/notes.h
+++ b/notes.h
@@ -302,4 +302,12 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 /* Expand inplace a note ref like "foo" or "notes/foo" into "refs/notes/foo" */
 void expand_notes_ref(struct strbuf *sb);
 
+/*
+ * Similar to expand_notes_ref, but allows arbitrary refs to be expanded via
+ * get_sha1 first. If get_sha1 fails to find a ref, fall back to traditional
+ * expand_notes_ref. The contents of the strbuf will be suitable to attempt
+ * passing to get_sha1 again inside the notes machinery.
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
2.6.1.264.gbab76a9
