From: Sebastien Gross <seb-git@chezwam.org>
Subject: [PATCH] Add a -z option to 'git status' to safely feed shell
	programs with path names
Date: Sat, 17 May 2008 04:33:40 +0200
Organization: Debian
Message-ID: <20080517023340.GG10006@kali.thurne.chezwam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 04:45:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxCQ2-0004Zt-W4
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 04:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYEQCnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 22:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbYEQCnx
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 22:43:53 -0400
Received: from thurne.chezwam.org ([82.245.152.156]:60624 "EHLO
	kali.thurne.chezwam.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751543AbYEQCnw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 22:43:52 -0400
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 May 2008 22:43:51 EDT
Received: from sjg by kali.thurne.chezwam.org with local (Exim 4.69)
	(envelope-from <seb@chezwam.org>)
	id 1JxCEu-0003JO-7Q
	for git@vger.kernel.org; Sat, 17 May 2008 04:33:40 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82330>

Add a -z option to 'git status' to get a list of all files
but ignored, starting with modification type or 'untracked'
as prefix and ending with '\0'.

Basically the output is similar to 'git status' but with no
comments and suitable to shell programs that should process
filenames (xargs would help for some of them) in a safe way.

Modifications:

  * Documentation/git-commit.txt,Documentation/git-status.txt:
    add description for -z option.
  * builtin-commit.c: add support for '-z' and complains if
    this option is given to `git-commit`.
  * quote.*: add 'make_path_relative' function which acts like
    the 'quote_path_relative' but do not quote path (only give
    the relative path to the perfix).
  * wt-status.*: add many tests and code to handle '-z'.
---


A file would match the template:

 ([status] [action]|untracked):file_name

Where:

 * `status` is: [ "updated", "changed" ]
 * `action` is: [ "new file", "deleted", "modified",
 	"changetype", "unknown", "unmerged" ]

Both "copied" and "renamed" are no used.

Hope nothing would be broken. This patch was generated against
1fbb58b4153e90eda08c2b022ee32d90729582e6.

Examples:

 * Remove all untracked files:

   git status -z | gawk 'BEGIN{RS="\0"; ORS="\0";}/^untracked/ \
	{sub("^.+:", "");print}' | xargs -0 -r rm

 * List all updated file regardless the modification:

   git status -z | gawk 'BEGIN{RS="\0"; ORS="\0";}/^updated/ \
	{sub("^.+:", "");print}' | xargs -0 -n 1


 Documentation/git-commit.txt |   10 ++++-
 Documentation/git-status.txt |   29 ++++++++++++++
 builtin-commit.c             |    8 +++-
 quote.c                      |   42 ++++++++++++++++++++
 quote.h                      |    2 +
 wt-status.c                  |   87 +++++++++++++++++++++++++++++-------------
 wt-status.h                  |    1 +
 7 files changed, 150 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c3c9f5b..2ffb95b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,7 +8,7 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a | --interactive] [-s] [-v] [-u]
+'git-commit' [-a | --interactive] [-s] [-v] [-u] [-z]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
 	   [--allow-empty] [--no-verify] [-e] [--author <author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
@@ -166,6 +166,14 @@ but can be used to amend a merge commit.
 -q|--quiet::
 	Suppress commit summary message.
 
+-z::
+	Only if calling linkgit:git-status[1]. Show all file
+	names that are not ignored, prefixed by its modification
+	type (or untracked) and suffixed by '\0'. Useful for
+	processing file with unsafe names.
+	See linkgit:git-status[1] for more information about tag
+	prefix.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index ea4376a..61deb25 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -34,6 +34,21 @@ OUTPUT
 The output from this command is designed to be used as a commit
 template comment, and all the output lines are prefixed with '#'.
 
+One exception is made with the `-z` option. In this case, all files
+are printed prefixed with a modification tag, and suffixed with '\0'.
+In that case all files can be piped to any shell program.
+The output format is the following:
+
+ ([status] [action]|untracked):file_name
+
+Where:
+
+  * `status` is: [ "updated", "changed" ]
+  * `action` is: [ "new file", "deleted", "modified", "changetype",
+    "unknown", "unmerged" ]
+
+Both "copied" and "renamed" are no used.
+
 The paths mentioned in the output, unlike many other git commands, are
 made relative to the current directory if you are working in a
 subdirectory (this is on purpose, to help cutting and pasting). See
@@ -57,6 +72,20 @@ to -1 or an unlimited number), the submodule summary will be enabled and a
 summary of commits for modified submodules will be shown (see --summary-limit
 option of linkgit:git-submodule[1]).
 
+EXAMPLES
+--------
+
+Remove all untracked files:
+
+   git status -z | gawk 'BEGIN{RS="\0"; ORS="\0";}/^untracked/ \
+  	{sub("^.+:", "");print}' | xargs -0 -r rm
+
+
+List all updated file regardless the modification:
+
+  git status -z | gawk 'BEGIN{RS="\0"; ORS="\0";}/^updated/ \
+  	{sub("^.+:", "");print}' | xargs -0 -n 1
+
 See Also
 --------
 linkgit:gitignore[5]
