From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 1/6] Teach --id/-d to "git status"
Date: Wed,  5 Aug 2009 17:51:41 +0800
Message-ID: <1249465906-3940-2-git-send-email-ayiehere@gmail.com>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYdDW-00051k-PP
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933935AbZHEJzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933227AbZHEJzU
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:55:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:58309 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178AbZHEJzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:55:17 -0400
Received: by wa-out-1112.google.com with SMTP id j5so710326wah.21
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 02:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=i9B4jxN/0SGgoxo3cJofpnYd7CtShteOVcMK/Y3zuac=;
        b=ipK/GGaqWBs+hyKSek/cvbBwF4eEZHPx3xolQx8WdE5AJKBv93janR47ajOUqgNJC2
         soI0kapPAvppd2g2BmPTZofSeFezN2TaHVkjP6jqwhlkfJpw66ph+oBm9y1936UBp2x5
         7wxA3bmuUG/mWUBoOrltvwsRx/9tYfc0iB9pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TY4YJLaxnQWfGAZkWqfPld6sxOX5s8QmfC30snTILdRzQVWH5YoL3GybSvgnBdKm/u
         YEZl5cCPnlFdaqy+QrHQweBT0QENbA6KfJUjhdEwg1AW41HuZ4I+h6qzWggGSqCevoUb
         klsOP6/5smjNK/oCbe1oV691U8f6f5Ac2hEWs=
Received: by 10.114.94.14 with SMTP id r14mr11444070wab.74.1249465812585;
        Wed, 05 Aug 2009 02:50:12 -0700 (PDT)
Received: from localhost.localdomain ([115.132.128.228])
        by mx.google.com with ESMTPS id k14sm13017099waf.25.2009.08.05.02.50.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 02:50:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.13.ge6580
In-Reply-To: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124885>

This patch adds a unique identifier for each file shown by "git status".

Subsequent operation (add/rm/checkout/commit/reset) may use these ids
to simplify specifying the files, provided that they are taught about
the --id option as well.

Example:

  $ git status --id
  # On branch local
  # Changed but not updated:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #	modified:   builtin-add.c (m1)
  #	modified:   builtin-checkout.c (m2)
  #	modified:   builtin-commit.c (m3)
  #	modified:   builtin-reset.c (m4)
  #	modified:   builtin-rm.c (m5)
  #
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #	makefile.debug (x1)
  #	nazri.sh (x2)
  no changes added to commit (use "git add" and/or "git commit -a")

  $ git add --id m1
  # Short for "git add builtin-add.c

  $ git add --id m3,m5
  # Short for "git add builtin-commit.c builtin-rm.c"

  # Even shorter: -d is equivalent to --id
  $ git add -d m3,m5

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 cache.h     |    1 +
 path.c      |   44 ++++++++++++++++++
 wt-status.c |  146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 wt-status.h |    1 +
 4 files changed, 181 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index e6c7f33..05817e3 100644
--- a/cache.h
+++ b/cache.h
@@ -649,6 +649,7 @@ const char *make_relative_path(const char *abs, const char *base);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, const char *prefix_list);
 char *strip_path_suffix(const char *path, const char *suffix);
+char ** expand_file_ids(const char *file_id, int *argc, char **argv);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index 047fdb0..7824c4a 100644
--- a/path.c
+++ b/path.c
@@ -564,3 +564,47 @@ char *strip_path_suffix(const char *path, const char *suffix)
 		return NULL;
 	return xstrndup(path, chomp_trailing_dir_sep(path, path_len));
 }
