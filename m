From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 22:43:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602232229340.3771@g5.osdl.org>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se>
 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
 <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
 <Pine.LNX.4.64.0602230911410.3771@g5.osdl.org> <7virr5hnw4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602231143290.3771@g5.osdl.org> <43FE1B9D.10403@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 07:44:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCWgO-0007sN-Rx
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 07:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbWBXGoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 01:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWBXGoA
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 01:44:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22482 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932714AbWBXGn7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 01:43:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1O6hsDZ007750
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Feb 2006 22:43:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1O6hqqT002605;
	Thu, 23 Feb 2006 22:43:53 -0800
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <43FE1B9D.10403@vilain.net>
X-Spam-Status: No, hits=-9 required=5 tests=PATCH_SUBJECT_OSDL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16685>



On Fri, 24 Feb 2006, Sam Vilain wrote:
> 
> I like the term "Domain Specific Language" to refer to this sort of thing.  It
> even hints at using the right kind of tools to achieve it, too :)

Just for fun, I wrote a first cut at a script engine for passing pipes 
around.

It's designed so that the "fork+exec with a pipe" should be easily 
replaced by "spawn with a socket" if that's what the target wants, but 
it also has some rather strange syntax, so I'm in no way claiming that 
this is a sane approach.

It was fun to write, though. You can already do some strange things with 
it, like writing a script like this

	set @ --since=2.months.ago Makefile
	exec git-rev-parse --default HEAD $@
		stdout arguments
	exec git-rev-list $arguments
		stdout revlist
	exec git-diff-tree --pretty --stdin
		stdin revlist
		stdout diff-tree-output
	exec less -S
		stdin diff-tree-output

which kind of shows the idea (it sets the "@" variable by hand, because 
the silly "git-script" thing doesn't set it itself).

I'm not sure this is worth pursuing (it really is a very strange kind of 
script syntax), but it was amusing to do. 

No docs - if you want to know how it works, you'll just have to read the 
equally strange sources.

		Linus

----
diff-tree 3e7dbcaae63278ccd413d93ecf9cba65a0d07021 (from d27d5b3c5b97ca30dfc5c448dc8cdae914131051)
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Thu Feb 23 22:06:12 2006 -0800

    Add really strange script engine

diff --git a/Makefile b/Makefile
index 0c04882..247030b 100644
--- a/Makefile
+++ b/Makefile
@@ -164,7 +164,7 @@ PROGRAMS = \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
-	git-describe$X git-merge-tree$X
+	git-describe$X git-merge-tree$X git-script$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -204,7 +204,7 @@ LIB_OBJS = \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
-	fetch-clone.o \
+	fetch-clone.o execute.o \
 	$(DIFF_OBJS)
 
 LIBS = $(LIB_FILE)
diff --git a/cache.h b/cache.h
index 5020f07..e4e66ce 100644
--- a/cache.h
+++ b/cache.h
@@ -352,4 +352,7 @@ extern int copy_fd(int ifd, int ofd);
 extern int receive_unpack_pack(int fd[2], const char *me, int quiet);
 extern int receive_keep_pack(int fd[2], const char *me, int quiet);
 
+/* script execution engine.. */
+extern int execute(const char *name, char *buf, unsigned int size);
+
 #endif /* CACHE_H */