diff --git a/builtin-commit.c b/builtin-commit.c
index 0baec6d..2b37a85 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -50,6 +50,8 @@ static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, untracked_files, no_verify, allow_empty;
+static int ls_files_zeroed;
+
 /*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
@@ -106,6 +108,8 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 
+	OPT_GROUP("List files (only for status)"),
+	OPT_BOOLEAN('z', 0, &ls_files_zeroed, "\\0 line termination on output"),
 	OPT_END()
 };
 
@@ -348,6 +352,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s.index_file = index_file;
 	s.fp = fp;
 	s.nowarn = nowarn;
+	s.ls_files_zeroed = ls_files_zeroed;
 
 	wt_status_print(&s);
 
@@ -899,7 +904,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	git_config(git_commit_config);
 
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage);
-
+	if (ls_files_zeroed)
+		die("option -z is nonsense with commit");
 	index_file = prepare_index(argc, argv, prefix);
 
 	/* Set up everything for writing the commit object.  This includes
diff --git a/quote.c b/quote.c
index d5cf9d8..6ab6c32 100644
--- a/quote.c
+++ b/quote.c
@@ -303,6 +303,48 @@ char *quote_path_relative(const char *in, int len,
 }
 
 /*
+ * return path as relative to the given prefix but do not quote it
+ * Useful to build a zero-terminated string of the path.
+ * TODO: Factorize this function with quote_path_relative
+ */
+char *make_path_relative(const char *in, int len,
+			  struct strbuf *out, const char *prefix)
+{
+
+	if (len < 0)
+		len = strlen(in);
+
+	/* "../" prefix itself does not need quoting, but "in" might. */
+	strbuf_setlen(out, 0);
+	strbuf_grow(out, len);
+	
+	if (prefix) {
+		int off = 0;
+		while (prefix[off] && off < len && prefix[off] == in[off])
+			if (prefix[off] == '/') {
+				prefix += off + 1;
+				in += off + 1;
+				len -= off + 1;
+				off = 0;
+			} else
+				off++;
+
+		for (; *prefix; prefix++)
+			if (*prefix == '/')
+				strbuf_addstr(out, "../");
+	}
+
+
+	strbuf_addstr(out, in);
+	/* quote_c_style_counted (in, len, out, NULL, 1); */
+
+	if (!out->len)
+		strbuf_addstr(out, "./");
+
+	return out->buf;
+}
+
+/*
  * C-style name unquoting.
  *
  * Quoted should point at the opening double quote.
diff --git a/quote.h b/quote.h
index c5eea6f..1934c60 100644
--- a/quote.h
+++ b/quote.h
@@ -50,6 +50,8 @@ extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
 /* quote path as relative to the given prefix */
 char *quote_path_relative(const char *in, int len,
 			  struct strbuf *out, const char *prefix);
+char *make_path_relative(const char *in, int len,
+			  struct strbuf *out, const char *prefix);
 
 /* quoting as a string literal for other languages */
 extern void perl_quote_print(FILE *stream, const char *src);
diff --git a/wt-status.c b/wt-status.c
index a44c543..1a007e1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -93,42 +93,58 @@ static void wt_status_print_filepair(struct wt_status *s,
 	const char *c = color(t);
 	const char *one, *two;
 	struct strbuf onebuf, twobuf;
+	char *updated_prefix="updated ", *changed_prefix="changed ", *pfx = 0;
 
 	strbuf_init(&onebuf, 0);
 	strbuf_init(&twobuf, 0);
-	one = quote_path(p->one->path, -1, &onebuf, s->prefix);
-	two = quote_path(p->two->path, -1, &twobuf, s->prefix);
 
-	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+	if (!s->ls_files_zeroed) {
+		one = quote_path(p->one->path, -1, &onebuf, s->prefix);
+		two = quote_path(p->two->path, -1, &twobuf, s->prefix);
+		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+	} else {
+		one = make_path_relative(p->one->path, -1, &onebuf, s->prefix);
+		two = 0;	/* Maybe in a future usage ? */
+		pfx = t != WT_STATUS_CHANGED ? changed_prefix : updated_prefix;
+	}
 	switch (p->status) {
 	case DIFF_STATUS_ADDED:
+		s->ls_files_zeroed ? printf("%snew file:%s%c", pfx, one, 0) :
 		color_fprintf(s->fp, c, "new file:   %s", one);
 		break;
 	case DIFF_STATUS_COPIED:
-		color_fprintf(s->fp, c, "copied:     %s -> %s", one, two);
+		if (!s->ls_files_zeroed)
+			color_fprintf(s->fp, c, "copied:     %s -> %s", one, two);
 		break;
 	case DIFF_STATUS_DELETED:
+		s->ls_files_zeroed ? printf("%sdeleted:%s%c", pfx, one, 0) :
 		color_fprintf(s->fp, c, "deleted:    %s", one);
 		break;
 	case DIFF_STATUS_MODIFIED:
+		s->ls_files_zeroed ? printf("%smodified:%s%c", pfx, one, 0) :
 		color_fprintf(s->fp, c, "modified:   %s", one);
 		break;
 	case DIFF_STATUS_RENAMED:
-		color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
+		if (!s->ls_files_zeroed)
+			color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
+		s->ls_files_zeroed ? printf("%schangetype:%s%c", pfx, one, 0) :
 		color_fprintf(s->fp, c, "typechange: %s", one);
 		break;
 	case DIFF_STATUS_UNKNOWN:
+		s->ls_files_zeroed ? printf("%sunknown:%s%c", pfx, one, 0) :
 		color_fprintf(s->fp, c, "unknown:    %s", one);
 		break;
 	case DIFF_STATUS_UNMERGED:
+		s->ls_files_zeroed ? printf("%sunmerged:%s%c", pfx, one, 0) :
 		color_fprintf(s->fp, c, "unmerged:   %s", one);
 		break;
 	default:
 		die("bug: unhandled diff status %c", p->status);
 	}
-	fprintf(s->fp, "\n");
+	if (!s->ls_files_zeroed)
+		fprintf(s->fp, "\n");
 	strbuf_release(&onebuf);
 	strbuf_release(&twobuf);
 }
