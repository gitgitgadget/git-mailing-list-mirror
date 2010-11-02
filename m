From: Kenny Root <kroot@google.com>
Subject: [PATCH v2] Remove restriction on notes ref base
Date: Tue,  2 Nov 2010 10:22:12 -0700
Message-ID: <1288718532-11939-1-git-send-email-kroot@google.com>
Cc: Kenny Root <kroot@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 18:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDKYz-0007tD-0k
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 18:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940Ab0KBRWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 13:22:19 -0400
Received: from smtp-out.google.com ([216.239.44.51]:48478 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab0KBRWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 13:22:17 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id oA2HMFbq023292
	for <git@vger.kernel.org>; Tue, 2 Nov 2010 10:22:16 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1288718536; bh=jT/mqARHzjSWqSi6qsvCfJ9htRw=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=RmU0Hm6YfRPq/AuXcsjrJG2D3TrK4MjIhQOX7w1XkChIrTTU2geG4RbrDjR0ABIXe
	 SXP+9Po65mycMVKkOmS+A==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=from:to:cc:subject:date:message-id:x-mailer;
	b=ayGRZl6azcC3dmxlzZ13FNZ/fCQtuAjUzj6dznbDWfJZWQPERT9i2pbskuzkd/A7R
	MTom2PToBX01JTxHDwhbQ==
Received: from kroot.mtv.corp.google.com (kroot.mtv.corp.google.com [172.18.103.3])
	by hpaq1.eem.corp.google.com with ESMTP id oA2HMDLH027760;
	Tue, 2 Nov 2010 10:22:14 -0700
X-Mailer: git-send-email 1.7.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160541>

Git notes were restricted to refs/notes/* in the command line utilities,
but setting things like GIT_NOTES_REF to something outside of that
structure would work.

This removes the restrictions on the git notes command line interface
and adds checks to make sure the branch appears to be a notes branch
before adding notes.

Signed-off-by: Kenny Root <kroot@google.com>
---
 builtin/notes.c  |   11 ++---------
 notes.c          |   12 ++++++++++++
 t/t3301-notes.sh |   12 ++++++------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 6d07aac..9acce7b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -343,11 +343,7 @@ static int notes_rewrite_config(const char *k, const char *v, void *cb)
 	} else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
 		/* note that a refs/ prefix is implied in the
 		 * underlying for_each_glob_ref */
-		if (!prefixcmp(v, "refs/notes/"))
-			string_list_add_refs_by_glob(c->refs, v);
-		else
-			warning("Refusing to rewrite notes in %s"
-				" (outside of refs/notes/)", v);
+		string_list_add_refs_by_glob(c->refs, v);
 		return 0;
 	}
 
@@ -473,9 +469,6 @@ static struct notes_tree *init_notes_check(const char *subcommand)
 	init_notes(NULL, NULL, NULL, 0);
 	t = &default_notes_tree;
 
-	if (prefixcmp(t->ref, "refs/notes/"))
-		die("Refusing to %s notes in %s (outside of refs/notes/)",
-		    subcommand, t->ref);
 	return t;
 }
 
@@ -844,7 +837,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	if (override_notes_ref) {
 		struct strbuf sb = STRBUF_INIT;
-		if (!prefixcmp(override_notes_ref, "refs/notes/"))
+		if (!prefixcmp(override_notes_ref, "refs/"))
 			/* we're happy */;
 		else if (!prefixcmp(override_notes_ref, "notes/"))
 			strbuf_addstr(&sb, "refs/");
diff --git a/notes.c b/notes.c
index 70d0013..92c9c35 100644
--- a/notes.c
+++ b/notes.c
@@ -940,6 +940,18 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	hashclr(root_tree.key_sha1);
 	hashcpy(root_tree.val_sha1, sha1);
 	load_subtree(t, &root_tree, t->root, 0);
+
+	unsigned int i, empty_tree = 1;
+	for (i = 0; i < 16; i++) {
+		if (t->root->a[i]) {
+			empty_tree = 0;
+			break;
+		}
+	}
+
+	/* If no notes and >0 non-notes, this is probably not a notes tree */
+	if (empty_tree && t->first_non_note)
+		die("'%s' doesn't look like a valid notes tree", t->ref);
 }
 
 struct notes_tree **load_notes_trees(struct string_list *refs)
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index a2b79a0..df98db6 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -38,16 +38,16 @@ test_expect_success 'need valid notes ref' '
 	 test_must_fail git notes show)
 '
 
-test_expect_success 'refusing to add notes in refs/heads/' '
-	(MSG=1 GIT_NOTES_REF=refs/heads/bogus &&
+test_expect_success 'allowing user to add notes outside of refs/notes/' '
+	(MSG=1 GIT_NOTES_REF=refs/meta/foo &&
 	 export MSG GIT_NOTES_REF &&
-	 test_must_fail git notes add)
+	 git notes add)
 '
 
-test_expect_success 'refusing to edit notes in refs/remotes/' '
-	(MSG=1 GIT_NOTES_REF=refs/remotes/bogus &&
+test_expect_success 'refusing to add notes to a non-note branch' '
+	(MSG=1 GIT_NOTES_REF=refs/heads/master &&
 	 export MSG GIT_NOTES_REF &&
-	 test_must_fail git notes edit)
+	 test_must_fail git notes add)
 '
 
 # 1 indicates caught gracefully by die, 128 means git-show barked
-- 
1.7.3.1
