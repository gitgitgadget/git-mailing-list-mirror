From: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 4/6] Allow "git notes merge" to use refs/remote-notes/ as a source.
Date: Sat, 18 Jun 2011 23:06:46 +0200
Message-ID: <1308431208-13353-5-git-send-email-ydirson@free.fr>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
Cc: Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 23:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY2js-0007jg-Qc
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 23:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab1FRVHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 17:07:11 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:42494 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001Ab1FRVHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 17:07:07 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 1BD18D48101;
	Sat, 18 Jun 2011 23:07:00 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.76)
	(envelope-from <ydirson@free.fr>)
	id 1QY2jF-0003V7-MQ; Sat, 18 Jun 2011 23:06:53 +0200
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1308431208-13353-1-git-send-email-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175986>

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 Documentation/git-notes.txt |    5 +++++
 builtin/notes.c             |    4 ++--
 notes.c                     |    5 +++--
 notes.h                     |    2 +-
 revision.c                  |    2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 6a187f2..7ce8a24 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -104,6 +104,11 @@ and instructs the user to manually resolve the conflicts there.
 When done, the user can either finalize the merge with
 'git notes merge --commit', or abort the merge with
 'git notes merge --abort'.
++
+In addition to `refs/notes/`, the remote notes ref is accepted
+from the `refs/remote-notes/` namespace.  This is intended to
+provide notes with support for a workflow similar to the one used
+for heads references.
 
 remove::
 	Remove the notes for given objects (defaults to HEAD). When
diff --git a/builtin/notes.c b/builtin/notes.c
index ae89d38..6bff44f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -905,7 +905,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	o.local_ref = default_notes_ref();
 	strbuf_addstr(&remote_ref, argv[0]);
-	expand_notes_ref(&remote_ref);
+	expand_notes_ref(&remote_ref, 1);
 	o.remote_ref = remote_ref.buf;
 
 	if (strategy) {
@@ -1075,7 +1075,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	if (override_notes_ref) {
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addstr(&sb, override_notes_ref);
-		expand_notes_ref(&sb);
+		expand_notes_ref(&sb, 0);
 		setenv("GIT_NOTES_REF", sb.buf, 1);
 		strbuf_release(&sb);
 	}
diff --git a/notes.c b/notes.c
index 1a5676a..12afc02 100644
--- a/notes.c
+++ b/notes.c
@@ -1282,9 +1282,10 @@ int copy_note(struct notes_tree *t,
 	return 0;
 }
 
-void expand_notes_ref(struct strbuf *sb)
+void expand_notes_ref(struct strbuf *sb, int allow_remotes)
 {
-	if (!prefixcmp(sb->buf, "refs/notes/"))
+	if (!prefixcmp(sb->buf, "refs/notes/") ||
+	    (allow_remotes && !prefixcmp(sb->buf, "refs/remote-notes/")))
 		return; /* we're happy */
 	else if (!prefixcmp(sb->buf, "notes/"))
 		strbuf_insert(sb, 0, "refs/", 5);
diff --git a/notes.h b/notes.h
index d8ae29d..80219ec 100644
--- a/notes.h
+++ b/notes.h
@@ -317,6 +317,6 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 					 const char *globs);
 
 /* Expand inplace a note ref like "foo" or "notes/foo" into "refs/notes/foo" */
-void expand_notes_ref(struct strbuf *sb);
+void expand_notes_ref(struct strbuf *sb, int allow_remotes);
 
 #endif
diff --git a/revision.c b/revision.c
index c46cfaa..b482314 100644
--- a/revision.c
+++ b/revision.c
@@ -1393,7 +1393,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		}
 		else
 			strbuf_addstr(&buf, arg+8);
-		expand_notes_ref(&buf);
+		expand_notes_ref(&buf, 1);
 		string_list_append(&revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
 	} else if (!strcmp(arg, "--no-notes")) {
-- 
1.7.5.3