@@ -143,14 +159,16 @@ static void wt_status_print_updated_cb(struct diff_queue_struct *q,
 	for (i = 0; i < q->nr; i++) {
 		if (q->queue[i]->status == 'U')
 			continue;
-		if (!shown_header) {
-			wt_status_print_cached_header(s);
-			s->commitable = 1;
-			shown_header = 1;
+		if (!s->ls_files_zeroed) {
+			if (!shown_header) {
+				wt_status_print_cached_header(s);
+				s->commitable = 1;
+				shown_header = 1;
+			}
 		}
 		wt_status_print_filepair(s, WT_STATUS_UPDATED, q->queue[i]);
 	}
-	if (shown_header)
+	if (shown_header && !s->ls_files_zeroed)
 		wt_status_print_trailer(s);
 }
 
@@ -163,16 +181,18 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 	if (q->nr) {
 		const char *msg = use_add_msg;
 		s->workdir_dirty = 1;
-		for (i = 0; i < q->nr; i++)
-			if (q->queue[i]->status == DIFF_STATUS_DELETED) {
-				msg = use_add_rm_msg;
-				break;
-			}
-		wt_status_print_header(s, "Changed but not updated", msg);
+		if (!s->ls_files_zeroed) {
+			for (i = 0; i < q->nr; i++)
+				if (q->queue[i]->status == DIFF_STATUS_DELETED) {
+					msg = use_add_rm_msg;
+					break;
+				}
+			wt_status_print_header(s, "Changed but not updated", msg);
+		}
 	}
 	for (i = 0; i < q->nr; i++)
 		wt_status_print_filepair(s, WT_STATUS_CHANGED, q->queue[i]);
-	if (q->nr)
+	if (q->nr && !s->ls_files_zeroed)
 		wt_status_print_trailer(s);
 }
 
@@ -284,16 +304,21 @@ static void wt_status_print_untracked(struct wt_status *s)
 			    !memcmp(ce->name, ent->name, ent->len))
 				continue;
 		}
-		if (!shown_header) {
-			s->workdir_untracked = 1;
-			wt_status_print_header(s, "Untracked files",
-					       use_add_to_include_msg);
-			shown_header = 1;
+		if (s->ls_files_zeroed) {
+			printf("untracked:%s%c", make_path_relative(ent->name,
+				ent->len, &buf, s->prefix), 0);
+		} else {
+			if (!shown_header) {
+				s->workdir_untracked = 1;
+				wt_status_print_header(s, "Untracked files",
+						       use_add_to_include_msg);
+				shown_header = 1;
+			}
+			color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+			color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%s",
+					quote_path(ent->name, ent->len,
+						&buf, s->prefix));
 		}
-		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
-		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%s",
-				quote_path(ent->name, ent->len,
-					&buf, s->prefix));
 	}
 	strbuf_release(&buf);
 }
@@ -316,6 +341,14 @@ void wt_status_print(struct wt_status *s)
 	unsigned char sha1[20];
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
 
+	if(s->ls_files_zeroed) {
+		wt_status_print_updated(s);
+		wt_status_print_changed(s);
+		wt_status_print_untracked(s);
+		return;
+	}
+
+
 	if (s->branch) {
 		const char *on_what = "On branch ";
 		const char *branch_name = s->branch;
diff --git a/wt-status.h b/wt-status.h
index 7d61410..7a02472 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -25,6 +25,7 @@ struct wt_status {
 	const char *index_file;
 	FILE *fp;
 	const char *prefix;
+	int ls_files_zeroed;
 };
 
 int git_status_config(const char *var, const char *value);
-- 
1.5.5.1
