From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v7 12/13] notes: track whether notes_trees were changed at all
Date: Fri, 12 Mar 2010 18:04:36 +0100
Message-ID: <1264c49974f992c4f7bc0a5fa72e01a8d1e6d18e.1268413246.git.trast@student.ethz.ch>
References: <cover.1268413246.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 18:06:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq8JR-00018m-Td
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 18:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758654Ab0CLRFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 12:05:34 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:30419 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758647Ab0CLRFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 12:05:31 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:27 +0100
Received: from localhost.localdomain (213.55.131.184) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:11 +0100
X-Mailer: git-send-email 1.7.0.2.417.gbc354
In-Reply-To: <cover.1268413246.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142048>

Currently, the notes copying is a bit wasteful since it always creates
new trees, even if no notes were copied at all.

Teach add_note() and remove_note() to flag the affected notes tree as
changed ('dirty').  Then teach builtin/notes.c to use this knowledge
and avoid committing trees that weren't changed.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Johan Herland <johan@herland.net>
---


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
index 66912a3..e72ba02 100644
--- a/notes.c
+++ b/notes.c
@@ -933,6 +933,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->ref = notes_ref ? xstrdup(notes_ref) : NULL;
 	t->combine_notes = combine_notes;
 	t->initialized = 1;
+	t->dirty = 0;
 
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
 	    read_ref(notes_ref, object_sha1))
@@ -1012,6 +1013,7 @@ void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
+	t->dirty = 1;
 	if (!combine_notes)
 		combine_notes = t->combine_notes;
 	l = (struct leaf_node *) xmalloc(sizeof(struct leaf_node));
@@ -1027,6 +1029,7 @@ void remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
+	t->dirty = 1;
 	hashcpy(l.key_sha1, object_sha1);
 	hashclr(l.val_sha1);
 	return note_tree_remove(t, t->root, 0, &l);
diff --git a/notes.h b/notes.h
index 6166927..596e0a5 100644
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
1.7.0.2.417.gbc354