diff --git a/execute.c b/execute.c
new file mode 100644
index 0000000..abb6801
--- /dev/null
+++ b/execute.c
@@ -0,0 +1,622 @@
+/*
+ * Stupid git script execution engine
+ *
+ * Copyrigt (C) 2006, Linus Torvalds
+ *
+ * There's one rule here: only ever expand a single level of variables.
+ * In particular - we never expand as a string, and keep everything as
+ * a list of entries. Always.
+ *
+ * This avoids all issues with quoting etc, since it's never an issue.
+ * When we execute a program, we have a list of arguments, no quoting
+ * or string parsing involved.
+ */
+#include "cache.h"
+#include <sys/wait.h>
+
+enum vartype {
+	var_none,
+	var_fd,
+	var_array
+};
+
+struct argument {
+	enum vartype type;
+	int fd, members, allocs, error;
+	const char **array;
+};
+
+struct variable {
+	const char *name;
+	struct variable *next;
+	struct argument value;
+};
+
+struct cmd_struct {
+	const char *line;
+	unsigned int len;
+	struct cmd_struct *subcmd;
+	struct cmd_struct *next;
+};
+
+struct parse_buf {
+	const char *name;
+	const char *error;
+	char *prog;
+	unsigned int size;
+	unsigned int offset;
+	unsigned int line;
+	unsigned int linestart;
+};
+
+static struct variable *vars = NULL;
+static void run_program(struct cmd_struct *cmd);
+
+static int countline(struct parse_buf *buf)
+{
+	int count = 0;
+	unsigned offset;
+
+	for (offset = buf->offset; offset < buf->size; offset++) {
+		unsigned char c = buf->prog[offset];
+		switch (c) {
+		case '\n':
+			buf->line++;
+		/* fallthrough */
+		case '\r':
+			count = 0;
+			buf->offset = offset + 1;
+			buf->prog[offset] = 0;
+			continue;
+		case ' ':
+			count++;
+			continue;
+		case '\t':
+			count = (count + 8) & ~7;
+			continue;
+		default:
+			buf->linestart = offset;
+			return count;
+		}
+	}
+	buf->offset = offset;
+	return -2;
+}
+
+/*
+ * When this is called, we've already done the indentation check,
+ * and "buf->linestart" points to the actual start of the command.
+ */
+static struct cmd_struct *parse_one_line(struct parse_buf *buf)
+{
+	unsigned int offset;
+	struct cmd_struct *cmd = xmalloc(sizeof(*cmd));
+	memset(cmd, 0, sizeof(*cmd));
+
+	offset = buf->linestart;
+	cmd->line = buf->prog + offset;
+	for ( ; offset < buf->size; offset++) {
+		unsigned char c = buf->prog[offset];
+		switch (c) {
+		case '\n':
+			buf->prog[offset++] = 0;
+			buf->line++;
+			break;
+		default:
+			continue;
+		}
+		break;
+	}
+	buf->offset = offset;
+	return cmd;
+}
+
+static struct cmd_struct *parse(struct parse_buf *buf, int indent)
+{
+	struct cmd_struct *first = NULL, *last = NULL;
+
+	for (;;) {
+		struct cmd_struct *now;
+		int newindent = countline(buf);
+
+		if (newindent < indent)
+			break;
+		if (!first)
+			indent = newindent;
+		if (newindent > indent) {
+			struct cmd_struct *subcmd;
+			if (last->subcmd) {
+				buf->error = "bad indentation";
+				return NULL;
+			}
+			subcmd = parse(buf, newindent);
+			if (!subcmd)
+				return NULL;
+			last->subcmd = subcmd;
+			continue;
+		}
+		now = parse_one_line(buf);
+		if (!now)
+			return NULL;
+		if (last)
+			last->next = now;
+		else
+			first = now;
+		last = now;
+	}
+	return first;
+}
+
+static struct cmd_struct *exec_bad(struct cmd_struct *cmd, struct argument *arg)
+{
+	printf("unrecognized command: '%s'\n", cmd->line);
+	return NULL;
+}
+
+static struct cmd_struct *exec_echo(struct cmd_struct *cmd, struct argument *arg)
+{
+	int i;
+	for (i = 0; i < arg->members; i++)
+		printf("%s%c", arg->array[i], i == arg->members-1 ? '\n': ' ');
+	return cmd->next;
+}
+
+static struct variable *find_variable(const char *name)
+{
+	struct variable *var = vars;
+	while (var) {
+		if (!strcmp(var->name, name))
+			return var;
+		var = var->next;
+	}
+	return NULL;
+}
+
+static struct variable *create_variable(const char *name)
+{
+	struct variable *var = find_variable(name);
+
+	if (!var) {
+		var = xmalloc(sizeof(*var));
+		memset(var, 0, sizeof(*var));
+		var->name = name;
+		var->next = vars;
+		vars = var;
+	}
+	return var;
+}
+
+static struct cmd_struct *exec_set(struct cmd_struct *cmd, struct argument *arg)
+{
+	int count = arg->members;
+	struct variable *var;
+	const char *name;
+	unsigned size;
+
+	if (!count)
+		return cmd->next;
+	name = arg->array[0];
+	var = create_variable(arg->array[0]);
+
+	var->value.members = count-1;
+	size = count * sizeof(var->value.array[0]);
+	var->value.array = xmalloc(size);
+	memcpy(var->value.array, arg->array+1, size);
+
+	return cmd->next;
+}
+
+static void free_arg_list(struct argument *arg)
+{
+	/*
+	 * We can't free the actual entries, since we re-use them
+	 * on expansion. Right or wrong, that's how it is...
+	 */
+	free(arg->array);
+}
+
+static void drop_variable(struct variable *var)
+{
+	free_arg_list(&var->value);
+	free(var);
+}
+
+static struct cmd_struct *exec_unset(struct cmd_struct *cmd, struct argument *arg)
+{
+	int i;
+
+	for (i = 0; i < arg->members; i++) {
+		const char *name = arg->array[i];
+		struct variable *var, **p = &vars;
+
+		while ((var = *p) != NULL) {
+			if (!strcmp(var->name, name)) {
+				*p = var->next;
+				drop_variable(var);
+				break;
+			}
+			p = &var->next;
+		}
+	}
+	return cmd->next;
+}
+
+static struct cmd_struct *exec_exit(struct cmd_struct *cmd, struct argument *arg)
+{
+	int value = 0;
+	if (arg->members)
+		value = atoi(arg->array[0]);
+	exit(value);
+}
+
+static struct cmd_struct *exec_else(struct cmd_struct *cmd, struct argument *arg)
+{
+	return cmd->next;
+}
+
+static struct cmd_struct *exec_if(struct cmd_struct *cmd, struct argument *arg)
+{
+	struct cmd_struct *pos, *neg;
+
+	pos = cmd->subcmd;
+	neg = cmd->next;
+	if (neg) {
+		if (!strncmp(neg->line, "else", 4))
+			neg = neg->subcmd;
+		else
+			neg = NULL;
+	}
+	if (!arg->members)
+		pos = neg;
+	run_program(pos);
+	return cmd->next;
+}
+
+static int match_cmd(const char *match, struct cmd_struct *cmd)
+{
+	int len = strlen(match), cmdlen = strlen(cmd->line);
+	if (cmdlen < len)
+		return 0;
+	if (cmdlen > len && !isspace(cmd->line[len]))
+		return 0;
+	return !memcmp(match, cmd->line, len);
+}
+
+static int set_input(int *redirect, const char *val)
+{
+	struct variable *var;
+
+	while (isspace(*val))
+		val++;
+	var = find_variable(val);
+	if (!var || var->value.type != var_fd)
+		die("bad 'fd' variable %s", val);
+
+	*redirect = var->value.fd;
+	var->value.fd = -1;
+	return 0;
+}
+
+static int set_output(int *redirect, const char *val)
+{
+	int fd[2];
+	struct variable *var;
+
+	while (isspace(*val))
+		val++;
+	var = create_variable(val);
+
+	if (pipe(fd) < 0)
+		die("unable to pipe");
+	var->value.type = var_fd;
+	var->value.fd = fd[0];
+	*redirect = fd[1];
+	return 0;
+}
+
+/*
+ * Only these routines should need to be ported to a "spawn()" interface
+ */
+static struct cmd_struct *exec_exec(struct cmd_struct *cmd, struct argument *arg)
+{
+	int redirect[3];
+	pid_t pid;
+	int nr = arg->members;
+	struct cmd_struct *io;
+
+	if (!nr) {
+		run_program(cmd->subcmd);
+		return cmd->next;
+	}
+
+	memset(redirect, 0, sizeof(redirect));
+	for (io = cmd->subcmd; io ; io = io->next) {
+		if (match_cmd("stdin", io)) {
+			set_input(redirect+0, io->line + 5);
+			continue;
+		}
+		if (match_cmd("stdout", io)) {
+			set_output(redirect+1, io->line + 6);
+			continue;
+		}
+		if (match_cmd("stderr", io)) {
+			set_output(redirect+2, io->line + 6);
+			continue;
+		}
+	}
+
+	/*
+	 * HERE! Use spawn if necessary - the fd redirect table has been set up
+	 */
+	pid = vfork();
+	if (pid < 0) {
+		error("vfork failed (%s)", strerror(errno));
+		return NULL;
+	}
+
+	if (!pid) {
+		int retval;
+		if (redirect[0]) {
+			dup2(redirect[0], 0);
+			close(redirect[0]);
+		}
+		if (redirect[1]) {
+			dup2(redirect[1], 1);
+			close(redirect[1]);
+		}
+		if (redirect[2]) {
+			dup2(redirect[2], 2);
+			close(redirect[2]);
+		}
+		retval = execvp(arg->array[0], (char *const*) arg->array);
+		exit(255);
+	}
+
+	if (redirect[0])
+		close(redirect[0]);
+	if (redirect[1])
+		close(redirect[1]);
+	if (redirect[2])
+		close(redirect[2]);
+
+	/*
+	 * If we don't have anybody waiting for output,
+	 * wait for it
+	 */
+	if (!redirect[1]) {
+		int status;
+		while (waitpid(pid, &status, 0) < 0) {
+			if (errno == EINTR)
+				continue;
+			error("unable to wait for child (%s)", strerror(errno));
+			return NULL;
+		}
+		/* FIXME! Put exit status in a variable! */
+	}
+	run_program(cmd->subcmd);
+	return cmd->next;
+}
+
+static struct cmd_struct *exec_nop(struct cmd_struct *cmd, struct argument *arg)
+{
+	return cmd->next;
+}
+
+static const struct cmd_def {
+	const char *n;
+	int len;
+	struct cmd_struct *(*exec)(struct cmd_struct *, struct argument *);
+} cmds[] = {
+	{ "bad", 0, exec_bad },
+	{ "set", 3, exec_set },
+	{ "unset", 5, exec_unset },
+	{ "echo", 4, exec_echo },
+	{ "exit", 4, exec_exit },
+	{ "if", 2, exec_if },
+	{ "else", 4, exec_else },
+	{ "exec", 4, exec_exec },
+	{ "stdin", 5, exec_nop },
+	{ "stdout", 6, exec_nop },
+	{ "stderr", 6, exec_nop },
+};
+
+static void add_argument(struct argument *arg, const char *n)
+{
+	int allocs = arg->allocs, members = arg->members;
+
+	if (members+1 >= allocs) {
+		allocs = (allocs * 3) / 2 + 32;
+		arg->array = xrealloc(arg->array, allocs*sizeof(arg->array[0]));
+		arg->allocs = allocs;
+	}
+	arg->array[members++] = n;
+	arg->array[members] = NULL;
+	arg->members = members;
+}
+
+static int get_word(const char *line, const char **res)
+{
+	int quoted = 0;
+	int offset = 0;
+	int stop = 0;
+	char *buf;
+
+	for (;;) {
+		unsigned char c = line[offset];
+		if (!c)
+			break;
+		offset++;
+		if (c == '\\') {
+			quoted ^= 1;
+			continue;
+		}
+		if (quoted) {
+			quoted = 0;
+			continue;
+		}
+		if (stop) {
+			if (c == stop)
+				stop = 0;
+			continue;
+		}
+		if (c == '\'' || c == '"') {
+			stop = c;
+			continue;
+		}
+		if (!isspace(c)) {
+			continue;
+		}
+		offset--;
+		break;
+	}
+	if (quoted || stop)
+		return -1;
+	buf = xmalloc(offset+1);
+	memcpy(buf, line, offset);
+	buf[offset] = 0;
+	*res = buf;
+	return offset;
+}
+
+static int expand_word(const char *line, struct argument *arg)
+{
+	const char *word;
+	int offset = get_word(line, &word);
+
+	if (offset > 0)
+		add_argument(arg, word);
+	return offset;
+}
+
+static void convert_fd_into_array(struct variable *var)
+{
+	int fd = var->value.fd;
+	char buffer[8192];
+	int len, offset, last;
+
+	var->value.fd = -1;
+	var->value.type = var_array;
+	len = 0;
+	for (;;) {
+		int ret = read(fd, buffer + len, sizeof(buffer) - len);
+		if (!ret)
+			break;
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			break;
+		}
+		len += ret;
+		if (len >= sizeof(buffer))
+			break;
+	}
+
+	last = 0;
+	for (offset = 0; offset < len; offset++) {
+		unsigned char c = buffer[offset];
+		if (c == '\n') {
+			buffer[offset] = 0;
+			add_argument(&var->value, buffer+last);
+			last = offset+1;
+			continue;
+		}
+	}		
+}
+
+static int expand_variable(const char *line, struct argument *arg)
+{
+	const char *word;
+	int offset = get_word(line+1, &word);
+
+	if (offset > 0) {
+		struct variable *var = find_variable(word);
+		offset++;	/* The '$' character itself */
+		if (var) {
+			int i;
+			if (var->value.type == var_fd)
+				convert_fd_into_array(var);
+			for (i = 0; i < var->value.members; i++)
+				add_argument(arg, var->value.array[i]);
+		}
+	}
+	return offset;
+}
+
+static int expand_value(const char *line, struct argument *arg)
+{
+	unsigned char c = *line;
+
+	switch (c) {
+	case '$':
+		return expand_variable(line, arg);
+	default:
+		return expand_word(line, arg);
+	}
+}
+
+static struct argument *expand_line(const char *line)
+{
+	struct argument *arg;
+
+	arg = xmalloc(sizeof(*arg));
+	memset(arg, 0, sizeof(*arg));
+	arg->type = var_array;
+	for (;;) {
+		int n;
+		while (isspace(*line)) {
+			line++;
+		}
+		if (!*line)
+			break;
+		n = expand_value(line, arg);
+		if (n <= 0)
+			break;
+		line += n;
+	}
+	return arg;
+}
+
+static void run_program(struct cmd_struct *cmd)
+{
+	while (cmd) {
+		int i;
+		const struct cmd_def *run = cmds+0;
+		struct argument *arg = NULL;
+		int cmdlen = strlen(cmd->line);
+
+		for (i = 1; i < sizeof(cmds)/sizeof(cmds[0]); i++) {
+			const struct cmd_def *def = cmds + i;
+			int len = def->len;
+			if (len > cmdlen)
+				continue;
+			if (len < cmdlen && !isspace(cmd->line[len]))
+				continue;
+			if (memcmp(cmd->line, def->n, len))
+				continue;
+			run = def;
+			arg = expand_line(cmd->line + len);
+			break;
+		}
+		cmd = run->exec(cmd, arg);
+	}
+}
+
+int execute(const char *name, char *buf, unsigned int size)
+{
+	struct parse_buf p;
+	struct cmd_struct *program;
+
+	p.name = name;
+	p.prog = buf;
+	p.size = size;
+	p.offset = 0;
+	p.line = 1;
+	p.error = "empty program";
+
+	program = parse(&p, -1);
+	if (!program || p.offset != p.size)
+		die("parse error at %s:%d: %s", p.name, p.line, p.error);
+
+	run_program(program);
+	return 0;
+}
diff --git a/script.c b/script.c
new file mode 100644
index 0000000..ae85598
--- /dev/null
+++ b/script.c
@@ -0,0 +1,58 @@
+/*
+ * Silly git script language
+ *
+ * Copyright (C) 2006, Linus Torvalds
+ */
+#include "cache.h"
+
+static const char script_usage[] = "git-script <scriptfile>";
+
+int main(int argc, char **argv)
+{
+	int fd;
+	char *buf;
+	const char *filename;
+	unsigned int size, alloc;
+
+	fd = 0;
+	switch (argc) {
+	case 1:
+		filename = "stdin";
+		fd = dup(0);
+		close(0);
+		open("/dev/null", O_RDONLY);
+		break;
+	case 2:
+		filename = argv[1];
+		fd = open(filename, O_RDONLY);
+		if (fd < 0)
+			die("unable to open '%s': %s", filename, strerror(errno));
+		break;
+	default:
+		usage(script_usage);
+	}
+
+	buf = NULL;
+	alloc = 0;
+	size = 0;
+	for (;;) {
+		int nr;
+		if (size >= alloc) {
+			alloc = (alloc * 3) / 2 + 8192;
+			buf = xrealloc(buf, alloc);
+		}
+		nr = read(fd, buf + size, alloc - size);
+		if (!nr)
+			break;
+		if (nr < 0) {
+			if (errno == EAGAIN || errno == EINTR)
+				continue;
+			die("script read failed (%s)", strerror(errno));
+		}
+		size += nr;
+	}
+	close(fd);
+
+	execute(filename, buf, size);
+	return 0;
+}
