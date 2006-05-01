From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] built-in "git grep" (git grip).
Date: Sun, 30 Apr 2006 23:32:36 -0700
Message-ID: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 01 08:32:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaRxk-0005KM-8s
	for gcvg-git@gmane.org; Mon, 01 May 2006 08:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWEAGck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 02:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWEAGck
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 02:32:40 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:8603 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751267AbWEAGcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 02:32:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060501063237.XZVN17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 1 May 2006 02:32:37 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19371>

This attempts to set up built-in "git grep" to further reduce
our dependence on the shell, while at the same time optionally
allowing to run grep against object database.  You could do
funky things like these:

	git grep --cached -e pattern	;# grep from index
	git grep -e pattern master	;# or in a rev
	git grep -e pattern master next ;# or in multiple revs
	git grep -e pattern pu^@	;# even like this with an
					;# extension from another topic ;-)
	git grep -e pattern master..next ;# or even from rev ranges
	git grep -e pattern master~20:Documentation
					;# or an arbitrary tree
	git grep -e pattern next:git-commit.sh
        				;# or an arbitrary blob

Right now, it does not understand and/or obey many options grep
should accept, and the pattern matcher using POSIX.2 regex seems
to be excruciatingly slow (I lifted it from Pasky's regexp
pickaxe code almost verbatim without thinking -- I was too
tired).  Help to improve things in the grep_buffer() function is
very much appreciated.

But this is going in the right direction.  The shell script
version is one of the worst Portability offender in the git
barebone Porcelainish; it uses xargs -0 to pass paths around and
shell arrays to sift flags and parameters.

In order to stay out of the way of real work people want to get
done with the real "git grep", for now this implementation is
called "git grip".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile       |    2 
 builtin-grep.c |  377 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h      |    1 
 git.c          |    1 
 4 files changed, 380 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8ce27a6..8d5122b 100644
--- a/Makefile
+++ b/Makefile
@@ -214,7 +214,7 @@ LIB_OBJS = \
 	$(DIFF_OBJS)
 
 BUILTIN_OBJS = \
