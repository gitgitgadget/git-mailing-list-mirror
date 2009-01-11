From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC PATCH 4/3] Add example git-vcs-p4
Date: Sun, 11 Jan 2009 15:12:13 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901110336380.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 21:13:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6gx-0008Ht-Sn
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbZAKUM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbZAKUMY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:12:24 -0500
Received: from iabervon.org ([66.92.72.58]:48388 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754448AbZAKUMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:12:15 -0500
Received: (qmail 30941 invoked by uid 1000); 11 Jan 2009 20:12:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2009 20:12:13 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105213>

This implements the "list" and "import" commands, and has an
implementation of "export" which isn't used yet.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-vcs-p4.txt |   33 ++
 Makefile                     |    3 +
 builtin.h                    |    2 +
 git.c                        |    2 +
 p4-notes                     |   33 ++
 p4client.c                   |   50 +++
 p4client.h                   |   10 +
 vcs-p4.c                     |  945 ++++++++++++++++++++++++++++++++++++++++++
 vcs-p4.h                     |  119 ++++++
 9 files changed, 1197 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-vcs-p4.txt
 create mode 100644 p4-notes
 create mode 100644 p4client.c
 create mode 100644 p4client.h
 create mode 100644 vcs-p4.c
 create mode 100644 vcs-p4.h

diff --git a/Documentation/git-vcs-p4.txt b/Documentation/git-vcs-p4.txt
new file mode 100644
index 0000000..4039d24
--- /dev/null
+++ b/Documentation/git-vcs-p4.txt
@@ -0,0 +1,33 @@
+Config
+------
+
+vcs-p4.port::
+	The value to use for P4PORT
+
+vcs-p4.client::
+	The value to use for P4CLIENT
+
+vcs-p4.codelineformat::
+	A regular expression to match valid codelines; a codeline is a
+	directory that contains exactly those files that belong to a
+	version of a project. Importing history with integrations will
+	generally discover codelines not explicitly marked to be
+	imported, found when a file in a known codeline, whose full
+	path is therefore the codeline path plus a relative path, is
+	integrated from a file with a name that ends with that
+	relative path. However, files will sometimes be integrated
+	from non-codelines (that is, from a directory that contains
+	unrelated files whose history should not be tracked), and this
+	option can be used to ignore some directories.
+
+	Note that, properly, the history of the individual files from
+	a non-codeline which got integrated into a codeline should
+	contribute but that this is not presently supported.
+
+remotes.*.url::
+	The perforce location of a codeline to track. Other codelines
+	may be discovered by git-vcs-p4, but it will make no attempt
+	to get versions in these locations more recent than the last
+	versions that contribute at present to the tracked codelines,
+	and it will not make them available for matching in "fetch"
+	patterns.
diff --git a/Makefile b/Makefile
index dee97c1..3f40452 100644
--- a/Makefile
+++ b/Makefile
@@ -501,6 +501,9 @@ LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
 LIB_OBJS += preload-index.o
 
+LIB_OBJS += p4client.o
+LIB_OBJS += vcs-p4.o
+
 BUILTIN_OBJS += builtin-add.o
 BUILTIN_OBJS += builtin-annotate.o
 BUILTIN_OBJS += builtin-apply.o
diff --git a/builtin.h b/builtin.h
index 1495cf6..9039ad5 100644
--- a/builtin.h
+++ b/builtin.h
@@ -21,6 +21,8 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		const char *author);
 extern int check_pager_config(const char *cmd);
 
