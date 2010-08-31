From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/2] notes.h: Extend remove_note to return the SHA1 of the removed note, if any
Date: Tue, 31 Aug 2010 17:59:05 +0200
Message-ID: <201008311759.05908.johan@herland.net>
References: <4C7CB8AF.5080008@atlas-elektronik.com> <4C7CD5B8.20602@atlas-elektronik.com> <201008311753.37433.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 17:59:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTEw-0001hS-QN
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab0HaP7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 11:59:09 -0400
Received: from smtp.opera.com ([213.236.208.81]:51453 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab0HaP7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 11:59:08 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o7VFx5BF022090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Aug 2010 15:59:06 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <201008311753.37433.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154926>

It might be useful to identify which note was removed by a call to
remove_note(). Add an optional parameter to remove_note() for recording
the SHA1 of the removed note object. If no note is removed by remove_note(),
null_sha1 is stored in this parameter.

Signed-off-by: Johan Herland <johan@herland.net>
---

This patch is very much optional. It adds a small API extension that
_might_ be useful in the future.


 builtin/notes.c |    6 +++---
 notes.c         |    7 +++++--
 notes.h         |    6 +++++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 6d07aac..e5c8208 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -572,7 +572,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	create_note(object, &msg, 0, note, new_note);
 
 	if (is_null_sha1(new_note))
-		remove_note(t, object);
+		remove_note(t, object, NULL);
 	else
 		add_note(t, object, new_note, combine_notes_overwrite);
 
@@ -711,7 +711,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	create_note(object, &msg, !edit, note, new_note);
 
 	if (is_null_sha1(new_note))
-		remove_note(t, object);
+		remove_note(t, object, NULL);
 	else
 		add_note(t, object, new_note, combine_notes_overwrite);
 
@@ -786,7 +786,7 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 
 	t = init_notes_check("remove");
 
-	retval = remove_note(t, object);
+	retval = remove_note(t, object, NULL);
 	if (retval)
 		fprintf(stderr, "Object %s has no note\n", sha1_to_hex(object));
 	else {
diff --git a/notes.c b/notes.c
index 70d0013..9fe857b 100644
--- a/notes.c
+++ b/notes.c
@@ -1006,7 +1006,8 @@ void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 	note_tree_insert(t, t->root, 0, l, PTR_TYPE_NOTE, combine_notes);
 }
 
-int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
+int remove_note(struct notes_tree *t, const unsigned char *object_sha1,
+		unsigned char *removed_note)
 {
 	struct leaf_node l;
 
@@ -1016,6 +1017,8 @@ int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 	hashcpy(l.key_sha1, object_sha1);
 	hashclr(l.val_sha1);
 	note_tree_remove(t, t->root, 0, &l);
+	if (removed_note)
+		hashcpy(removed_note, l.val_sha1);
 	if (is_null_sha1(l.val_sha1)) // no note was removed
 		return 1;
 	t->dirty = 1;
@@ -1085,7 +1088,7 @@ void prune_notes(struct notes_tree *t, int flags)
 		if (flags & NOTES_PRUNE_VERBOSE)
 			printf("%s\n", sha1_to_hex(l->sha1));
 		if (!(flags & NOTES_PRUNE_DRYRUN))
-			remove_note(t, l->sha1);
+			remove_note(t, l->sha1, NULL);
 		l = l->next;
 	}
 }
diff --git a/notes.h b/notes.h
index 5106761..c61e962 100644
--- a/notes.h
+++ b/notes.h
@@ -90,9 +90,13 @@ void add_note(struct notes_tree *t, const unsigned char *object_sha1,
  * structure are not persistent until a subsequent call to write_notes_tree()
  * returns zero.
  *
+ * If removed_note is non-NULL, the SHA1 of the removed note will be written
+ * there. If there was no note to remove, then null_sha1 will be written there.
+ *
  * Return 0 if a note was removed; 1 if there was no note to remove.
  */
-int remove_note(struct notes_tree *t, const unsigned char *object_sha1);
+int remove_note(struct notes_tree *t, const unsigned char *object_sha1,
+		unsigned char *removed_note);
 
 /*
  * Get the note object SHA1 containing the note data for the given object
-- 
1.7.2.220.gea1d3
