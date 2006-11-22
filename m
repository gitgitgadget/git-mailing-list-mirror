X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] xdiff: add xdl_merge()
Date: Wed, 22 Nov 2006 19:58:27 +0000
Message-ID: <4564ABE3.6080605@ramsay1.demon.co.uk>
References: <Pine.LNX.4.63.0611212316080.26827@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020501010309010407020806"
NNTP-Posting-Date: Wed, 22 Nov 2006 20:01:26 +0000 (UTC)
Cc: Davide Libenzi <davidel@xmailserver.org>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <Pine.LNX.4.63.0611212316080.26827@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32096>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmyHV-0005kI-7p for gcvg-git@gmane.org; Wed, 22 Nov
 2006 21:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756776AbWKVUBJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 15:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756777AbWKVUBJ
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 15:01:09 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:50190 "EHLO
 anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP id
 S1756776AbWKVUBF (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006
 15:01:05 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196]) by
 anchor-post-31.mail.demon.net with esmtp (Exim 4.42) id 1GmyH4-0002Kk-5q;
 Wed, 22 Nov 2006 20:00:58 +0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------020501010309010407020806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

Johannes Schindelin wrote:
> This new function implements the functionality of RCS merge, but
> in-memory. It returns < 0 on error, otherwise the number of conflicts.
> 

I had a similar idea (removing the RCS dependency) and, about two months
ago, implemented a git-diff3 that used the internal xdiff library.
Unfortunately, I then got distracted by other things and left this as a
WIP, without posting it to the list. [I had an email exchange with Junio
about it, but then dropped the ball - sorry Junio!]

> Finding the conflicting lines can be a very expensive task. You can
> control the eagerness of this algorithm:
> 
> - a level value of 0 means that all overlapping changes are treated
>   as conflicts,
> - a value of 1 means that if the overlapping changes are identical,
>   it is not treated as a conflict.
> - If you set level to 2, overlapping changes will be analyzed, so that
>   almost identical changes will not result in huge conflicts. Rather,
>   only the conflicting lines will be shown inside conflict markers.
> 
> With each increasing level, the algorithm gets slower, but more accurate.
> Note that the code for level 2 depends on the simple definition of
> mmfile_t specific to git, and therefore it will be harder to port that
> to LibXDiff.
> 

Erm, I guess I need to read the code! I haven't had an opportunity to
do that yet, but I hope to have time at the weekend.

> 	My hopes are that when I wake up in the morning, all bugs are
> 	fixed, git-merge-one-file is rewritten as a builtin,
> 	git-merge-index defaults to calling xdl_merge() directly when
> 	no program is passed with "-o", and git-merge-recursive also
> 	avoids fork()ing RCS' merge.

Yep, I had a similar todo list.

> 
> 	A funny side effect is that you can merge with white space
> 	corruption by setting the xpparam flags to ignore whitespace.
> 	The file passed as mf1 wins over mf2 in that case.

Yes, I had this on my todo list. In fact you can already try it out
by using --diff-program="diff -wb" (which uses the external diff).
[To be fair, you can also write an obvious script and use GNU diff3]

> 
>  Makefile       |    3 
>  xdiff/xdiff.h  |    7 +
>  xdiff/xdiffi.c |    3 
>  xdiff/xdiffi.h |    1 
>  xdiff/xmerge.c |  433 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 444 insertions(+), 3 deletions(-)
> 

 From the above, I would guess that your code integrates well with the
