From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/6] gitopt: a new command-line option parser for git
Date: Mon, 08 May 2006 22:06:44 -0700
Message-ID: <11471512103526-git-send-email-normalperson@yhbt.net>
References: <1147151209168-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 09 08:22:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdLcO-00087J-VZ
	for gcvg-git@gmane.org; Tue, 09 May 2006 08:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWEIGWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 02:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWEIGWp
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 02:22:45 -0400
Received: from hand.yhbt.net ([66.150.188.102]:7391 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751418AbWEIGWm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 02:22:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E983C2DC03A;
	Mon,  8 May 2006 23:22:40 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <1147151209168-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19822>

It was initially conceived as an addition to the git.c wrapper,
and not affect other programs.  But it turns out existing C
programs can use it pretty easily, too.

Features include:

 * getopt-style permuting (can easily be disabled for
   things like update-index)

 * command-line compatibile with existing usage:
   -S=pickaxe-arg-with-leading-equals is unchanged

 * printf-style rewriting (for front-ending shell scripts)

 * unbundling of short options: -uC20n20z => -u -C20 -n20 -z

 * automatically understands unambiguous abbreviations

 * optional argument handling (-C<num>, -M<num>)
   -C <num> (with a space between them) has not changed,
   however, <num> can be a sha1, or a path

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 .gitignore           |    1 
 Makefile             |   10 +
 git.c                |   11 +
 gitopt.c             |  603 ++++++++++++++++++++++++++++++++++++++++++++++++++
 gitopt.h             |  142 ++++++++++++
 gitopt/git_wrapper.h |   45 ++++
 gitopt/sh.h          |   45 ++++
 t/t0200-gitopt.sh    |  280 +++++++++++++++++++++++
 test-gitopt.c        |  112 +++++++++
 9 files changed, 1244 insertions(+), 5 deletions(-)
 create mode 100644 gitopt.c
 create mode 100644 gitopt.h
 create mode 100644 gitopt/git_wrapper.h
 create mode 100644 gitopt/sh.h
 create mode 100755 t/t0200-gitopt.sh
 create mode 100644 test-gitopt.c

083777c55feab0b68b859f8cb0d5bcf105db4ef5
diff --git a/.gitignore b/.gitignore
index b5959d6..b2d8b06 100644
--- a/.gitignore
+++ b/.gitignore
@@ -123,6 +123,7 @@ git-write-tree
 git-core-*/?*
 test-date
 test-delta
+test-gitopt
 common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 45484fc..46f2401 100644
--- a/Makefile
+++ b/Makefile
@@ -197,7 +197,7 @@ LIB_H = \
 	blob.h cache.h commit.h csum-file.h delta.h \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
-	tree-walk.h log-tree.h
+	tree-walk.h log-tree.h gitopt.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -212,6 +212,7 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
+	gitopt.o \
 	$(DIFF_OBJS)
 
 BUILTIN_OBJS = \
@@ -470,6 +471,8 @@ all:
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
+gitopt.o: gitopt.c gitopt.h gitopt/*.h
+
 git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS)
 	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
@@ -600,7 +603,7 @@ # with that.
 
 export NO_PYTHON
 
-test: all
+test: all test-gitopt$X
 	$(MAKE) -C t/ all
 
 test-date$X: test-date.c date.o ctype.o
@@ -609,6 +612,9 @@ test-date$X: test-date.c date.o ctype.o
 test-delta$X: test-delta.c diff-delta.o patch-delta.o
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $^ -lz
 
+test-gitopt$X: test-gitopt.c gitopt.o ctype.o usage.o
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $^
+
 check:
 	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
 
diff --git a/git.c b/git.c
index 49ba518..785d97f 100644
--- a/git.c
+++ b/git.c
@@ -11,6 +11,7 @@ #include <stdarg.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
 
+#include "gitopt/git_wrapper.h"
 #include "builtin.h"
 
 static void prepend_to_path(const char *dir, int len)
@@ -72,6 +73,7 @@ int main(int argc, const char **argv, ch
 	char *slash = strrchr(cmd, '/');
 	char git_command[PATH_MAX + 1];
 	const char *exec_path = NULL;
+	struct exec_args *ea;
 
 	/*
 	 * Take the basename of argv[0] as the command
@@ -99,7 +101,8 @@ int main(int argc, const char **argv, ch
 	if (!strncmp(cmd, "git-", 4)) {
 		cmd += 4;
 		argv[0] = cmd;
-		handle_internal_command(argc, argv, envp);
+		ea = gitopt_parse_git(argc, argv);
+		handle_internal_command(ea->argc, ea->argv, envp);
 		die("cannot handle %s internally", cmd);
 	}
 
@@ -144,6 +147,8 @@ int main(int argc, const char **argv, ch
 	}
 	argv[0] = cmd;
 
+	ea = gitopt_parse_git(argc, argv);
+
 	/*
 	 * We search for git commands in the following order:
 	 *  - git_exec_path()
@@ -157,10 +162,10 @@ int main(int argc, const char **argv, ch
 	prepend_to_path(exec_path, strlen(exec_path));
 
 	/* See if it's an internal command */
-	handle_internal_command(argc, argv, envp);
+	handle_internal_command(ea->argc, ea->argv, envp);
 
 	/* .. then try the external ones */
-	execv_git_cmd(argv);
+	execv_git_cmd(ea->argv);
 
 	if (errno == ENOENT)
 		cmd_usage(0, exec_path, "'%s' is not a git-command", cmd);
diff --git a/gitopt.c b/gitopt.c
new file mode 100644
index 0000000..056e163
--- /dev/null
+++ b/gitopt.c
@@ -0,0 +1,603 @@
+#include "git-compat-util.h"
+#include "gitopt.h"
+#include "cache.h"
+
+/* whether or not to pass-through unrecognized switches or to report an error.
+ * This is only intended to be set to true for use in the git.c wrapper */
+int gitopt_pass_through = 0;
+static int gitopt_errno = 0;
+int gitopt_dd_seen = 0;	/* double-dash seen flag */
+
+void (*gitopt_non_option_cb)(struct exec_args *b, const int argc,
+				const char **argv, int *argc_pos);
+
+void gitopt_default_non_option_cb(struct exec_args *b, const int argc,
+				const char **argv, int *argc_pos)
+{
+	b->argv[b->argc++] = argv[*argc_pos];
+}
+
+struct exec_args *new_exec_args(const int argc)
+{
+	struct exec_args *ea = xmalloc(sizeof(*ea));
+	ea->argc = argc;
+	ea->argv = xcalloc((argc+1), sizeof(char*));
+
+	return ea;
+}
+
+struct exec_args *nil_exec_args(struct exec_args *ea)
+{
+	int i;
+	for (i = 0; i < ea->argc; i++)
+		ea->argv[i] = NULL;
+	ea->argc = 0;
+	return ea;
+}
+
+static int combine_exec_args(struct exec_args *dest, struct exec_args *from)
+{
+	int i;
+
+	dest->argv = xrealloc(dest->argv,
+				(2 + dest->argc + from->argc)*sizeof(char*));
+
+	for (i = 0; i < from->argc; i++)
+		dest->argv[dest->argc++] = from->argv[i];
+
+	dest->argv[dest->argc] = NULL;
+
+	return i;
+}
+
+static struct exec_args *rewrite_args(const char *rewrite_fmt, const char *arg)
+{
+	struct exec_args *ea;
+	size_t len = strlen(rewrite_fmt) + (arg ? strlen(arg) : 0);
+	char *dest = xmalloc(len); /* don't free this */
+	int nr_ws = 0;
+	char *a, *b;
+
+	if (!arg) {
+		strcpy(dest, rewrite_fmt);
+		if ((a = strstr(dest,"=%s")) || (a = strstr(dest," %s")))
+			a[0] = a[1] = a[2] = '\0';
+		else if ((a = strstr(dest,"%s")))
+			a[0] = a[1] = '\0';
+	} else {
+		const char *c = rewrite_fmt;
+
+		do { if (isspace(*c++)) nr_ws++; } while (*c);
+		snprintf(dest, len, rewrite_fmt, arg);
+	}
+
+	ea = new_exec_args(1 + nr_ws);
+	a = b = dest;
+
+	for (ea->argc = 0; nr_ws && *b; b++) {
+		if (isspace(*b)) {
+			*b = '\0';
+			if (strlen(a))
+				ea->argv[ea->argc++] = a;
+			a = b + 1;
+		}
+	}
+	if (strlen(a))
+		ea->argv[ea->argc++] = a;
+	ea->argv[ea->argc] = NULL;
+
+	return ea;
+}
+
+struct exec_args *one_arg(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos)
+{
+	const char *c = argv[*argc_pos];
+	struct exec_args *ea = NULL;
+	const char *a = NULL;
+	size_t l_len = s->l ? strlen(s->l) : 0;
+	int so = 0; /* short option passed flag */
+
+	if (*c == '-')  {
+		if (s->s && c[1] != '-') {
+			if (isspace(s->s)) {
+				a = c + 1;
+				so = 1;
+			} else if (c[1] == s->s) {
+				a = c + 2;
+				so = 1;
+			}
+		} else if (s->l && c[1] == '-' && !strncmp(c+2, s->l, l_len))
+			a = c + 2 + l_len;
+	}
+
+	if (!a)
+		return NULL;
+
+	switch(a[0]) {
+	case '\0':
+		if (((*argc_pos + 1) < argc) && (a = argv[*argc_pos + 1])) {
+			/* optional arguments must be attached to the switch
+			 * so that there are no abiguities */
+			if (s->arg_fl & ARG_IS_OPT)
+				break;
+			*argc_pos += 1;
+			if (s->rewrite_fmt)
+				ea = rewrite_args(s->rewrite_fmt, a);
+			else {
+				ea = new_exec_args(2);
+				ea->argv[0] = c;
+				ea->argv[1] = a;
+			}
+		}
+		break;
+	case '=': /* only long options get to use "=" to denote an arg */
+		if (!so) {
+			if (s->rewrite_fmt)
+				ea = rewrite_args(s->rewrite_fmt, a + 1);
+			else {
+				ea = new_exec_args(1);
+				ea->argv[0] = c;
+			}
+			break;
+		}
+		/* fall-through, so that -S'= assigned_val;' still works */
+	default:
+		/* -s<a> (short opts only), long opts are ambiguous
+		 * w/o '=' or a space separating the opt */
+		if (!so)
+			break;
+		if (s->rewrite_fmt)
+			ea = rewrite_args(s->rewrite_fmt, a);
+		else {
+			ea = new_exec_args(1);
+			ea->argv[0] = c;
+		}
+	}
+
+	return ea;
+}
+
+static struct exec_args *optional_arg_common(struct exec_args *ea,
+			const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos)
+{
+	if (!ea) {
+		if (s->rewrite_fmt)
+			ea = rewrite_args(s->rewrite_fmt, NULL);
+		else {
+			ea = new_exec_args(1);
+			ea->argv[0] = argv[*argc_pos];
+		}
+	}
+	return ea;
+}
+
+struct exec_args *optional_arg(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos)
+{
+	return optional_arg_common( one_arg(s, argc, argv, argc_pos),
+						s, argc, argv, argc_pos);
+}
+
+struct exec_args *int_arg(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos)
+{
+	struct exec_args *ea = one_arg(s, argc, argv, argc_pos);
+
+	if (ea) {
+		const char *c = ea->argv[ea->argc - 1];
+		char *endptr;
+		long int tmp;
+
+		/* -C<num>: */
+		if (ea->argc == 1) {
+			while (*c && !isdigit(*c)) c++;
+			if (!c) goto err;
+		}
+
+		endptr = (char *)c;
+		tmp = strtol(c, &endptr, 10);
+		if (endptr == c) {
+err:
+			if (s->arg_fl & ARG_IS_INT)
+				(*argc_pos)--;
+			free_exec_args(ea);
+			return NULL;
+		}
+	}
+	return ea;
+}
+
+struct exec_args *optional_int_arg(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos)
+{
+	return optional_arg_common( int_arg(s, argc, argv, argc_pos),
+						s, argc, argv, argc_pos);
+}
+
+static struct exec_args *run_proc(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos)
+{
+	if (s->fn)
+		return s->fn(s, argc, argv, argc_pos);
+	switch (s->arg_fl) {
+	case ARG_ONE:
+		return one_arg(s, argc, argv, argc_pos);
+	case ARG_INT:
+		return int_arg(s, argc, argv, argc_pos);
+	case ARG_OPT:
+		return optional_arg(s, argc, argv, argc_pos);
+	case ARG_OPTINT:
+		return optional_int_arg(s, argc, argv, argc_pos);
+	default:
+		return NULL;
+	}
+}
+
+static const char * parse_bundled(struct exec_args *dest,
+			const struct opt_spec *s, const char *cur,
+			const int argc, const char **argv, int *arg_pos)
+{
+	struct exec_args *ea = NULL;
+	const char *orig = cur;
+	char *c = xmalloc(strlen(cur) + 2); /* don't free this */
+	const char *tmp_argv[] = { c };
+	int i = 0;
+
+	*c++ = '-';
+	*c++ = *cur++;
+	if (!s || (!s->arg_fl && !s->fn)) {
+		ea = new_exec_args(1);
+		if (s && s->rewrite_fmt)
+			ea->argv[0] = s->rewrite_fmt;
+		else {
+			ea->argv[0] = tmp_argv[0];
+			*c = '\0';
+		}
+	} else if (s->arg_fl || s->fn) {
+		if (*cur) {
+			/* no space between the arg and opt switch: */
+			if (s->arg_fl & ARG_IS_INT) {
+				/* we know to handle stuff like:
+				 * -h24w80 => -h=24 -w=80 */
+				char *endptr = (char *)cur;
+				strtol(cur, &endptr, 10);
+
+				while (cur < endptr)
+					*c++ = *cur++;
+			} else if (s->arg_fl & ARG_ONE) {
+				/* unfortunately, other args are less
+				 * clear-cut */
+				while (*cur)
+					*c++ = *cur++;
+			}
+			*c = '\0';
+			ea = run_proc(s, 1, tmp_argv, &i);
+		} else if ((*arg_pos + 1) < argc) {
+			int j = *arg_pos;
+			int x = argc - j;
+			const char **argv2 = xmalloc(x * sizeof(char *));
+
+			*c = '\0';
+			argv2[i++] = tmp_argv[0];
+			while (i <= x) argv2[i++] = argv[++j];
+
+			i = 0;
+			ea = run_proc(s, x, argv2, &i);
+			*arg_pos += i;
+			free(argv2);
+		}
+	}
+	if (ea) {
+		combine_exec_args(dest, ea);
+		free_exec_args(ea);
+	} else
+		gitopt_errno = error("Failed to parse bundled arguments in: %s",
+									orig);
+	return cur;
+}
+
+static void unbundle(struct exec_args *dest, const char *cur,
+		const struct opt_spec *ost,
+		const struct opt_spec *cur_spec,
+		const int argc, const char **argv, int *arg_pos)
+{
+	struct exec_args *ea = new_exec_args(strlen(cur));
+	const struct opt_spec *s;
+	const char *c = cur;
+
+	ea->argc = 0;
+
+	while (*c) {
+		int i;
+		for (i = 0; ost[i].s || ost[i].l; i++) {
+			s = ost + i;
+			if (!s->s || (!isspace(s->s) && s->s != *c))
+				continue;
+			c = parse_bundled(ea, s, c, argc, argv, arg_pos);
+			break;
+		}
+		if (ost[i].l || ost[i].s) continue;
+		/* pass-through while unbundling and creating switches:
+		 * this means that if we see -abc here, but we only
+		 * had -a defined in ost (-a defined to not accept args),
+		 * then we'd create switches
+		 * for -b and -c here (since we already knew -a)
+		 * and we're assuming -b and -c were just forgotten
+		 * in the ost.  If we had gotten -bac, that would
+		 * be passed through as -bac in gitopt_parse_ost()
+		 * as an unknown option if -b is undefined in the ost
+		 */
+		if (gitopt_pass_through)
+			c = parse_bundled(ea, NULL, c, argc, argv, arg_pos);
+		else {
+			/* continue for now, a higher-up function will work
+			 * with the error */
+			gitopt_errno = error("Unknown option '%s' in '%s'",
+							c,argv[*arg_pos]);
+			c++;
+		}
+	}
+	combine_exec_args(dest, ea);
+	free_exec_args(ea);
+}
+
+static void push_one_opt(struct exec_args *dest, const struct opt_spec *s,
+		const int argc, const char **argv, int *i)
+{
+	struct exec_args *ea;
+
+	if (!s->arg_fl && !s->fn) {
+		dest->argv[dest->argc++] = s->rewrite_fmt ? s->rewrite_fmt
+							: argv[*i];
+		return;
+	}
+
+	if ((ea = run_proc(s,argc,argv,i))) {
+		combine_exec_args(dest, ea);
+		free_exec_args(ea);
+	} else
+		gitopt_errno = error("Failed to parse arguments for: %s %s",
+					argv[*i], argv[*i+1]?argv[*i+1]:"");
+}
+
+/* look for a prefix abbreviation */
+static int opt_abbrev_match(const struct opt_spec *s, const char *p)
+{
+	const char *l = s->l;
+
+	while (*p) {
+		if (*l++ != *p++) return 0;
+		if (!*p || (s->arg_fl && *p == '=')) return 1;
+	}
+
+	return 0;
+}
+
+/* match a short option switch */
+static int opt_char_match(const struct opt_spec *s, const char *p)
+{
+	return ((s->s == p[0]) && ((!s->arg_fl && p[1] == '\0')
+				||
+			(s->arg_fl && (p[1] == '\0' || p[1] == '='))));
+}
+
+/* tokenize on '-' and look for a prefix abbreviation match */
+static int opt_token_match(const struct opt_spec *s, const char *p0)
+{
+	const char *l = s->l;
+	const char *p;
+
+	while ((l = strchr(l,'-'))) {
+		l++;
+		p = p0;
+		while (*p) {
+			if (*l++ != *p++) break;
+			if (!*p || (s->arg_fl && *p == '=')) return 1;
+		}
+	}
+
+	return 0;
+}
+
+/* look for unambigious abbreviated switches, if it can't be found,
+ * assume it's a non-option and pass it to b */
+static void fallback_long(const struct opt_spec *ost,
+			struct exec_args *a, struct exec_args *b,
+			const int argc, const char **argv,
+			const char *cur, int *argc_pos)
+{
+	const struct opt_spec *s;
+	int i, found = -1;
+
+	/* look for abbreviations: */
+	for (i = 0; ost[i].l || ost[i].s; i++) {
+		s = &(ost[i]);
+		/* maybe they wanted to use a short option
+		 * (normally a single-dash) but typed two dashes instead.
+		 * note: even if we find a short option here, we do not
+		 * attempt to unbundle in this case */
+		if ((s->s && opt_char_match(s, cur)) ||
+					(s->l && opt_abbrev_match(s,cur))) {
+			if (found >= 0)
+				goto pass_through;
+			found = i;
+		}
+	}
+
+	/* ok, try harder, based on tokenization on '-' */
+	if (found < 0) {
+		for (i = 0; ost[i].l || ost[i].s; i++) {
+			s = &(ost[i]);
+			if (s->l && opt_token_match(s,cur)) {
+				if (found >= 0)
+					goto pass_through;
+				found = i;
+			}
+		}
+	}
+	/* should I add a strstr() matcher here for the desperate? */
+
+	/* rewrite the abbreviated switch in it's unabbreviated form: */
+	if (found >= 0) {
+		char *tmp;
+		size_t len = 3 + strlen(cur); /* --cur=potential_args\0 */
+		size_t l_len;
+
+		s = &(ost[found]);
+		l_len = s->l ? strlen(s->l) : 0; /* favor long options */
+		tmp = xcalloc(len + l_len, 1); /* don't free this */
+		tmp[0] = '-';
+
+		if (s->l) {
+			tmp[1] = '-';
+			memcpy(tmp + 2, s->l, l_len);
+		} else
+			tmp[1] = s->s;
+		if (s->arg_fl) {
+			const char *c;
+			if ((c = strchr(cur,'='))) {
+				if (!l_len) c++; /* skip '=' for short opts */
+				strcpy(tmp + 2 + l_len, c);
+			}
+		}
+
+		argv[*argc_pos] = tmp;
+		push_one_opt(a, s, argc, argv, argc_pos);
+		return;
+	}
+
+pass_through:
+	gitopt_non_option_cb(b, argc, argv, argc_pos);
+	if (!gitopt_pass_through)
+		gitopt_errno = error("Unknown option: '%s'",argv[*argc_pos]);
+}
+
+static int opt_complete_match(const struct opt_spec *s, const char *p)
+{
+	if (s->arg_fl) {
+		size_t len = strlen(s->l);
+
+		return (!strncmp(s->l,p,len) &&
+				(p[len] == '\0' || (p[len] == '=')));
+	}
+	return !strcmp(s->l,p);
+}
+
+/* You should really only use this in git (wrapper) and test-gitopt: */
+struct exec_args *gitopt_parse_ost(const struct opt_spec *ost,
+			const int argc, const char **argv)
+{
+	struct exec_args *a = new_exec_args(argc); /* argv[0] and options: */
+	struct exec_args *b = new_exec_args(argc); /* non-option args */
+
+	gitopt_pass_through = 1;
+
+	if (gitopt_parse_ost_split(a, b, ost, argc, argv) < 0)
+		die("gitopt argument parsing failed");
+	combine_exec_args(a, b);
+	free_exec_args(b);
+
+	return a;
+}
+
+int gitopt_verify_b_args(const struct exec_args *b)
+{
+	const char **arg;
+
+	for (arg = b->argv; *arg; arg++) {
+		/* anything goes after a double dash */
+		if (!memcmp("--",*arg,3))
+			return 1;
+		if (*arg[0] == '-')
+			return 0;
+	}
+	return 1;
+}
+
+void gitopt_parse_one_opt(struct exec_args *a, struct exec_args *b,
+			const struct opt_spec *ost,
+			const int argc, const char **argv, int *argc_pos)
+{
+	const char *c = argv[*argc_pos];
+	const struct opt_spec *s;
+	int i;
+
+	if (!gitopt_dd_seen && !memcmp("--",c,3)) {
+		gitopt_dd_seen = 1;
+		if (!gitopt_pass_through)
+			return;
+	}
+	if (gitopt_dd_seen) {
+		gitopt_non_option_cb(b, argc, argv, argc_pos);
+		return;
+	}
+	if (!memcmp("--",c,2)) {	/* long options */
+		c += 2;
+		for (i = 0; ost[i].l || ost[i].s; i++) {
+			s = &(ost[i]);
+			if (!s->l || !opt_complete_match(s, c))
+				continue;
+			push_one_opt(a, s, argc, argv, argc_pos);
+			return;
+		}
+		if (ost[i].l || ost[i].s) return;
+		/* undefined --option: */
+		fallback_long(ost, a, b, argc, argv, c, argc_pos);
+		return;
+	}
+	if ((c[0] == '-') && (c[1] != '-')) { /* short option */
+		c++;
+		for (i = 0; ost[i].l || ost[i].s; i++) {
+			s = &(ost[i]);
+			if (!s->s) continue;
+			if (isspace(s->s) && (*c == '\0' || isdigit(*c))) {
+				/* special case for -<num> */
+				push_one_opt(a, s, argc, argv, argc_pos);
+				return;
+			}
+			if (s->s != *c) continue;
+			if ((c[1] != '\0') && (c[1] != '='))
+				unbundle(a, c, ost, s, argc, argv, argc_pos);
+			else
+				push_one_opt(a, s, argc, argv, argc_pos);
+			return;
+		}
+		if (ost[i].l || ost[i].s) return;
+		/* undefined: */
+		if (gitopt_pass_through)
+			gitopt_non_option_cb(b, argc, argv, argc_pos);
+		else
+			gitopt_errno = error("Unknown option: %s",
+							argv[*argc_pos]);
+		return;
+	}
+	gitopt_non_option_cb(b, argc, argv, argc_pos);
+}
+
+int gitopt_parse_ost_split(struct exec_args *a, struct exec_args *b,
+			const struct opt_spec *ost,
+			const int argc, const char **argv)
+{
+	int i;
+
+	if (!gitopt_non_option_cb)
+		gitopt_non_option_cb = gitopt_default_non_option_cb;
+
+	gitopt_dd_seen = 0;
+	b->argc = 0;
+	a->argv[0] = argv[0];
+	a->argc = 1;
+
+	for (i = 1; i < argc; i++)
+		gitopt_parse_one_opt(a, b, ost, argc, argv, &i);
+	return gitopt_errno;
+}
+
+void free_exec_args(struct exec_args *ea)
+{
+	free(ea->argv);
+	free(ea);
+}
+
diff --git a/gitopt.h b/gitopt.h
new file mode 100644
index 0000000..78c9e5d
--- /dev/null
+++ b/gitopt.h
@@ -0,0 +1,142 @@
+#ifndef GITOPT_H
+#define GITOPT_H
+
+/* gitopt_* functions will return this structure
+ * the elements in this struct can then be treated just
+ * like their counterparts from main(). */
+struct exec_args {
+	const char **argv;
+	int argc;
+};
+
+/* @l: long option string (without the leading "--")
+ *
+ * @s: single option char, ' ' has a special meaning for accepting a
+ * single '-' (dash), which can also accept an integer argument This is
+ * for things like "-5" => "--max-count=5" or "-" => "--stdin"
+ *
+ * @rewrite_fmt: rewrite the passed argument(s) (if any) into this
+ * (*printf) style string.  Only a single %s can be accepted and handled
+ * by the default fn() handlers included in gitopt.
+ *
+ * Do not use this if you need to use more than one "%s", you'll need to
+ * define and use a custom fn().  rewrite_fmt is only intended for
+ * the common argument rewriting cases.
+ *
+ * If rewrite_fmt has a "%s", " %s" or "=%s" in it, it will be stripped
+ * out if no arguments are passed to it (this can be the case where
+ * fn() (see below) is defined to optional_arg).
+ *
+ * Any single space between non-space characters will be interpreted as
+ * break in the option and the options will be split out into seperate
+ * elements in argv.
+ *
+ * @fn: define this to the function you wish to use for handling any
+ * arguments, or cases where rewrite_fmt is too limited.  You can define
+ * your own functions and use it here, of course.  The gitopt_eat*
+ * macros provide convenient ways to write functions for this member.
+ * Set this to 0/NULL if you have no args to parse.
+ */
+struct opt_spec {
+	const char *l;
+	const char s;
+	const char *rewrite_fmt;
+	unsigned int arg_fl;
+	struct exec_args *(*fn)(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos);
+};
+
+/* internal use: */
+#define ARG_IS_INT	0x08
+#define ARG_IS_OPT	0x10
+
+/* use these for opt_spec flags: */
+#define ARG_NIL		0x00
+#define ARG_ONE		0x01
+#define ARG_TWO		0x02	/* not really supported yet */
+#define ARG_THREE	0x04	/* not really supported yet */
+#define ARG_TRE		ARG_THREE
+#define ARG_INT		(ARG_ONE | ARG_IS_INT)
+#define ARG_OPT		(ARG_ONE | ARG_IS_OPT)
+#define ARG_OPTINT	(ARG_ONE | ARG_IS_OPT | ARG_IS_INT)
+
+extern int gitopt_pass_through;
+extern int gitopt_dd_seen;	/* double-dash seen flag */
+void (*gitopt_non_option_cb)(struct exec_args *b, const int argc,
+				const char **argv, int *argc_pos);
+void gitopt_default_non_option_cb(struct exec_args *b, const int argc,
+				const char **argv, int *argc_pos);
+struct exec_args *new_exec_args(const int argc);
+void free_exec_args(struct exec_args *ea);
+struct exec_args *nil_exec_args(struct exec_args *ea);
+
+/* You should really only use this in the git wrapper or tests: */
+struct exec_args *gitopt_parse_ost(const struct opt_spec *ost,
+			const int argc, const char **argv);
+
+/* Most C programs should use this internally.  Returns -1 on error */
+int gitopt_parse_ost_split(struct exec_args *a, struct exec_args *b,
+			const struct opt_spec *ost,
+			const int argc, const char **argv);
+
+# define gitopt_eat(func,code_block) \
+static struct exec_args *func(const struct opt_spec *s, \
+			const int argc, const char **argv, int *argc_pos) \
+{ \
+	code_block \
+	return new_exec_args(0); /* return non-NULL if no errors */ \
+}
+
+# define gitopt_eat_one_arg(func,code_block) \
+static struct exec_args *func(const struct opt_spec *s, \
+			const int argc, const char **argv, int *argc_pos) \
+{ \
+	struct exec_args *ea = one_arg(s, argc, argv, argc_pos); \
+	if (!ea) return NULL; \
+	code_block \
+	return nil_exec_args(ea); /* return non-NULL if no errors */ \
+}
+#define gitopt_eat_arg(func,code_block)	gitopt_eat_one_arg(func,code_block)
+
+# define gitopt_eat_int(func,code_block) \
+static struct exec_args *func(const struct opt_spec *s, \
+			const int argc, const char **argv, int *argc_pos) \
+{ \
+	struct exec_args *ea = one_arg(s, argc, argv, argc_pos); \
+	if (!ea) return NULL; \
+	code_block \
+	return nil_exec_args(ea); /* return non-NULL if no errors */ \
+}
+
+# define gitopt_eat_opt_int(func,code_block) \
+static struct exec_args *func(const struct opt_spec *s, \
+			const int argc, const char **argv, int *argc_pos) \
+{ \
+	struct exec_args *ea = optional_int_arg(s, argc, argv, argc_pos); \
+	code_block \
+	return nil_exec_args(ea); /* return non-NULL if no errors */ \
+}
+
+/* used for debugging */
+static inline void dump_ea(const char *pfx, struct exec_args *ea)
+{
+	const char **arg;
+	int i = 0;
+	for (arg = ea->argv; *arg; arg++)
+		fprintf(stderr,"[%d] %s: %s\n",i++,pfx,*arg);
+}
+
+void gitopt_parse_one_opt(struct exec_args *a, struct exec_args *b,
+			const struct opt_spec *ost,
+			const int argc, const char **argv, int *argc_pos);
+void gitopt_set_pass_through();	/* should only be used by git.c wrapper */
+
+struct exec_args *one_arg(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos);
+struct exec_args *int_arg(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos);
+struct exec_args *optional_arg(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos);
+struct exec_args *optional_int_arg(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos);
+#endif /* GITOPT_H */
diff --git a/gitopt/git_wrapper.h b/gitopt/git_wrapper.h
new file mode 100644
index 0000000..5f27bf4
--- /dev/null
+++ b/gitopt/git_wrapper.h
@@ -0,0 +1,45 @@
+/* opt_spec table mappings for the git.c wrapper */
+
+#include "../gitopt.h"
+#include "../gitopt/sh.h"
+
+static const struct opt_spec ost_null[] = { { 0, 0 } };
+
+static const struct opt_spec_map {
+	const char *cmd;
+	const struct opt_spec *ost;
+} opt_specs[] = {
+	{ "checkout",		ost_checkout },
+	{ "commit",		ost_commit },
+	{ "am",			ost_am},
+};
+
+static const struct opt_spec *find_cmd_ost(const int argc, const char **argv)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(opt_specs); i++) {
+		const char *cmd = opt_specs[i].cmd;
+		if (strcmp(cmd, *argv))
+			continue;
+		return opt_specs[i].ost;
+	}
+	return NULL;
+}
+
+static struct exec_args *gitopt_parse_git(const int argc, const char **argv)
+{
+	const struct opt_spec *ost;
+
+	if (!strcmp(argv[0],"help") || !strcmp(argv[0],"version") ||
+				!(ost = find_cmd_ost(argc, argv))) {
+		struct exec_args *ea = new_exec_args(argc);
+		int i;
+
+		for (i = 0; i <= argc; i++) /* argv[argc] == NULL */
+			ea->argv[i] = argv[i];
+
+		return ea;
+	}
+	return gitopt_parse_ost(ost, argc, argv);
+}
diff --git a/gitopt/sh.h b/gitopt/sh.h
new file mode 100644
index 0000000..0ce6620
--- /dev/null
+++ b/gitopt/sh.h
@@ -0,0 +1,45 @@
+#ifndef GITOPT_SH_H
+#define GITOPT_SH_H
+
+/* opt_spec tables for some git programs written in shell that don't
+ * have too many options */
+
+static const struct opt_spec ost_am[] = {
+	{ "dotest",		'd',	0,		ARG_ONE,	0 },
+	{ "interactive",	'i',	0,		0,		0 },
+	{ "binary",		'b',	0,		0,		0 },
+	{ "3way",		'3',	0,		0,		0 },
+	{ "signoff",		's',	0,		0,		0 },
+	{ "utf8",		'u',	0,		0,		0 },
+	{ "keep",		'k',	0,		0,		0 },
+	{ "resolved",		'r',	0,		0,		0 },
+	{ "skip",		0,	0,		0,		0 },
+	{ "whitespace",		0,	0,		ARG_ONE,	0 },
+	{ 0, 0 }
+};
+
+static const struct opt_spec ost_checkout[] = {
+	{ 0,			'f',	0,		0,		0 },
+	{ 0,			'm',	0,		0,		0 },
+	{ 0,			'b',	"-b %s",	ARG_ONE,	0 },
+	{ 0, 0 }
+};
+
+static const struct opt_spec ost_commit[] = {
+	{ "file",		'F',	0,		ARG_ONE,	0 },
+	{ "all",		'a',	0,		0,		0 },
+	{ "author",		0,	0,		ARG_ONE,	0 },
+	{ "edit",		'e',	0,		0,		0 },
+	{ "include",		'i',	0,		0,		0 },
+	{ "only",		'o',	0,		0,		0 },
+	{ "message",		'm',	0,		ARG_ONE,	0 },
+	{ "no-verify",		'n',	0,		0,		0 },
+	{ "amend",		0,	0,		0,		0 },
+	{ "reedit",		'c',	0,		ARG_ONE,	0 },
+	{ "reuse-message",	'C',	0,		ARG_ONE,	0 },
+	{ "signoff",		's',	0,		0,		0 },
+	{ "verbose",		'v',	0,		0,		0 },
+	{ 0, 0 }
+};
+
+#endif /* GITOPT_SH_H */
diff --git a/t/t0200-gitopt.sh b/t/t0200-gitopt.sh
new file mode 100755
index 0000000..6da686c
--- /dev/null
+++ b/t/t0200-gitopt.sh
@@ -0,0 +1,280 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Eric Wong
+#
+
+test_description='gitopt command-line pa{ss,rs}er'
+
+. ./test-lib.sh
+
+cat > expect <<EOF
+00 'commit'
+01 '(null)'
+EOF
+test_expect_success 'single command' \
+	'test-gitopt commit > output && cmp expect output'
+
+cat > expect <<EOF
+00 'commit'
+01 '-a'
+02 '-s'
+03 '(null)'
+EOF
+test_expect_success 'simple command with switches' \
+	'test-gitopt commit -a -s > output &&
+	cmp expect output'
+
+cat > expect <<EOF
+00 'commit'
+01 '-a'
+02 '-s'
+03 '(null)'
+EOF
+test_expect_success 'command with bundled switches' \
+	'test-gitopt commit -as > output &&
+	cmp expect output'
+
+cat > expect <<EOF
+00 'commit'
+01 '-a'
+02 '-s'
+03 '-mhello world'
+04 '(null)'
+EOF
+test_expect_success 'bundle with args for last (no space)' \
+	'test-gitopt commit -asm"hello world" > output &&
+	cmp expect output'
+
+cat > expect <<EOF
+00 'commit'
+01 '-a'
+02 '-s'
+03 '-m'
+04 'hello world'
+05 '(null)'
+EOF
+test_expect_success 'unbundle with args (space)' \
+	'test-gitopt commit -asm "hello world" > output &&
+	cmp expect output'
+
+cat > expect <<EOF
+00 'commit'
+01 '-a'
+02 '-s'
+03 '-m'
+04 'hello world'
+05 'file1'
+06 'file2'
+07 '(null)'
+EOF
+test_expect_success 'unbundle and reorder switches and command w/args' \
+	'test-gitopt commit file1 file2 -asm "hello world" > output &&
+	cmp expect output'
+
+cat > expect <<EOF
+00 'commit'
+01 '-a'
+02 '-s'
+03 '--edit'
+04 'file2'
+05 '--'
+06 'file1'
+07 '-as'
+08 '--all'
+09 '(null)'
+EOF
+test_expect_success 'reorder up to and pass-through "--"' \
+	'test-gitopt commit -as file2 --edit -- file1 -as --all > output &&
+	cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '--find-copies-harder'
+02 '(null)'
+EOF
+test_expect_success 'abbreviation finder (prefix)' \
+	'test-gitopt whatchanged --find-c > output &&
+	 cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '--patch-with-raw'
+02 '(null)'
+EOF
+test_expect_success 'abbreviation finder (substring on "-" token)' \
+	'test-gitopt whatchanged --raw > output &&
+	 cmp expect output'
+
+# we assume unknown switches that cannot be resolved to a single known
+# switch to just be an new argument we do not know about, so we pass
+# it to the underlying command
+cat > expect <<EOF
+00 'whatchanged'
+01 '--name'
+02 '(null)'
+EOF
+test_expect_success 'ambiguous abbreviation (pass-through)' \
+	'test-gitopt whatchanged --name > output &&
+	 cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '--diff-filter=MCT'
+02 'file1'
+03 '(null)'
+EOF
+test_expect_success 'rewrite on long argument' \
+	'test-gitopt whatchanged file1 --diff-filter MCT > output &&
+	 cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '-Shello'
+02 '(null)'
+EOF
+test_expect_success 'rewrite on short argument (#1)' \
+	'test-gitopt whatchanged -Shello > output &&
+	 cmp expect output'
+test_expect_success 'rewrite on short argument (#2)' \
+	'test-gitopt whatchanged -S hello > output &&
+	 cmp expect output'
+test_expect_success 'rewrite on --short argument (#3)' \
+	'test-gitopt whatchanged --S hello > output &&
+	 cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '-Shello'
+02 '(null)'
+EOF
+test_expect_success 'rewrite on short argument (leading "=" arg) (#1)' \
+	'test-gitopt whatchanged --S=hello > output &&
+	 cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '-C20'
+02 '-M'
+03 '(null)'
+EOF
+test_expect_success 'pass optional arg (#1)' \
+	'test-gitopt whatchanged -C20 -M > output &&
+	 cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '-C'
+02 '--find-copies-harder'
+03 '(null)'
+EOF
+test_expect_success 'detect optional arg bogus (#1)' \
+	'test-gitopt whatchanged -C --find-copies-harder > output &&
+	 cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '-C20'
+02 '(null)'
+EOF
+test_expect_success 'pass optional arg (#2)' \
+	'test-gitopt whatchanged -C20 > output &&
+	 cmp expect output'
+# test_expect_success 'pass optional arg (#3)' \
+	# 'test-gitopt whatchanged -C=20 > output &&
+	 # cmp expect output'
+
+cat > expect <<EOF
+00 'checkout'
+01 '-b'
+02 'newbranch'
+03 '(null)'
+EOF
+test_expect_success 'rewrite short split arg (#1)' \
+	'test-gitopt checkout -bnewbranch > output &&
+	 cmp expect output'
+# test_expect_success 'rewrite short split arg (#2)' \
+	# 'test-gitopt checkout --b=newbranch > output &&
+	 # cmp expect output'
+test_expect_success 'rewrite short sanity check' \
+	'test-gitopt checkout -b newbranch > output &&
+	 cmp expect output'
+
+cat > expect <<EOF
+00 'log'
+01 '--default'
+02 'dunno'
+03 '--all'
+04 '(null)'
+EOF
+test_expect_success 'rewrite long split arg' \
+	'test-gitopt log --default=dunno --all > output &&
+	 cmp expect output'
+test_expect_success 'rewrite long sanity check' \
+	'test-gitopt log --default dunno --all > output &&
+	 cmp expect output'
+
+cat > expect <<EOF
+00 'log'
+01 '--max-count=56'
+02 '(null)'
+EOF
+test_expect_success 'rewrite -<num> => --max-count=<num>' \
+	'test-gitopt log -56 > output && cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '-u'
+02 '-l20'
+03 '-p'
+04 '-Spicktoken'
+05 '(null)'
+EOF
+test_expect_success 'bundle options with integer args mixed in' \
+	'test-gitopt whatchanged -ul20pSpicktoken > output &&
+	cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '-u'
+02 '-C20'
+03 '-p'
+04 '(null)'
+EOF
+test_expect_success 'bundle options with optional integer args used' \
+	'test-gitopt whatchanged -uC20p > output &&
+	cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '-u'
+02 '-C'
+03 '-p'
+04 '(null)'
+EOF
+test_expect_success 'bundle options with optional integer args not used' \
+	'test-gitopt whatchanged -uCp > output &&
+	cmp expect output'
+
+cat > expect <<EOF
+00 'whatchanged'
+01 '-C'
+02 '20'
+03 '(null)'
+EOF
+test_expect_success 'optional integer arg switch must be attached' \
+	'test-gitopt whatchanged -C 20 > output &&
+	cmp expect output'
+
+cat > expect <<EOF
+00 'commit'
+01 '--message'
+02 'hello world'
+03 '-s'
+04 'file'
+05 '(null)'
+EOF
+test_expect_success 'long option argument parsing when short option can work' \
+	'test-gitopt commit --message "hello world" -s file > output &&
+	cmp expect output'
+
+test_done
diff --git a/test-gitopt.c b/test-gitopt.c
new file mode 100644
index 0000000..2692e2b
--- /dev/null
+++ b/test-gitopt.c
@@ -0,0 +1,112 @@
+
+#include "git-compat-util.h"
+#include "gitopt.h"
+#include "gitopt/sh.h"
+
+#define _rev \
+{ "max-count",		'n',	"--max-count=%s",	ARG_INT,	0 }, \
+{ 0,			' ',	"--max-count=%s",	ARG_INT,	0 }, \
+{ "max-age",		0,	"--max-age=%s",		ARG_INT,	0 }, \
+{ "min-age",		0,	"--min-age=%s",		ARG_INT,	0 }, \
+{ "since",		0,	"--since=%s",		ARG_ONE,	0 }, \
+{ "after",		0,	"--after=%s",		ARG_ONE,	0 }, \
+{ "before",		0,	"--before=%s",		ARG_ONE,	0 }, \
+{ "until",		0,	"--until=%s",		ARG_ONE,	0 }, \
+{ "all",		0,	0,			0,		0 }, \
+{ "not",		0,	0,			0,		0 }, \
+{ "default",		0,	"--default %s",		ARG_ONE,	0 }, \
+{ "topo-order",		0,	0,			0,		0 }, \
+{ "date-order",		0,	0,			0,		0 }, \
+{ "parents",		0,	0,			0,		0 }, \
+{ "dense",		0,	0,			0,		0 }, \
+{ "sparse",		0,	0,			0,		0 }, \
+{ "remove-empty",	0,	0,			0,		0 }, \
+{ "no-merges",		0,	0,			0,		0 }, \
+{ "boundary",		0,	0,			0,		0 }, \
+{ "objects",		0,	0,			0,		0 }, \
+{ "objects-edge",	0,	0,			0,		0 }, \
+{ "unpacked",		0,	0,			0,		0 }, \
+{ 0,			'r',	0,			0,		0 }, \
+{ 0,			't',	0,			0,		0 }, \
+{ 0,			'm',	0,			0,		0 }, \
+{ 0,			'c',	0,			0,		0 }, \
+{ "cc",			0,	0,			0,		0 }, \
+{ 0,			'v',	0,			0,		0 }, \
+{ "pretty",		0,	"--pretty=%s",		ARG_ONE,	0 }, \
+{ "root",		0,	0,			0,		0 }, \
+{ "no-commit-id",	0,	0,			0,		0 }, \
+{ "always",		0,	0,			0,		0 }, \
+{ "no-abbrev",		0,	0,			0,		0 }, \
+{ "abbrev",		0,	0,			0,		0 }, \
+{ "abbrev-commit",	0,	0,			0,		0 }, \
+{ "full-diff",		0,	0,			0,		0 }, \
+
+#define _diff \
+{ 0,			'u',	0,			0,		0 }, \
+{ 0,			'p',	0,			0,		0 }, \
+{ "patch-with-raw",	0,	0,			0,		0 }, \
+{ "stat",		0,	0,			0,		0 }, \
+{ "patch-with-stat",	0,	0,			0,		0 }, \
+{ 0,			'z',	0,			0,		0 }, \
+{ 0,			'l',	"-l%s",			ARG_INT,	0 }, \
+{ "full-index",		0,	0,			0,		0 }, \
+{ "name-only",		0,	0,			0,		0 }, \
+{ "name-status",	0,	0,			0,		0 }, \
+{ 0,			'R',	0,			0,		0 }, \
+{ 0,			'S',	"-S%s",			ARG_ONE,	0 }, \
+{ 0,			's',	0,			0,		0 }, \
+{ 0,			'O',	"-O%s",			ARG_ONE,	0 }, \
+{ "diff-filter",	0,	"--diff-filter=%s",	ARG_ONE,	0 }, \
+{ "pickaxe-all",	0,	0,			0,		0 }, \
+{ "pickaxe-regex",	0,	0,			0,		0 }, \
+{ 0,			'B',	"-B%s",			ARG_OPTINT,	0 }, \
+{ 0,			'M',	"-M%s",			ARG_OPTINT,	0 }, \
+{ 0,			'C',	"-C%s",			ARG_OPTINT,	0 }, \
+{ "find-copies-harder",	0,	0,			0,		0 }, \
+{ "abbrev",		0,	"--abbrev=%s",		ARG_OPT,	0 }, \
+
+#define end {0,0}
+
+static const struct opt_spec ost_log[] = { _rev end };
+static const struct opt_spec ost_rev_list[] = { _rev end };
+static const struct opt_spec ost_whatchanged[] = { _diff _rev end };
+static const struct opt_spec ost_show[] = { _diff _rev end };
+
+static const struct opt_spec_map {
+	const char *cmd;
+	const struct opt_spec *ost;
+} opt_specs[] = {
+	{ "checkout",		ost_checkout },
+	{ "commit",		ost_commit },
+	{ "log",		ost_log },
+	{ "rev-list",		ost_rev_list },
+	{ "show",		ost_show },
+	{ "whatchanged",	ost_whatchanged },
+};
+
+
+int main(int argc, const char **argv, char **envp)
+{
+	int i;
+	struct exec_args *ea;
+	const struct opt_spec *ost = NULL;
+
+	if (!argv[1])
+		usage("test-gitopt [<options>] <command> [<options>]");
+
+	for (i = 0; i < ARRAY_SIZE(opt_specs); i++) {
+		if (!strcmp(argv[1], opt_specs[i].cmd)) {
+			ost = opt_specs[i].ost;
+			break;
+		}
+	}
+	if (!ost)
+		usage("test-gitopt [<options>] <command> [<options>]");
+
+	ea = gitopt_parse_ost(ost, argc - 1, argv + 1);
+
+	for (i = 0; i <= ea->argc; i++)
+		printf("%02d '%s'\n", i, ea->argv[i] ? ea->argv[i] : "(null)");
+
+	return 0;
+}
-- 
1.3.2.g0a3ae
