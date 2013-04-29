From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] clean: Introduce -z for machine readable output
Date: Mon, 29 Apr 2013 16:30:57 +0200
Message-ID: <6733a9080da07ace27c3252de2399be339b4e349.1367245712.git.git@drmicha.warpmail.net>
References: <vpqwqrl931e.fsf@grenoble-inp.fr>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jiang Xin <worldhello.net@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 16:30:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWp6V-00081F-0F
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 16:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901Ab3D2Oau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 10:30:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50104 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752721Ab3D2Oau (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Apr 2013 10:30:50 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7B9F021591;
	Mon, 29 Apr 2013 10:30:49 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 29 Apr 2013 10:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=tLvJ5OxK6CpGjBB9G1/2Bz8oP
	AE=; b=kDdhi0l+kspydBSVFe9c0hrVk+YJdIQAtVKvU/ir1I+D96eOEYWecVTJb
	Z+SbNIGKES66FGaXg60GdvQzlJps9NDkiiRVoHt+kl0FimAZB6AJkxTfCVHtN3fZ
	yqs8nm0icji1WnrZxXuy8vj9ydnTCYa3k7rgayVFFPkvMkuDDg=
X-Sasl-enc: 9jRgQ0FShjsVXQbKTyS4t7iyoQAH3RWiOYTleTCBpMib 1367245849
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 11D34C8000A;
	Mon, 29 Apr 2013 10:30:48 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.rc0.297.g8c90ec5
In-Reply-To: <vpqwqrl931e.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222797>

-z makes clean output only the names of paths which are or would be
deleted, and separates them with \0.

Use as "xargs -0 -a <(git clean -nz [-d]) rm -ri", e.g., as a quick
"git clean -i".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Here's an alternative approach to that problem with a complete different attach
vector but a similar purpose. I've been using it for a while, but it's kind of
unpolished. My "git-clean-i" looks like:

--->%---
#!/bin/bash
xargs -0 -a <(git clean -n -z "$@") rm -ri
--->%---

 Documentation/git-clean.txt |  9 ++++++++-
 builtin/clean.c             | 27 +++++++++++++++++++--------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index bdc3ab8..849e775 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-n] [-q] [-z] [-e <pattern>] [-x | -X] [--] <path>...
 
 DESCRIPTION
 -----------
@@ -63,6 +63,13 @@ OPTIONS
 	Remove only files ignored by Git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
+-z::
+	Use machine readable output for (to be) removed paths: Output the paths
+	which are or would be removed only (without extra wording) and
+	separate them with \0.
++
+This does not imply `-n` but can be combined with it.
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
diff --git a/builtin/clean.c b/builtin/clean.c
index 04e396b..0ebba24 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -41,8 +41,18 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+void write_name(const char *fmt, const char *name, int nul_terminated)
+{
+	if (nul_terminated) {
+		fputs(name, stdout);
+		fputc(0, stdout);
+	} else {
+		printf(fmt, name);
+	}
+}
+
 static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
-		int dry_run, int quiet, int *dir_gone)
+		int dry_run, int quiet, int *dir_gone, int nul_terminated)
 {
 	DIR *dir;
 	struct strbuf quoted = STRBUF_INIT;
@@ -57,8 +67,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 			!resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
 		if (!quiet) {
 			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
-			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
-					quoted.buf);
+			write_name(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
+					quoted.buf, nul_terminated);
 		}
 
 		*dir_gone = 0;
@@ -91,7 +101,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		if (lstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
-			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
+			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone, nul_terminated))
 				ret = 1;
 			if (gone) {
 				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
@@ -136,7 +146,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 
 	if (!*dir_gone && !quiet) {
 		for (i = 0; i < dels.nr; i++)
-			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
+			write_name(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string, nul_terminated);
 	}
 	string_list_clear(&dels, 0);
 	return ret;
@@ -146,7 +156,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
-	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
+	int ignored_only = 0, config_set = 0, errors = 0, gone = 1, nul_terminated = 0;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory = STRBUF_INIT;
 	struct dir_struct dir;
@@ -167,6 +177,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('x', NULL, &ignored, N_("remove ignored files, too")),
 		OPT_BOOLEAN('X', NULL, &ignored_only,
 				N_("remove only ignored files")),
+		OPT_BOOLEAN('z', NULL, &nul_terminated, "(actually or to be) removed paths are separated with NUL character"),
 		OPT_END()
 	};
 
@@ -259,7 +270,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
 			if (remove_directories || (matches == MATCHED_EXACTLY)) {
-				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
+				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone, nul_terminated))
 					errors++;
 				if (gone && !quiet) {
 					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
@@ -277,7 +288,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				errors++;
 			} else if (!quiet) {
 				qname = quote_path_relative(ent->name, -1, &buf, prefix);
-				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
+				write_name(dry_run ? _(msg_would_remove) : _(msg_remove), qname, nul_terminated);
 			}
 		}
 	}
-- 
1.8.3.rc0.297.g8c90ec5
