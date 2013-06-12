From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/3] Move copy_note_for_rewrite + friends from builtin/notes.c to notes-utils.c
Date: Wed, 12 Jun 2013 02:13:00 +0200
Message-ID: <1370995981-1553-3-git-send-email-johan@herland.net>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
 <1370995981-1553-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	artagnon@gmail.com, john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	felipe.contreras@gmail.com, torvalds@linux-foundation.org,
	johan@herland.net, Thomas Rast <trast@inf.ethz.ch>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 12 02:13:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmYhA-0005IF-Gf
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 02:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474Ab3FLANm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 20:13:42 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:43816 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642Ab3FLANk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 20:13:40 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so7496384lab.17
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 17:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TiZBG/+Sv4DNYuQiXNq6Y8XktjVKuQ7ca3t9BjUHqro=;
        b=pHraqITYZO6N162n5/VP6E8zjJXvfBxLyq61cFENZqBNBOjH6aPXA6BSfyN1rhXz9d
         MoL4X2OsEd43SeVi81ut7mOUbk/5PX9dzV3I3tWyujdJ2mWSU5rXJkbvo6JJi4WnPY3D
         33Jy75A8QSVktI9iTiOCMnnIm0gAAC2rErdviwMWWpaXpR1z+jx3tdPND47jmbO9DTqQ
         QSS1zRxaNgs3ZqLuMp5QUXiJCwHaVrhYDABl+24bGcS5Eg7YdRDiihz9qKGrgSs25+YE
         fCi7Lb/prm2QUGJeS8JwWMeY3dyOsTnRiSPiAosPd/kEnMkwtFUQdkEPwJNPfV0qk82A
         qfnw==
X-Received: by 10.152.28.233 with SMTP id e9mr8507595lah.41.1370996019136;
        Tue, 11 Jun 2013 17:13:39 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPSA id x3sm7102525lag.6.2013.06.11.17.13.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 17:13:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1370995981-1553-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227582>

This is a pure code movement of the machinery for copying notes to
rewritten objects. This code was located in builtin/notes.c for
historical reasons. In order to make it available to builtin/commit.c
it was declared in builtin.h. This was more of an accident of history
than a concious design, and we now want to make this machinery more
widely available.

Hence, this patch moves the code into the new notes-utils.[hc] files
which are included into libgit.a. Except for adjusting #includes
accordingly, this patch merely moves the relevant functions verbatim
into the new files.

Cc: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Makefile         |   2 +
 builtin.h        |  16 -------
 builtin/commit.c |   1 +
 builtin/notes.c  | 131 +-----------------------------------------------------
 notes-utils.c    | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 notes-utils.h    |  23 ++++++++++
 6 files changed, 159 insertions(+), 146 deletions(-)
 create mode 100644 notes-utils.c
 create mode 100644 notes-utils.h

diff --git a/Makefile b/Makefile
index 0f931a2..22deee1 100644
--- a/Makefile
+++ b/Makefile
@@ -682,6 +682,7 @@ LIB_H += merge-recursive.h
 LIB_H += mergesort.h
 LIB_H += notes-cache.h
 LIB_H += notes-merge.h
+LIB_H += notes-utils.h
 LIB_H += notes.h
 LIB_H += object.h
 LIB_H += pack-refs.h
@@ -815,6 +816,7 @@ LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
+LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-refs.o
diff --git a/builtin.h b/builtin.h
index 78fb14d..72bb2a8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -5,7 +5,6 @@
 #include "strbuf.h"
 #include "cache.h"
 #include "commit.h"
-#include "notes.h"
 
 #define DEFAULT_MERGE_LOG_LEN 20
 
@@ -23,21 +22,6 @@ struct fmt_merge_msg_opts {
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 struct fmt_merge_msg_opts *);
 
-struct notes_rewrite_cfg {
-	struct notes_tree **trees;
-	const char *cmd;
-	int enabled;
-	combine_notes_fn combine;
-	struct string_list *refs;
-	int refs_from_env;
-	int mode_from_env;
-};
-
-struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
-int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
-			  const unsigned char *from_obj, const unsigned char *to_obj);
-void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg);
-
 extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, int sha1_valid, char **buf, unsigned long *buf_size);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
diff --git a/builtin/commit.c b/builtin/commit.c
index f8df8ca..ce40176 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -29,6 +29,7 @@
 #include "gpg-interface.h"
 #include "column.h"
 #include "sequencer.h"
+#include "notes-utils.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [options] [--] <pathspec>..."),
diff --git a/builtin/notes.c b/builtin/notes.c
index 6a80714..9ed2508 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -18,9 +18,7 @@
 #include "parse-options.h"
 #include "string-list.h"
 #include "notes-merge.h"
-
-static void commit_notes(struct notes_tree *t, const char *msg);
-static combine_notes_fn parse_combine_notes_fn(const char *v);
+#include "notes-utils.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes_ref>] [list [<object>]]"),
@@ -287,133 +285,6 @@ static int parse_reedit_arg(const struct option *opt, const char *arg, int unset
 	return parse_reuse_arg(opt, arg, unset);
 }
 
