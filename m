From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] format_note(): simplify API
Date: Wed, 17 Oct 2012 22:45:24 -0700
Message-ID: <1350539128-21577-3-git-send-email-gitster@pobox.com>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 07:46:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOivh-0005dI-1D
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 07:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab2JRFph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 01:45:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088Ab2JRFpf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 01:45:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F4406D25
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qWJC
	93GPC39YwRPVUkFDNd+7MKs=; b=xGwALuI1KQqk8Ob6vwBRAQfT92gdHsoCBsBS
	5W6jrvQl99tfYASLg22F21issjVB5zItNgdFk3zc6XmGcdJcNtVUSIJm9Gns7/up
	1lRUHaGEpVjZIyTaSV7PprsnMEiftWXxcqaaNB9WRTWu8N+Vk1aEEKJKdqZuPb1K
	2fSbqzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Fgo3wG
	lGTTVVYTcDNhJ6oFHHeFHZhkGbRdpzdm4KwvLPjZcwkteSIzQhWDe+T+WOi098uK
	pt5q8vsbhPNZ8/Jhce7wBHky93Ps1whL1c3sXo34dQZ8mstpwaEog3Ij1e9ZdWT6
	4uPDhXTWDE+OCBXprHJHNav77cxhQ7UQgLDYc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C0686D24
	for <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 579AE6D22 for
 <git@vger.kernel.org>; Thu, 18 Oct 2012 01:45:34 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc3.112.gdb88a5e
In-Reply-To: <1350539128-21577-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 091893D0-18E7-11E2-9BDC-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207963>

We either stuff the notes message without modification for %N
userformat, or format it for human consumption.  Using two bits
is an overkill that does not benefit anybody.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 notes.c    | 13 +++++++------
 notes.h    |  6 +-----
 pretty.c   |  5 ++---
 revision.c |  2 +-
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/notes.c b/notes.c
index bc454e1..97097db 100644
--- a/notes.c
+++ b/notes.c
@@ -1204,10 +1204,11 @@ void free_notes(struct notes_tree *t)
  * If the given notes_tree is NULL, the internal/default notes_tree will be
  * used instead.
  *
- * 'flags' is a bitwise combination of the flags for format_display_notes.
+ * (raw != 0) gives the %N userformat; otherwise, the note message is given
+ * for human consumption.
  */
 static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
-			struct strbuf *sb, const char *output_encoding, int flags)
+			struct strbuf *sb, const char *output_encoding, int raw)
 {
 	static const char utf8[] = "utf-8";
 	const unsigned char *sha1;
@@ -1244,7 +1245,7 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (msglen && msg[msglen - 1] == '\n')
 		msglen--;
 
-	if (flags & NOTES_SHOW_HEADER) {
+	if (!raw) {
 		const char *ref = t->ref;
 		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
 			strbuf_addstr(sb, "\nNotes:\n");
@@ -1260,7 +1261,7 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
 		linelen = strchrnul(msg_p, '\n') - msg_p;
 
-		if (flags & NOTES_INDENT)
+		if (!raw)
 			strbuf_addstr(sb, "    ");
 		strbuf_add(sb, msg_p, linelen);
 		strbuf_addch(sb, '\n');
@@ -1270,13 +1271,13 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 }
 
 void format_display_notes(const unsigned char *object_sha1,
-			  struct strbuf *sb, const char *output_encoding, int flags)
+			  struct strbuf *sb, const char *output_encoding, int raw)
 {
 	int i;
 	assert(display_notes_trees);
 	for (i = 0; display_notes_trees[i]; i++)
 		format_note(display_notes_trees[i], object_sha1, sb,
-			    output_encoding, flags);
+			    output_encoding, raw);
 }
 
 int copy_note(struct notes_tree *t,
diff --git a/notes.h b/notes.h
index 3592b19..3324c48 100644
--- a/notes.h
+++ b/notes.h
@@ -237,10 +237,6 @@ void prune_notes(struct notes_tree *t, int flags);
  */
 void free_notes(struct notes_tree *t);
 
-/* Flags controlling how notes are formatted */
-#define NOTES_SHOW_HEADER 1
-#define NOTES_INDENT 2
-
 struct string_list;
 
 struct display_notes_opt {
@@ -274,7 +270,7 @@ void init_display_notes(struct display_notes_opt *opt);
  * You *must* call init_display_notes() before using this function.
  */
 void format_display_notes(const unsigned char *object_sha1,
-			  struct strbuf *sb, const char *output_encoding, int flags);
+			  struct strbuf *sb, const char *output_encoding, int raw);
 
 /*
  * Load the notes tree from each ref listed in 'refs'.  The output is
diff --git a/pretty.c b/pretty.c
index c311a68..735cf0f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1035,7 +1035,7 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	case 'N':
 		if (c->pretty_ctx->show_notes) {
 			format_display_notes(commit->object.sha1, sb,
-				    get_log_output_encoding(), 0);
+					     get_log_output_encoding(), 1);
 			return 1;
 		}
 		return 0;
@@ -1419,8 +1419,7 @@ void pretty_print_commit(const struct pretty_print_context *pp,
 		strbuf_addch(sb, '\n');
 
 	if (pp->show_notes)
-		format_display_notes(commit->object.sha1, sb, encoding,
-				     NOTES_SHOW_HEADER | NOTES_INDENT);
+		format_display_notes(commit->object.sha1, sb, encoding, 0);
 
 	free(reencoded);
 }
diff --git a/revision.c b/revision.c
index a09e60b..ddfba11 100644
--- a/revision.c
+++ b/revision.c
@@ -2236,7 +2236,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		if (!buf.len)
 			strbuf_addstr(&buf, commit->buffer);
 		format_display_notes(commit->object.sha1, &buf,
-				     get_log_output_encoding(), 0);
+				     get_log_output_encoding(), 1);
 	}
 
 	/* Find either in the commit object, or in the temporary */
-- 
1.8.0.rc3.112.gdb88a5e