+
+char ** expand_file_ids(const char *file_id, int *argc, char **argv)
+{
+	FILE *fp;
+	const char *filename = git_path("FILE_IDS");
+	struct strbuf sb = STRBUF_INIT;
+	int i;
+
+	char **new_argv;
+
+	new_argv = (char **) xmalloc(*argc * sizeof(char *));
+	for (i = 0; i < *argc; i++) {
+		new_argv[i] = (char *) argv[i];
+	}
+
+	fp = fopen(filename, "r");
+	if (!fp)
+		die("cannot open %s: %s\n", filename, strerror(errno));
+
+	while (strbuf_getline(&sb, fp, '\n') == 0) {
+		char *b, *e;
+		if (sb.len == 0)
+			continue;
+		b = e = sb.buf;
+		while(*e && *e != ' ')
+			e++;
+		*e = '\0';
+		if(strstr(file_id, b)) {
+			 (*argc)++;
+			 new_argv = xrealloc(new_argv, (*argc) * sizeof(char *));
+			 new_argv[*argc - 1] = xstrdup(e+1);
+		}
+	}
+	strbuf_release(&sb);
+
+	/* 
+	 * parse_options adds a NULL terminator at end of argv. Do the same for
+	 * new_argv.
+	 */
+	new_argv = xrealloc(new_argv, *argc + 1 * sizeof(char *));
+	new_argv[*argc] = NULL;
+
+	return new_argv;
+}
diff --git a/wt-status.c b/wt-status.c
index 47735d8..6013fbd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -96,6 +96,106 @@ static void wt_status_print_trailer(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 }
 