-static void commit_notes(struct notes_tree *t, const char *msg)
-{
-	struct strbuf buf = STRBUF_INIT;
-	unsigned char commit_sha1[20];
-
-	if (!t)
-		t = &default_notes_tree;
-	if (!t->initialized || !t->ref || !*t->ref)
-		die(_("Cannot commit uninitialized/unreferenced notes tree"));
-	if (!t->dirty)
-		return; /* don't have to commit an unchanged tree */
-
-	/* Prepare commit message and reflog message */
-	strbuf_addstr(&buf, msg);
-	if (buf.buf[buf.len - 1] != '\n')
-		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */
-
-	create_notes_commit(t, NULL, &buf, commit_sha1);
-	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
-	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0, DIE_ON_ERR);
-
-	strbuf_release(&buf);
-}
-
-static combine_notes_fn parse_combine_notes_fn(const char *v)
-{
-	if (!strcasecmp(v, "overwrite"))
-		return combine_notes_overwrite;
-	else if (!strcasecmp(v, "ignore"))
-		return combine_notes_ignore;
-	else if (!strcasecmp(v, "concatenate"))
-		return combine_notes_concatenate;
-	else if (!strcasecmp(v, "cat_sort_uniq"))
-		return combine_notes_cat_sort_uniq;
-	else
-		return NULL;
-}
-
-static int notes_rewrite_config(const char *k, const char *v, void *cb)
-{
-	struct notes_rewrite_cfg *c = cb;
-	if (!prefixcmp(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
-		c->enabled = git_config_bool(k, v);
-		return 0;
-	} else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
-		if (!v)
-			config_error_nonbool(k);
-		c->combine = parse_combine_notes_fn(v);
-		if (!c->combine) {
-			error(_("Bad notes.rewriteMode value: '%s'"), v);
-			return 1;
-		}
-		return 0;
-	} else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
-		/* note that a refs/ prefix is implied in the
-		 * underlying for_each_glob_ref */
-		if (!prefixcmp(v, "refs/notes/"))
-			string_list_add_refs_by_glob(c->refs, v);
-		else
-			warning(_("Refusing to rewrite notes in %s"
-				" (outside of refs/notes/)"), v);
-		return 0;
-	}
-
-	return 0;
-}
-
-
-struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
-{
-	struct notes_rewrite_cfg *c = xmalloc(sizeof(struct notes_rewrite_cfg));
-	const char *rewrite_mode_env = getenv(GIT_NOTES_REWRITE_MODE_ENVIRONMENT);
-	const char *rewrite_refs_env = getenv(GIT_NOTES_REWRITE_REF_ENVIRONMENT);
-	c->cmd = cmd;
-	c->enabled = 1;
-	c->combine = combine_notes_concatenate;
-	c->refs = xcalloc(1, sizeof(struct string_list));
-	c->refs->strdup_strings = 1;
-	c->refs_from_env = 0;
-	c->mode_from_env = 0;
-	if (rewrite_mode_env) {
-		c->mode_from_env = 1;
-		c->combine = parse_combine_notes_fn(rewrite_mode_env);
-		if (!c->combine)
-			/* TRANSLATORS: The first %s is the name of the
-			   environment variable, the second %s is its value */
-			error(_("Bad %s value: '%s'"), GIT_NOTES_REWRITE_MODE_ENVIRONMENT,
-					rewrite_mode_env);
-	}
-	if (rewrite_refs_env) {
-		c->refs_from_env = 1;
-		string_list_add_refs_from_colon_sep(c->refs, rewrite_refs_env);
-	}
-	git_config(notes_rewrite_config, c);
-	if (!c->enabled || !c->refs->nr) {
-		string_list_clear(c->refs, 0);
-		free(c->refs);
-		free(c);
-		return NULL;
-	}
-	c->trees = load_notes_trees(c->refs);
-	string_list_clear(c->refs, 0);
-	free(c->refs);
-	return c;
-}
-
-int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
-			  const unsigned char *from_obj, const unsigned char *to_obj)
-{
-	int ret = 0;
-	int i;
-	for (i = 0; c->trees[i]; i++)
-		ret = copy_note(c->trees[i], from_obj, to_obj, 1, c->combine) || ret;
-	return ret;
-}
-
-void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg)
-{
-	int i;
-	for (i = 0; c->trees[i]; i++) {
-		commit_notes(c->trees[i], msg);
-		free_notes(c->trees[i]);
-	}
-	free(c->trees);
-	free(c);
-}
-
 static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/notes-utils.c b/notes-utils.c