+extern int cmd_p4(int argc, const char **argv, const char *prefix);
+
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index a53e24f..9ba92fe 100644
--- a/git.c
+++ b/git.c
@@ -265,6 +265,8 @@ static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
 	static struct cmd_struct commands[] = {
+		{ "vcs-p4", cmd_p4 },
+
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
diff --git a/p4-notes b/p4-notes
new file mode 100644
index 0000000..bd95903
--- /dev/null
+++ b/p4-notes
@@ -0,0 +1,33 @@
+People using branches in p4 work like svn, except that the branches
+are not rooted at predictable places. Furthermore, there is not a
+uniform tree layout within a depot.
+
+Therefore, in order to generate a git repository from p4, it is
+necessary to specify a root within the depot as the working tree root
+in git. On the other hand, it should be possible to determine from the
+p4 history what portions of the depot outside of the root should be
+considered as branches, as it tracks "integrations".
+
+In theory, anyway, it should even be possible to produce a git
+repository with submodules when a similar thing has been done with
+integrations in p4, by determining that there are integrations into a
+subdirectory of the root.
+
+---
+
+Overview of operation:
+
+ - Allocate codeline
+ - Import codeline
+   - use p4_filelog to find the files and their revisions in the codeline
+   - For each file,
+
+---
+Saving processed state
+
+ - Record for each codeline
+   - What are all the changesets?
+
+ - Record for each codeline/changeset
+   - What's the commit
+
diff --git a/p4client.c b/p4client.c
new file mode 100644
index 0000000..09adc47
--- /dev/null
+++ b/p4client.c
@@ -0,0 +1,50 @@
+#include "p4client.h"
+
+#include "cache.h"
+#include "run-command.h"
+
+static const char *const *envp;
+
+void p4_init(const char *const *env)
+{
+	envp = env;
+}
+
+static struct child_process child;
+
+int p4_call(int fds[], const char *arg0, int argc, const char **argv)
+{
+	int i;
+	memset(&child, 0, sizeof(child));
+	if (fds) {
+		child.in = -1;
+		child.out = -1;
+	} else {
+		child.no_stdin = 1;
+		child.no_stdout = 1;
+	}
+	child.err = 0;
+	child.argv = xcalloc(argc + 3, sizeof(*argv));
+	child.argv[0] = "p4";
+	child.argv[1] = arg0;
+	child.env = envp;
+	for (i = 0; i < argc; i++)
+		child.argv[i + 2] = argv[i];
+	child.argv[argc + 2] = NULL;
+	start_command(&child);
+	if (fds) {
+		fds[0] = child.in;
+		fds[1] = child.out;
+	}
+	return 0;
+}
+
+int p4_complete(void)
+{
+	if (!child.no_stdin)
+		close(child.in);
+	if (!child.no_stdout)
+		close(child.out);
+	finish_command(&child);
+	return 0;
+}
diff --git a/p4client.h b/p4client.h
new file mode 100644
index 0000000..2fa2cc3
--- /dev/null
+++ b/p4client.h
@@ -0,0 +1,10 @@
+#ifndef P4CLIENT_H
+#define P4CLIENT_H
+
+void p4_init(const char *const *env);
+
+int p4_call(int fds[], const char *arg0, int argc, const char **argv);
+
+int p4_complete();
+
+#endif
diff --git a/vcs-p4.c b/vcs-p4.c
new file mode 100644
index 0000000..3ac1e38
--- /dev/null
+++ b/vcs-p4.c
@@ -0,0 +1,945 @@
+#include "cache.h"
+#include "vcs-p4.h"
+#include "strbuf.h"
+#include "remote.h"
+#include "commit.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "diff.h"
+
+#include "p4client.h"
+
+/** Should we try to find codelines that branch off of the relevant
+ * ones, for future reference? This lets us find new things in
+ * ls-remote without making the user tell us.
+ **/
+static int find_new_codelines;
+
+static regex_t *codeline_regex;
+
+#define CODELINE_TAG "Codeline: "
+#define CHANGESET_TAG "Changeset: "
+
+/** List functions **/
+
+static void add_to_revision_list(struct p4_revision_list **list,
+				 struct p4_revision *revision)
+{
+	while (*list)
+		list = &(*list)->next;
+	*list = xcalloc(1, sizeof(**list));
+	(*list)->revision = revision;
+}
+
+/** Functions to find or create representations **/
+
+static struct p4_depot *get_depot(void)
+{
+	struct p4_depot *depot = xcalloc(1, sizeof(*depot));
+	depot->next_mark = 1;
+	return depot;
+}
+
+static struct p4_changeset *get_changeset(struct p4_codeline *codeline,
+					  long number);
+
+static char *codeline_to_refname(const char *path) {
+	struct strbuf buf;
+	if (prefixcmp(path, "//"))
+		return NULL;
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "refs/p4/%s", path + 2);
+	return strbuf_detach(&buf, NULL);
+}
+
+static char *refname_to_codeline(const char *refname) {
+	struct strbuf buf;
+	if (prefixcmp(refname, "refs/p4/"))
+		return NULL;
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "//%s", refname + strlen("refs/p4/"));
+	return strbuf_detach(&buf, NULL);
+}
+
+static struct p4_codeline *get_codeline(struct p4_depot *depot, const char *path)
+{
+	struct p4_codeline **posn, *codeline;
+	unsigned char sha1[20];
+
+	if (codeline_regex && regexec(codeline_regex, path, 0, NULL, 0))
+		return NULL;
+
+	for (posn = &depot->codelines; *posn; posn = &(*posn)->next)
+		if (!strcmp(path, (*posn)->path))
+			return *posn;
+	codeline = xcalloc(1, sizeof(*codeline));
+	codeline->depot = depot;
+	codeline->path = xstrdup(path);
+
+	codeline->refname = codeline_to_refname(path);
+	if (!get_sha1(codeline->refname, sha1)) {
+		struct commit *commit = lookup_commit(sha1);
+		char *field;
+		parse_commit(commit);
+		printf("progress found commit for %s\n", codeline->refname);
+		field = strstr(commit->buffer, CHANGESET_TAG);
+		if (!field) {
+			fprintf(stderr, "Couldn't find changeset line in commit\n");
+		} else {
+			struct p4_changeset *changeset;
+			codeline->finished_changeset =
+				atoi(field + strlen(CHANGESET_TAG));
+			printf("progress for changeset %lu\n",
+			       codeline->finished_changeset);
+			changeset = get_changeset(codeline, codeline->finished_changeset);
+			changeset->commit = commit;
+			codeline->history = changeset;
+		}
+	}
+	*posn = codeline;
+	return codeline;
+}
+
+static struct p4_codeline *find_codeline(struct p4_depot *depot, const char *path)
+{
+	struct p4_codeline **posn;
+	for (posn = &depot->codelines; *posn; posn = &(*posn)->next)
+		if (!prefixcmp(path, (*posn)->path))
+			return *posn;
+	return NULL;
+}
+
+/** Inserts the changeset at the right place in order for the codeline **/
+static struct p4_changeset *get_changeset(struct p4_codeline *codeline,
+					  long number)
+{
+	struct p4_changeset **posn = &codeline->changesets;
+	struct p4_changeset *changeset, *prev = NULL;
+	while (*posn && (*posn)->number < number) {
+		prev = *posn;
+		posn = &(*posn)->next;
+	}
+	if (*posn && (*posn)->number == number)
+		return *posn;
+	printf("# add changeset %lu in %s\n", number, codeline->path);
+	changeset = xcalloc(1, sizeof(*changeset));
+	changeset->codeline = codeline;
+	changeset->next = *posn;
+	changeset->previous = prev;
+	if (changeset->next)
+		changeset->next->previous = changeset;
+	else
+		codeline->head = changeset;
+	*posn = changeset;
+	changeset->number = number;
+	codeline->num_changesets++;
+	return changeset;
+}
+
+static struct p4_changeset *changeset_from_commit(struct p4_depot *depot,
+						  struct commit *commit)
+{
+	unsigned long number = 0;
+	char *codeline = NULL, *field;
+	parse_commit(commit);
+	field = strstr(commit->buffer, CHANGESET_TAG);
+	if (field)
+		number = atoi(field + strlen(CHANGESET_TAG));
+	field = strstr(commit->buffer, CODELINE_TAG);
+	if (field) {
+		char *end;
+		codeline = field + strlen(CODELINE_TAG);
+		end = strchr(codeline, '\n');
+		if (end)
+			*end = '\0';
+	}
+	if (number && codeline)
+		return get_changeset(get_codeline(depot, codeline), number);
+	return NULL;
+}
+
+static struct p4_file *get_file_by_full(struct p4_codeline *codeline,
+					const char *fullpath)
+{
+	const char *rel = fullpath + strlen(codeline->path);
+	struct p4_file **posn;
+	for (posn = &codeline->files; *posn; posn = &(*posn)->next) {
+		if (!strcmp((*posn)->name, rel))
+			return *posn;
+	}
+	*posn = xcalloc(1, sizeof(**posn));
+	(*posn)->codeline = codeline;
+	(*posn)->name = xstrdup(rel);
+	return *posn;
+}
+
+static struct p4_file *get_related_file(struct p4_file *base, const char *path)
+{
+	int basenamelen = strlen(base->name);
+	int reldirlen = strlen(path) - basenamelen;
+	struct p4_codeline *codeline;
+	if (reldirlen > 0 && !strcmp(path + reldirlen, base->name)) {
+		/* File with the same name in another codeline */
+		char *other = xstrndup(path, reldirlen);
+		printf("# find %s in %s\n", path, other);
+		codeline = get_codeline(base->codeline->depot, other);
+		if (codeline)
+			return get_file_by_full(codeline, path);
+		return NULL;
+	}
+	codeline = find_codeline(base->codeline->depot, path);
+	if (codeline) {
+		/* File with a different name in some known codeline */
+		return get_file_by_full(codeline, path);
+	}
+	/* Not in any known codeline; need to recheck this after
+	 * discovering codelines completes.
+	 */
+	return NULL;
+}
+
+static struct p4_revision *get_revision(struct p4_file *file, unsigned number)
+{
+	struct p4_revision **posn;
+	struct p4_revision *revision;
+	for (posn = &file->revisions; *posn && (*posn)->number < number;
+	     posn = &(*posn)->next)
+		;
+	if (!*posn || (*posn)->number != number) {
+		revision = xcalloc(1, sizeof(*revision));
+		revision->next = *posn;
+		*posn = revision;
+		revision->number = number;
+		revision->file = file;
+	}
+	return *posn;
+}
+
+static int parse_p4_date(const char *date)
+{
+	struct tm tm;
+	memset(&tm, 0, sizeof(tm));
+	tm.tm_year = strtol(date, NULL, 10) - 1900;
+	tm.tm_mon = strtol(date + 5, NULL, 10) - 1;
+	tm.tm_mday = strtol(date + 8, NULL, 10);
+	tm.tm_hour = strtol(date + 11, NULL, 10);
+	tm.tm_min = strtol(date + 14, NULL, 10);
+	tm.tm_sec = strtol(date + 17, NULL, 10);
+	return mktime(&tm);
+}
+
+static const char *get_file_type(char *text)
+{
+	if (!prefixcmp(text, "text"))
+		return "text";
+	if (!prefixcmp(text, "ktext"))
+		return "ktext";
+	if (!prefixcmp(text, "xtext"))
+		return "xtext";
+	if (!prefixcmp(text, "kxtext"))
+		return "kxtext";
+	return "unknown";
+}
+
+static const char *get_file_mode(const char *type)
+{
+	if (!strcmp(type, "kxtext") || !strcmp(type, "xtext"))
+		return "100755";
+	return "100644";
+}
+
+static void output_data(struct strbuf *buf)
+{
+	printf("data %d\n", buf->len);
+	fwrite(buf->buf, 1, buf->len, stdout);
+	printf("\n");
+}
+
+static int write_blob(struct p4_codeline *codeline,
+		      const unsigned char *sha1,
+		      const char *path)
+{
+	struct strbuf buf;
+	void *content;
+	enum object_type type;
+	unsigned long size;
+	int fd;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/%s", codeline->working, path);
+	content = read_sha1_file(sha1, &type, &size);
+	fd = open(buf.buf, O_WRONLY | O_CREAT, 0666);
+	if (fd < 0) {
+		die("Got err %d", errno);
+	}
+	write_or_die(fd, content, size);
+	return 0;
+}
+
+/** P4 operations **/
+
+static int p4_where(struct p4_codeline *codeline)
+{
+	int fds[2];
+	const char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addstr(&buf, codeline->path);
+	argv[0] = buf.buf;
+	p4_call(fds, "where", 1, argv);
+	FILE *input = fdopen(fds[1], "r");
+
+	while (!strbuf_getline(&buf, input, '\n')) {
+		char *working = strrchr(buf.buf, ' ');
+		if (working)
+			codeline->working = xstrdup(working + 1);
+	}
+	p4_complete();
+	return codeline->working ? 0 : -1;
+}
+
+static void p4_sync(struct p4_codeline *codeline)
+{
+	const char *argv[1];
+	struct strbuf buf;
+
+	printf("progress syncing %s/...\n", codeline->working);
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/...@%lu",
+		    codeline->working, codeline->head->number);
+	argv[0] = buf.buf;
+	p4_call(NULL, "sync", 1, argv);
+	p4_complete();
+}
+
+static void p4_edit(struct p4_codeline *codeline, const char *path)
+{
+	const char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/%s", codeline->working, path);
+	argv[0] = buf.buf;
+	p4_call(NULL, "edit", 1, argv);
+	strbuf_release(&buf);
+	p4_complete();
+}
+
+static void p4_add(struct p4_codeline *codeline, const char *path)
+{
+	const char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/%s", codeline->working, path);
+	argv[0] = buf.buf;
+	p4_call(NULL, "add", 1, argv);
+	strbuf_release(&buf);
+	p4_complete();
+}
+
+static void p4_delete(struct p4_codeline *codeline, const char *path)
+{
+	const char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/%s", codeline->working, path);
+	argv[0] = buf.buf;
+	p4_call(NULL, "delete", 1, argv);
+	strbuf_release(&buf);
+	p4_complete();
+}
+
+static void p4_submit(struct commit *commit)
+{
+	int fds[2];
+	const char *argv[1];
+	int skip = 0;
+	argv[0] = "-o";
+	p4_call(fds, "change", 1, argv);
+
+	struct strbuf message;
+	struct strbuf line;
+
+	FILE *input = fdopen(fds[1], "r");
+
+	strbuf_init(&message, 0);
+	strbuf_init(&line, 0);
+
+	while (!strbuf_getline(&line, input, '\n')) {
+		if (!skip) {
+			strbuf_addstr(&message, line.buf);
+			strbuf_addch(&message, '\n');
+		}
+		if (line.buf[0] != '\t')
+			skip = 0;
+		if (!strcmp(line.buf, "Description:")) {
+			char *posn;
+			parse_commit(commit);
+			posn = strstr(commit->buffer, "\n\n");
+			if (posn)
+				posn += 2;
+			while (*posn) {
+				char *eol = strchr(posn, '\n');
+				strbuf_addstr(&message, "\t");
+				if (eol) {
+					eol++;
+					strbuf_add(&message, posn, eol - posn);
+					posn = eol;
+				} else {
+					strbuf_addstr(&message, posn);
+					break;
+				}
+			}
+			strbuf_addstr(&message, "\n");
+			skip = 1;
+		}
+	}
+
+	fclose(input);
+	p4_complete();
+
+	printf("%s\n", message.buf);
+
+	argv[0] = "-i";
+	p4_call(fds, "submit", 1, argv);
+
+	write_or_die(fds[0], message.buf, message.len);
+	close(fds[0]);
+
+	input = fdopen(fds[1], "r");
+	while (!strbuf_getline(&line, input, '\n'))
+		fprintf(stderr, "%s\n", line.buf);
+	p4_complete();
+}
+
+static void p4_print(struct p4_revision *revision)
+{
+	int fds[2];
+	const char *argv[2];
+	struct strbuf line;
+	strbuf_init(&line, 0);
+	strbuf_addf(&line, "%s%s#%lu",
+		    revision->file->codeline->path,
+		    revision->file->name, revision->number);
+	argv[1] = line.buf;
+	argv[0] = "-q";
+	p4_call(fds, "print", 2, argv);
+
+	strbuf_reset(&line);
+	strbuf_read(&line, fds[1], 0);
+	printf("data %d\n%s\n", line.len, line.buf);
+	close(fds[1]);
+	p4_complete();
+}
+
+static void p4_change(struct p4_changeset *changeset)
+{
+	int fds[2];
+	const char *argv[2];
+	struct strbuf line;
+	struct strbuf message;
+	int date = 0;
+	char *user = NULL;
+
+	strbuf_init(&line, 0);
+	strbuf_addf(&line, "%lu", changeset->number);
+	argv[1] = line.buf;
+	argv[0] = "-o";
+	p4_call(fds, "change", 2, argv);
+
+	FILE *input = fdopen(fds[1], "r");
+
+	while (!strbuf_getline(&line, input, '\n')) {
+		if (!prefixcmp(line.buf, "User:\t"))
+			user = xstrdup(line.buf + 6);
+		else if (!prefixcmp(line.buf, "Date:\t"))
+			date = parse_p4_date(line.buf + 6);
+		else if (!prefixcmp(line.buf, "Description:"))
+			break;
+	}
+	printf("committer %s <%s> %d +0000\n", user, user, date);
+	free(user);
+
+	strbuf_init(&message, 0);
+
+	while (!strbuf_getline(&line, input, '\n')) {
+		strbuf_addstr(&message, line.buf + (line.buf[0] == '\t'));
+		strbuf_addch(&message, '\n');
+	}
+
+	strbuf_addf(&message, CODELINE_TAG "%s\n" CHANGESET_TAG "%lu\n",
+		    changeset->codeline->path, changeset->number);
+	output_data(&message);
+	fclose(input);
+	p4_complete();
+}
+
+/** Finds all files in the codeline, and all revisions of those files,
+ * and all of the changesets they are from, and looks up the codelines
+ * and files they integrate or branch.
+ **/
+static void p4_filelog(struct p4_codeline *codeline)
+{
+	int fds[2];
+	struct strbuf line;
+
+	struct p4_file *file = NULL;
+	struct p4_revision *revision = NULL;
+	const char *arg;
+
+	if (codeline->filelog_done)
+		return;
+
+	printf("progress looking at codeline %s\n", codeline->path);
+
+	strbuf_init(&line, 0);
+	strbuf_addstr(&line, codeline->path);
+	strbuf_addstr(&line, "/...");
+	arg = line.buf;
+	p4_call(fds, "filelog", 1, &arg);
+
+	FILE *input = fdopen(fds[1], "r");
+
+	while (!strbuf_getline(&line, input, '\n')) {
+		if (prefixcmp(line.buf, "...")) {
+			if (file) {
+				// we're done with one; set HEAD number
+				// also need this at the end
+			}
+			file = get_file_by_full(codeline, line.buf);
+		} else if (prefixcmp(line.buf, "... ...")) {
+// ... #<rev> change <change> <op> on <date> by <client> (<type>) '<oneline>'
+			int rev, change;
+			char *posn = line.buf + strlen("... #");
+			rev = strtoul(posn, &posn, 10);
+			posn += strlen(" change ");
+			change = strtoul(posn, &posn, 10);
+			posn = strchr(posn, '(') + 1;
+			revision = get_revision(file, rev);
+			revision->changeset = get_changeset(codeline, change);
+			revision->type = get_file_type(posn);
+			add_to_revision_list(&revision->changeset->revisions,
+					     revision);
+		} else {
+// ... ... <op> <direction> <path>#<rev>
+			const char *path;
+			int rev, from = 0;
+			char *type = line.buf + strlen("... ... ");
+			char *posn = strrchr(type, ' ') + 1;
+
+			from = (!prefixcmp(type, "ignored") &&
+				posn == type + strlen("ignored") + 1) ||
+				!prefixcmp(strchr(type, ' '), " from");
+
+			path = posn;
+			posn = strchr(posn, '#');
+			*(posn++) = '\0';
+			do {
+				/* ???? What does a list of revisions mean? */
+				rev = strtoul(posn, &posn, 10);
+				if (*posn != ',')
+					break;
+				posn += 2;
+			} while (1);
+			if (from) {
+				struct p4_file *rel_file =
+					get_related_file(file, path);
+				if (!rel_file)
+					printf("# Couldn't find %s related to %s %s\n",
+					    path, file->codeline->path,
+					    file->name);
+				if (rel_file && rel_file->codeline != codeline)
+					add_to_revision_list(&revision->integrated,
+							     get_revision(rel_file, rev));
+			} else if (find_new_codelines) {
+				/* This is an "<op> into <path>#<rev>" line.
+				 * We just want to try to create a codeline.
+				 */
+				get_related_file(file, path);
+			}
+		}
+	}
+	fclose(input);
+	p4_complete();
+	if (codeline->history)
+		codeline->unreported = codeline->history->next;
+	else
+		codeline->unreported = codeline->changesets;
+	codeline->filelog_done = 1;
+}
+
+/** Functions to import things (i.e., fill out the representations) **/
+
+static struct p4_changeset_list *
+find_codeline_changeset(struct p4_changeset_list **list,
+			struct p4_codeline *codeline)
+{
+	while (*list) {
+		if ((*list)->changeset->codeline == codeline)
+			return *list;
+		list = &(*list)->next;
+	}
+	*list = xcalloc(1, sizeof(**list));
+	return *list;
+}
+
+static void resolve_changeset_integrates(struct p4_changeset *changeset)
+{
+	struct p4_revision_list *posn;
+	struct p4_changeset_list *changesets = NULL;
+	/* For each codeline, we want the highest numbered changeset
+	 * that introduced a revision that has been integrated.
+	 */
+	for (posn = changeset->revisions; posn; posn = posn->next) {
+		struct p4_revision_list *rev_ints = posn->revision->integrated;
+		while (rev_ints) {
+			struct p4_changeset_list *item;
+			if (rev_ints->revision->file->codeline == changeset->codeline) {
+				rev_ints = rev_ints->next;
+				continue;
+			}
+			/* The revision doesn't have the changeset
+			 * filled out unless we call this.
+			 */
+			p4_filelog(rev_ints->revision->file->codeline);
+			item = find_codeline_changeset(&changesets,
+						       rev_ints->revision->file->codeline);
+			if (!item->changeset ||
+			    item->changeset->number < rev_ints->revision->changeset->number) {
+				printf("progress %lu integrates %s#%lu from %lu\n",
+				       changeset->number,
+				       rev_ints->revision->file->name,
+				       rev_ints->revision->number,
+				       rev_ints->revision->changeset->number);
+				item->changeset = rev_ints->revision->changeset;
+			}
+			rev_ints = rev_ints->next;
+		}
+	}
+	/* We could issue a warning if the state of other files didn't
+	 * match and yet didn't get integrated, but that's a lot of
+	 * work and there's no good way to represent the case of a
+	 * commit contributing to but not being completely obsoleted
+	 * by another commit.
+	 */
+	changeset->integrated = changesets;
+	while (changesets) {
+		printf("# integrate %lu from %lu\n", changeset->number, changesets->changeset->number);
+		changesets = changesets->next;
+	}
+}
+
+static struct p4_codeline *import_depot(struct p4_depot *depot, const char *refname)
+{
+	struct p4_codeline *target, *posn;
+	char *path = refname_to_codeline(refname);
+	target = get_codeline(depot, path);
+
+	if (!target)
+		die("Invalid codeline: %s", path);
+
+	free(path);
+
+	p4_filelog(target);
+
+	printf("progress resolving integrates\n");
+
+	/* Now resolve all the integrates in changesets */
+	for (posn = depot->codelines; posn; posn = posn->next) {
+		struct p4_changeset *changeset;
+		for (changeset = posn->unreported; changeset; changeset = changeset->next) {
+			resolve_changeset_integrates(changeset);
+		}
+	}
+
+	return target;
+}
+
+static void name_changeset(struct p4_changeset *changeset)
+{
+	if (changeset->commit)
+		printf("%s\n", sha1_to_hex(changeset->commit->object.sha1));
+	else
+		printf(":%d\n", changeset->mark);
+}
+
+static void lookup_git_changeset(struct p4_codeline *codeline,
+				 struct p4_changeset *changeset)
+{
+	while (!changeset->commit) {
+		struct commit *parent = codeline->history->commit->parents->item;
+		parse_commit(parent);
+		codeline->history->previous->commit = parent;
+		codeline->history = codeline->history->previous;
+	}
+}
+
+static void report_codeline(struct p4_codeline *codeline,
+			    struct p4_changeset *until);
+
+static void identify_changeset(struct p4_changeset *changeset)
+{
+	if (changeset->mark || changeset->commit)
+		return;
+	if (changeset->codeline->finished_changeset >= changeset->number)
+		lookup_git_changeset(changeset->codeline, changeset);
+	else
+		report_codeline(changeset->codeline, changeset);
+}
+
+static void report_codeline(struct p4_codeline *codeline, struct p4_changeset *until)
+{
+	struct p4_changeset *changeset;
+	struct p4_revision_list *rev;
+
+	printf("progress importing content of codeline %s", codeline->path);
+	if (until)
+		printf(" (up to changeset %lu)", until->number);
+	printf("\n");
+
+	for (changeset = codeline->unreported; changeset; changeset = changeset->next) {
+		struct p4_changeset_list *integrated = changeset->integrated;
+		printf("progress check %lu\n", changeset->number);
+
+		while (integrated) {
+			identify_changeset(integrated->changeset);
+			integrated = integrated->next;
+		}
+		printf("progress import changeset %lu\n",
+		       changeset->number);
+		printf("# changeset %lu\n", changeset->number);
+		printf("commit %s\n", codeline->refname);
+		changeset->mark = codeline->depot->next_mark++;
+		printf("mark :%d\n", changeset->mark);
+		p4_change(changeset);
+		if (changeset->previous) {
+			printf("from ");
+			name_changeset(changeset->previous);
+		}
+		integrated = changeset->integrated;
+		while (integrated) {
+			printf("merge ");
+			name_changeset(integrated->changeset);
+			integrated = integrated->next;
+		}
+
+		for (rev = changeset->revisions; rev; rev = rev->next) {
+			printf("M %s inline %s\n",
+			       get_file_mode(rev->revision->type),
+			       rev->revision->file->name + 1);
+			p4_print(rev->revision);
+		}
+		printf("\n");
+		codeline->unreported = changeset->next;
+		if (changeset == until)
+			break;
+	}
+	printf("checkpoint\n");
+}
+
+static void import_p4(int ref_nr, const char **refs)
+{
+	int i;
+	struct p4_depot *depot = get_depot();
+	struct p4_codeline *target;
+	save_commit_buffer = 1;
+
+	for (i = 0; i < ref_nr; i++) {
+		target = import_depot(depot, refs[i]);
+
+		identify_changeset(target->head);
+	}
+}
+
+static void export_change(struct diff_options *options,
+			  unsigned old_mode, unsigned new_mode,
+			  const unsigned char *old_sha1,
+			  const unsigned char *new_sha1,
+			  const char *path)
+{
+	struct p4_codeline *codeline = options->format_callback_data;
+	p4_edit(codeline, path);
+	write_blob(codeline, new_sha1, path);
+}
+
+static void export_add_remove(struct diff_options *options,
+			      int addremove, unsigned mode,
+			      const unsigned char *sha1,
+			      const char *path)
+{
+	struct p4_codeline *codeline = options->format_callback_data;
+	if (addremove == '+') {
+		write_blob(codeline, sha1, path);
+		p4_add(codeline, path);
+	} else if (addremove == '-') {
+		p4_delete(codeline, path);
+	}
+}
+
+static void export_commit(struct p4_codeline *codeline,
+			  struct commit *git_commit, struct commit *git_parent)
+{
+	struct tree_desc pre, post;
+	struct diff_options opts;
+	memset(&opts, 0, sizeof(opts));
+	parse_tree(git_commit->tree);
+	parse_tree(git_parent->tree);
+	init_tree_desc(&pre, git_parent->tree->buffer, git_parent->tree->size);
+	init_tree_desc(&post, git_commit->tree->buffer, git_commit->tree->size);
+	opts.change = export_change;
+	opts.add_remove = export_add_remove;
+	opts.format_callback_data = codeline;
+	opts.flags = DIFF_OPT_RECURSIVE;
+	diff_tree(&pre, &post, "/", &opts);
+	p4_submit(git_commit);
+}
+
+static void export_p4(struct remote *remote, const char *branch)
+{
+	struct p4_depot *depot = get_depot();
+	const char *codeline = remote->url[0];
+	struct p4_codeline *target;
+	struct strbuf buf;
+
+	// check client
+
+	target = import_depot(depot, codeline);
+
+	strbuf_init(&buf, 0);
+
+	while (!strbuf_getline(&buf, stdin, '\n')) {
+		struct p4_changeset *parent = NULL, *integrate = NULL;
+		unsigned char sha1[20];
+		struct commit *commit, *git_parent = NULL;
+		struct commit_list *parents;
+		get_sha1(buf.buf, sha1);
+		commit = lookup_commit(sha1);
+		parse_commit(commit);
+		for (parents = commit->parents; parents; parents = parents->next) {
+			struct p4_changeset *p4_parent =
+				changeset_from_commit(depot, parents->item);
+			if (p4_parent) {
+				if (p4_parent->codeline == target) {
+					parent = p4_parent;
+					git_parent = parents->item;
+				} else
+					integrate = p4_parent;
+			}
+		}
+		if (target->head != parent) {
+			printf("progress not up-to-date\n");
+			return;
+		}
+		if (p4_where(target))
+			break;
+		p4_sync(target);
+
+		if (!parent) {
+			// Need to start new codeline
+		}
+		export_commit(target, commit, git_parent);
+	}
+}
+
+static const char **env;
+static int env_nr;
+static int env_alloc;
+
+static int handle_config(const char *key, const char *value, void *cb)
+{
+	struct strbuf buf;
+	const char *subkey;
+	if (!prefixcmp(key, "vcs-p4.")) {
+		subkey = key + 7;
+		if (!strcmp(subkey, "port")) {
+			strbuf_init(&buf, 0);
+			strbuf_addf(&buf, "P4PORT=%s", value);
+
+			ALLOC_GROW(env, env_nr + 1, env_alloc);
+			env[env_nr++] = strbuf_detach(&buf, NULL);
+		}
+		if (!strcmp(subkey, "client")) {
+			strbuf_init(&buf, 0);
+			strbuf_addf(&buf, "P4CLIENT=%s", value);
+
+			ALLOC_GROW(env, env_nr + 1, env_alloc);
+			env[env_nr++] = strbuf_detach(&buf, NULL);
+		}
+		if (!strcmp(subkey, "codelineformat")) {
+			codeline_regex = (regex_t*)xmalloc(sizeof(regex_t));
+			if (regcomp(codeline_regex, value, REG_EXTENDED)) {
+				free(codeline_regex);
+				fprintf(stderr, "Invalid codeline pattern: %s",
+					value);
+			}
+		}
+	}
+	return 0;
+}
+
+int cmd_p4(int argc, const char **argv, const char *prefix)
+{
+	struct remote *remote;
+
+	git_config(handle_config, NULL);
+
+	//ALLOC_GROW(env, env_nr + 1, env_alloc);
+	//env[env_nr++] = "P4PORT=localhost:1666";
+
+	ALLOC_GROW(env, env_nr + 1, env_alloc);
+	env[env_nr++] = NULL;
+
+	p4_init(env);
+
+	if (!strcmp(argv[1], "capabilities")) {
+		printf("import\n");
+		printf("find-new-branches\n");
+		printf("export\n");
+		printf("fork\n");
+		printf("merge\n");
+		return 0;
+	}
+	if (!strcmp(argv[1], "import")) {
+		prefix = setup_git_directory();
+		remote = remote_get(argv[2]);
+		import_p4(argc - 3, argv + 3);
+		return 0;
+	}
+	if (!strcmp(argv[1], "list")) {
+		int i;
+		prefix = setup_git_directory();
+		remote = remote_get(argv[2]);
+		for (i = 0; i < remote->url_nr; i++) {
+			printf("%s\n", codeline_to_refname(remote->url[i]));
+		}
+		return 0;
+	}
+	if (!strcmp(argv[1], "export")) {
+		remote = remote_get(argv[2]);
+
+		export_p4(remote, argv[3]);
+		// 1: check whether the import of the target location
+		//    is up-to-date
+
+		// 2: find the target location in the client view
+
+		// 3: bring the client view up-to-date with the target
+		//    location
+
+		// 4: recheck that this matches the tree
+
+		// 5: open the necessary files in the client
+
+		// 6: replace the necessary files in the filesystem
+
+		// 7: submit
+
+		// 8: reimport
+
+		// 9: go back to (3)
+	}
+	return 1;
+}
diff --git a/vcs-p4.h b/vcs-p4.h
new file mode 100644
index 0000000..55aa307
--- /dev/null
+++ b/vcs-p4.h
@@ -0,0 +1,119 @@
+#ifndef VCS_P4_H
+#define VCS_P4_H
+
+struct p4_depot {
+	struct p4_codeline *codelines;
+
+	int next_mark;
+};
+
+/** Note that multiple codelines can have changesets with the same
+ * number.
+ **/
+struct p4_changeset {
+	struct p4_codeline *codeline;
+
+	unsigned long number;
+
+	/** Used only if a previous import found this changeset **/
+	struct commit *commit;
+
+	/** Used only if this changeset is newly imported in this operation. **/
+	int mark;
+
+	const char *message;
+
+	struct p4_revision_list *revisions;
+
+	/** Not explicit in p4 **/
+	struct p4_changeset_list *integrated;
+
+	/** Next and previous in codeline **/
+	struct p4_changeset *next;
+	struct p4_changeset *previous;
+};
+
+struct p4_changeset_list {
+	struct p4_changeset *changeset;
+	struct p4_changeset_list *next;
+};
+
+struct p4_revision {
+	unsigned long number;
+
+	const char *type;
+
+	struct p4_file *file;
+	struct p4_changeset *changeset;
+
+	struct p4_revision_list *integrated;
+
+	/** Next in file **/
+	struct p4_revision *next;
+};
+
+/** Represents a collection of revisions of different files
+ **/
+struct p4_revision_list {
+	struct p4_revision *revision;
+	struct p4_revision_list *next;
+};
+
+struct p4_file {
+	struct p4_codeline *codeline;
+	const char *name;
+
+	unsigned head_number;
+
+	struct p4_revision *revisions;
+
+	/** Next file in codeline **/
+	struct p4_file *next;
+};
+
+/** perforce doesn't record codelines; we have to reverse-engineer
+ * them from how people seem to be branching.
+ **/
+struct p4_codeline {
+	struct p4_depot *depot;
+
+	/** Base path of codeline **/
+	const char *path;
+
+	/** git refname to import into **/
+	const char *refname;
+
+	struct p4_file *files;
+	struct p4_changeset *changesets;
+
+	int filelog_done;
+
+	/* The incremental state is that we have some changeset that
+	 * we previously imported up to, and we have git history going
+	 * back from that point, of which we've looked up some and
+	 * could look up more as needed. Also, there's p4-only history
+	 * going forward after the common history, and we've imported
+	 * some of that, and could import more as needed. Since
+	 * codelines are sorted by changeset number, we can tell which
+	 * way to go to get a name for a changeset.
+	 */
+	struct p4_changeset *history;
+	struct p4_changeset *unreported;
+
+	struct p4_changeset *head;
+
+	unsigned long finished_changeset;
+
+	/** For reporting **/
+	unsigned long num_changesets;
+
+	/** Next codeline in depot **/
+	struct p4_codeline *next;
+
+	/** Filesystem location of working directory for this codeline
+	 * on the client.
+	 **/
+	char *working;
+};
+
+#endif
-- 
1.6.0.6