+struct id_list {
+	struct id_list *next;
+	char status;
+	int nr;
+	char *name;
+};
+
+static struct id_list *wt_files = NULL;
+static struct id_list *wt_files_last = NULL;
+static int n_id_list = 0;
+
+static int get_id_list_id(char status)
+{
+	static int added = 0;
+	static int copied = 0;
+	static int deleted = 0;
+	static int modified = 0;
+	static int renamed = 0;
+	static int type_changed = 0;
+	static int unknown = 0;
+	static int unmerged = 0;
+
+	switch(status) {
+	case DIFF_STATUS_ADDED:
+		return ++added;
+	case DIFF_STATUS_COPIED:
+		return ++copied;
+	case DIFF_STATUS_DELETED:
+		return ++deleted;
+	case DIFF_STATUS_MODIFIED:
+		return ++modified;
+	case DIFF_STATUS_RENAMED:
+		return ++renamed;
+	case DIFF_STATUS_TYPE_CHANGED:
+		return ++type_changed;
+	case DIFF_STATUS_UNKNOWN:
+		return ++unknown;
+	case DIFF_STATUS_UNMERGED:
+		return ++unmerged;
+	}
+	die("bug: unhandled diff status %c", status);
+}
+
+static int add_to_id_list(char status, const char *name)
+{
+	struct id_list *new_entry;
+	if(wt_files_last == NULL) {
+		wt_files = xcalloc(1, sizeof(*wt_files));
+		wt_files_last = wt_files;
+		new_entry = wt_files_last;
+	} else {
+		wt_files_last->next = xcalloc(1, sizeof(*wt_files));
+		new_entry = wt_files_last->next;
+		wt_files_last = wt_files_last->next;
+	}
+	new_entry->name = xstrdup(name);
+	new_entry->nr = get_id_list_id(status);
+	new_entry->status = status;
+	new_entry->next = NULL;
+
+	n_id_list++;
+
+	return new_entry->nr;
+}
+
+static void store_id_list()
+{
+	FILE *fp;
+	struct id_list *p = wt_files;
+	const char *filename = git_path("FILE_IDS");
+
+	fp = fopen(filename, "w");
+	if (!fp)
+		die("cannot open %s: %s\n", filename, strerror(errno));
+
+	while (p) {
+		fprintf(fp, "%c%d %s\n",tolower(p->status), p->nr, p->name);
+		p = p->next;
+	}
+	fclose(fp);
+}
+
+static void free_id_list()
+{
+  struct id_list *p = wt_files;
+  struct id_list *next = p;
+  while (p) {
+    next = p->next;
+    free(p->name);
+    free(p);
+    p = next;
+  }
+  wt_files = NULL;
+}
+
+static void format_id(char *buf, char status, int nr)
+{
+	sprintf(buf, " (%c%d)", tolower(status), nr);
+}
+
 #define quote_path quote_path_relative
 
 static void wt_status_print_filepair(struct wt_status *s,
@@ -104,35 +204,48 @@ static void wt_status_print_filepair(struct wt_status *s,
 	const char *c = color(t);
 	const char *one, *two;
 	struct strbuf onebuf = STRBUF_INIT, twobuf = STRBUF_INIT;
+	char id[64] = ""; /* arbitrary limit, 64 should be enough for everybody ... */
+	int nr;
 
 	one = quote_path(p->one->path, -1, &onebuf, s->prefix);
 	two = quote_path(p->two->path, -1, &twobuf, s->prefix);
 
+	if (s->show_file_id) {
+		if ( p->status == DIFF_STATUS_RENAMED 
+		     || p->status == DIFF_STATUS_COPIED)
+			nr = add_to_id_list(p->status, two);
+		else
+			nr = add_to_id_list(p->status, one);
+		format_id(id, p->status, nr);
+	}
+
+
 	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
 	switch (p->status) {
 	case DIFF_STATUS_ADDED:
-		color_fprintf(s->fp, c, "new file:   %s", one);
+		color_fprintf(s->fp, c, "new file:   %s%s", one, id);
 		break;
 	case DIFF_STATUS_COPIED:
-		color_fprintf(s->fp, c, "copied:     %s -> %s", one, two);
+		color_fprintf(s->fp, c, "copied:     %s -> %s%s", one, two, id);
 		break;
 	case DIFF_STATUS_DELETED:
-		color_fprintf(s->fp, c, "deleted:    %s", one);
+		color_fprintf(s->fp, c, "deleted:    %s%s", one, id);
 		break;
 	case DIFF_STATUS_MODIFIED:
-		color_fprintf(s->fp, c, "modified:   %s", one);
+		color_fprintf(s->fp, c, "modified:   %s%s", one, id);
+
 		break;
 	case DIFF_STATUS_RENAMED:
-		color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
+		color_fprintf(s->fp, c, "renamed:    %s -> %s%s", one, two, id);
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
-		color_fprintf(s->fp, c, "typechange: %s", one);
+		color_fprintf(s->fp, c, "typechange: %s%s", one, id);
 		break;
 	case DIFF_STATUS_UNKNOWN:
-		color_fprintf(s->fp, c, "unknown:    %s", one);
+		color_fprintf(s->fp, c, "unknown:    %s%s", one, id);
 		break;
 	case DIFF_STATUS_UNMERGED:
-		color_fprintf(s->fp, c, "unmerged:   %s", one);
+		color_fprintf(s->fp, c, "unmerged:   %s%s", one, id);
 		break;
 	default:
 		die("bug: unhandled diff status %c", p->status);
@@ -247,6 +360,9 @@ static void wt_status_print_untracked(struct wt_status *s)
 	int i;
 	int shown_header = 0;
 	struct strbuf buf = STRBUF_INIT;
+	char id[64] = ""; /* arbitrary limit, 64 should be enough for everybody ... */
+	char *quoted;
+	int nr;
 
 	memset(&dir, 0, sizeof(dir));
 
@@ -266,9 +382,13 @@ static void wt_status_print_untracked(struct wt_status *s)
 			shown_header = 1;
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
-		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%s",
-				quote_path(ent->name, ent->len,
-					&buf, s->prefix));
+		quoted = quote_path(ent->name, ent->len, &buf, s->prefix);
+		if (s->show_file_id) {
+			nr = add_to_id_list(DIFF_STATUS_UNKNOWN, quoted);
+			format_id(id, DIFF_STATUS_UNKNOWN, nr);
+		}
+		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%s%s",
+				quoted, id);
 	}
 	strbuf_release(&buf);
 }
@@ -370,6 +490,10 @@ void wt_status_print(struct wt_status *s)
 		else
 			printf("nothing to commit (working directory clean)\n");
 	}
+	if (s->show_file_id) {
+		store_id_list();
+		free_id_list();
+	}
 }
 
 int git_status_config(const char *k, const char *v, void *cb)
diff --git a/wt-status.h b/wt-status.h
index 78add09..efcb566 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -23,6 +23,7 @@ struct wt_status {
 	char *branch;
 	const char *reference;
 	int verbose;
+	int show_file_id;
 	int amend;
 	int untracked;
 	int nowarn;
-- 
1.6.4.13.ge6580