new file mode 100644
index 0000000..2ae5cb2
--- /dev/null
+++ b/notes-utils.c
@@ -0,0 +1,132 @@
+#include "cache.h"
+#include "commit.h"
+#include "refs.h"
+#include "notes-utils.h"
+#include "notes-merge.h" // need create_notes_commit()
+
+void commit_notes(struct notes_tree *t, const char *msg)
+{
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char commit_sha1[20];
+
+	if (!t)
+		t = &default_notes_tree;
+	if (!t->initialized || !t->ref || !*t->ref)
+		die(_("Cannot commit uninitialized/unreferenced notes tree"));
+	if (!t->dirty)
+		return; /* don't have to commit an unchanged tree */
+
+	/* Prepare commit message and reflog message */
+	strbuf_addstr(&buf, msg);
+	if (buf.buf[buf.len - 1] != '\n')
+		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */
+
+	create_notes_commit(t, NULL, &buf, commit_sha1);
+	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
+	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0, DIE_ON_ERR);
+
+	strbuf_release(&buf);
+}
+
+static combine_notes_fn parse_combine_notes_fn(const char *v)
+{
+	if (!strcasecmp(v, "overwrite"))
+		return combine_notes_overwrite;
+	else if (!strcasecmp(v, "ignore"))
+		return combine_notes_ignore;
+	else if (!strcasecmp(v, "concatenate"))
+		return combine_notes_concatenate;
+	else if (!strcasecmp(v, "cat_sort_uniq"))
+		return combine_notes_cat_sort_uniq;
+	else
+		return NULL;
+}
+
+static int notes_rewrite_config(const char *k, const char *v, void *cb)
+{
+	struct notes_rewrite_cfg *c = cb;
+	if (!prefixcmp(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
+		c->enabled = git_config_bool(k, v);
+		return 0;
+	} else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
+		if (!v)
+			config_error_nonbool(k);
+		c->combine = parse_combine_notes_fn(v);
+		if (!c->combine) {
+			error(_("Bad notes.rewriteMode value: '%s'"), v);
+			return 1;
+		}
+		return 0;
+	} else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
+		/* note that a refs/ prefix is implied in the
+		 * underlying for_each_glob_ref */
+		if (!prefixcmp(v, "refs/notes/"))
+			string_list_add_refs_by_glob(c->refs, v);
+		else
+			warning(_("Refusing to rewrite notes in %s"
+				" (outside of refs/notes/)"), v);
+		return 0;
+	}
+
+	return 0;
+}
+
+
+struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
+{
+	struct notes_rewrite_cfg *c = xmalloc(sizeof(struct notes_rewrite_cfg));
+	const char *rewrite_mode_env = getenv(GIT_NOTES_REWRITE_MODE_ENVIRONMENT);
+	const char *rewrite_refs_env = getenv(GIT_NOTES_REWRITE_REF_ENVIRONMENT);
+	c->cmd = cmd;
+	c->enabled = 1;
+	c->combine = combine_notes_concatenate;
+	c->refs = xcalloc(1, sizeof(struct string_list));
+	c->refs->strdup_strings = 1;
+	c->refs_from_env = 0;
+	c->mode_from_env = 0;
+	if (rewrite_mode_env) {
+		c->mode_from_env = 1;
+		c->combine = parse_combine_notes_fn(rewrite_mode_env);
+		if (!c->combine)
+			/* TRANSLATORS: The first %s is the name of the
+			   environment variable, the second %s is its value */
+			error(_("Bad %s value: '%s'"), GIT_NOTES_REWRITE_MODE_ENVIRONMENT,
+					rewrite_mode_env);
+	}
+	if (rewrite_refs_env) {
+		c->refs_from_env = 1;
+		string_list_add_refs_from_colon_sep(c->refs, rewrite_refs_env);
+	}
+	git_config(notes_rewrite_config, c);
+	if (!c->enabled || !c->refs->nr) {
+		string_list_clear(c->refs, 0);
+		free(c->refs);
+		free(c);
+		return NULL;
+	}
+	c->trees = load_notes_trees(c->refs);
+	string_list_clear(c->refs, 0);
+	free(c->refs);
+	return c;
+}
+
+int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
+			  const unsigned char *from_obj, const unsigned char *to_obj)
+{
+	int ret = 0;
+	int i;
+	for (i = 0; c->trees[i]; i++)
+		ret = copy_note(c->trees[i], from_obj, to_obj, 1, c->combine) || ret;
+	return ret;
+}
+
+void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg)
+{
+	int i;
+	for (i = 0; c->trees[i]; i++) {
+		commit_notes(c->trees[i], msg);
+		free_notes(c->trees[i]);
+	}
+	free(c->trees);
+	free(c);
+}
diff --git a/notes-utils.h b/notes-utils.h
new file mode 100644
index 0000000..0661e99
--- /dev/null
+++ b/notes-utils.h
@@ -0,0 +1,23 @@
+#ifndef NOTES_UTILS_H
+#define NOTES_UTILS_H
+
+#include "notes.h"
+
+void commit_notes(struct notes_tree *t, const char *msg);
+
+struct notes_rewrite_cfg {
+	struct notes_tree **trees;
+	const char *cmd;
+	int enabled;
+	combine_notes_fn combine;
+	struct string_list *refs;
+	int refs_from_env;
+	int mode_from_env;
+};
+
+struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
+int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
+			  const unsigned char *from_obj, const unsigned char *to_obj);
+void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg);
+
+#endif
-- 
1.8.1.3.704.g33f7d4f
