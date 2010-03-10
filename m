From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6 12/13] notes: track whether notes_trees were changed at all
Date: Wed, 10 Mar 2010 15:05:59 +0100
Message-ID: <f4ef87cbd1f0bb98d8c8d2cc7dd6d3e417ec2875.1268229087.git.trast@student.ethz.ch>
References: <cover.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 10 15:06:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpMYo-0004t1-T7
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 15:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407Ab0CJOGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 09:06:20 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7926 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932403Ab0CJOGS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 09:06:18 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:06:05 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Mar
 2010 15:06:02 +0100
X-Mailer: git-send-email 1.7.0.2.407.g21ebda
In-Reply-To: <cover.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141896>

Currently, the notes copying is a bit wasteful since it always creates
new trees, even if no notes were copied at all.

Teach add_note() and remove_note() to flag the affected notes tree as
changed ('dirty').  Then teach builtin/notes.c to use this knowledge
and avoid committing trees that weren't changed.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

New in this iteration

 builtin/notes.c |    2 ++
 notes.c         |    3 +++
 notes.h         |    1 +
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index cb30ad0..4543d11 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -240,6 +240,8 @@ int commit_notes(struct notes_tree *t, const char *msg)
 		t = &default_notes_tree;
 	if (!t->initialized || !t->ref || !*t->ref)
 		die("Cannot commit uninitialized/unreferenced notes tree");
+	if (!t->dirty)
+		return 0; /* don't have to commit an unchanged tree */
 
 	/* Prepare commit message and reflog message */
 	strbuf_addstr(&buf, "notes: "); /* commit message starts at index 7 */
diff --git a/notes.c b/notes.c
index b1b15e9..ffda597 100644
--- a/notes.c
+++ b/notes.c
@@ -926,6 +926,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->ref = notes_ref ? xstrdup(notes_ref) : NULL;
 	t->combine_notes = combine_notes;
 	t->initialized = 1;
+	t->dirty = 0;
 
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
 	    read_ref(notes_ref, object_sha1))
@@ -1014,6 +1015,7 @@ void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
+	t->dirty = 1;
 	if (!combine_notes)
 		combine_notes = t->combine_notes;
 	l = (struct leaf_node *) xmalloc(sizeof(struct leaf_node));
@@ -1029,6 +1031,7 @@ void remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
+	t->dirty = 1;
 	hashcpy(l.key_sha1, object_sha1);
 	hashclr(l.val_sha1);
 	return note_tree_remove(t, t->root, 0, &l);
diff --git a/notes.h b/notes.h
index e1868d8..ee5d47b 100644
--- a/notes.h
+++ b/notes.h
@@ -40,6 +40,7 @@
 	char *ref;
 	combine_notes_fn *combine_notes;
 	int initialized;
+	int dirty;
 } default_notes_tree;
 
 /*
-- 
1.7.0.2.407.g21ebda
