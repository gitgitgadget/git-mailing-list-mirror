From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/4] msvc: Fix some "expr evaluates to function" compiler
 warnings
Date: Wed, 23 Jun 2010 20:40:19 +0100
Message-ID: <4C226323.5080709@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:51:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVyg-0008LG-Px
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab0FWTvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:51:16 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:48140 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753100Ab0FWTvP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 15:51:15 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1ORVyb-0000hm-mB; Wed, 23 Jun 2010 19:51:14 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149540>


In particular, the following warning is issued while compiling
notes.c:

    notes.c(927) : warning C4550: expression evaluates to a \
function which is missing an argument list

along with identical warnings on lines 928, 1016 and 1017.

In order to suppress the warning, we change the definition of
combine_notes_fn, so that the symbol type is an (explicit)
"pointer to function ...".  As a result, several other
declarations need some minor fix-up to take account of the
new typedef.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin.h       |    4 ++--
 builtin/notes.c |    2 +-
 notes.h         |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin.h b/builtin.h
index b614d12..1054c6e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -23,13 +23,13 @@ struct notes_rewrite_cfg {
 	struct notes_tree **trees;
 	const char *cmd;
 	int enabled;
-	combine_notes_fn *combine;
+	combine_notes_fn combine;
 	struct string_list *refs;
 	int refs_from_env;
 	int mode_from_env;
 };
 
-combine_notes_fn *parse_combine_notes_fn(const char *v);
+combine_notes_fn parse_combine_notes_fn(const char *v);
 struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 			  const unsigned char *from_obj, const unsigned char *to_obj);
diff --git a/builtin/notes.c b/builtin/notes.c
index 648033c..f1f53a8 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -313,7 +313,7 @@ int commit_notes(struct notes_tree *t, const char *msg)
 	return 0;
 }
 
-combine_notes_fn *parse_combine_notes_fn(const char *v)
+combine_notes_fn parse_combine_notes_fn(const char *v)
 {
 	if (!strcasecmp(v, "overwrite"))
 		return combine_notes_overwrite;
diff --git a/notes.h b/notes.h
index cc2dff2..65fc3a6 100644
--- a/notes.h
+++ b/notes.h
@@ -18,7 +18,7 @@
  * combine_notes_concatenate(), which appends the contents of the new note to
  * the contents of the existing note.
  */
-typedef int combine_notes_fn(unsigned char *cur_sha1, const unsigned char *new_sha1);
+typedef int (*combine_notes_fn)(unsigned char *cur_sha1, const unsigned char *new_sha1);
 
 /* Common notes combinators */
 int combine_notes_concatenate(unsigned char *cur_sha1, const unsigned char *new_sha1);
@@ -38,7 +38,7 @@ extern struct notes_tree {
 	struct int_node *root;
 	struct non_note *first_non_note, *prev_non_note;
 	char *ref;
-	combine_notes_fn *combine_notes;
+	combine_notes_fn combine_notes;
 	int initialized;
 	int dirty;
 } default_notes_tree;
-- 
1.7.1