-	builtin-log.o builtin-help.o
+	builtin-log.o builtin-help.o builtin-grep.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-grep.c b/builtin-grep.c
new file mode 100644
index 0000000..adcdbaa
--- /dev/null
+++ b/builtin-grep.c
@@ -0,0 +1,377 @@
+/*
+ * Builtin "git grep"
+ *
+ * Copyright (c) 2006 Junio C Hamano
+ */
+#include "cache.h"
+#include "blob.h"
+#include "tree.h"
+#include "commit.h"
+#include "tag.h"
+#include "diff.h"
+#include "revision.h"
+#include "builtin.h"
+#include <regex.h>
+
+struct grep_opt {
+	const char *pattern;
+	regex_t regexp;
+	unsigned linenum:1;
+	unsigned pre_context;
+	unsigned post_context;
+};
+
+static char *end_of_line(char *cp, unsigned long *left)
+{
+	unsigned long l = *left;
+	while (l && *cp != '\n') {
+		l--;
+		cp++;
+	}
+	*left = l;
+	return cp;
+}
+
+static int grep_buffer(struct grep_opt *opt, const char *name,
+		       char *buf, unsigned long size)
+{
+	char *bol = buf;
+	unsigned long left = size;
+	unsigned lno = 1;
+	int hit = 0;
+
+	while (left) {
+		regmatch_t pmatch[10];
+		int flags = 0;
+		char *eol, *cp, ch;
+		eol = end_of_line(bol, &left);
+		ch = *eol;
+		*eol = 0;
+		for (cp = bol; cp < eol; cp++) { 
+			int status = regexec(&opt->regexp, cp,
+					     ARRAY_SIZE(pmatch), pmatch,
+					     flags);
+			if (status == REG_NOMATCH)
+				flags |= REG_NOTBOL;
+			else if (status == 0) {
+				/* Hit at this line */
+				printf("%s:", name);
+				if (opt->linenum)
+					printf("%d:", lno);
+				printf("%.*s\n", eol-bol, bol);
+				hit = 1;
+				break;
+			}
+		}
+		*eol = ch;
+		bol = eol + 1;
+		left--;
+		lno++;
+	}
+	return hit;
+}
+
+static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1, const char *name)
+{
+	unsigned long size;
+	char *data;
+	char type[20];
+	int hit;
+	data = read_sha1_file(sha1, type, &size);
+	if (!data) {
+		error("'%s': unable to read %s", name, sha1_to_hex(sha1));
+		return 0;
+	}
+	hit = grep_buffer(opt, name, data, size);
+	free(data);
+	return hit;
+}
+
+static int grep_file(struct grep_opt *opt, const char *filename)
+{
+	struct stat st;
+	int i;
+	char *data;
+	if (lstat(filename, &st) < 0) {
+	err_ret:
+		if (errno != ENOENT)
+			error("'%s': %s", filename, strerror(errno));
+		return 0;
+	}
+	if (!st.st_size)
+		return 0; /* empty file -- no grep hit */
+	if (!S_ISREG(st.st_mode))
+		return 0;
+	i = open(filename, O_RDONLY);
+	if (i < 0)
+		goto err_ret;
+	data = xmalloc(st.st_size + 1);
+	if (st.st_size != xread(i, data, st.st_size)) {
+		error("'%s': short read %s", filename, strerror(errno));
+		close(i);
+		free(data);
+		return 0;
+	}
+	close(i);
+	i = grep_buffer(opt, filename, data, st.st_size);
+	free(data);
+	return i;
+}
+
+static int grep_cache(struct grep_opt *opt, struct rev_info *revs, int cached)
+{
+	int hit = 0;
+	int nr;
+	read_cache();
+
+	for (nr = 0; nr < active_nr; nr++) {
+		struct cache_entry *ce = active_cache[nr];
+		if (ce_stage(ce) || !S_ISREG(ntohl(ce->ce_mode)))
+			continue;
+		if (revs->diffopt.nr_paths) {
+			int i;
+			int namelen = ce_namelen(ce);
+			const char *name = ce->name;
+			for (i = 0; i < revs->diffopt.nr_paths; i++) {
+				const char *match = revs->diffopt.paths[i];
+				int matchlen = revs->diffopt.pathlens[i];
+				if (matchlen <= namelen)
+					if (!strncmp(name, match, matchlen))
+						break;
+			}
+			if (revs->diffopt.nr_paths <= i)
+				continue;
+		}
+		if (cached)
+			hit |= grep_sha1(opt, ce->sha1, ce->name);
+		else
+			hit |= grep_file(opt, ce->name);
+	}
+	return hit;
+}
+
+static int pathspec_matches(struct diff_options *opt, const char *name)
+{
+	int i;
+	int namelen;
+	if (!opt->nr_paths)
+		return 1;
+	namelen = strlen(name);
+	for (i = 0; i < opt->nr_paths; i++) {
+		const char *match = opt->paths[i];
+		int matchlen = opt->pathlens[i];
+		if (matchlen <= namelen)
+			if (!strncmp(name, match, matchlen))
+				return 1;
+	}
+	return 0;
+}
+
+static int grep_tree(struct grep_opt *opt, struct rev_info *revs,
+		     struct tree_desc *tree,
+		     const char *tree_name, const char *base)
+{
+	unsigned mode;
+	int len;
+	int hit = 0;
+	const char *path;
+	const unsigned char *sha1;
+	char *down_base;
+	char *path_buf = xmalloc(PATH_MAX + strlen(tree_name) + 100);
+
+	if (tree_name[0]) {
+		int offset = sprintf(path_buf, "%s:", tree_name);
+		down_base = path_buf + offset;
+		strcat(down_base, base);
+	}
+	else {
+		down_base = path_buf;
+		strcpy(down_base, base);
+	}
+	len = strlen(path_buf);
+
+	while (tree->size) {
+		int pathlen;
+		sha1 = tree_entry_extract(tree, &path, &mode);
+		pathlen = strlen(path);
+		strcpy(path_buf + len, path);
+
+		if (!pathspec_matches(&revs->diffopt, down_base))
+			;
+		else if (S_ISREG(mode))
+			hit |= grep_sha1(opt, sha1, path_buf);
+		else if (S_ISDIR(mode)) {
+			char type[20];
+			struct tree_desc sub;
+			void *data;
+			data = read_sha1_file(sha1, type, &sub.size);
+			if (!data)
+				die("unable to read tree (%s)",
+				    sha1_to_hex(sha1));
+			strcpy(path_buf + len + pathlen, "/");
+			sub.buf = data;
+			hit = grep_tree(opt, revs, &sub, tree_name, down_base);
+			free(data);
+		}
+		update_tree_entry(tree);
+	}
+	return hit;
+}
+
+static int grep_object(struct grep_opt *opt, struct rev_info *revs,
+		       struct object *obj, const char *name)
+{
+	if (!strcmp(obj->type, blob_type))
+		return grep_sha1(opt, obj->sha1, name);
+	if (!strcmp(obj->type, commit_type) ||
+	    !strcmp(obj->type, tree_type)) {
+		struct tree_desc tree;
+		void *data;
+		int hit;
+		data = read_object_with_reference(obj->sha1, tree_type,
+						  &tree.size, NULL);
+		if (!data)
+			die("unable to read tree (%s)", sha1_to_hex(obj->sha1));
+		tree.buf = data;
+		hit = grep_tree(opt, revs, &tree, name, "");
+		free(data);
+		return hit;
+	}
+	die("unable to grep from object of type %s", obj->type);
+}
+
+static const char builtin_grep_usage[] =
+"git-grep <option>* <rev>* [-e] <pattern> [<path>...]";
+
+int cmd_grep(int argc, const char **argv, char **envp)
+{
+	struct rev_info rev;
+	const char **dst, **src;
+	int err;
+	int hit = 0;
+	int no_more_arg = 0;
+	int seen_range = 0;
+	int seen_noncommit = 0;
+	int cached = 0;
+	struct grep_opt opt;
+	struct object_list *list;
+
+	memset(&opt, 0, sizeof(opt));
+
+	/*
+	 * Interpret and remove the grep options upfront.  Sigh...
+	 */
+	for (dst = src = &argv[1]; src < argc + argv; ) {
+		const char *arg = *src++;
+		if (!no_more_arg) {
+			if (!strcmp("--", arg)) {
+				no_more_arg = 1;
+				*dst++ = arg;
+				continue;
+			}
+			if (!strcmp("--cached", arg)) {
+				cached = 1;
+				continue;
+			}
+			if (!strcmp("-e", arg)) {
+				if (src < argc + argv) {
+					opt.pattern = *src++;
+					continue;
+				}
+				usage(builtin_grep_usage);
+			}
+			if (!strcmp("-n", arg)) {
+				opt.linenum = 1;
+				continue;
+			}
+			if (!strcmp("-H", arg)) {
+				/* We always show the pathname, so this
+				 * is a noop.
+				 */
+				continue;
+			}
+			if (!strcmp("-A", arg) ||
+			    !strcmp("-B", arg) ||
+			    !strcmp("-C", arg)) {
+				unsigned num;
+				if ((argc + argv <= src) ||
+				    sscanf(*src++, "%u", &num) != 1)
+					usage(builtin_grep_usage);
+				switch (arg[1]) {
+				case 'A':
+					opt.post_context = num;
+					break;
+				case 'C':
+					opt.post_context = num;
+				case 'B':
+					opt.pre_context = num;
+					break;
+				}
+				continue;
+			}
+		}
+		*dst++ = arg;
+	}
+	if (!opt.pattern)
+		die("no pattern given.");
+
+	err = regcomp(&opt.regexp, opt.pattern, REG_NEWLINE);
+	if (err) {
+		char errbuf[1024];
+		regerror(err, &opt.regexp, errbuf, 1024);
+		regfree(&opt.regexp);
+		die("'%s': %s", opt.pattern, errbuf);
+	}
+
+	init_revisions(&rev);
+	*dst = NULL;
+	argc = setup_revisions(dst - argv, argv, &rev, NULL);
+
+	/*
+	 * Do not walk "grep -e foo master next pu -- Documentation/"
+	 * but do walk "grep -e foo master..next -- Documentation/".
+	 * Ranged request mixed with a blob or tree object, like
+	 * "grep -e foo v1.0.0:Documentation/ master..next"
+	 * so detect that and complain.
+	 */
+	for (list = rev.pending_objects; list; list = list->next) {
+		struct object *real_obj;
+		if (list->item->flags & UNINTERESTING)
+			seen_range = 1;
+		real_obj = deref_tag(list->item, NULL, 0);
+		if (strcmp(real_obj->type, commit_type))
+			seen_noncommit = 1;
+	}
+	if (!rev.pending_objects)
+		return !grep_cache(&opt, &rev, cached);
+	if (cached)
+		die("both --cached and revisions given.");
+
+	if (seen_range && seen_noncommit)
+		die("both A..B and non commit are given.");
+	if (seen_range) {
+		struct commit *commit;
+		prepare_revision_walk(&rev);
+		while ((commit = get_revision(&rev)) != NULL) {
+			unsigned char *sha1 = commit->object.sha1;
+			char *n = find_unique_abbrev(sha1, DEFAULT_ABBREV);
+			char rev_name[41];
+			strcpy(rev_name, n);
+			if (grep_object(&opt, &rev, &commit->object, rev_name))
+				hit = 1;
+			commit->buffer = NULL;
+		}
+		return !hit;
+	}
+
+	/* all of them are non-commit; do not walk, and
+	 * do not lose their names.
+	 */
+	for (list = rev.pending_objects; list; list = list->next) {
+		struct object *real_obj;
+		real_obj = deref_tag(list->item, NULL, 0);
+		if (grep_object(&opt, &rev, real_obj, list->name))
+			hit = 1;
+	}
+	return !hit;
+}
diff --git a/builtin.h b/builtin.h
index 47408a0..cf5de3b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -19,5 +19,6 @@ extern int cmd_version(int argc, const c
 extern int cmd_whatchanged(int argc, const char **argv, char **envp);
 extern int cmd_show(int argc, const char **argv, char **envp);
 extern int cmd_log(int argc, const char **argv, char **envp);
+extern int cmd_grep(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 01b7e28..18e857d 100644
--- a/git.c
+++ b/git.c
@@ -46,6 +46,7 @@ static void handle_internal_command(int 
 		{ "log", cmd_log },
 		{ "whatchanged", cmd_whatchanged },
 		{ "show", cmd_show },
+		{ "grip", cmd_grep },
 	};
 	int i;
 
-- 
1.3.1.gd233