xdiff library and, as a result, would be more memory efficient than my
code. I had considered doing this, but I wanted to support an external
diff option, so it was easier to implement the diff3 algorithm outside
the library, treating it just like an external diff (that I didn't need
to fork()/exec()). Also, I didn't need to understand the xdiff code, I
just treat it as a black box (and I'm lazy!).

[Having an external diff option was actually a debugging aid to ensure
that the main diff3 algorithm was implemented correctly. In the end I
didn't use it for debugging anyway!]

[snip patch]

I have attached a version of my patch, against v1.4.2, just for the
interested. Also it contains some tests which I found very helpful
in squashing bugs, so you might like to give them a try with your code.

Note: the fact that the patch is against v1.4.2 should not cause too
much of a problem, since it is mostly new files and the changes to
Makefile, builtin.h and git.c you could probably do in your sleep.

[Junio, this is almost exactly the same patch I sent you last time,
modulo some minor code clean-up/formatting]

All the best,

Ramsay



--------------020501010309010407020806
Content-Type: text/plain;
 name="p0016.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p0016.txt"

>From f23d8df5d7774cb85b834357019c725cf8c1e231 Mon Sep 17 00:00:00 2001
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Mon, 13 Nov 2006 23:04:37 +0000
Subject: [PATCH] Initial implementation of builtin diff3

The intention of this work is to remove the dependancy on
the rcs merge program. As a first step, we implement a
builtin clone of diff3. (A builtin merge replacement command
will be able to reuse this code, since merge is a thin
wrapper around diff3). So git-diff3 is only a stepping stone
to a merge replacement and is not meant to stay!

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile         |    5 
 builtin-diff3.c  | 1824 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h        |    2 
 git.c            |    1 
 t/txxxx-diff3.sh |  175 +++++
 t/txxxx/lao      |   11 
 t/txxxx/lao1     |    8 
 t/txxxx/lao2     |   16 
 t/txxxx/lao3     |   13 
 t/txxxx/lao4     |   12 
 t/txxxx/tao      |   14 
 t/txxxx/tao1     |   10 
 t/txxxx/tao2     |   16 
 t/txxxx/tao3     |   13 
 t/txxxx/tao4     |   15 
 t/txxxx/tzu      |   13 
 16 files changed, 2146 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0761d6c..60f5adc 100644
--- a/Makefile
+++ b/Makefile
@@ -198,7 +198,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-apply$X git-show-branch$X git-diff-files$X git-update-index$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X \
 	git-fmt-merge-msg$X git-prune$X git-mv$X git-prune-packed$X \
-	git-repo-config$X
+	git-repo-config$X git-diff3$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -255,7 +255,8 @@ BUILTIN_OBJS = \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
 	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
-	builtin-mv.o builtin-prune-packed.o builtin-repo-config.o
+	builtin-mv.o builtin-prune-packed.o builtin-repo-config.o \
+	builtin-diff3.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-diff3.c b/builtin-diff3.c
new file mode 100644
index 0000000..9f5698f
--- /dev/null
+++ b/builtin-diff3.c
@@ -0,0 +1,1824 @@
+/*
+ * Builtin "git diff3"
+ *
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "xdiff-interface.h"
+#include <sys/wait.h>
+#include <assert.h>
+
+
+#define MAX_DIFF_ARGS 32
+
+/* diff3 options */
+struct diff3_options {
+	unsigned show_all:1;     /* show all changes, including merged       */
+	unsigned overlap_only:1; /* restrict to overlapping changes          */
+	unsigned unmerged_only:1;/* restrict to unmerged non-overlapping     */
+	unsigned initial_tab:1;  /* output initial tab                       */
+	unsigned markers:1;      /* output conflict markers                  */
+	unsigned edscript:1;     /* output an ed script to perform the merge */
+	unsigned merge:1;        /* actually output the merged file          */
+	const char *diff_prog;   /* external diff program (command line)     */
+};
+
+/* input file info */
+struct finfo {
+	const char *name;   /* filename                       */
+	const char *label;  /* label to use for markers       */
+	int         num;    /* 0 = ours, 1 = base, 2 = theirs */
+	mmfile_t    mf;     /* file mmap() info               */
+};
+
+/* pipe info when running external diff */
+struct pinfo {
+	int   fd;   /* pipe read/write fd    */
+	pid_t pid;  /* child pid to wait for */
+};
+
+/* argv info for external diff */
+struct diff_argv {
+	char *args;         /* argument string memory */
+	const char **argv;  /* argument pointer array */
+	int argc;           /* argument count         */
+};
+
+/* callback info used with internal diff */
+struct ecb_info {
+	char *text;  /* pointer to text of diff output    */
+	long size;   /* size of memory block holding text */
+	long used;   /* length of diff output             */
+};
+
+/* type of diff */
+enum {
+	UNKNOWN_FORMAT,
+	NORMAL_FORMAT,
+	UNIFIED_FORMAT,
+	CONTEXT_FORMAT
+};
+
+/* normal format diff hunk header */
+struct hunk_header {
+	int fs, fe;  /* from-file start and end line numbers */
+	int type;    /* 'a' add, 'c' change, 'd' delete      */
+	int ts, te;  /* to-file start and end line numbers   */
+};
+
+/* unified format diff hunk header */
+struct unified_hunk_header {
+	int fs, fc;  /* from-file start line and count */
+	int ts, tc;  /* to-file start line and count   */
+};
+
+/* lines from one file referenced by a hunk */
+struct hunk_lines {
+	int  start;     /* start line number of hunk         */
+	int  end;       /* end line number of hunk           */
+	char **lines;   /* pointer to array of line pointers */
+	int  *lengths;  /* pointer to array of line lengths  */
+	int  size;      /* size of the above arrays          */
+};
+
+/* 2way diff hunk */
+struct diff2_hunk {
+	int               type;   /* hunk type: 'a', 'c', 'd'   */
+	struct hunk_lines from;   /* from-file hunk lines       */
+	struct hunk_lines to;     /* to-file hunk lines         */
+	struct diff2_hunk *next;  /* next hunk in list          */
+};
+
+/* 2way diff */
+struct diff2 {
+	struct finfo      *ff;      /* from file            */
+	struct finfo      *ft;      /* to file              */
+	mmbuffer_t        content;  /* text content of diff */
+	struct diff2_hunk *hunks;   /* list of diff hunks   */
+};
+
+/* a segment (sub-list) of diff2 hunks */
+struct segment {
+	int               from;   /* from-file number          */
+	int               to;     /* to-file number            */
+	struct diff2_hunk *head;  /* head of hunk list segment */
+	struct diff2_hunk *tail;  /* tail of hunk list segment */
+	int               count;  /* count of hunks            */
+};
+
+/* 3way diff hunk */
+struct diff3_hunk {
+	int               type;  /* 'a' all, '1' 1st, '2' 2nd, '3' 3rd */
+	struct hunk_lines f[3];  /* hunk lines for files 0, 1, 2       */
+	struct diff3_hunk *next; /* next hunk in list                  */
+};
+
+/* 3way diff */
+struct diff3 {
+	struct diff2      *diff01;  /* diff ours -> base   */
+	struct diff2      *diff21;  /* diff theirs -> base */
+	struct diff3_hunk *hunks;   /* list of diff3 hunks */
+};
+
+static void init_finfo(struct finfo *f, const char *name, const char *lab, int num)
+{
+	if (f) {
+		f->name  = name;
+		f->label = lab;
+		f->num   = num;
+
+		f->mf.ptr  = 0;
+		f->mf.size = 0;
+	}
+}
+
+static void alloc_line_arrays(int num, struct hunk_lines *h)
+{
+	assert(h);
+	h->lines   = xcalloc(num, sizeof(char *));
+	h->lengths = xcalloc(num, sizeof(int));
+	h->size    = num;
+}
+
+static struct diff2_hunk *new_diff2_hunk(void)
+{
+	struct diff2_hunk *new = xmalloc(sizeof(*new));
+
+	memset(new, 0, sizeof(*new));
+
+	return new;
+}
+
+static void free_diff2_hunk(struct diff2_hunk *p)
+{
+	if (p->from.lines)
+		free(p->from.lines);
+	if (p->from.lengths)
+		free(p->from.lengths);
+
+	if (p->to.lines)
+		free(p->to.lines);
+	if (p->to.lengths)
+		free(p->to.lengths);
+
+	free(p);
+}
+
+static struct diff2 *new_diff2(struct finfo *ff, struct finfo *ft)
+{
+	struct diff2 *new = xmalloc(sizeof(*new));
+
+	memset(new, 0, sizeof(*new));
+
+	new->ff = ff;
+	new->ft = ft;
+
+	return new;
+}
+
+static void free_diff2(struct diff2 *p)
+{
+	struct diff2_hunk *h, *next;
+
+	for (h = p->hunks; h; h = next) {
+		next = h->next;
+		free_diff2_hunk(h);
+	}
+
+	if (p->content.ptr)
+		free(p->content.ptr);
+
+	free(p);
+}
+
+static struct diff3_hunk *new_diff3_hunk(void)
+{
+	struct diff3_hunk *new = xmalloc(sizeof(*new));
+
+	memset(new, 0, sizeof(*new));
+
+	return new;
+}
+
+static void free_diff3_hunk(struct diff3_hunk *p)
+{
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		if (p->f[i].lines)
+			free(p->f[i].lines);
+		if (p->f[i].lengths)
+			free(p->f[i].lengths);
+	}
+
+	free(p);
+}
+
+static struct diff3 *new_diff3(struct diff2 *diff01, struct diff2 *diff21)
+{
+	struct diff3 *new = xmalloc(sizeof(*new));
+
+	memset(new, 0, sizeof(*new));
+
+	new->diff01 = diff01;
+	new->diff21 = diff21;
+
+	return new;
+}
+
+static void free_diff3(struct diff3 *p)
+{
+	struct diff3_hunk *h, *next;
+
+	for (h = p->hunks; h; h = next) {
+		next = h->next;
+		free_diff3_hunk(h);
+	}
+
+	free_diff2(p->diff01);
+	free_diff2(p->diff21);
+
+	free(p);
+}
+
+static int init_mmfile(mmfile_t *mf, const char *file)
+{
+	char *data;
+	long size;
+	struct stat st;
+	int fd;
+
+	assert(mf && file && *file);
+
+	mf->ptr  = 0;
+	mf->size = 0;
+
+	if (lstat(file, &st) < 0)
+		return -1;
+	size = st.st_size;
+	if (!size) {
+		mf->ptr = "";
+		return 0;
+	}
+
+	fd = open(file, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	data = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (data == MAP_FAILED)
+		return -1;
+
+	mf->ptr  = data;
+	mf->size = size;
+	return 0;
+}
+
+static void free_mmfile(mmfile_t *mf)
+{
+	if (mf) {
+		if (mf->ptr && mf->size != 0)
+			munmap(mf->ptr, mf->size);
+		mf->ptr  = 0;
+		mf->size = 0;
+	}
+}
+
+static void map_file(struct finfo *f)
+{
+	if (!f->mf.ptr && (init_mmfile(&f->mf, f->name) < 0))
+		die("can't read file '%s': %s", f->name, strerror(errno));
+}
+
+static int popenv(int argc, const char *argv[], const char *type, struct pinfo *p)
+{
+	int pfd[2];
+	pid_t pid;
+	int fd;
+
+	if (!argv || !type || !p) {
+		errno = EINVAL;
+		return -1;
+	}
+	p->fd = -1;
+	p->pid = 0;
+
+	if (!*type || (*type != 'r' && *type != 'w') || type[1] != 0) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	if (pipe(pfd) < 0)
+		return -1;
+
+	if ((pid = fork()) < 0) {
+		return -1;
+	} else if (pid == 0) {  /* child */
+		if (*type == 'r') {
+			close(pfd[0]);
+			if(pfd[1] != STDOUT_FILENO) {
+				dup2(pfd[1], STDOUT_FILENO);
+				close(pfd[1]);
+			}
+		} else { /* *type == 'w' */
+			close(pfd[1]);
+			if(pfd[0] != STDIN_FILENO) {
+				dup2(pfd[0], STDIN_FILENO);
+				close(pfd[0]);
+			}
+
+		}
+
+#ifdef DUMMY
+		fd = open("/dev/null", O_RDWR);
+		dup2(fd, STDERR_FILENO);
+		close(fd);
+#endif
+
+		execvp(argv[0], (char *const *)argv);
+		_exit(127);
+	}
+
+	/* parent */
+	if (*type == 'r') {
+		close(pfd[1]);
+		fd = pfd[0];
+	} else {
+		close(pfd[0]);
+		fd = pfd[1];
+	}
+
+	p->fd = fd;
+	p->pid = pid;
+
+	return 0;
+}
+
+static int pclosev(struct pinfo *p)
+{
+	int stat;
+
+	if (!p || p->fd == -1 || p->pid == 0) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	close(p->fd);  /* XXX check for close() failure? */
+	p->fd = -1;
+
+	while (waitpid(p->pid, &stat, 0) < 0)
+		if (errno != EINTR)
+			return -1;
+
+	p->pid = 0;
+
+	return stat;
+}
+
+static int split_cmdline(const char *cmdline, int max, struct diff_argv *prog)
+{
+	assert(prog);
+
+	if (cmdline && *cmdline && (prog->args = xmalloc(strlen(cmdline)+2))) {
+
+		const char *p = cmdline;
+		char *a = prog->args;
+		int argc = 0;
+
+		prog->argv = xmalloc(max * sizeof(char *));
+
+		while( *p ) {
+
+			while (*p == ' ' || *p == '\t')
+				p++;
+			if ( !*p )
+				break;
+
+			if (argc >= max)
+				break;
+
+			prog->argv[argc++] = a;
+			while ((*a = *p) && *a != ' ' && *a != '\t')
+				a++,p++;
+			*a++ = 0;
+
+		}
+
+		*a++ = 0;
+		prog->argc = argc;
+		prog->argv[argc] = 0;
+
+		if (argc == 0) {
+			free(prog->args);
+			free(prog->argv);
+			return -1;
+		}
+
+		return 0;
+	}
+
+	return -1;
+}
+
+static struct diff_argv *new_diff_argv(const char *cmdline)
+{
+	struct diff_argv *a = xmalloc(sizeof(*a));
+
+	memset(a, 0, sizeof(*a));
+
+	if (split_cmdline(cmdline, MAX_DIFF_ARGS, a) < 0) {
+		free(a);
+		return 0;
+	}
+
+	return a;
+}
+
+static void free_diff_argv(struct diff_argv *a)
+{
+	if (a) {
+		if (a->args)
+			free(a->args);
+		if (a->argv)
+			free(a->argv);
+		free(a);
+	}
+}
+
+static int read_from_pipe(int fd, mmbuffer_t *content)
+{
+	ssize_t n, size = 1024, total = 0;
+	char *text = xmalloc(size);
+
+	assert(content != 0);
+
+	while ((n = read(fd, text+total, size-total)) > 0) {
+		if (n == size-total) {
+			size *= 2;
+			text = xrealloc(text, size);
+		}
+		total += n;
+	}
+	if (n < 0)
+		return -1;
+
+	if (total == 0)
+		free(text);
+	else {
+		content->ptr  = text;
+		content->size = total;
+	}
+
+	return 0;
+}
+
+static void run_external_diff(struct diff_argv *prog, const char* file1, const char* file2, mmbuffer_t *content)
+{
+	char const **ap;
+	struct pinfo pi;
+	int stat, code;
+
+	if (!prog || !prog->args || !prog->argv || prog->argc < 1)
+		die("internal error: invalid diff argv");
+
+	if (prog->argc > MAX_DIFF_ARGS - 4)
+		die("too many arguments for external diff-program");
+
+	ap = &prog->argv[prog->argc];
+	*ap++ = "--";
+	*ap++ = file1;
+	*ap++ = file2;
+	*ap++ = 0;
+
+	if(popenv(prog->argc+4, prog->argv, "r", &pi) < 0)
+		die("popenv() failed: %s", strerror(errno));
+
+	if (read_from_pipe(pi.fd, content) < 0)
+		die("read_from_pipe() failed: %s", strerror(errno));
+
+	if ((stat = pclosev(&pi)) < 0)
+		die("pclosev() failed: %s", strerror(errno));
+
+	if (!WIFEXITED(stat))
+		die("diff-program '%s' terminated abnormally", prog->argv[0]);
+
+	if ((code = WEXITSTATUS(stat)) == 127)
+		die("can't execute external diff-program '%s'", prog->argv[0]);
+
+	if (code < 0 || code > 1)
+		die("external diff-program '%s' failed", prog->argv[0]);
+}
+
+#ifdef DUMMY
+static void print_buffer(mmbuffer_t *b)
+{
+	ssize_t count = 0, n;
+
+	if (b->size == 0)
+		return;
+
+	while ((n = xwrite(STDOUT_FILENO, b->ptr+count, b->size-count)) > 0)
+		count += n;
+}
+#endif
+
+static void external_diff(struct diff_argv *prog, struct finfo *ff, struct finfo *ft, mmbuffer_t *diff)
+{
+	assert(ff != 0 && ft != 0 && diff != 0);
+
+	run_external_diff(prog, ff->name, ft->name, diff);
+
+#ifdef DUMMY
+	printf("diff %s %s\n", ff->name, ft->name);
+	print_buffer(diff);
+	printf("--------\n");
+#endif
+}
+
+static int xdiff_output(void *priv_, mmbuffer_t *mb, int nbuf)
+{
+	struct ecb_info *b = priv_;
+	int i;
+
+	for (i = 0; i < nbuf; i++) {
+
+		if (b->used + mb[i].size > b->size) {
+			if (b->size > mb[i].size)
+				b->size *= 2;
+			else
+				b->size += mb[i].size;
+			b->text = xrealloc(b->text, b->size);
+		}
+
+		memcpy(b->text+b->used, mb[i].ptr, mb[i].size);
+		b->used += mb[i].size;
+
+	}
+	return 0;
+}
+
+static void run_internal_diff(mmfile_t *mf1, mmfile_t *mf2, mmbuffer_t *diff)
+{
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	xdemitcb_t ecb;
+	struct ecb_info ecb_data;
+
+	ecb_data.text = xmalloc(1024);
+	ecb_data.size = 1024;
+	ecb_data.used = 0;
+
+	xpp.flags = XDF_NEED_MINIMAL;
+
+	xecfg.ctxlen = 0;
+	xecfg.flags  = 0;
+
+	ecb.outf = xdiff_output;
+	ecb.priv = &ecb_data;
+
+	xdl_diff(mf1, mf2, &xpp, &xecfg, &ecb);
+
+	if (ecb_data.used == 0)
+		free(ecb_data.text);
+	else {
+		diff->ptr  = ecb_data.text;
+		diff->size = ecb_data.used;
+	}
+}
+
+static void internal_diff(struct finfo *ff, struct finfo *ft, mmbuffer_t *diff)
+{
+	assert(ff != 0 && ft != 0 && diff != 0);
+
+	map_file(ff);
+	map_file(ft);
+
+	run_internal_diff(&ff->mf, &ft->mf, diff);
+
+#ifdef DUMMY
+	printf("diff %s %s\n", ff->name, ft->name);
+	print_buffer(diff);
+	printf("--------\n");
+#endif
+}
+
+
+static void read_diff(struct diff_argv *prog, struct finfo *ff, struct finfo *ft, mmbuffer_t *diff)
+{
+	if (prog)
+		external_diff(prog, ff, ft, diff);
+	else
+		internal_diff(ff, ft, diff);
+}
+
+static char *nextline(char *p, char *limit)
+{
+	while (p < limit)
+		if (*p++ == '\n')
+			return p;
+	return 0;
+}
+
+static int get_num(char **tp, int *np)
+{
+	char *p  = *tp;
+	int  neg = 0;
+	int  num = 0;
+
+	/* can't use: num = strtol(p, tp, 10); because strtol() will
+	 * skip using isspace() which includes '\n'.
+	 */
+
+	while (*p == ' ' || *p == '\t') p++;
+
+	if (*p == '-' || *p == '+') {
+		neg = *p == '-';
+		p++;
+	}
+
+	while (isdigit(*p))
+		num = num * 10 + (*p++ - '0');
+
+	if (*tp == p)
+		return 0;
+
+	*tp = p;
+	*np = (neg) ? -num : num;
+	return 1;
+}
+
+static int have(char **tp, char c)
+{
+	char *p = *tp;
+
+	while (*p == ' ' || *p == '\t') p++;
+
+	if (*p == c) {
+		*tp = ++p;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int at_eol(char **tp)
+{
+	char *p = *tp;
+
+	while (*p == ' ' || *p == '\t') p++;
+	*tp = p;
+
+	if (*p == '\n')
+		return 1;
+
+	return 0;
+}
+
+static int normal_header(char **curp, struct hunk_header *header)
+{
+	char *p = *curp;
+
+	if (!get_num(&p, &header->fs))
+		return 0;
+
+	header->fe = header->fs;
+	if (have(&p, ',')) {
+		if(!get_num(&p, &header->fe))
+			return 0;
+	}
+
+	if (have(&p, 'a'))
+		header->type = 'a';
+	else if (have(&p, 'c'))
+		header->type = 'c';
+	else if (have(&p, 'd'))
+		header->type = 'd';
+	else
+		return 0;
+
+	if (header->type == 'a') {
+		assert(header->fs == header->fe);
+		header->fe--;  /* null (zero) range of lines */
+	}
+
+	if (!get_num(&p, &header->ts))
+		return 0;
+
+	header->te = header->ts;
+	if (have(&p, ',')) {
+		if(!get_num(&p, &header->te))
+			return 0;
+	}
+
+	if (header->type == 'd') {
+		assert(header->ts == header->te);
+		header->te--;  /* null (zero) range of lines */
+	}
+
+	if(!at_eol(&p))
+		return 0;
+
+	*curp = ++p;
+	return 1;
+}
+
+static int determine_diff_format(mmbuffer_t *content, char** curp)
+{
+	char *p     = content->ptr;
+	char *limit = p + content->size;
+	char *p2, *p3, *p4;
+	struct hunk_header head;
+
+	*curp = p;
+
+	if((p2 = nextline(p, limit)) == 0)
+		return UNKNOWN_FORMAT;
+
+	/* internal (unified) diff, no header */
+	if (memcmp(p, "@@ ", 3) == 0)
+		return UNIFIED_FORMAT;
+
+	/* normal format diff */
+	if (normal_header(&p, &head))
+		return NORMAL_FORMAT;
+
+	if((p3 = nextline(p2, limit)) == 0)
+		return UNKNOWN_FORMAT;
+
+	/* external (unified) diff, with header */
+	if (memcmp(p,  "--- ", 4) == 0 &&
+	    memcmp(p2, "+++ ", 4) == 0 &&
+	    memcmp(p3, "@@ ",  3) == 0) {
+
+		*curp = p3;
+		return UNIFIED_FORMAT;
+	}
+
+	/* context diff */
+	if (memcmp(p,  "*** ", 4) == 0 &&
+	    memcmp(p2, "--- ", 4) == 0 &&
+	    memcmp(p3, "****", 4) == 0) {
+
+		if((p4 = nextline(p3, limit)) == 0)
+			return UNKNOWN_FORMAT;
+
+		*curp = p4;
+		return CONTEXT_FORMAT;
+	}
+
+	return UNKNOWN_FORMAT;
+}
+
+static void get_line(char **curp, char *limit, char type, int num, struct hunk_lines *hl)
+{
+	char *p = *curp;
+	int  normal = (type == '<') || (type == '>');
+	char *pn;
+
+	assert(p < limit);
+
+	if (*p++ != type || (normal && *p++ != ' '))
+		die("invalid diff: leading line chars");
+
+	hl->lines[num] = p;
+
+	if ((pn = nextline(p, limit)) == 0)
+		die("invalid diff: missing eol #3");
+
+	hl->lengths[num] = (int)(pn - p);
+
+	/* check for "\ No newline at end of file" */
+	if (pn < limit && *pn == '\\') {
+		/* remove nl from length and skip */
+		hl->lengths[num] = (int)(pn - p) - 1;
+		pn = nextline(pn, limit);
+	}
+
+	*curp = pn;
+}
+
+static void process_normal_diff(struct diff2 *d, char *p)
+{
+	mmbuffer_t *content = &d->content;
+	char *limit = content->ptr + content->size;
+	struct diff2_hunk *hunk, **last_hunk;
+	int i;
+
+	last_hunk = &d->hunks;
+
+	while (p < limit) {
+		struct hunk_header head;
+
+		hunk = new_diff2_hunk();
+
+		/* hunk header: <int>[,<int>]<type><int>[,<int>] */
+		if (!normal_header(&p, &head))
+			die("invalid diff: header");
+
+		hunk->type = head.type;
+
+		/* from-file hunk lines (if any) */
+		hunk->from.start = head.fs;
+		hunk->from.end   = head.fe;
+		if (head.type != 'a') {
+			int numlines = head.fe - head.fs + 1;
+
+			assert(numlines > 0);
+
+			alloc_line_arrays(numlines, &hunk->from);
+
+			for (i = 0; i < numlines; i++)
+				get_line(&p, limit, '<', i, &hunk->from);
+		}
+
+		/* skip change hunk separator (if any) */
+		if (head.type == 'c') {
+			if (memcmp(p, "---\n", 4) != 0)
+				die("invalid diff: missing change separator");
+			p += 4;
+		}
+
+		/* to-file hunk lines (if any) */
+		hunk->to.start = head.ts;
+		hunk->to.end   = head.te;
+		if (head.type != 'd') {
+			int numlines = head.te - head.ts + 1;
+
+			assert(numlines > 0);
+
+			alloc_line_arrays(numlines, &hunk->to);
+
+			for (i = 0; i < numlines; i++)
+				get_line(&p, limit, '>', i, &hunk->to);
+		}
+
+		/* add this hunk to the end of the list */
+		*last_hunk = hunk;
+		last_hunk  = &hunk->next;
+
+	}
+
+	*last_hunk = 0;
+}
+
+static int have_str(char **tp, char *s)
+{
+	char *p = *tp;
+	int  len = strlen(s);
+
+	if (memcmp(p, s, len) == 0) {
+		p += len;
+		*tp = p;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int unified_header(char **curp, struct unified_hunk_header *header)
+{
+	char *p = *curp;
+
+	if (!have_str(&p, "@@ -"))
+		return 0;
+
+	if (!get_num(&p, &header->fs))
+		return 0;
+
+	header->fc = 1;
+	if (have(&p, ',')) {
+		if(!get_num(&p, &header->fc))
+			return 0;
+	}
+
+	if (!have_str(&p, " +"))
+		return 0;
+
+	if (!get_num(&p, &header->ts))
+		return 0;
+
+	header->tc = 1;
+	if (have(&p, ',')) {
+		if(!get_num(&p, &header->tc))
+			return 0;
+	}
+
+	if (!have_str(&p, " @@"))
+		return 0;
+
+	if(!at_eol(&p))
+		return 0;
+
+	*curp = ++p;
+	return 1;
+}
+
+static int count_hunk_lines(char *p, char *limit, char type)
+{
+	int num = 0;
+
+	while (p < limit && *p == type) {
+		char *pn;
+
+		if ((pn = nextline(p, limit)) == 0)
+			die("invalid diff: missing eol #1");
+
+		num++;
+		p = pn;
+	}
+
+	return num;
+}
+
+static void process_unified_diff(struct diff2 *d, char *p)
+{
+	mmbuffer_t *content = &d->content;
+	char *limit = content->ptr + content->size;
+	struct diff2_hunk *hunk, **last_hunk;
+	int i;
+
+	last_hunk = &d->hunks;
+
+	while (p < limit) {
+		struct unified_hunk_header head;
+		int single_hunk = 0;
+
+		/* hunk header: @@ -<int>[,<int>] +<int>[,<int>] @@ */
+		if (!unified_header(&p, &head))
+			die("invalid diff: header");
+
+		single_hunk = (head.fc == 0 || head.tc == 0);
+
+		for (;;) {  /* for all hunks */
+			int cc = 0, fc = 0, tc = 0;
+
+			/* find begining of next hunk: skip common lines */
+			while (p < limit && *p == ' ') {
+				char *pn;
+
+				cc++;
+				head.fs++; head.fc--;
+				head.ts++; head.tc--;
+
+				if ((pn = nextline(p, limit)) == 0)
+					die("invalid diff: missing eol #2");
+				p = pn;
+			}
+
+			/* finished? */
+			if (limit <= p || *p == '@') {
+				assert(head.fc == 0 && head.tc == 0);
+				break;
+			}
+			if (*p != '-' && *p != '+')
+				die("invalid diff: missing -/+ lines");
+
+			hunk = new_diff2_hunk();
+
+			hunk->from.start = hunk->from.end = head.fs;
+			hunk->to.start   = hunk->to.end   = head.ts;
+
+			/* from-file hunk lines (if any) */
+			fc = count_hunk_lines(p, limit, '-');
+			if (fc > 0) {
+				alloc_line_arrays(fc, &hunk->from);
+
+				for (i = 0; i < fc; i++)
+					get_line(&p, limit, '-', i, &hunk->from);
+
+				hunk->from.end += fc-1;
+
+				head.fs += fc;
+				head.fc -= fc;
+			}
+
+			/* to-file hunk lines (if any) */
+			tc = count_hunk_lines(p, limit, '+');
+			if (tc > 0) {
+				alloc_line_arrays(tc, &hunk->to);
+
+				for (i = 0; i < tc; i++)
+					get_line(&p, limit, '+', i, &hunk->to);
+
+				hunk->to.end += tc-1;
+
+				head.ts += tc;
+				head.tc -= tc;
+			}
+
+			/* set hunk type */
+			assert(fc > 0 || tc > 0);
+			if (fc == 0) {
+				hunk->type = 'a';
+				if (!single_hunk)
+					hunk->from.start--;
+				hunk->from.end = hunk->from.start - 1;
+			} else if (tc == 0) {
+				hunk->type = 'd';
+				if (!single_hunk)
+					hunk->to.start--;
+				hunk->to.end = hunk->to.start - 1;
+			} else {
+				hunk->type = 'c';
+			}
+
+			/* add this hunk to the end of the list */
+			*last_hunk = hunk;
+			last_hunk  = &hunk->next;
+		}
+
+	}
+
+	*last_hunk = 0;
+
+}
+
+struct diff2* process_diff(struct diff_argv *prog, struct finfo *ff, struct finfo *ft)
+{
+	struct diff2 *result = new_diff2(ff, ft);
+	char *scan;
+
+	read_diff(prog, ff, ft, &result->content);
+
+	if (result->content.size == 0)
+		return result;  /* empty diff is ok */
+
+	assert(result->content.size > 0);
+
+	if (result->content.ptr[result->content.size-1] != '\n')
+		die("invalid diff: missing eol on last line");
+
+	switch (determine_diff_format(&result->content, &scan)) {
+		case NORMAL_FORMAT:
+			process_normal_diff(result, scan);
+			break;
+		case UNIFIED_FORMAT:
+			process_unified_diff(result, scan);
+			break;
+		case CONTEXT_FORMAT:
+			die("context diff format not supported");
+			break;
+		case UNKNOWN_FORMAT:
+		default:
+			die("unknown diff format");
+			break;
+	}
+
+	return result;
+}
+
+static void adjust_diff2(struct diff2 *d)
+{
+	struct diff2_hunk *p;
+
+	for (p = d->hunks; p; p = p->next) {
+		if (p->type == 'a') {
+			p->from.start++;
+			p->from.end++;
+		} else if (p->type == 'd') {
+			p->to.start++;
+			p->to.end++;
+		}
+	}
+}
+
+static int copy_lines(struct hunk_lines *dst, int off, struct hunk_lines *src)
+{
+	char **s = src->lines;
+	int  *sl = src->lengths;
+	char **d = dst->lines + off;
+	int  *dl = dst->lengths + off;
+	int  n   = src->size;
+
+	assert(n <= dst->size - off);
+
+	while(n--) {
+		if (*d) {
+			if (*sl != *dl || memcmp(*s, *d, *sl)) {
+				return 0;
+			}
+		} else {
+			*d  = *s;
+			*dl = *sl;
+		}
+		d++; dl++;
+		s++; sl++;
+	}
+	return 1;
+}
+
+static int equal_lines(struct hunk_lines *lhs, struct hunk_lines *rhs)
+{
+	char **l = lhs->lines;
+	int  *ll = lhs->lengths;
+	char **r = rhs->lines;
+	int  *rl = rhs->lengths;
+	int  n   = lhs->size;
+
+	if (n != rhs->size)
+		return 0;
+
+	while (n--) {
+		if (!*l || !*r || *ll != *rl || memcmp(*l, *r, *ll))
+			return 0;
+		l++; ll++;
+		r++; rl++;
+	}
+	return 1;
+}
+
+static int get_low_thread(struct diff2_hunk *p[2])
+{
+	if (!p[0])
+		return 1;
+	if (!p[1])
+		return 0;
+	return (p[0]->to.start > p[1]->to.start) ? 1 : 0;
+}
+
+static void init_segment(struct segment *s, int from, int to)
+{
+	s->from  = from;
+	s->to    = to;
+	s->head  = 0;
+	s->tail  = 0;
+	s->count = 0;
+}
+
+static void add_segment(struct segment *s, struct diff2_hunk *d)
+{
+	assert(d != 0);
+
+	if (!s->head)
+		s->head = s->tail = d;
+	else
+		s->tail = d;
+	s->count++;
+}
+
+static struct diff3_hunk *make_diff3_hunk(struct segment use[2],
+		int low_thread, int high_thread, struct diff3_hunk *last)
+{
+	struct diff3_hunk *result = new_diff3_hunk();
+	int startc, endc;
+	int i, common;
+	int from0, from1;
+
+	assert(use[0].to == use[1].to);
+	assert(use[0].from != use[1].from);
+
+	from0 = use[0].from;
+	from1 = use[1].from;
+
+	common = use[0].to;
+	assert(common >= 0 && common <= 2);
+
+	/* find start/end line numbers from the common file */
+	startc = result->f[common].start = use[low_thread].head->to.start;
+	endc   = result->f[common].end   = use[high_thread].tail->to.end;
+
+	/* find start/end line numbers for other files */
+	for (i = 0; i < 2; i++) {
+		struct segment *s = &use[i];
+		struct diff2_hunk *h = s->head;
+		struct diff2_hunk *t = s->tail;
+		int file = s->from;
+		int start = startc, end = endc;
+
+		assert(file >= 0 && file <= 2);
+
+		if (h) {
+			start = startc - h->to.start + h->from.start;
+			end   = endc   - t->to.end   + t->from.end;
+		} else if (last) {
+			int d = last->f[file].end - last->f[common].end;
+			start = startc + d;
+			end   = endc   + d;
+		}
+		result->f[file].start = start;
+		result->f[file].end   = end;
+	}
+
+	/* allocate hunk_lines line pointer and lengths arrays */
+	for (i = 0; i < 3; i++) {
+		int numlines = result->f[i].end - result->f[i].start + 1;
+
+		if (numlines > 0)
+			alloc_line_arrays(numlines, &result->f[i]);
+	}
+
+	/* copy line info for common file */
+	for (i = 0; i < 2; i++) {
+		struct segment *s = &use[i];
+		struct diff2_hunk *h = s->head;
+		int j;
+
+		for (j = 0; j < s->count; j++,h = h->next) {
+			int offset = h->to.start - startc;
+
+			if (!copy_lines(&result->f[common], offset, &h->to))
+				die("internal error: copy_lines()");
+
+		}
+	}
+
+	/* copy line info for other files */
+	for (i = 0; i < 2; i++) {
+		struct segment *s = &use[i];
+		struct diff2_hunk *h = s->head;
+		struct hunk_lines *tf, *cf;
+		int start, end, file = s->from;
+		int j, k, l, m;
+
+		assert(file >= 0 && file <= 2);
+
+		tf = &result->f[file];
+		cf = &result->f[common];
+
+		start = tf->start;
+		end   = tf->end;
+
+		/* before first hunk */
+		k = (h) ? h->from.start : end+1;
+		for (j = 0; j + start < k; j++) {
+			tf->lines[j]   = cf->lines[j];
+			tf->lengths[j] = cf->lengths[j];
+		}
+
+		/* hunk list */
+		for (j = 0; j < s->count; j++,h = h->next) {
+			int offset = h->from.start - start;
+
+			if (!copy_lines(&result->f[file], offset, &h->from))
+				die("internal error:");
+
+			/* between this and next hunk */
+			l = h->to.end + 1 - startc;
+			if (j < s->count-1)
+				k = h->next->from.start - start;
+			else
+				k = end+1 - start;
+			for (m = h->from.end + 1 - start; m < k; m++,l++) {
+				tf->lines[m]   = cf->lines[l];
+				tf->lengths[m] = cf->lengths[l];
+			}
+
+		}
+
+	}
+
+	/* set diff3 hunk type */
+	if (!use[0].head)
+		result->type = '0' + from1;
+	else if (!use[1].head)
+		result->type = '0' + from0;
+	else {
+		if (equal_lines(&result->f[from0], &result->f[from1]))
+			result->type = '0' + common;
+		else
+			result->type = 'a';
+	}
+
+	return result;
+}
+
+static struct diff3 *make_3way_diff(struct diff2 *d01, struct diff2 *d21)
+{
+	struct diff3 *result = new_diff3(d01, d21);
+	struct diff2_hunk *diff01 = d01->hunks;
+	struct diff2_hunk *diff21 = d21->hunks;
+	struct diff2_hunk *p[2], *high_diff, *other_diff;
+	struct diff3_hunk *hunk, **last_hunk;
+	struct diff3_hunk *last;
+	struct segment use[2];
+	int low_thread, high_thread;
+	int other_thread, high_line;
+
+	assert(d01->ft->num == d21->ft->num);
+	assert(d01->ff->num != d21->ff->num);
+
+	adjust_diff2(d01);
+	adjust_diff2(d21);
+
+	last_hunk = &result->hunks;
+	last = 0;
+	p[0] = diff01;
+	p[1] = diff21;
+
+	while (p[0] || p[1]) {
+		init_segment(&use[0], d01->ff->num, d01->ft->num);
+		init_segment(&use[1], d21->ff->num, d21->ft->num);
+
+		high_thread = low_thread = get_low_thread(p);
+
+		high_diff = p[high_thread];
+		high_line = high_diff->to.end;
+
+		add_segment(&use[high_thread], high_diff);
+		p[high_thread] = high_diff->next;
+
+		other_thread = high_thread ^ 0x1;
+		other_diff   = p[other_thread];
+
+		while (other_diff && other_diff->to.start <= high_line+1) {
+
+			add_segment(&use[other_thread], other_diff);
+			p[other_thread] = p[other_thread]->next;
+
+			if (high_line < other_diff->to.end) {
+				high_thread ^= 0x1;
+				high_diff = other_diff;
+				high_line = other_diff->to.end;
+			}
+
+			other_thread = high_thread ^ 0x1;
+			other_diff   = p[other_thread];
+		}
+
+		hunk = make_diff3_hunk(use, low_thread, high_thread, last);
+
+		if (!hunk)
+			die("can't create diff3 hunk");
+
+		/* add this hunk to the end of the list */
+		*last_hunk = hunk;
+		last_hunk  = &hunk->next;
+
+		last = hunk;
+	}
+
+	*last_hunk = 0;
+
+	return result;
+}
+
+#ifdef DUMMY
+static void print_diff2_hunk(struct diff2_hunk *p)
+{
+	struct hunk_lines *f = &p->from;
+	struct hunk_lines *t = &p->to;
+	int i, type = p->type;
+
+	printf("%d,%d %c %d,%d\n", f->start, f->end, type, t->start, t->end);
+
+	for (i = 0; i < f->size; i++)
+		printf("< %.*s", f->lengths[i], f->lines[i]);
+
+	printf("---\n");
+
+	for (i = 0; i < t->size; i++)
+		printf("> %.*s", t->lengths[i], t->lines[i]);
+
+	printf("+++\n");
+}
+
+static void print_diff2(struct diff2 *d)
+{
+	struct diff2_hunk *p;
+
+	printf("<--- diff2 --->\n");
+	for (p = d->hunks; p; p = p->next)
+		print_diff2_hunk(p);
+	printf(">=============<\n");
+}
+#endif
+
+static void print_diff3_hunk(FILE *outf, struct diff3_hunk *p, char *prefix)
+{
+	int i, j, k, skip_print;
+
+	if (p->type == 'a')
+		fprintf(outf, "====\n");
+	else
+		fprintf(outf, "====%c\n", p->type+1);
+
+	switch (p->type) {
+		case '0': skip_print = 1; break;
+		case '1': skip_print = 0; break;
+		case '2': skip_print = 0; break;
+		case 'a': skip_print = 3; break;
+		default:
+			die("internal error: invalid diff3 hunk type");
+			break;
+	}
+
+	for (j = 0,k = 0; j < 3; j++,k++) {
+		int  numlines, start, end, len;
+		char *s;
+
+		if (p->type == '1' && j > 0)
+			k = (j == 1) ? 2 : 1;
+
+		start = p->f[k].start;
+		end   = p->f[k].end;
+
+		numlines = end - start + 1;
+
+		if (numlines == 0)
+			fprintf(outf, "%d:%da\n", k+1, start-1);
+		else if (numlines == 1)
+			fprintf(outf, "%d:%dc\n", k+1, start);
+		else
+			fprintf(outf, "%d:%d,%dc\n", k+1, start, end);
+
+		if (k == skip_print)
+			continue;
+
+		assert(numlines == p->f[k].size);
+
+		if (p->f[k].size <= 0)
+			continue;
+
+		s   = 0;
+		len = 0;
+
+		for (i = 0; i < p->f[k].size; i++) {
+			s = p->f[k].lines[i];
+			len = p->f[k].lengths[i];
+			fprintf(outf, "%s", prefix);
+			fwrite(s, 1, len, outf);
+		}
+
+		if (s && (len == 0 || s[len-1] != '\n'))
+			fprintf(outf, "\n\\ No newline at end of file\n");
+
+	}
+
+}
+
+static void print_diff3(FILE *outf, struct diff3 *d, struct diff3_options *o)
+{
+	struct diff3_hunk *p;
+	char *prefix = (o->initial_tab) ? "\t" : "  ";
+
+	for (p = d->hunks; p; p = p->next)
+		print_diff3_hunk(outf, p, prefix);
+}
+
+static int write_lines(FILE *outf, char **curp, char *limit, int num)
+{
+	char *p = *curp;
+	char *pn;
+	int  size;
+
+	assert(num >= 0);
+
+	while (num--) {
+		if ((pn = nextline(p, limit)) == 0) {
+			if (num > 0)
+				return -1;
+			pn = limit;
+		}
+		p = pn;
+	}
+	size = (int)(p - *curp);
+	if (size > 0)
+		fwrite(*curp, 1, size, outf);
+	*curp = p;
+	return 0;
+}
+
+static int skip_lines(char **curp, char *limit, int num)
+{
+	char *p = *curp;
+	char *pn;
+
+	assert(num >= 0);
+
+	while (num--) {
+		if ((pn = nextline(p, limit)) == 0) {
+			if (num > 0)
+				return -1;
+			pn = limit;
+		}
+		p = pn;
+	}
+	*curp = p;
+	return 0;
+}
+
+static int diff3_merge(FILE *outf, mmfile_t *inf, struct diff3 *d, struct finfo f[3], struct diff3_options *opts)
+{
+	struct diff3_hunk *p;
+	int conflicts = 0;
+	int inf_lines = 0;
+	char *infp, *inf_limit;
+
+	infp = inf->ptr;
+	inf_limit = infp + inf->size;
+
+	for (p = d->hunks; p; p = p->next) {
+		int conflict = 0;
+		int i, lines;
+
+		/* check if we can skip this block */
+		switch (p->type) {
+			default:
+			case '0': /* change unique to our file: skip */
+				continue;
+				break;
+			case '1': /* same in ours and theirs: merged change */
+				if (!opts->show_all)
+					continue;
+				conflict = 1;
+				break;
+			case '2': /* change only in theirs: un-merged change */
+				if (opts->overlap_only)
+					continue;
+				break;
+			case 'a': /* all files differ: overlapping change */
+				if (opts->unmerged_only)
+					continue;
+				conflict = opts->markers;
+				break;
+		}
+
+		/* write lines from '0' (our) file (if any) */
+		lines = p->f[0].start - inf_lines - 1;
+		if (lines > 0) {
+			if (write_lines(outf, &infp, inf_limit, lines) < 0)
+				die("unexpected eof on file");
+			inf_lines += lines;
+		}
+
+		if (conflict) {
+			/* write lines from files with conflict markers */
+			char *marker_fmt = "<<<<<<< %s\n";
+
+			conflicts++;
+
+			if (p->type == 'a') {
+				/* write lines from '0' (our) file */
+				fprintf(outf, marker_fmt, f[0].label);
+				for (i = 0; i < p->f[0].size; i++) {
+					char *s = p->f[0].lines[i];
+					int len = p->f[0].lengths[i];
+					fwrite(s, 1, len, outf);
+				}
+				marker_fmt = "||||||| %s\n";
+			}
+
+			if (opts->show_all) {
+				/* write lines from '1' (base) file */
+				fprintf(outf, marker_fmt, f[1].label);
+				for (i = 0; i < p->f[1].size; i++) {
+					char *s = p->f[1].lines[i];
+					int len = p->f[1].lengths[i];
+					fwrite(s, 1, len, outf);
+				}
+			}
+
+			fprintf(outf, "=======\n");
+
+		}
+
+		/* write lines from '2' (their) file */
+		for (i = 0; i < p->f[2].size; i++) {
+			char *s = p->f[2].lines[i];
+			int len = p->f[2].lengths[i];
+			fwrite(s, 1, len, outf);
+		}
+
+		/* add conflict marker */
+		if (conflict)
+			fprintf(outf, ">>>>>>> %s\n", f[2].label);
+
+		/* skip lines from '0' (our) file */
+		lines = p->f[0].size;
+		if (lines > 0) {
+			if (skip_lines(&infp, inf_limit, lines) < 0)
+				die("unexpected eof");
+			inf_lines += lines;
+		}
+
+	}
+
+	/* write remainder of '0' (our) file */
+	if (infp < inf_limit)
+		fwrite(infp, 1, (int)(inf_limit - infp), outf);
+
+	return conflicts;
+}
+
+int diff3(FILE *outf, const char *file[3], const char *label[3], struct diff3_options *opts)
+{
+	int i;
+	struct finfo f[3];
+	struct diff2 *d1, *d2;
+	struct diff3 *d3;
+	struct diff_argv *prog = 0;
+	int conflicts = 0;
+
+	for ( i = 0; i < 3; i++ )
+		init_finfo(&f[i], file[i], label[i], i);
+
+	if (opts->diff_prog)
+		prog = new_diff_argv(opts->diff_prog);
+
+	d2 = process_diff(prog, &f[2], &f[1]);
+	free_mmfile(&f[2].mf);
+
+	d1 = process_diff(prog, &f[0], &f[1]);
+	free_mmfile(&f[1].mf);
+
+	d3 = make_3way_diff(d1, d2);
+
+	if (opts->merge) {
+		map_file(&f[0]);
+		conflicts = diff3_merge(outf, &f[0].mf, d3, f, opts);
+	} else {
+		print_diff3(outf, d3, opts);
+	}
+
+	free_mmfile(&f[0].mf);
+	free_diff3(d3);  /* also free()'s d1 and d2 */
+	free_diff_argv(prog);
+
+	return conflicts;
+}
+
+
+static const char builtin_diff3_usage[] =
+"git-diff3 [options]... ours base theirs\n"
+"\n"
+"  -e  --ed            output unmerged changes from BASE to THEIRS into OURS\n"
+"  -E  --show-overlap  output unmerged changes, bracketing conflicts\n"
+"  -A  --show-all      output all changes, bracketing conflicts\n"
+"  -x  --overlap-only  output overlapping changes\n"
+"  -X                  output overlapping changes, bracketing them\n"
+"  -3  --easy-only     output unmerged non-overlapping changes\n"
+"\n"
+"  -m  --merge         output merged file instead of ed script\n"
+"  -T  --initial-tab   make tabs line up by prepending a tab\n"
+"\n"
+"  -L LABEL  --label=LABEL  use LABEL instead of filename\n"
+"  --diff-program=PROGRAM   use PROGRAM to compare files\n"
+;
+
+
+int cmd_diff3(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	const char *label_strings[3];
+	int label_count = 0;
+	int conflicts = 0;
+	int edarg = 0;
+	const char **file;
+	struct diff3_options opts;
+
+	memset(&opts, 0, sizeof(opts));
+
+	for (i = 1 ; i < argc ; i++) {
+		const char *arg = argv[i];
+
+		if (*arg != '-')
+			break;
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(arg, "-e") || !strcmp(arg, "--ed")) {
+			edarg++;
+			continue;
+		}
+		if (!strcmp(arg, "-E") || !strcmp(arg, "--show-overlap")) {
+			edarg++;
+			opts.markers = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-A") || !strcmp(arg, "--show-all")) {
+			edarg++;
+			opts.show_all = 1;
+			opts.markers = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-x") || !strcmp(arg, "--overlap-only")) {
+			edarg++;
+			opts.overlap_only = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-X")) {
+			edarg++;
+			opts.overlap_only = 1;
+			opts.markers = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-3") || !strcmp(arg, "--easy-only")) {
+			edarg++;
+			opts.unmerged_only = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-m") || !strcmp(arg, "--merge")) {
+			opts.merge = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-T") || !strcmp(arg, "--initial-tab")) {
+			opts.initial_tab = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-L")) {
+			if ( argc <= i+1 )
+				die("-L needs a LABEL argument");
+			if ( label_count < 3 )
+				label_strings[label_count++] = argv[++i];
+			else
+				die("too many labels options specified");
+			continue;
+		}
+		if (!strncmp(arg, "--label=", 8)) {
+			if ( !*(arg+8) )
+				die("--label needs a LABEL argument");
+			if ( label_count < 3 )
+				label_strings[label_count++] = arg+8;
+			else
+				die("too many labels options specified");
+			continue;
+		}
+		if (!strncmp(arg, "--diff-program=", 15)) {
+			if ( !*(arg+15) )
+				die("--diff-program needs a PROGRAM argument");
+			opts.diff_prog = arg+15;
+			continue;
+		}
+		if (*(arg+1) != '-') {
+			const char *a = arg+1;
+
+			while (*a) {
+				switch (*a) {
+					case 'A':
+						edarg++;
+						opts.show_all = 1;
+						opts.markers = 1;
+						break;
+					case 'e':
+						edarg++;
+						break;
+					case 'E':
+						edarg++;
+						opts.markers = 1;
+						break;
+					case 'x':
+						edarg++;
+						opts.overlap_only = 1;
+						break;
+					case 'X':
+						edarg++;
+						opts.overlap_only = 1;
+						opts.markers = 1;
+						break;
+					case '3':
+						edarg++;
+						opts.unmerged_only = 1;
+						break;
+					case 'm':
+						opts.merge = 1;
+						break;
+					case 'T':
+						opts.initial_tab = 1;
+						break;
+					default:
+						error("unknown option: %c\n", *a);
+						usage(builtin_diff3_usage);
+						break;
+				}
+				a++;
+			}
+			continue;
+		}
+		error("unrecognised option: %s\n", arg);
+		usage(builtin_diff3_usage);
+	}
+
+	if (edarg > 1)
+		die("at most one of the AeExX3 options are allowed");
+
+	/* -AeExX3 without -m implies ed script */
+	opts.edscript = edarg && !opts.merge;
+	/* -m without -AeExX3 implies -A */
+	if (opts.merge && !edarg) {
+		opts.show_all = 1;
+		opts.markers = 1;
+	}
+
+	if (opts.edscript)
+		die("ed scripts not yet supported!");
+
+	if (argc != i+3) {
+		if ( argc < i+3 )
+			error("missing file argument(s)\n");
+		else
+			error("too many arguments ('%s'...)\n", argv[i+3]);
+		usage(builtin_diff3_usage);
+	}
+
+	file = &argv[i];
+
+	for ( i = label_count; i < 3; i++ )
+		label_strings[i] = file[i];
+
+	conflicts = diff3(stdout, file, label_strings, &opts);
+
+	return conflicts > 0;
+}
+
+
diff --git a/builtin.h b/builtin.h
index 26ebcaf..a0e9ab7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -12,6 +12,8 @@ extern void help_unknown_cmd(const char 
 extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_version(int argc, const char **argv, const char *prefix);
 
+extern int cmd_diff3(int argc, const char **argv, const char *prefix);
+
 extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 18ba14a..a76c7b6 100644
--- a/git.c
+++ b/git.c
@@ -233,6 +233,7 @@ static void handle_internal_command(int 
 		{ "format-patch", cmd_format_patch, NEEDS_PREFIX },
 		{ "count-objects", cmd_count_objects },
 		{ "diff", cmd_diff, NEEDS_PREFIX },
+		{ "diff3", cmd_diff3 },
 		{ "grep", cmd_grep, NEEDS_PREFIX },
 		{ "rm", cmd_rm, NEEDS_PREFIX },
 		{ "add", cmd_add, NEEDS_PREFIX },
diff --git a/t/txxxx-diff3.sh b/t/txxxx-diff3.sh
new file mode 100755
index 0000000..3b515e7
--- /dev/null
+++ b/t/txxxx-diff3.sh
@@ -0,0 +1,175 @@
+#!/bin/sh
+
+test_description='diff3 tests'
+
+. ./test-lib.sh
+
+###########################################################
+# initialise counts
+
+diff3_count=0
+diff3_fails=0
+diff3_stats=0
+total_count=0
+total_fails=0
+total_stats=0
+
+###########################################################
+# test that "git diff3" and "diff3" give the same output
+# and the same exit code for a given set of arguments.
+
+test_diff3 () {
+
+    diff3_count=$(expr $diff3_count + 1)
+
+    diff3 "$@" >out-diff3
+    dret="$?"
+
+    git diff3 "$@" >out-git
+    gret="$?"
+
+    diff out-diff3 out-git >out-diff 2>&1
+
+    if [ "$?" != 0 ]
+    then
+        diff3_fails=$(expr $diff3_fails + 1)
+        echo "*   FAIL: --- " "$@" " ---"
+    fi
+    if [ "$dret" != "$gret" ]
+    then
+        diff3_stats=$(expr $diff3_stats + 1)
+        echo "*   STAT: ($dret != $gret) --- " "$@" " ---"
+    fi
+
+}
+
+###########################################################
+# test that "git diff3" and "diff3" give the same output
+# and the same exit code for several invocations of git
+# with different external diff command lines. (ie "normal"
+# diff and several unified diffs with context lines 0->5)
+
+test_diff3_extra () {
+
+    diff3 "$@" >out-diff3
+    dret="$?"
+
+    for dopt in "" "-U0" "-U1" "-U2" "-u" "-U4" "-U5"
+    do
+        diff3_count=$(expr $diff3_count + 1)
+
+        git diff3 --diff-program="diff $dopt" "$@" >out-git
+        gret="$?"
+
+        diff out-diff3 out-git >out-diff 2>&1
+
+        if [ "$?" != 0 ]
+        then
+            diff3_fails=$(expr $diff3_fails + 1)
+            echo "*   FAIL: --- --diff-program='diff $dopt'" "$@" " ---"
+        fi
+        if [ "$dret" != "$gret" ]
+        then
+            diff3_stats=$(expr $diff3_stats + 1)
+            echo "*   STAT: ($dret != $gret) --- --diff-program='diff $dopt'" "$@" " ---"
+        fi
+    done
+
+}
+
+###########################################################
+# given some options ($1) and three input files ($2->$4)
+# test git diff3 on permutations of the input files.
+
+test_perm_files () {
+    test_diff3 $1 $2 $3 $4
+    test_diff3 $1 $4 $3 $2
+    test_diff3 $1 $3 $2 $4
+    test_diff3 $1 $4 $2 $3
+    test_diff3 $1 $2 $4 $3
+    test_diff3 $1 $3 $4 $2
+}
+
+###########################################################
+# given three input files ($1->$3) test git diff3 output
+# ($opt == "") and all merge types for several permutaions
+# of the input files.  also test the external diff support.
+
+test_files () {
+
+    diff3_count=0
+    diff3_fails=0
+    diff3_stats=0
+
+    for opt in "" "-mA" "-me" "-mE" "-mx" "-mX" "-m3"
+    do
+        test_perm_files $opt $1 $2 $3
+    done
+
+    test_diff3_extra -mA -L our                  $1 $2 $3
+    test_diff3_extra -mA -L our -L base          $1 $2 $3
+    test_diff3_extra -mA -L our -L base -L their $1 $2 $3
+
+    total_count=$(expr $total_count + $diff3_count)
+    total_fails=$(expr $total_fails + $diff3_fails)
+    total_stats=$(expr $total_stats + $diff3_stats)
+
+    fails_and_stats=$(expr $diff3_fails + $diff3_stats)
+
+    case "$fails_and_stats" in
+    0)
+        return 0 ;;
+    *)
+        echo "    tests: $diff3_count, fails: $diff3_fails, stats: $diff3_stats"
+        return 1 ;;
+    esac
+
+}
+
+###########################################################
+# ok so test some files.
+
+test_expect_success \
+    "test files lao tzu tao" \
+    'test_files ../txxxx/lao ../txxxx/tzu ../txxxx/tao'
+
+test_expect_success \
+    "test files lao1 tzu tao1" \
+    'test_files ../txxxx/lao1 ../txxxx/tzu ../txxxx/tao1'
+
+test_expect_success \
+    "test files lao2 tzu tao2" \
+    'test_files ../txxxx/lao2 ../txxxx/tzu ../txxxx/tao2'
+
+test_expect_success \
+    "test files lao3 tzu tao3" \
+    'test_files ../txxxx/lao3 ../txxxx/tzu ../txxxx/tao3'
+
+test_expect_success \
+    "test files lao4 tzu tao4" \
+    'test_files ../txxxx/lao4 ../txxxx/tzu ../txxxx/tao4'
+
+test_expect_success \
+    "test files tzu tzu tzu" \
+    'test_files ../txxxx/tzu ../txxxx/tzu ../txxxx/tzu'
+
+test_expect_success \
+    "test files lao tzu tzu" \
+    'test_files ../txxxx/lao ../txxxx/tzu ../txxxx/tzu'
+
+test_expect_success \
+    "test files lao tzu /dev/null" \
+    'test_files ../txxxx/lao ../txxxx/tzu /dev/null'
+
+test_expect_success \
+    "test files /dev/null tzu /dev/null" \
+    'test_files /dev/null ../txxxx/tzu /dev/null'
+
+###########################################################
+# ok we are done.
+
+echo "    tests: $total_count, fails: $total_fails, stats: $total_stats"
+
+test_done
+
+
diff --git a/t/txxxx/lao b/t/txxxx/lao
new file mode 100644
index 0000000..635ef2c
--- /dev/null
+++ b/t/txxxx/lao
@@ -0,0 +1,11 @@
+The Way that can be told of is not the eternal Way;
+The name that can be named is not the eternal name.
+The Nameless is the origin of Heaven and Earth;
+The Named is the mother of all things.
+Therefore let there always be non-being,
+  so we may see their subtlety,
+And let there always be being,
+  so we may see their outcome.
+The two are the same,
+But after they are produced,
+  they have different names.
diff --git a/t/txxxx/lao1 b/t/txxxx/lao1
new file mode 100644
index 0000000..831654a
--- /dev/null
+++ b/t/txxxx/lao1
@@ -0,0 +1,8 @@
+The Nameless is the origin of Heaven and Earth;
+
+  so we may see their subtlety,
+  so we may see their outcome.
+The two are the same,
+But after they are produced,
+They both may be called deep and profound.
+The door of all subtleties!
diff --git a/t/txxxx/lao2 b/t/txxxx/lao2
new file mode 100644
index 0000000..a7babdc
--- /dev/null
+++ b/t/txxxx/lao2
@@ -0,0 +1,16 @@
+The Nameless is the origin of Heaven and Earth;
+home, away
+The named is the mother of all things.
+
+Amy, Helen, Kym
+Therefore let there always be non-being,
+  so we may see their subtlety,
+fred, bill, george
+And let there always be being,
+  so we may see their outcome.
+The two are the same,
+But after they are produced,
+  they have different names.
+They both may be called deep and profound.
+Deeper and more profound,
+The door of all subtleties!
diff --git a/t/txxxx/lao3 b/t/txxxx/lao3
new file mode 100644
index 0000000..ea500e5
--- /dev/null
+++ b/t/txxxx/lao3
@@ -0,0 +1,13 @@
+The Nameless is the origin of Heaven and Earth;
+The named is the mother of ALL things.
+
+Therefore let there ALWAYS be non-being,
+  so we may see their subtlety,
+And let there ALWAYS be being,
+  so we may see their outcome.
+The two are the same,
+But after they are produced,
+  they have different names.
+They both may be called deep and profound.
+Deeper and more profound,
+The door of all subtleties!
diff --git a/t/txxxx/lao4 b/t/txxxx/lao4
new file mode 100644
index 0000000..2ca7ddd
--- /dev/null
+++ b/t/txxxx/lao4
@@ -0,0 +1,12 @@
+The Way that can be told of is not the eternal Way;
+The name that can be named is not the eternal name.
+The Nameless is the origin of Heaven and Earth;
+The Named is the mother of all things.
+Therefore let there always be non-being,
+  so we may see their subtlety,
+And let there always be being,
+  so we may see their outcome.
+The two are the same,
+But after they are produced,
+  they have different names.
+unfinished symphony
\ No newline at end of file
diff --git a/t/txxxx/tao b/t/txxxx/tao
new file mode 100644
index 0000000..ffe1ba3
--- /dev/null
+++ b/t/txxxx/tao
@@ -0,0 +1,14 @@
+The Way that can be told of is not the eternal Way;
+The name that can be named is not the eternal name.
+The Nameless is the origin of Heaven and Earth;
+The named is the mother of all things.
+
+Therefore let there always be non-being,
+  so we may see their subtlety,
+And let there always be being,
+  so we may see their result.
+The two are the same,
+But after they are produced,
+  they have different names.
+
+  -- The Way of Lao-Tzu, tr. Wing-tsit Chan
diff --git a/t/txxxx/tao1 b/t/txxxx/tao1
new file mode 100644
index 0000000..7c0e98a
--- /dev/null
+++ b/t/txxxx/tao1
@@ -0,0 +1,10 @@
+The Nameless is the origin of Heaven and Earth;
+The named is the mother of all things.
+Therefore let there always be non-being,
+And let there always be being,
+The two are the same,
+But after they are produced,
+  they have different names.
+They both may be called DEEP and profound.
+Deeper and more profound,
+The door of ALL subtleties!
diff --git a/t/txxxx/tao2 b/t/txxxx/tao2
new file mode 100644
index 0000000..033360b
--- /dev/null
+++ b/t/txxxx/tao2
@@ -0,0 +1,16 @@
+The Nameless is the origin of Heaven and Earth;
+The named is the mother of all things.
+mars, venus, neptune
+
+Therefore let there always be non-being,
+quartz, diamond, ruby
+  so we may see their subtlety,
+And let there always be being,
+lilly, rose, tulip
+  so we may see their outcome.
+The two are the same,
+But after they are produced,
+  they have different names.
+They both may be called deep and profound.
+Deeper and more profound,
+The door of all subtleties!
diff --git a/t/txxxx/tao3 b/t/txxxx/tao3
new file mode 100644
index 0000000..0457551
--- /dev/null
+++ b/t/txxxx/tao3
@@ -0,0 +1,13 @@
+The Nameless is the origin of Heaven and Earth;
+The named is the mother of all things.
+THEIR
+Therefore let there always be non-being,
+  so we may see THEIR subtlety,
+And let there always be being,
+  so we may see THEIR outcome.
+The two are the same,
+But after they are produced,
+  they have different names.
+They both may be called deep and profound.
+Deeper and more profound,
+The door of all subtleties!
diff --git a/t/txxxx/tao4 b/t/txxxx/tao4
new file mode 100644
index 0000000..fbe30fd
--- /dev/null
+++ b/t/txxxx/tao4
@@ -0,0 +1,15 @@
+The Way that can be told of is not the eternal Way;
+The name that can be named is not the eternal name.
+The Nameless is the origin of Heaven and Earth;
+The named is the mother of all things.
+
+Therefore let there always be non-being,
+  so we may see their subtlety,
+And let there always be being,
+  so we may see their result.
+The two are the same,
+But after they are produced,
+  they have different names.
+
+  -- The Way of Lao-Tzu, tr. Wing-tsit Chan
+unchained melody
\ No newline at end of file
diff --git a/t/txxxx/tzu b/t/txxxx/tzu
new file mode 100644
index 0000000..5af88a8
--- /dev/null
+++ b/t/txxxx/tzu
@@ -0,0 +1,13 @@
+The Nameless is the origin of Heaven and Earth;
+The named is the mother of all things.
+
+Therefore let there always be non-being,
+  so we may see their subtlety,
+And let there always be being,
+  so we may see their outcome.
+The two are the same,
+But after they are produced,
+  they have different names.
+They both may be called deep and profound.
+Deeper and more profound,
+The door of all subtleties!
-- 
1.4.2


--------------020501010309010407020806--
